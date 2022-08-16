Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0A5958DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiHPKsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiHPKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:47:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FE1A5717;
        Tue, 16 Aug 2022 03:06:41 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G9t5A5027314;
        Tue, 16 Aug 2022 10:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fMlpgennJ+aDCXLc/X3LXd1l1LOrSsqhn3FftA8j/XU=;
 b=YpokH12g3ELurHfgJgCjpzY61QPPNZ4y/4GgdMGvEAzYKzHmGc9jPKvKuRugseaItFTW
 Ks0n6OZDk5UYScCukso9RRYGEIy0tdcJNBsLrzSHyFzBvW9+pfeS3x09A0O6SgiAhvCM
 F/EswoibWoyncYwz/+/W/eP8MrynsFq+oZzf5DrvD6H/0qFgAU8m1hdjcPFmpmYKFQX8
 8T1uh5dvlZiAwK3JKBYmj6/lV1IMx25uv6TkqZehnIRA5EfqwS0TzsU8x5UHfB1bIRw/
 zAayZRRqpwHVIzw2svz71osmP6H4+Phn/pEVVf6AiIGLE9saNhDVzURpCHYYHPGvGm5P oA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j06wr0dfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 10:05:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GA0vqj010852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 10:00:57 GMT
Received: from [10.216.49.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 03:00:52 -0700
Message-ID: <8c9d82d3-eb5d-8e0c-283a-2bb5e7dc8838@quicinc.com>
Date:   Tue, 16 Aug 2022 15:30:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/7] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <agross@kernel.org>, <bgoswami@quicinc.com>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <perex@perex.cz>, <quic_plai@quicinc.com>,
        <quic_rohkumar@quicinc.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <swboyd@chromium.org>,
        <tiwai@suse.com>
References: <1660308466-410-1-git-send-email-quic_srivasam@quicinc.com>
 <1660308466-410-7-git-send-email-quic_srivasam@quicinc.com>
 <6d551cf9-94b4-653b-122a-938ee5504150@wanadoo.fr>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <6d551cf9-94b4-653b-122a-938ee5504150@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jv1gQGIODM9IV2vrNVXirYLXzMY3O3pJ
