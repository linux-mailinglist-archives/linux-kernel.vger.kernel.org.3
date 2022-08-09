Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B301858D6F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiHIJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiHIJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:58:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70554220CA
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 02:58:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e15so16368007lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dNKI0alQrhjS9L9F86wgRZLWLDDwbvdm53vSyGV+VS4=;
        b=VhMw8Rgdr+ABmi3Y576qLby0119i9K2rnMNLgJVMYDkOe8lWHUAdPHSJb3GxrjaX/Z
         G65bSFLOoeTD8sDHc9I4MWY5WhPn1qz3C278MibJzNs9kJ17stkjDzn1wBxx8Kq1EcB6
         2SVIuwcrIst1UyNe0LSGc/wj2waD+ZbI5JKgTPnyQMPTrYRPcdjCZT2JU6OIA8DLdu4d
         MgfoeqCKkmcLShXV3xVZ+dYzF073w2GZfbMysaRQLv4hy6Dv86THbDtJgQEE/j/MpanL
         GtZRRLMMH3kbUASiQ48JoOWfzdf9XVcfKIVLN9zMlAa2em4anGLFbBZhWnoiQh0oOlB6
         bM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dNKI0alQrhjS9L9F86wgRZLWLDDwbvdm53vSyGV+VS4=;
        b=x7EceYr3B2ZN6phajluhsX6JPbozZroge2IMG4ulXR8DT3iWOiWAj2HgD7YUHA7pH6
         zyU5cCrj0cJXmIzbCGZlwt5LToyNG7cvDML8JuCNVHneQ0nVjOZmNl+TRUsVRrClWbF1
         obuy2UGhaehjI3/Zu8A8BL9bPyJ3X8nIouaeAPP96ANUVoZPHq5Y+8SSbwbL7TXnGQor
         6bIb9ZQhp340wLkpjcdikrDbg7rHq/ifwYSDh7FoK7hMmMhNYDAOWgNcZ33ein6updMu
         67+9J/2clnXK10soyOPz/A3MGXhQhHjtZO5imVNiyeI/+jiiPPJNbFuRqM7cXL+32z2K
         ulPg==
X-Gm-Message-State: ACgBeo24V5G0jmvHT9E8cOsazoMTmrUO+pM+UnJKeiWhMSi5QrOd/rij
        HSi3H+N8OQXhjaUIyvvwo32cOg==
X-Google-Smtp-Source: AA6agR44h8B1/uwdCyXQkdtIOlFe25gbtHpOlAJmp/D1KFFnmNubjQd6v8FYZkEJPiQhaJLwxPt4Ww==
X-Received: by 2002:a05:6512:10d0:b0:48b:80d:849b with SMTP id k16-20020a05651210d000b0048b080d849bmr8261320lfg.399.1660039133661;
        Tue, 09 Aug 2022 02:58:53 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id v22-20020a197416000000b0048ad4c718f3sm1709823lfe.30.2022.08.09.02.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 02:58:52 -0700 (PDT)
Message-ID: <26ad247d-a4b3-4051-b8d9-505c09b76f6b@linaro.org>
Date:   Tue, 9 Aug 2022 12:58:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/3] memory: Add Broadcom STB memory controller driver
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220801220931.181531-1-f.fainelli@gmail.com>
 <20220801220931.181531-4-f.fainelli@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801220931.181531-4-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 01:09, Florian Fainelli wrote:
> Add support for configuring the Self Refresh Power Down (SRPD)
> inactivity timeout on Broadcom STB chips. This is used to conserve power
> when the DRAM activity is reduced.
> 


> +static int __maybe_unused brcmstb_memc_resume(struct device *dev)
> +{
> +	struct brcmstb_memc *memc = dev_get_drvdata(dev);
> +
> +	if (memc->timeout_cycles == 0)
> +		return 0;
> +
> +	return brcmstb_memc_srpd_config(memc, memc->timeout_cycles);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(brcmstb_memc_pm_ops, brcmstb_memc_suspend,
> +			 brcmstb_memc_resume);
> +
> +static struct platform_driver brcmstb_memc_driver = {
> +	.probe = brcmstb_memc_probe,
> +	.remove = brcmstb_memc_remove,
> +	.driver = {
> +		.name		= "brcmstb_memc",
> +		.owner		= THIS_MODULE,

No need, run coccinelle.

> +		.of_match_table	= brcmstb_memc_of_match,
> +		.pm		= &brcmstb_memc_pm_ops,

Shouldn't this be pm_ptr()? and then no need for __maybe_unused in
brcmstb_memc_resume/suspend.

> +	},
> +};
> +module_platform_driver(brcmstb_memc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Broadcom");
> +MODULE_DESCRIPTION("DDR SRPD driver for Broadcom STB chips");


Best regards,
Krzysztof
