Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC88A591114
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiHLMxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbiHLMxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:53:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF92AB40C;
        Fri, 12 Aug 2022 05:53:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C7sgDW013721;
        Fri, 12 Aug 2022 12:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QIQw8N9pfAoMaGvQJw2uwrPY3A883n5OBfawHuG2BtY=;
 b=X2W8UShGULgw0mEHQK97tTMoBhqP/oAV/T80VPMjl4FwZbFf6+L1FEoAktGZxo5MmCYx
 mhUC8f18pqjaepMSKOvhJZWOpRB4WTSBV0QQY4mEEQ5stqflymWA1CFjscJEu8L18KtG
 runJ91E1LJEKoQnEa7CuW1TodvuzFQf5eIgKt6BzybBOVOS7HQkkXjmFJqu5+n3fYwnm
 /0eV+c5NXObPuFiWnK5SHxUbrjhj+o1ZvbIkyUJmhLn5LRlnM40Ei7iMWNwzE5pJqrxF
 zv1tLPnt9uzSTJcZNAXi7G9E7+HTQjGCRN7LzIsbZb08h4bb80Kr9zROmbt0Hkmtdzgh 1g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hwe0j9tbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:52:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27CCqssK026603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:52:54 GMT
Received: from [10.216.36.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 12 Aug
 2022 05:52:48 -0700
Message-ID: <3bebd711-f4b7-989a-2b26-40086875fc0d@quicinc.com>
Date:   Fri, 12 Aug 2022 18:22:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
 <1660117558-21829-8-git-send-email-quic_srivasam@quicinc.com>
 <080f3e2b-af7b-0ac0-1716-a33da73290e4@wanadoo.fr>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <080f3e2b-af7b-0ac0-1716-a33da73290e4@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0sfbGlqcObvifIvAGxbRYuAfxgsa4fPH
X-Proofpoint-ORIG-GUID: 0sfbGlqcObvifIvAGxbRYuAfxgsa4fPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_08,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/2022 11:02 AM, Christophe JAILLET wrote:
Thanks for your time Christophe!!!
> Le 10/08/2022 à 09:45, Srinivasa Rao Mandadapu a écrit :
>> Update pil driver with SMMU mapping for allowing authorised
>> memory access to ADSP firmware, by reading required memory
>> regions either from device tree file or from resource table
>> embedded in ADSP binary header.
>>
>
> Hi,
>
> comments below about error handling paths that look incomplete to me.
>
> Just my 2c.
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>> Changes since V2:
>>     -- Replace platform_bus_type with adsp->dev->bus.
>>     -- Use API of_parse_phandle_with_args() instead of 
>> of_parse_phandle_with_fixed_args().
>>     -- Replace adsp->is_wpss with adsp->is_adsp.
>>     -- Update error handling in adsp_start().
>>
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 107 
>> +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 105 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index f2945bf..b9cafe2 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/firmware.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> +#include <linux/iommu.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mfd/syscon.h>
>> @@ -48,6 +49,8 @@
>>   #define LPASS_PWR_ON_REG        0x10
>>   #define LPASS_HALTREQ_REG        0x0
>>   +#define SID_MASK_DEFAULT        0xF
>> +
>>   #define QDSP6SS_XO_CBCR        0x38
>>   #define QDSP6SS_CORE_CBCR    0x20
>>   #define QDSP6SS_SLEEP_CBCR    0x3c
>> @@ -78,7 +81,7 @@ struct adsp_pil_data {
>>   struct qcom_adsp {
>>       struct device *dev;
>>       struct rproc *rproc;
>> -
>> +    struct iommu_domain *iommu_dom;
>>       struct qcom_q6v5 q6v5;
>>         struct clk *xo;
>> @@ -333,6 +336,94 @@ static int adsp_load(struct rproc *rproc, const 
>> struct firmware *fw)
>>       return 0;
>>   }
>>   +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
>> +{
>> +    struct of_phandle_args args;
>> +    struct fw_rsc_devmem *rsc_fw;
>> +    struct fw_rsc_hdr *hdr;
>> +    const __be32 *prop;
>> +    long long sid;
>> +    unsigned long mem_phys;
>> +    unsigned long iova;
>> +    unsigned int mem_size;
>> +    unsigned int flag;
>> +    unsigned int len;
>> +    int access_level;
>> +    int offset;
>> +    int ret;
>> +    int rc;
>> +    int i;
>> +
>> +    rc = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", 
>> "#iommu-cells", 0, &args);
>> +    if (rc < 0)
>> +        sid = -1;
>> +    else
>> +        sid = args.args[0] & SID_MASK_DEFAULT;
>> +
>> +    adsp->iommu_dom = iommu_domain_alloc(adsp->dev->bus);
>> +    if (!adsp->iommu_dom) {
>> +        dev_err(adsp->dev, "failed to allocate iommu domain\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
>
> iommu_domain_free() or error handling path (see below)?
>
>> +        return -EBUSY;
>> +    }
>> +
>> +    /* Add SID configuration for ADSP Firmware to SMMU */
>> +    adsp->mem_phys =  adsp->mem_phys | (sid << 32);
>> +
>> +    ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
>> +            adsp->mem_size,    IOMMU_READ | IOMMU_WRITE);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
>
> iommu_domain_free() or error handling path (see below)?
Okay. Will update accordingly!!!
>
>> +        return ret;
>> +    }
>> +
>> +    prop = of_get_property(adsp->dev->of_node, 
>> "qcom,adsp-memory-regions", &len);
>> +    if (prop) {
>> +        len /= sizeof(__be32);
>> +        for (i = 0; i < len; i++) {
>> +            iova = be32_to_cpu(prop[i++]);
>> +            mem_phys = be32_to_cpu(prop[i++]);
>> +            mem_size = be32_to_cpu(prop[i++]);
>> +            access_level = be32_to_cpu(prop[i]);
>> +
>> +            if (access_level)
>> +                flag = IOMMU_READ | IOMMU_WRITE;
>> +            else
>> +                flag = IOMMU_READ;
>> +
>> +            ret = iommu_map(adsp->iommu_dom, iova, mem_phys, 
>> mem_size, flag);
>> +            if (ret) {
>> +                dev_err(adsp->dev, "failed to map addr = %p mem_size 
>> = %x\n",
>> +                        &(mem_phys), mem_size);
>> +                return ret;
>
> Should there be an error handling path to undo iommu_domain_alloc() 
> and iommu_map() above.
> Same for iommu_map() already done in the loop.
Okay. Will update accordingly!!!
>
>> +            }
>> +        }
>> +    } else {
>> +        if (!rproc->table_ptr)
>> +            return 0;
>> +
>> +        for (i = 0; i < rproc->table_ptr->num; i++) {
>> +            offset = rproc->table_ptr->offset[i];
>> +            hdr = (void *)rproc->table_ptr + offset;
>> +            rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
>> +
>> +            ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
>> +                        rsc_fw->len, rsc_fw->flags);
>> +            if (ret) {
>> +                pr_err("%s; unable to map adsp memory address\n", 
>> __func__);
>> +                return ret;
>
> Same comment.
Okay.
>
>> +            }
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +
>>   static int adsp_start(struct rproc *rproc)
>>   {
>>       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> @@ -343,9 +434,16 @@ static int adsp_start(struct rproc *rproc)
>>       if (ret)
>>           return ret;
>>   +    if (adsp->is_adsp_sb_needed) {
>> +        ret = adsp_map_smmu(adsp, rproc);
>> +        if (ret) {
>> +            dev_err(adsp->dev, "ADSP smmu mapping failed\n");
>> +            goto disable_irqs;
>> +        }
>> +    }
>>       ret = clk_prepare_enable(adsp->xo);
>>       if (ret)
>> -        goto disable_irqs;
>> +        goto adsp_smmu_unmap;
>>         ret = qcom_rproc_pds_enable(adsp, adsp->proxy_pds,
>>                       adsp->proxy_pd_count);
>> @@ -401,6 +499,11 @@ static int adsp_start(struct rproc *rproc)
>>       qcom_rproc_pds_disable(adsp, adsp->proxy_pds, 
>> adsp->proxy_pd_count);
>>   disable_xo_clk:
>>       clk_disable_unprepare(adsp->xo);
>> +adsp_smmu_unmap:
>> +    if (adsp->is_adsp_sb_needed) {
>> +        iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
>> +        iommu_domain_free(adsp->iommu_dom);
>
> Hi,
>
> Do the iommu_map() in the for loops of adsp_map_smmu() also need some 
> iommu_unmap() here?
>
> Maybe introducing a adsp_unmap_smmu() would simplify the release of 
> resources.
>
> Does the same resource release makes sense in adsp_stop() or somewhere 
> else?
>
> CJ
>
Okay. Will update accordingly!!!
>
>> +    }
>>   disable_irqs:
>>       qcom_q6v5_unprepare(&adsp->q6v5);
>
