Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA05A0D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbiHYKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiHYKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:05:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FB5A2866;
        Thu, 25 Aug 2022 03:05:21 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P6TPkt018605;
        Thu, 25 Aug 2022 10:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IM5cttMRYnn7UaAmvUeSHl9XOYihY8Ufu8esThp9cIA=;
 b=ZJHFAaoEBeGZp24WeVkkjZJBm0rjdkdcLrnzKOXoc/J70CebPI9S6xqEZWoJGaJ6MWyA
 AsKA/UHz4gBT2TEDn7FpOQ4+ieK3UQzbjhuyfgL+SfBi4i5Z0eCtM60ndSjzBfo7f3/X
 TA+6DBPCFYnZ2gjJoYKhhZCzWjnYSJnyd3SwTYyFEKkntGPCapX3wdTwp+FQx+ewSrQJ
 VtyQkXfLmJQvMj2eSm1cmWaGpASM5B+ZIvXrDEFGmKu/HHEw2Byj97CB/ndIXwP8K0cV
 R4yhRMboZlxVLr1XO+UgkTe10gRYKt4BbRyZHYNrC1sYtDuh37m6SbabKk41X2rouvzk Vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j63v0gnck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 10:04:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27PA4bnI015571
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 10:04:37 GMT
Received: from [10.216.5.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 03:04:32 -0700
Message-ID: <df904bab-8c37-0797-1226-bc867178ed0b@quicinc.com>
Date:   Thu, 25 Aug 2022 15:34:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND v5 6/7] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bgoswami@quicinc.com>, <bjorn.andersson@linaro.org>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <judyhsiao@chromium.org>, <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <quic_rohkumar@quicinc.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
References: <1661156523-22611-1-git-send-email-quic_srivasam@quicinc.com>
 <1661156523-22611-7-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53G_nKUPDDZtH1i9=G9s9ATV=iTdpuFcU6y1oeKyc0B9w@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n53G_nKUPDDZtH1i9=G9s9ATV=iTdpuFcU6y1oeKyc0B9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KWE2AlnoWmbSc5Cn99Ble2yXb5oNwVrv
