Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892FA58C661
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbiHHK2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiHHK2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:28:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB062638E;
        Mon,  8 Aug 2022 03:28:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so8612155pjf.5;
        Mon, 08 Aug 2022 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=4djeHmc6H0j5ABAGLKuMZwwbdGA+AzyfiwDeNc2b8T0=;
        b=Uz8mSuG1Q6Rt0PPYZDqn1G2YFKjrlobnzNGdtVQ6GCF5FC65gunCkQWPN+BskZ2ZUG
         2sIo2tmeD3PXm1UUkxFIfWHeZiyEQwLN37FR+ereVECvMsNas5i8j8jCbTJvLkaKcflV
         TKTQ/T237dE8+mqFsEEtPyQBxdpN7htqIjrkOPmkbFKv/ql9jpQjTY3iFQaog3Fky3up
         /WkkhyRyovaa/+SLM+zozEPWM1T0vMefUcPGiptiSB7HtKIW6Px+ln+K4dqbXALoyBlx
         DBTKtekntTdYNpKG+XQ1Hljr6yMpB7urRvhwQ1NXddA1L4PQmjnAp/qxF3MnwuRApfDw
         9INw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=4djeHmc6H0j5ABAGLKuMZwwbdGA+AzyfiwDeNc2b8T0=;
        b=JXxXzNStwHsgFI+j1wg+PhxF9NHoqa0Kmo0YFI6TwOvxTconviDQ7eK+HaxtsXWNSb
         uJbFhplnVztEoVeK7EEMg+xJvwPEctY5LO5qHlqPZs4yfr6aDwxmpINb60Nk5Bi9t5kq
         sU+nnZ2sAy7FH77JOlxXqDw9ZrwIei2mYDb8ayP0A3d8VxbI7zXUxd7q+5RbdwJutKoI
         qvvEXRTLvlpWsPjmZrfD6M15mLdrz3wLpQPNpXC9eOZPcWDwUNaNNK0ZKHrBFOSWqhkI
         giFUU8OeTBfzJkLGKbzkDISZm3TZqdC/iTvuBh0T1SHLjr3NIatTv097BWaCoHBuB8S1
         W1yw==
X-Gm-Message-State: ACgBeo3zu/9flE7r1SiDYNcma3DQyXIIjFVd99pmcoax1GxQ8uTvtqCL
        VSVNDNAd0sve31OyZG2Ub00=
X-Google-Smtp-Source: AA6agR6f405nhrlrDg7OQoaEsh1jRifFxPPtvfFXLo1uSviQxr3RrGMRXlVM3BFxJmA/8hEDypq2pw==
X-Received: by 2002:a17:90b:3ec1:b0:1f5:15a6:aaf5 with SMTP id rm1-20020a17090b3ec100b001f515a6aaf5mr20131839pjb.123.1659954480141;
        Mon, 08 Aug 2022 03:28:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m11-20020a62a20b000000b0052d9d95bb2bsm8267790pff.180.2022.08.08.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:27:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 Aug 2022 03:27:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5 27/33] hwmon/drivers/core: Switch to new of thermal API
Message-ID: <20220808102758.GB1969424@roeck-us.net>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-28-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804224349.1926752-28-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 12:43:43AM +0200, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Based on other feedback, it apears that with this patch in place the
hwmon device fails to register unless it is indeed part of a configured
thermal zone (which so far was optional). Given that, I have to withdraw
my Acked-by: tag until this problem has been resolved.

Guenter
