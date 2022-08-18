Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1E597FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiHRIJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiHRIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:09:57 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9249779EDB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:09:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s9so983040ljs.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=EVo1JzzO+AXs1TK3RqIAy/YrxBDBkv9rEHre/pP8Dec=;
        b=iDsTMsdTlN0fSKLMyb8USiEFCQe0NG9k6CcT9HwE5WmrhuNT4G4y5TxqDO4LrAY01m
         GXKY5NfAe+tOCFRgb4GHyJuIf8Vz8mcsCmLXXze/Jwae+MWVVT8xs7ey4/lfRtPmJgjy
         fWzrjmG51Nc/OYruHWKXiR7Zopsr/OzObK92jZFIX7wmg1OzGVyLY0OaTq000c3hepxh
         39ji9J4eM28CgBleZnmaUiEDgbc34cS+LKfVm1DYf9z3+XkxcxLSQeCGMVvWPkZbMOWC
         obzR5VpRcpvPev0rkt+W+7JzWp2mA7C5PEqATzRwgO7rBCIvafceVsZw/GqN7l6ZdnL3
         gdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EVo1JzzO+AXs1TK3RqIAy/YrxBDBkv9rEHre/pP8Dec=;
        b=aX23y3QtqtEA3BHBUBk1Wnzvs6wyl3zFNEdjMpqa01GUb5AZctOwHUcgTugWPqEZUy
         LCj6LgPHVi6eGl0JrhMdR5LCLsDp//8uv7OQInkLgjhKNDLaidUocr6DnVxZAHBxu78k
         5IWG4nCeNCKwwUSjt1L6sp+PL9RWHFC9ubZK/LalWyfpiOXFxu7XHYyNmUWFxgq4Zg8k
         l00TQ1RC6VctJn3isGemOVnpHkdPju1RAGqSiQ/6N6sjNCVqYfnXwkvf9E023Z0tM36m
         voC8GI2rb3e0urHPz6YpB8b7d8ZG0L0Mi+W6dSYgVxN/UthUNFq2JVSE6KT/mpl3kyNA
         8COw==
X-Gm-Message-State: ACgBeo3Iy8xOZv6VPVhn7axuLtTQfmElZVIY9zAHkqaWTf/hBWsfDxNB
        bhdeaF4H0s4EK3gNjeBDyG59jA==
X-Google-Smtp-Source: AA6agR5oWxJHUE1I2LfnQ5MXv3En7vtZMVUEcP09vZv5xbcLbvExxZ05uPN1/J4xNYLcEhqstH39gw==
X-Received: by 2002:a2e:8e8b:0:b0:261:b3fa:1818 with SMTP id z11-20020a2e8e8b000000b00261b3fa1818mr305679ljk.444.1660810194964;
        Thu, 18 Aug 2022 01:09:54 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id g28-20020a0565123b9c00b0048a9356cd63sm133113lfv.11.2022.08.18.01.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 01:09:54 -0700 (PDT)
Message-ID: <85193de5-244c-2cda-e442-656769b97b14@linaro.org>
Date:   Thu, 18 Aug 2022 11:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] power: supply: rt9471: Add Richtek RT9471 charger
 driver
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1660785696-9010-1-git-send-email-u0084500@gmail.com>
 <1660785696-9010-3-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1660785696-9010-3-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 04:21, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add support for the RT9471 3A 1-Cell Li+ battery charger.
> 
> The RT9471 is a highly-integrated 3A switch mode battery charger with
> low impedance power path to better optimize the charging efficiency.
> 
> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2:
> - Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
> - Specify the member name directly for the use of linear range.
> 
> ---

(...)

> +
> +static DEVICE_ATTR_RW(sysoff_enable);
> +static DEVICE_ATTR_RW(charge_term_enable);
> +static DEVICE_ATTR_RW(port_detect_enable);
> +
> +static struct attribute *rt9471_sysfs_entries[] = {
> +	&dev_attr_sysoff_enable.attr,
> +	&dev_attr_charge_term_enable.attr,
> +	&dev_attr_port_detect_enable.attr,
> +	NULL

You need to document the sysfs ABI in Documentation.

> +};
> +
> +static const struct attribute_group rt9471_attr_group = {
> +	.attrs	= rt9471_sysfs_entries,
> +};
> +
> +static const struct attribute_group *rt9471_attr_groups[] = {
> +	&rt9471_attr_group,
> +	NULL
> +};

(...)

> +
> +static const struct of_device_id rt9471_of_device_id[] = {
> +	{ .compatible = "richtek,rt9471" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rt9471_of_device_id);
> +
> +static struct i2c_driver rt9471_driver = {
> +	.driver = {
> +		.name = "rt9471",
> +		.owner = THIS_MODULE,

You should not need this. Run coccinelle/coccicheck on your driver.


Best regards,
Krzysztof