X-Proofpoint-ORIG-GUID: KWE2AlnoWmbSc5Cn99Ble2yXb5oNwVrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/23/2022 8:55 AM, Stephen Boyd wrote:
Thanks for your time and valuable suggestions!!!
> Quoting Srinivasa Rao Mandadapu (2022-08-22 01:22:02)
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index b0a63a0..d01c97e 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -333,6 +336,185 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>>          return 0;
>>   }
>>
>> +static void adsp_of_unmap_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
>> +{
>> +       unsigned long iova;
>> +       unsigned int mem_size;
>> +       int i;
>> +
>> +       len /= sizeof(__be32);
>> +       for (i = 0; i < len; i++) {
>> +               iova = be32_to_cpu(prop[i++]);
>> +               /* Skip Physical address*/
>> +               i++;
>> +               mem_size = be32_to_cpu(prop[i++]);
>> +               iommu_unmap(iommu_dom, iova, mem_size);
>> +       }
>> +}
>> +
>> +static void adsp_rproc_unmap_smmu(struct rproc *rproc, int len)
>> +{
>> +       struct fw_rsc_devmem *rsc_fw;
>> +       struct fw_rsc_hdr *hdr;
>> +       int offset;
>> +       int i;
>> +
>> +       for (i = 0; i < len; i++) {
>> +               offset = rproc->table_ptr->offset[i];
>> +               hdr = (void *)rproc->table_ptr + offset;
>> +               rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
>> +
>> +               iommu_unmap(rproc->domain, rsc_fw->da, rsc_fw->len);
>> +       }
>> +}
>> +
>> +static void adsp_unmap_smmu(struct rproc *rproc)
>> +{
>> +       struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> +       const __be32 *prop;
>> +       unsigned int len;
>> +
>> +       iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
>> +
>> +       prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
>> +       if (prop) {
>> +               adsp_of_unmap_smmu(adsp->iommu_dom, prop, len);
>> +       } else {
>> +               if (rproc->table_ptr)
>> +                       adsp_rproc_unmap_smmu(rproc, rproc->table_ptr->num);
>> +       }
>> +
>> +       iommu_domain_free(adsp->iommu_dom);
>> +}
>> +
>> +static int adsp_of_map_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
>> +{
>> +       unsigned long mem_phys;
>> +       unsigned long iova;
>> +       unsigned int mem_size;
>> +       unsigned int flag;
>> +       int access_level;
>> +       int ret;
>> +       int i;
>> +
>> +       len /= sizeof(__be32);
>> +       for (i = 0; i < len; i++) {
>> +               iova = be32_to_cpu(prop[i++]);
>> +               mem_phys = be32_to_cpu(prop[i++]);
>> +               mem_size = be32_to_cpu(prop[i++]);
>> +               access_level = be32_to_cpu(prop[i]);
>> +
>> +               if (access_level)
>> +                       flag = IOMMU_READ | IOMMU_WRITE;
>> +               else
>> +                       flag = IOMMU_READ;
>> +
>> +               ret = iommu_map(iommu_dom, iova, mem_phys, mem_size, flag);
>> +               if (ret) {
>> +                       pr_err("failed to map addr = %p mem_size = %x\n", &(mem_phys), mem_size);
> Why can't this be dev_err()?
Actually, dev pointer is not available here, hence used pr_err.
>
>> +                       goto of_smmu_unmap;
>> +               }
>> +       }
>> +       return 0;
>> +of_smmu_unmap:
>> +       adsp_of_unmap_smmu(iommu_dom, prop, i);
>> +       return ret;
>> +}
>> +
>> +static int adsp_rproc_map_smmu(struct rproc *rproc, int len)
>> +{
>> +       struct fw_rsc_devmem *rsc_fw;
> const?
Okay. will update.
>
>> +       struct fw_rsc_hdr *hdr;
> const?
Okay. Will update.
>
>> +       int offset;
>> +       int ret;
>> +       int i;
>> +
>> +       if (!rproc->table_ptr)
>> +               return 0;
>> +
>> +       for (i = 0; i < rproc->table_ptr->num; i++) {
>> +               offset = rproc->table_ptr->offset[i];
>> +               hdr = (void *)rproc->table_ptr + offset;
>> +               rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
>> +
>> +               ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
>> +                                       rsc_fw->len, rsc_fw->flags);
>> +               if (ret) {
>> +                       pr_err("failed to map addr = %x mem_size = %x\n", rsc_fw->pa, rsc_fw->len);
> Why can't this be dev_err()?
Okay. Will change it.
>
>> +                       goto  rproc_smmu_unmap;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +rproc_smmu_unmap:
>> +       adsp_rproc_unmap_smmu(rproc, i);
> Does i need to be incremented? And/or unmap should be done in reverse.

Here i is the upper bound index in mapping failure case, hence it is 
used as length. un-mapping is being done from starting till i value.

Please correct me if I am missing some thing.

>
>> +       return ret;
>> +}
>> +
>> +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
>> +{
>> +       struct of_phandle_args args;
>> +       const __be32 *prop;
>> +       long long sid;
>> +       unsigned int len;
>> +       int ret;
>> +
>> +       ret = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", "#iommu-cells", 0, &args);
>> +       if (ret < 0)
>> +               sid = -1;
> Is it a good idea to set the sid to -1? Does that mean all stream IDs?
It seems, if sid is -1 iomap fails, because of alignment issues. Any I 
will update with return in this case.
>
>> +       else
>> +               sid = args.args[0] & SID_MASK_DEFAULT;
>> +
>> +       adsp->iommu_dom = iommu_domain_alloc(adsp->dev->bus);
>> +       if (!adsp->iommu_dom) {
>> +               dev_err(adsp->dev, "failed to allocate iommu domain\n");
>> +               ret = -ENOMEM;
>> +               goto domain_free;
>> +       }
>> +
>> +       ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
>> +       if (ret) {
>> +               dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
>> +               ret = -EBUSY;
> Why do we overwrite the error value?
It seems not required. Will remove it.
>
>> +               goto detach_device;
>> +       }
>> +
>> +       /* Add SID configuration for ADSP Firmware to SMMU */
>> +       adsp->mem_phys =  adsp->mem_phys | (sid << 32);
>> +
>> +       ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
>> +                       adsp->mem_size, IOMMU_READ | IOMMU_WRITE);
>> +       if (ret) {
>> +               dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
>> +               goto sid_unmap;
>> +       }
>> +
>> +       prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
> I find it odd that we're encoding virtual addresses (iovas) into
Actually from HLOS perspective, same IOVA and physical memory is being 
used. Hence will remove virtual address field in DT.
> devicetree. Presumably the physical address needs to be in DT as a
> carveout, but after that I would think we're free to allocate the
Will try to carveout the physical addresses and handle it accordingly. 
If this method is ignored I don't think we need to mention in DT in anyway.
> segments from the carveout however we see fit and then program that into
> the SMMU. Maybe DT can be a suggestion, but otherwise can it be ignored?

Yes, it seems it can be ignored. As it is the approach we did for 
bringing up AudioReach solution, and used when ADSP binary is without 
metadata section header info.

Will check internally and update accordingly.

Your opinion also helps please!!. Is it okay to keep it as backup option 
with proper comment, such that this method can be used internally, with 
raw ADSP binary in early stage bring-up scenarios?

>
>> +       if (prop) {
>> +               ret = adsp_of_map_smmu(adsp->iommu_dom, prop, len);
>> +               if (ret) {
>> +                       dev_err(adsp->dev, "Unable to map memory regions accessed by ADSP\n");
>> +                       goto sid_unmap;
>> +               }
>> +       } else {
>> +               ret = adsp_rproc_map_smmu(rproc, len);
>> +               if (ret) {
>> +                       dev_err(adsp->dev, "Unable to map memory regions accessed by ADSP\n");
> Maybe this should be a different string in case it is confused with the
> above print of the same string.
Okay. Will modify the string.
>
>> +                       goto sid_unmap;
>> +               }
>> +       }
>> +       return 0;
>> +
>> +sid_unmap:
>> +       iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
>> +detach_device:
>> +       iommu_domain_free(adsp->iommu_dom);
>> +domain_free:
>> +       return ret;
>> +}
>> +
>> +
>>   static int adsp_start(struct rproc *rproc)
>>   {
>>          struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> @@ -343,9 +525,16 @@ static int adsp_start(struct rproc *rproc)
>>          if (ret)
>>                  return ret;
>>
>> +       if (adsp->adsp_sandbox_needed) {
>> +               ret = adsp_map_smmu(adsp, rproc);
>> +               if (ret) {
>> +                       dev_err(adsp->dev, "ADSP smmu mapping failed\n");
>> +                       goto disable_irqs;
>> +               }
>> +       }
> Newline here please.
Okay.
>
>>          ret = clk_prepare_enable(adsp->xo);
>>          if (ret)
>> -               goto disable_irqs;
>> +               goto adsp_smmu_unmap;
>>
>>          ret = qcom_rproc_pds_enable(adsp, adsp->proxy_pds,
>>                                      adsp->proxy_pd_count);