X-Proofpoint-GUID: Jv1gQGIODM9IV2vrNVXirYLXzMY3O3pJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/15/2022 12:07 PM, Christophe JAILLET wrote:
Thanks for Your time and valuable insights CJ !!!
> Le 12/08/2022 à 14:47, Srinivasa Rao Mandadapu a écrit :
>> Update pil driver with SMMU mapping for allowing authorised
>> memory access to ADSP firmware, by reading required memory
>> regions either from device tree file or from resource table
>> embedded in ADSP binary header.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu 
>> <quic_srivasam-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>
>> ---
>> Changes since V3:
>>     -- Rename is_adsp_sb_needed to adsp_sandbox_needed.
>>     -- Add smmu unmapping in error case and in adsp stop.
>> Changes since V2:
>>     -- Replace platform_bus_type with adsp->dev->bus.
>>     -- Use API of_parse_phandle_with_args() instead of 
>> of_parse_phandle_with_fixed_args().
>>     -- Replace adsp->is_wpss with adsp->is_adsp.
>>     -- Update error handling in adsp_start().
>>
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 172 
>> +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 170 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index b0a63a0..ca45d2c 100644
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
>> @@ -333,6 +336,155 @@ static int adsp_load(struct rproc *rproc, const 
>> struct firmware *fw)
>>       return 0;
>>   }
>>   +static void adsp_of_unmap_smmu(struct iommu_domain *iommu_dom, 
>> const __be32 *prop, int len)
>> +{
>> +    unsigned long mem_phys;
>> +    unsigned long iova;
>> +    unsigned int mem_size;
>> +    int access_level;
>> +    int i;
>> +
>> +    for (i = 0; i < len; i++) {
>> +        iova = be32_to_cpu(prop[i++]);
>> +        mem_phys = be32_to_cpu(prop[i++]);
>> +        mem_size = be32_to_cpu(prop[i++]);
>> +        access_level = be32_to_cpu(prop[i]);
>> +        iommu_unmap(iommu_dom, iova, mem_size);
>> +    }
>> +}
>> +
>> +static void adsp_rproc_unmap_smmu(struct rproc *rproc, int len)
>> +{
>> +    struct fw_rsc_devmem *rsc_fw;
>> +    struct fw_rsc_hdr *hdr;
>> +    int offset;
>> +    int i;
>> +
>> +    for (i = 0; i < len; i++) {
>> +        offset = rproc->table_ptr->offset[i];
>> +        hdr = (void *)rproc->table_ptr + offset;
>> +        rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
>> +
>> +        iommu_unmap(rproc->domain, rsc_fw->da, rsc_fw->len);
>> +    }
>> +}
>> +
>> +static void adsp_unmap_smmu(struct rproc *rproc)
>> +{
>
> When I proposed a adsp_unmap_smmu() function, the idea was to undo 
> everything that is donne by adsp_map_smmu().
> iommu_domain_alloc() and iommu_map(adsp->iommu_dom, ..) are not undone 
> here.
>
> If this make sense, it would improve the semantic, simplify the 
> 'adsp_smmu_unmap' label in adsp_start() and avoid what looks like a 
> leak to me in adsp_stop().
Okay. Will modify accordingly and re post it.
>
>
>> +    struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> +    const __be32 *prop;
>> +    unsigned int len;
>> +
>> +    prop = of_get_property(adsp->dev->of_node, 
>> "qcom,adsp-memory-regions", &len);
>> +    if (prop) {
>
> In the allocation path, you have a "len /= sizeof(__be32);" which is 
> not here. Is it needed?
Yes It's missing. will ad it.
>
> You call adsp_unmap_smmu() from the error handling path of 
> adsp_map_smmu(). If needed, maybe it should be part of 
> adsp_of_unmap_smmu()?
Okay. Will modify accordingly and re post it.
>
>> + adsp_of_unmap_smmu(adsp->iommu_dom, prop, len);
>> +    } else {
>> +        if (rproc->table_ptr)
>> +            adsp_rproc_unmap_smmu(rproc, rproc->table_ptr->num);
>> +    }
>> +}
>> +
>> +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
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
>
> Are ret and rc both needed?
Yes it's redundant. Will replace it with ret.
>
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
>> +        ret = -ENOMEM;
>> +        goto domain_free;
>> +    }
>> +
>> +    ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
>> +        ret = -EBUSY;
>> +        goto detach_device;
>> +    }
>> +
>> +    /* Add SID configuration for ADSP Firmware to SMMU */
>> +    adsp->mem_phys =  adsp->mem_phys | (sid << 32);
>> +
>> +    ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
>> +            adsp->mem_size,    IOMMU_READ | IOMMU_WRITE);
>> +    if (ret) {
>> +        dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
>> +        goto sid_unmap;
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
>> +                goto smmu_unmap;
>> +            }
>> +        }
>> +    } else {
>> +        if (!rproc->table_ptr)
>> +            goto sid_unmap;
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
>> +                goto rproc_smmu_unmap;
>> +            }
>> +        }
>> +    }
>
> If you introduce a adsp_of_unmap_smmu() and adsp_rproc_unmap_smmu(), 
> would it make things more readable to have the same kind of functions 
> when allocating the resources?
>
> Symmetry often helps.
Yes, Agree.  Will update accordingly.
>
>> +    return 0;
>
> Add an empty new line here?
>
>> +rproc_smmu_unmap:
>> +    adsp_rproc_unmap_smmu(rproc, i);
>> +    goto sid_unmap;
>> +smmu_unmap:
>> +    adsp_of_unmap_smmu(adsp->iommu_dom, prop, i);
>> +sid_unmap:
>> +    iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
>> +detach_device:
>> +    iommu_domain_free(adsp->iommu_dom);
>> +domain_free:
>> +    return ret;
>> +}
>> +
>> +
>>   static int adsp_start(struct rproc *rproc)
>>   {
>>       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> @@ -343,9 +495,16 @@ static int adsp_start(struct rproc *rproc)
>>       if (ret)
>>           return ret;
>>   +    if (adsp->adsp_sandbox_needed) {
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
>> @@ -401,6 +560,12 @@ static int adsp_start(struct rproc *rproc)
>>       qcom_rproc_pds_disable(adsp, adsp->proxy_pds, 
>> adsp->proxy_pd_count);
>>   disable_xo_clk:
>>       clk_disable_unprepare(adsp->xo);
>> +adsp_smmu_unmap:
>> +    if (adsp->adsp_sandbox_needed) {
>> +        iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
>> +        adsp_unmap_smmu(rproc);
>> +        iommu_domain_free(adsp->iommu_dom);
>> +    }
>>   disable_irqs:
>>       qcom_q6v5_unprepare(&adsp->q6v5);
>>   @@ -429,6 +594,9 @@ static int adsp_stop(struct rproc *rproc)
>>       if (ret)
>>           dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
>>   +    if (adsp->adsp_sandbox_needed)
>> +        adsp_unmap_smmu(rproc);
>
> No need to call iommu_unmap() and iommu_domain_free() here?
> (this is the same comment as the one in adsp_rproc_unmap_smmu(). This 
> is just a blind guess based on symmetry of the code.)
Okay.
>
>> +
>>       handover = qcom_q6v5_unprepare(&adsp->q6v5);
>>       if (handover)
>>           qcom_adsp_pil_handover(&adsp->q6v5);
>
