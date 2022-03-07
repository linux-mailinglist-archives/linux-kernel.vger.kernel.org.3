Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDFB4D0723
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiCGTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbiCGTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:03:38 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D977A11C21
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:02:43 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 207413F60B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646679762;
        bh=Vq+Wtj+GyJ+co0AT1jDLyXY4eOmwo/VOwm55xSz0z6A=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iaibsntuZUYaI9SuqeS53Lsp5ttMCrc13+sj4nSDHaoNBltU5HfuySfw7R9VwgYzs
         zvDsLGXz/3x0VqLzgdgAxcFRdNw4AEWMov5g3xYqh6Dq6cY0srtKQuCNbLWqnh7TmN
         DorIe2KLzdp6AnWZyIMPg1C+BEBsUii70txrZ9Wjc6MyI8/++Q4vwfSl3vrGaod5s+
         hbDUhNPoQGNrcmL1wwO7DtrPSDVjao7BActJVlmR+/XSE1ebL6AXTjYFZdMLTa9019
         6nEPWb0sSg30x6OwabiNFEpYYMgAQGf9abPOLZ9l5e6BlYuRHo+ZGLpnc6t2sxe6EH
         9OPrJdRicB7Pw==
Received: by mail-ed1-f69.google.com with SMTP id h17-20020a05640250d100b004133863d836so9197264edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 11:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vq+Wtj+GyJ+co0AT1jDLyXY4eOmwo/VOwm55xSz0z6A=;
        b=4y0tIZAfmXWefCs+LDfuD2CgGubzyVIlU1CJlldw08it6Uw/H7R8WJuoKRe21DCbZ3
         J7c/wuWS/qATX8VnXK56k0xh5+seW/TDHrbVpCd7CXuOADkb5szahMF0MdxAYOYSwozu
         q/5Viwl9sx1ShnULrunaJrwfbjrYd8Yjg6R/xivIJuVk/ez5UBMWqQpsyvLSpoI+hvsP
         20EVqtrF6ZgCT7Yy6/eYd0HhVdhPAcgqsLC+Esd2FEWBt7JfFN8puUrz2DGE6pLa/oO/
         R8nQM0rKcJpAqx49KBYwGi3KEZtBjQEccrkZWaGt9imdHUf9Nzx9NFiC3aP9/T5SZHIG
         hyfg==
X-Gm-Message-State: AOAM530O/mv0zs0Yf2o97dN3NHq21boIfIwMVL4oIBhjM3Hjhgz6OZ4L
        c+kDsRxMUb7yzNrpi2wjNrjSn7CHwHrusTdXV2uIMYqOw6HGjrreR0tZ1ALf/rFE+xbBHCkaTH6
        zJvs7cFprybSqOnXhSuD08NSgLILGcmGnmCfYrMcjXw==
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id a10-20020a056402168a00b003fb600e4cc3mr12645895edv.32.1646679761691;
        Mon, 07 Mar 2022 11:02:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGHTRfZqI1f7NfmlXnfc8CnSpyAgiiBB+6cgpM2S/0teiqFrn9zZ+Tl1DI7G8Bi+m6XdPd9A==
X-Received: by 2002:a05:6402:168a:b0:3fb:600e:4cc3 with SMTP id a10-20020a056402168a00b003fb600e4cc3mr12645854edv.32.1646679761342;
        Mon, 07 Mar 2022 11:02:41 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm6699066eds.21.2022.03.07.11.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:02:40 -0800 (PST)
Message-ID: <0fa44005-158b-74ee-f4ff-f2694ffce38a@canonical.com>
Date:   Mon, 7 Mar 2022 20:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] cpufreq: mediatek: clean up cpufreq driver
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-4-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122151.11666-4-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 13:21, Tim Chang wrote:
> cleanup of naming, print log and comments.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 487 ++++++++++++++---------------
>  1 file changed, 233 insertions(+), 254 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 8e9d706d8081..3f00c7eb01f1 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015 Linaro Ltd.
> - * Author: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> + * Copyright (C) 2022 MediaTek Inc.

