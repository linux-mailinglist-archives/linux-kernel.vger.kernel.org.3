Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51054BC64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357876AbiFNVD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357710AbiFNVDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:03:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA10506C2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:03:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d5so6149494plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=54uqX4hoxceYxZbvXXXTQIRCQh50Z99ozZMeQkD5dEg=;
        b=KPGKRgHC5n8hWs2HP0HefSE6DkYDIETw7epRbgNMqeA2V9Lv/O6MTXFZpSwfhZrQSx
         pPHYr/9NXuMF2wPXKlCtcPkRQmGoW8YTg7ZUFh0VFPchZdwTfzhVCshMqbJG5riAQPLI
         PDYS8v64XEw8vsdnYaJea9nU/dMobg8aXd1k2lnipdWh0We3aElzh6C9CzlZwQ0UtXbT
         MJ0dT5ahLlIXRIUOxz9SHanzYNlA3G71tKHRa2If59GERiWa/uSJTf+Ao2aVEv4KVzDi
         okFAfbBrEPXKHtHBp1hmSlUpbIzsL/v5P4mCeivarjnOxmlGAYh3OUtav88xmr2MRQCf
         Jksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=54uqX4hoxceYxZbvXXXTQIRCQh50Z99ozZMeQkD5dEg=;
        b=HoFioczc9rX+X0MjZnbW51mgCejmZvl/uZyqZ85KiKYXYvB1nV8HzZLI7EelDTI5m6
         yDoJQhLeaiaxRCXBTjBAZDiUqn6YHyjZUxwI3SEf+cKJw03C2i8SGs/vnysoBLJLz8em
         1JiMCR2QrjN308Q3zbYpYXmjlhiZ0OpTVeZPOeutBrK8HHGolWk5jOhTF/x/zzk2rip/
         txyzNaL8IMnzRhqRPh4F+M/X7ryU/OnNyhJeHWEu5sUC9m4iRqmqkxn4NFP3qOS/H3Sk
         7GY2WwTWl7n3y5/faSaN79/Qt6ER+osM6aW/UvIGcgc9fsRRjYUNDtU9GgVordOMJsJ1
         /Ssw==
X-Gm-Message-State: AJIora/UHzOTnE9LR5+kA79IWIpvmYldgqUfZYpQyU+tZZb3zRaljNjo
        bAeB+hhc0AnMMybebHaSs4UPMg==
X-Google-Smtp-Source: AGRyM1uhtOpnkODqEAnt2BMBBTumHS2aKQXcRkaESL5xgjTuUoibnJg//T9j+N0OhBrTniTj1c+NWw==
X-Received: by 2002:a17:903:2291:b0:167:59ad:52e8 with SMTP id b17-20020a170903229100b0016759ad52e8mr6373890plh.121.1655240628282;
        Tue, 14 Jun 2022 14:03:48 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b001635a8f9dfdsm59307plm.26.2022.06.14.14.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:03:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome NEANNE <jneanne@baylibre.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, will@kernel.org, lee.jones@linaro.org,
        jneanne@baylibre.com
Cc:     narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 2/5] mfd: drivers: Add TI TPS65219 PMIC support
In-Reply-To: <20220613090604.9975-3-jneanne@baylibre.com>
References: <20220613090604.9975-1-jneanne@baylibre.com>
 <20220613090604.9975-3-jneanne@baylibre.com>
Date:   Tue, 14 Jun 2022 14:03:46 -0700
Message-ID: <7hy1xznej1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome NEANNE <jneanne@baylibre.com> writes:

> The TPS65219 is a power management IC PMIC designed
> to supply a wide range of SoCs
> in both portable and stationary applications.
> Any SoC can control TPS65219 over a standard I2C interface.
>
> It contains the following components:
> - Regulators.
> - Over Temperature warning and Shut down.
> - GPIOs
> - Multi Function Pins (MFP)
>
> This patch adds support for tps65219 mfd device. At this time only
> the functionalities listed below are made available:
>
> - Regulators probe and functionalities
> - warm and cold reset support
> - SW shutdown support
>
> Signed-off-by: Jerome NEANNE <jneanne@baylibre.com>

[...]

> +/**
> + * pmic_rst_restart: trig tps65219 reset to SOC.
> + *
> + * Trigged via notifier
> + */
> +static int pmic_rst_restart(struct notifier_block *this,
> +			  unsigned long mode, void *cmd)
> +{
> +	struct tps65219 *tps;
> +
> +	tps = container_of(this, struct tps65219, nb);
> +	if (tps != NULL) {
> +		if (WARMNCOLD)

This value is hard-coded to 1 in the header, so war reset will always be
done.  

> +			tps65219_warm_reset(tps);
> +		else
> +			tps65219_cold_reset(tps);

Doesn't the reboot_notifier get a value like REBOOT_WARM,
REBOOT_COLD etc (c.f. enum in linux/reboot.h)  so you could properly select?

Kevin
