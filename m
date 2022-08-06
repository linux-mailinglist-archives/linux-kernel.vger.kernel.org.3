Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87F58B83E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiHFUeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiHFUeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:34:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A7D11F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:34:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r14so6302879ljp.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=nUZOASi1AeWsiTeJpwg1uH93uFHvf8HXjE9XeYBo5aM=;
        b=ZoUuuyAaXzkKYx0XT8mw+QQvBbduB7hwbgwm5wHD4dPejcIt8MVVklDLI2oaXlRTC+
         6VioMO+g16FctWAoIDD1FvZnrJJtfkxXtFqg/6IKA2kEUIlNhcouL6LZTBA1htHLkNkH
         CLBiEbxwCYA0qvbZv2KlxFqICEoC1+ZF5eHiIm37Sl/oKN6c6TOOmUDqrpv+NKo4pVgu
         IFohCM2rqepd3I7ObqkoA6gzgvYpXBesgeqZrJbYldgxnqHo1vQOFs9dzM2iEQ+KBC9/
         9IJySzfWY5h/tdL5f4v6RLjcqLZq3wPLkk6QCSIlxApRA5IqZkTIc98BCmdLHTjq0Wvr
         yK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nUZOASi1AeWsiTeJpwg1uH93uFHvf8HXjE9XeYBo5aM=;
        b=L2b6tPbaNChoBh3ukzAv3Avlbs406K1yXpi9b9govvEteLa0gBqDip5uhue3TX3Zht
         BMYiTd9iwPlra0Z41oJUWRwlTKoYp2MWfQCyrYaZIKsLFCvvLR6kY2HVLUIUKyfcyvCf
         mnZCNOEDVpH13ds+O6rVKGp2+TlMbqX1Mu4vyIXPcntB9lLvqIXM0WLy7f/381HBvj+I
         PeFza9m40FWshxx4FKDvtfzQO0ZaSNS/IDDBIg2sWYwdDHGRc8rEhO277NoeqEskd3PU
         I4EomUdvsW3isgZmPNw9cMnU74iix45pIG9VMigFJGl1vT+Z6M8ROg8mety9euBrbBR3
         TNMg==
X-Gm-Message-State: ACgBeo1R9I6h169eyN6j8PXnoTiUgHJ61uAJd6PWo2pPa3pD10nGB75T
        u4lLfym4zDX1u/0v1zji5v5sOg==
X-Google-Smtp-Source: AA6agR67XcS0BLgr+RQtLddpumdVPZaBVbRFhr7sKtIBlLKGWyVvNMxNj2cSbqRVrVkd3YZk6LRSdA==
X-Received: by 2002:a2e:92c8:0:b0:25d:6ddf:e71d with SMTP id k8-20020a2e92c8000000b0025d6ddfe71dmr3625998ljh.170.1659818061691;
        Sat, 06 Aug 2022 13:34:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c11-20020ac25f6b000000b0048af2fe78c4sm874215lfc.3.2022.08.06.13.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 13:34:21 -0700 (PDT)
Message-ID: <9d78a571-8d02-2967-1f29-21ca737a582f@linaro.org>
Date:   Sat, 6 Aug 2022 23:34:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-GB
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-8-git-send-email-quic_srivasam@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1659536480-5176-8-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 17:21, Srinivasa Rao Mandadapu wrote:
> Add memory sandbox support for ADSP based platforms secure booting.