Removal of authorship and existing copyrights does not fit into "clean
up". Please explain this thoroughly.

>   */
>  
>  #include <linux/clk.h>
> @@ -22,7 +21,7 @@
>  #define VOLT_TOL		(10000)
>  
>  /*
> - * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
> + * The struct mtk_cpufreq_drv holds necessary information for doing CPU DVFS
>   * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
>   * Mediatek SoCs has two voltage inputs, Vproc and Vsram. In some cases the two
>   * voltage inputs need to be controlled under a hardware limitation:
> @@ -32,7 +31,7 @@
>   * needs to be switched to another stable PLL clock temporarily until
>   * the original PLL becomes stable at target frequency.
>   */
> -struct mtk_cpu_dvfs_info {
> +struct mtk_cpufreq_drv {
>  	struct cpumask cpus;
>  	struct device *cpu_dev;
>  	struct regulator *proc_reg;
> @@ -40,45 +39,45 @@ struct mtk_cpu_dvfs_info {
>  	struct clk *cpu_clk;
>  	struct clk *inter_clk;
>  	struct list_head list_head;
> -	int intermediate_voltage;
> +	int inter_voltage;
>  	bool need_voltage_tracking;
> -	int old_vproc;
> -	struct mutex lock; /* avoid notify and policy race condition */
> +	int old_voltage;
> +	struct mutex lock;  /* avoid notify and policy race condition */
>  	struct notifier_block opp_nb;
>  	int opp_cpu;
>  	unsigned long opp_freq;
>  };
>  
> -static LIST_HEAD(dvfs_info_list);
> +static LIST_HEAD(drv_list);
>  
> -static struct mtk_cpu_dvfs_info *mtk_cpu_dvfs_info_lookup(int cpu)
> +static struct mtk_cpufreq_drv *mtk_cpufreq_drv_lookup(int cpu)
>  {
> -	struct mtk_cpu_dvfs_info *info;
> +	struct mtk_cpufreq_drv *drv;
>  
> -	list_for_each_entry(info, &dvfs_info_list, list_head) {
> -		if (cpumask_test_cpu(cpu, &info->cpus))
> -			return info;
> +	list_for_each_entry(drv, &drv_list, list_head) {
> +		if (cpumask_test_cpu(cpu, &drv->cpus))
> +			return drv;>  	}
>  
>  	return NULL;
>  }
>  
> -static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
> -					int new_vproc)
> +static int mtk_cpufreq_voltage_tracking(struct mtk_cpufreq_drv *drv,
> +					int new_voltage)
>  {
> -	struct regulator *proc_reg = info->proc_reg;
> -	struct regulator *sram_reg = info->sram_reg;
> -	int old_vproc, old_vsram, new_vsram, vsram, vproc, ret;
> -
> -	old_vproc = regulator_get_voltage(proc_reg);
> -	if (old_vproc < 0) {
> -		pr_err("%s: invalid Vproc value: %d\n", __func__, old_vproc);
> -		return old_vproc;
> +	struct regulator *proc_reg = drv->proc_reg;
> +	struct regulator *sram_reg = drv->sram_reg;
> +	int old_voltage, old_vsram, new_vsram, vsram, voltage, ret;
> +
> +	old_voltage = regulator_get_voltage(proc_reg);
> +	if (old_voltage < 0) {
> +		pr_err("%s: invalid vproc value: %d\n", __func__, old_voltage);
> +		return old_voltage;


Several different changes in one commit. Please read the document
"Submitting patches".

(...)

> -MODULE_AUTHOR("Pi-Cheng Chen <pi-cheng.chen@linaro.org>");
> +MODULE_AUTHOR("Jia-Wei Chang <jia-wei.chang@mediatek.com>");

Ekhm, why? He was not the author?

Best regards,
Krzysztof
