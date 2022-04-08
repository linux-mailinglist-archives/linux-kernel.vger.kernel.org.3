Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1E4F90A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiDHIXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiDHIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:23:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3556624B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:21:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so15820016ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xeGOI+hxBRRDCw8I69VJZGllvVRkuKM+GL1fDWIHwuE=;
        b=NMOd190nGhnmVD60Zvn3Etf8Z3SwRZPaQ5AoYH685WmUKlO2nsX2vBdXYbwKFp7kBt
         TnwPNJCpPNbyvcZ8DgooR2RwHXwCIGH0jjrpplV+2dXG3+5EG6COoOUKwCvaqtwHRVU8
         5xYd4miMtAlzUCEVLxlb4c/wJIWGq7lTjOHae6o30zQR9HKPnF7ZQrFe0hA1TgmU6Rv2
         nOSLc7T/jA4pEN6xIGT5KSKrYgffDkt+jyl+GTUg6QTufXdaFDkUauaazQh4JzPc2j9e
         1bd5Q4SMrlmFLquHIC/yu5wBpDHT4DjZp+ga2ugrHX21UlOv//t8rtAqWIWSrOD1nkFg
         31iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xeGOI+hxBRRDCw8I69VJZGllvVRkuKM+GL1fDWIHwuE=;
        b=oQVvQD42fuaSgFt8lEikHB4nk6Eu0fPrn6PsdMZwup4bIecvmxOArLc8BsdKpUf3TR
         vMK0d6nrux/Zhk9cVQZe2Fzv6somf6FKKY39ltuXBjExRcjfA/S4XFjyaTHTAP0WQsYo
         wEEmzjwsAPHiMF+oGESpwx1mIKEtvN42pXZRottCFtuCw4H3Zq2CyZzvjipJmx96HZCM
         jPcPOST97erKqpOBjUL9I0JIACEIrEETbnv09kJWbbqyx+46R53NwihU2wpohNQ3s5qL
         Puq6dizMAGUUmkiCMbKZb5wQ0bEeNNY3WHMSkvDto+79l8dR9/xHLXsbRxYnjFKdkFrz
         k2LA==
X-Gm-Message-State: AOAM531HUWEG6pLJ8U6XyEAUJPU9NGmioSCXTEkPgeR34q1PawVJhdBN
        bWU1wxeV1YNkQdW6GS1OcP4mgg==
X-Google-Smtp-Source: ABdhPJyECBMXetuRDQC9zHM+ji1UA36sURAIRNcwnY01yfNVSOdRrknMnly6epCHA8osgRfsPfiH+Q==
X-Received: by 2002:a17:906:2f97:b0:6ce:3ef6:94be with SMTP id w23-20020a1709062f9700b006ce3ef694bemr17650508eji.136.1649406091573;
        Fri, 08 Apr 2022 01:21:31 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ke11-20020a17090798eb00b006e7fbf53398sm4764031ejc.129.2022.04.08.01.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:21:31 -0700 (PDT)
Message-ID: <76d58182-2f56-32b2-42e9-2ecbdd09ba3d@linaro.org>
Date:   Fri, 8 Apr 2022 10:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     khilman@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408052150.22536-1-johnson.wang@mediatek.com>
 <20220408052150.22536-3-johnson.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220408052150.22536-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 07:21, Johnson Wang wrote:
> We introduce a devfreq driver for the MediaTek Cache Coherent Interconnect
> (CCI) used by some MediaTek SoCs.
> 
(...)

> index 87eb2b837e68..d985597f343f 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
>  	  It reads ACTMON counters of memory controllers and adjusts the
>  	  operating frequencies and voltages with OPP support.
>  
> +config ARM_MEDIATEK_CCI_DEVFREQ
> +	tristate "MEDIATEK CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ

|| COMPILE_TEST? And check if it test compiles.

(...)

> +
> +static int mtk_ccifreq_remove(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;

s/cci_dev/dev/
Everywhere.

> +	struct mtk_ccifreq_drv *drv;
> +
> +	drv = platform_get_drvdata(pdev);
> +
> +	dev_pm_opp_unregister_notifier(cci_dev, &drv->opp_nb);
> +	dev_pm_opp_of_remove_table(cci_dev);
> +	clk_disable_unprepare(drv->inter_clk);
> +	clk_disable_unprepare(drv->cci_clk);
> +	regulator_disable(drv->proc_reg);
> +	if (!IS_ERR(drv->sram_reg))
> +		regulator_disable(drv->sram_reg);
> +
> +	return 0;
> +}
> +
> +static const struct mtk_ccifreq_platform_data mt8183_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 200000,
> +	.proc_max_volt = 1150000,
> +	.sram_min_volt = 0,
> +	.sram_max_volt = 1150000,
> +};
> +
> +static const struct mtk_ccifreq_platform_data mt8186_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 250000,
> +	.proc_max_volt = 1118750,
> +	.sram_min_volt = 850000,
> +	.sram_max_volt = 1118750,
> +};
> +
> +static const struct of_device_id mtk_ccifreq_machines[] = {
> +	{ .compatible = "mediatek,mt8183-cci", .data = &mt8183_platform_data },
> +	{ .compatible = "mediatek,mt8186-cci", .data = &mt8186_platform_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_ccifreq_machines);
> +
> +static struct platform_driver mtk_ccifreq_platdrv = {
> +	.probe	= mtk_ccifreq_probe,
> +	.remove	= mtk_ccifreq_remove,
> +	.driver = {
> +		.name = "mtk-ccifreq",
> +		.of_match_table = of_match_ptr(mtk_ccifreq_machines),

You use of_match_ptr() so is it possible to build it without OF? If so,
then mtk_ccifreq_machines needs maybe_unused.

> +	},
> +};
> +
> +static int __init mtk_ccifreq_platdrv_init(void)
> +{
> +	return platform_driver_register(&mtk_ccifreq_platdrv);
> +}
> +module_init(mtk_ccifreq_platdrv_init)
> +
> +static void __exit mtk_ccifreq_platdrv_exit(void)
> +{
> +	platform_driver_unregister(&mtk_ccifreq_platdrv);
> +}
> +module_exit(mtk_ccifreq_platdrv_exit)

Why not module_platform_driver()?

> +
> +MODULE_DESCRIPTION("MediaTek CCI devfreq driver");
> +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");
> +MODULE_LICENSE("GPL v2");


Best regards,
Krzysztof
