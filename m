Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7C5136A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348235AbiD1OSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348202AbiD1ORx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:17:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF79B7156;
        Thu, 28 Apr 2022 07:14:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r11-20020a05600c35cb00b0039409c1111bso2158107wmq.3;
        Thu, 28 Apr 2022 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S0n4vT9BhMHU2WQlHRXLpp/KRrHRQlF2a1BLW87KTmk=;
        b=gAo2hOkVIKXQN2B46GdYlRrzaZTgfNHy4B0UwKMLWDwYy2hqdunAn+f4J1YAWxsIkI
         f/NTIomFneugwkvTqguhSHUAGUWJYzufBW+YNSTDGQ8CVjSXpvcRptzF3ErfhV+eF50K
         RDmPIYaFrwTxpnF5W66kw9Bcl51jKC9OE+kX3jJi5GnpnBg2EG/tXzi7CSngM83SWpzy
         lOt5/qMLQkGXXCzNURX9+mfmuFM9fieJWVR3yX10BwivUYDaIeab7/nNE5PSylJDnUUh
         8Jm/YJcbi4GrShGruqoOvtAqyRFa7BdZtg37hxbiQUEgKlmg6oyXt3IQFbUJyr2zFTfY
         gfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S0n4vT9BhMHU2WQlHRXLpp/KRrHRQlF2a1BLW87KTmk=;
        b=objDyJ9AlI6G68wdRBqQbn14S8vmF5IPA/Of+9WCnjp/2wFlfDE5LWkOt1aHjAW2Dh
         NuTjeTmRfH0+v4on33K1ab3Y322Qg3LgQXZScsZ6V5X3i4IbPgsu5KLYLP9KWyAcZAd4
         Uw4BJBqCR5YwYqn03P+r2MaVBWbw7Ls0u0YjudDaTxAjDN0ekjZRIGohHKw7qt0elw06
         ZcZLG5ZX8p6SwUATIpx7NJF814g4xSnhI2G0EgU8BgLDl5Cxxk8ubE+cvGsv7d4ENKMQ
         IsqOYm43H+ZL5x9jvlhULLB+WDJyUsz8BoDlvn/HBRD5vzCQuppk4vFetnWv0Y05Jr/F
         cdpQ==
X-Gm-Message-State: AOAM531mI3t5f9U02VG4MR8rPygT2wJkRcI8gK910+ehFmEyFuAXhWi7
        e7ZtdVvb+sUkawqitcBDIbrrxbjvvjHGCA==
X-Google-Smtp-Source: ABdhPJwUdgNeXIVbLSeg3t/l9hijtw5yJRrMD2iH8BHIePXx5Ru7c5WskYH6AKHZcKUO2GzrZkH9SQ==
X-Received: by 2002:a05:600c:1548:b0:392:8e1a:18c3 with SMTP id f8-20020a05600c154800b003928e1a18c3mr31451311wmg.102.1651155276124;
        Thu, 28 Apr 2022 07:14:36 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b00393e84ea043sm54451wma.44.2022.04.28.07.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 07:14:35 -0700 (PDT)
Message-ID: <cc7cc7a8-c7a2-56a1-47bf-6c553c200b33@gmail.com>
Date:   Thu, 28 Apr 2022 16:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 31/34] iommu/mediatek: Get the proper bankid for multi
 banks
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com
References: <20220407075726.17771-1-yong.wu@mediatek.com>
 <20220407075726.17771-32-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220407075726.17771-32-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2022 09:57, Yong Wu wrote:
> We preassign some ports in a special bank via the new defined
> banks_portmsk. Put it in the plat_data means it is not expected to be
> adjusted dynamically.
> 
> If the iommu id in the iommu consumer's dtsi node is inside this
> banks_portmsk, then we switch it to this special iommu bank, and
> initialise the IOMMU bank HW.
> 
> Each a bank has the independent pgtable(4GB iova range). Each a bank
> is a independent iommu domain/group. Currently we don't separate different
> iova ranges inside a bank.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/mtk_iommu.c | 39 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0828cff97625..d42b3d35a36e 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -191,6 +191,7 @@ struct mtk_iommu_plat_data {
>   
>   	u8                  banks_num;
>   	bool                banks_enable[MTK_IOMMU_BANK_MAX];
> +	unsigned int        banks_portmsk[MTK_IOMMU_BANK_MAX];
>   	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
>   };
>   
> @@ -467,6 +468,30 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> +static unsigned int mtk_iommu_get_bank_id(struct device *dev,
> +					  const struct mtk_iommu_plat_data *plat_data)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	unsigned int i, portmsk = 0, bankid = 0;
> +
> +	if (plat_data->banks_num == 1)
> +		return bankid;
> +
> +	for (i = 0; i < fwspec->num_ids; i++)
> +		portmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
> +
> +	for (i = 0; i < plat_data->banks_num && i < MTK_IOMMU_BANK_MAX; i++) {
> +		if (!plat_data->banks_enable[i])
> +			continue;
> +
> +		if (portmsk & plat_data->banks_portmsk[i]) {
> +			bankid = i;
> +			break;
> +		}
> +	}
> +	return bankid; /* default is 0 */
> +}
> +
>   static int mtk_iommu_get_iova_region_id(struct device *dev,
>   					const struct mtk_iommu_plat_data *plat_data)
>   {
> @@ -619,13 +644,14 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   	struct list_head *hw_list = data->hw_list;
>   	struct device *m4udev = data->dev;
>   	struct mtk_iommu_bank_data *bank;
> -	unsigned int bankid = 0;
> +	unsigned int bankid;
>   	int ret, region_id;
>   
>   	region_id = mtk_iommu_get_iova_region_id(dev, data->plat_data);
>   	if (region_id < 0)
>   		return region_id;
>   
> +	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);
>   	mutex_lock(&dom->mutex);
>   	if (!dom->bank) {
>   		/* Data is in the frstdata in sharing pgtable case. */
> @@ -802,6 +828,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>   	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
>   	struct list_head *hw_list = c_data->hw_list;
>   	struct iommu_group *group;
> +	unsigned int bankid, groupid;
>   	int regionid;
>   
>   	data = mtk_iommu_get_frst_data(hw_list);
> @@ -812,12 +839,18 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>   	if (regionid < 0)
>   		return ERR_PTR(regionid);
>   
> +	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);

I think code readability would be improved if we add a new function like 
mtk_iommu_get_id which call mtk_iommu_get_bankid and if necessary 
mtk_iommu_get_regionid.

>   	mutex_lock(&data->mutex);
> -	group = data->m4u_group[regionid];
> +	/*
> +	 * If the bank function is enabled, each a bank is a iommu group/domain.
> +	 * otherwise, each a iova region is a iommu group/domain.

While at it:
"If the bank function is enabled, each bank is a iommu group/domain. Otherwise, 
each iova region is a iommu group/domain."

Regards,
Matthias

> +	 */
> +	groupid = bankid ? bankid : regionid;
> +	group = data->m4u_group[groupid];
>   	if (!group) {
>   		group = iommu_group_alloc();
>   		if (!IS_ERR(group))
> -			data->m4u_group[regionid] = group;
> +			data->m4u_group[groupid] = group;
>   	} else {
>   		iommu_group_ref_get(group);
>   	}
