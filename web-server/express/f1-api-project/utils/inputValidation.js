import Joi from "joi";
//closure
/* 
function funcaoA(paramA) {
  return function funcaoB(paramB) {
    return paramA + paramB
  }  
}

const resultado = funcaoA(2)
console.log(resultadoFuncaoA(4))

output: 6
*/

const driverSchema = Joi.object({
  name: Joi.string().min(3).max(30).required(),
  team: Joi.string().min(3).max(50).required(),
  points: Joi.number().min(0).max(1000).default(0),
});

const updateDriversSchema = Joi.object({
  name: Joi.string().min(3).max(30),
  team: Joi.string().min(3).max(50),
  points: Joi.number().min(0).max(1000),
}).min(1);

function validation(schema) {
  return function validateInfo(info) {
    return schema.validate(info, { abortEarly: false });
  };
}

const generatePositionSchema = (maxValue) => Joi.number().min(1).max(maxValue);
export const validateDriverInfo = validation(driverSchema);
export const validateUpdateDriverInfo = validation(updateDriversSchema);
export const validatePosition = (position, maxValue) =>
  generatePositionSchema(maxValue).validate(position);