This repeats commit subject. Please replace it with proper commit 
message text describing what is done and why.

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>   drivers/remoteproc/qcom_q6v5_adsp.c | 101 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 3dbd035..f81da47 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -9,6 +9,7 @@
>   #include <linux/firmware.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> +#include <linux/iommu.h>
>   #include <linux/iopoll.h>
>   #include <linux/kernel.h>
>   #include <linux/mfd/syscon.h>
> @@ -48,6 +49,8 @@
>   #define LPASS_PWR_ON_REG		0x10
>   #define LPASS_HALTREQ_REG		0x0
>   
> +#define SID_MASK_DEFAULT        0xF
> +
>   #define QDSP6SS_XO_CBCR		0x38
>   #define QDSP6SS_CORE_CBCR	0x20
>   #define QDSP6SS_SLEEP_CBCR	0x3c
> @@ -77,7 +80,7 @@ struct adsp_pil_data {
>   struct qcom_adsp {
>   	struct device *dev;
>   	struct rproc *rproc;
> -
> +	struct iommu_domain *iommu_dom;
>   	struct qcom_q6v5 q6v5;
>   
>   	struct clk *xo;
> @@ -332,6 +335,91 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>   	return 0;
>   }
>   
> +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
> +{
> +	struct of_phandle_args args;
> +	int ret, rc, i;
> +	long long sid;
> +
> +	unsigned long mem_phys;
> +	unsigned long iova;
> +	const __be32 *prop;
> +	int access_level;
> +	uint32_t len, flag, mem_size;
> +	int offset;
> +	struct fw_rsc_hdr *hdr;
> +	struct fw_rsc_devmem *rsc_fw;
> +
> +	rc = of_parse_phandle_with_fixed_args(adsp->dev->of_node, "iommus", 1, 0, &args);

Please do not add implicit dependency on #iommu-cells value.

> +	if (rc < 0)
> +		sid = -1;
> +	else
> +		sid = args.args[0] & SID_MASK_DEFAULT;
> +
> +	adsp->iommu_dom = iommu_domain_alloc(&platform_bus_type);

please use adsp->dev->bus instead of platform_bus_type here.

> +	if (!adsp->iommu_dom) {
> +		dev_err(adsp->dev, "failed to allocate iommu domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
> +	if (ret) {
> +		dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
> +		return -EBUSY;
> +	}
> +
> +	/* Add SID configuration for ADSP Firmware to SMMU */
> +	adsp->mem_phys =  adsp->mem_phys | (sid << 32);
> +
> +	ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
> +			adsp->mem_size,	IOMMU_READ | IOMMU_WRITE);
> +	if (ret) {
> +		dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
> +		return ret;
> +	}
> +
> +	prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory", &len);

Non-documented property. So, this chunk is not acceptable.

> +	if (prop) {
> +		len /= sizeof(__be32);
> +		for (i = 0; i < len; i++) {
> +			iova = be32_to_cpu(prop[i++]);
> +			mem_phys = be32_to_cpu(prop[i++]);
> +			mem_size = be32_to_cpu(prop[i++]);
> +			access_level = be32_to_cpu(prop[i]);
> +
> +			if (access_level)
> +				flag = IOMMU_READ | IOMMU_WRITE;
> +			else
> +				flag = IOMMU_READ;
> +
> +			ret = iommu_map(adsp->iommu_dom, iova, mem_phys, mem_size, flag);
> +			if (ret) {
> +				dev_err(adsp->dev, "failed to map addr = %p mem_size = %x\n",
> +						&(mem_phys), mem_size);
> +				return ret;
> +			}
> +		}
> +	} else {
> +		if (!rproc->table_ptr)
> +			return 0;
> +
> +		for (i = 0; i < rproc->table_ptr->num; i++) {
> +			offset = rproc->table_ptr->offset[i];
> +			hdr = (void *)rproc->table_ptr + offset;
> +			rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
> +
> +			ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
> +						rsc_fw->len, rsc_fw->flags);

What about filling an sgtable instead and using it?

> +			if (ret) {
> +				pr_err("%s; unable to map adsp memory address\n", __func__);
> +				return ret;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +
>   static int adsp_start(struct rproc *rproc)
>   {
>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> @@ -341,7 +429,13 @@ static int adsp_start(struct rproc *rproc)
>   	ret = qcom_q6v5_prepare(&adsp->q6v5);
>   	if (ret)
>   		return ret;
> -
> +	if (!adsp->is_wpss) {
> +		ret = adsp_map_smmu(adsp, rproc);

Is this also applicable to cDSP? To sdm845 adsp?

> +		if (ret) {
> +			dev_err(adsp->dev, "ADSP smmu mapping failed\n");
> +			goto adsp_smmu_unmap;
> +		}
> +	}
>   	ret = clk_prepare_enable(adsp->xo);
>   	if (ret)
>   		goto disable_irqs;
> @@ -402,6 +496,9 @@ static int adsp_start(struct rproc *rproc)
>   	clk_disable_unprepare(adsp->xo);
>   disable_irqs:
>   	qcom_q6v5_unprepare(&adsp->q6v5);
> +adsp_smmu_unmap:
> +	iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
> +	iommu_domain_free(adsp->iommu_dom);
>   
>   	return ret;
>   }


-- 
With best wishes
Dmitry
