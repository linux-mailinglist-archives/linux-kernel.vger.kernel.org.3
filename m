Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A251848B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiECMtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiECMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:48:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900D8192A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:45:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so9075329edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X5xc8khrWfXRyyoC9UiryZoQ9oxBaqA5OpwQNPSrCwg=;
        b=tGLokiH9nEwrsuNK1MHu3mZOtVER/Jz0IVTajxe17Qk7fXo7UPs9r0K6oT6cnrtFEC
         Y39aeuWA0TEcoazrEDtEHZ/pE0CzZVooQQqASUU6uJXaoTujl7cL4xm5k9dWKh6VwiGU
         rcCVw6zP8beksMWgBxvw/a3DXQzE4oMzJR6OW22nQ2+9LedzvoshdxaR+96EL6s6bBgc
         piwrG0e0608Z7ZBagaDhFwtwVJg9sh1ErSXexIE0o7wH1E4Jf4STPh+lryBPENgjkCbq
         43DAwvrCVOBC/sZC/y+PVR5+qrC5R14vzmvNlyZh0pnpcFiA1dvxBku5GAnvhEumNKyQ
         RB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X5xc8khrWfXRyyoC9UiryZoQ9oxBaqA5OpwQNPSrCwg=;
        b=uL59dWMPtiRYl6iKOuCaN/3qBNNYmX1hNwj2fWyvGeZ2yRGZV2DqsDGmP+SxfxkwOE
         Te0dhlVuBOL/mWulPdzLe464ohtT5dZcVdq6qa5aIsu5xb0VUgU5ftaTNRbZdkecIXHu
         fj2zwW8pFc77HtI6R+mL1U2weozreXM0lSqEht1bGAmZY0uxE4eQAeChSRiMEvsB2ZxB
         zZFlGv1hqzzQrJnJX76UwkYng9Y72OGKJcVkuppZmkX56LtLHmC2DS6Xgwk5RP7sL8dW
         A05B635yvx0i8F3Ga3wqFnWSEYpF8aWgiBv1CbxyY8zdszzDTcvB/e44QZVfvxO+1gzw
         Sjwg==
X-Gm-Message-State: AOAM531QtSXuNCVna/0/7lE5n263U9Dmbed6K0TnkVUut1jVRZBArgl0
        usbAxU+keEGXmO5BgjXSf1LVtw==
X-Google-Smtp-Source: ABdhPJxTStsbY/p6UStlTDO7k8CzuStWVcAMOGXPE9UDmDIlgD9sPTlihPh4SfAec3T7nTDorsdJaQ==
X-Received: by 2002:a05:6402:d0e:b0:413:3d99:f2d6 with SMTP id eb14-20020a0564020d0e00b004133d99f2d6mr17883961edb.189.1651581921201;
        Tue, 03 May 2022 05:45:21 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jl6-20020a17090775c600b006f3ef214e64sm4533443ejc.202.2022.05.03.05.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:45:20 -0700 (PDT)
Message-ID: <e00ff3b2-d5d1-706d-49cc-e70fe2cc9cab@linaro.org>
Date:   Tue, 3 May 2022 14:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] mux: lan966: Add support for flexcom mux controller
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        peda@axentia.se
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, Manohar.Puri@microchip.com,
        UNGLinuxDriver@microchip.com
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
 <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503105528.12824-5-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 12:55, Kavyasree Kotagiri wrote:
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/mux/driver.h>
> +#include <linux/io.h>
> +
> +#define FLEX_SHRD_MASK		0x1FFFFF
> +#define LAN966_MAX_CS		21
> +
> +static void __iomem *flx_shared_base;

Why do you have file-scope shared variable? Cannot it be passed via
private data?

> +struct mux_lan966x {
> +	u32 offset;
> +	u32 ss_pin;
> +};
> +
> +static int mux_lan966x_set(struct mux_control *mux, int state)
> +{
> +	struct mux_lan966x *mux_lan966x = mux_chip_priv(mux->chip);
> +	u32 val;
> +
> +	val = ~(1 << mux_lan966x[state].ss_pin) & FLEX_SHRD_MASK;
> +	writel(val, flx_shared_base + mux_lan966x[state].offset);
> +
> +	return 0;
> +}
> +
> +static const struct mux_control_ops mux_lan966x_ops = {
> +	.set = mux_lan966x_set,
> +};
> +
> +static const struct of_device_id mux_lan966x_dt_ids[] = {
> +	{ .compatible = "microchip,lan966-flx-mux", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mux_lan966x_dt_ids);
> +
> +static int mux_lan966x_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct mux_lan966x *mux_lan966x;
> +	struct mux_chip *mux_chip;
> +	int ret, num_fields, i;
> +
> +	ret = of_property_count_u32_elems(np, "mux-offset-pin");
> +	if (ret == 0 || ret % 2)
> +		ret = -EINVAL;
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "mux-offset-pin property missing or invalid");
> +	num_fields = ret / 2;
> +
> +	mux_chip = devm_mux_chip_alloc(dev, num_fields, sizeof(*mux_lan966x));
> +	if (IS_ERR(mux_chip))
> +		return dev_err_probe(dev, PTR_ERR(mux_chip),
> +				     "failed to allocate mux_chips\n");
> +
> +	mux_lan966x = mux_chip_priv(mux_chip);
> +
> +	flx_shared_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +	if (IS_ERR(flx_shared_base))
> +		return dev_err_probe(dev, PTR_ERR(flx_shared_base),
> +				     "failed to get flexcom shared base address\n");
> +
> +	for (i = 0; i < num_fields; i++) {
> +		struct mux_control *mux = &mux_chip->mux[i];
> +		u32 offset, shared_pin;
> +
> +		ret = of_property_read_u32_index(np, "mux-offset-pin",
> +						 2 * i, &offset);
> +		if (ret == 0)
> +			ret = of_property_read_u32_index(np, "mux-offset-pin",
> +							 2 * i + 1,
> +							 &shared_pin);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read mux-offset-pin property: %d", i);
> +
> +		if (shared_pin >= LAN966_MAX_CS)
> +			return -EINVAL;
> +
> +		mux_lan966x[i].offset = offset;
> +		mux_lan966x[i].ss_pin = shared_pin;
> +
> +		mux->states = LAN966_MAX_CS;
> +	}
> +
> +	mux_chip->ops = &mux_lan966x_ops;
> +
> +	ret = devm_mux_chip_register(dev, mux_chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mux_lan966x_driver = {
> +	.driver = {
> +		.name = "lan966-mux",
> +		.of_match_table	= of_match_ptr(mux_lan966x_dt_ids),

of_match_ptr comes with maybe_unused on data structure. Are you sure it
does not have W=1 warnings during compile tests? Just drop the of_match_ptr.

> +	},
> +	.probe = mux_lan966x_probe,
> +};
> +
> +module_platform_driver(mux_lan966x_driver);

Missing MODULE() stuff.


Best regards,
Krzysztof
