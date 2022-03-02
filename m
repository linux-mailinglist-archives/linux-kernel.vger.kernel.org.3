Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5E4CAC88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbiCBRxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiCBRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:53:31 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35395DFDF;
        Wed,  2 Mar 2022 09:52:48 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id j2so2420859oie.7;
        Wed, 02 Mar 2022 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DHY7VhQT9qgEOgLNTzp5elUV+Jbj7LJzyVtU0MTV7u0=;
        b=g0Sypa3YZdvUNqPWk96PKSCJoH/f25NWGfg49/dnqFxSTEzr1DvRckN9/3j6eV4E+J
         Lz5L8MUGvA5B+UHdHqg9a3xgDErG3VWm13D15YVZqqvxbyjZhc+5KquLgzC/UV2xWnup
         933KBI3pNA1IIT6OZBgxG6ZYz1gkcSztHgd4aQxfhuYMc0Uixh90wTvizaW6qWPGVkjb
         My0mQ5FcZzfQHVHRUAhcW3Ef0bD3vzfv+SOMcV8wShZ/MOes6+Gy7hmlAnj0meu0Ugdy
         +4TqXbihb1abqPz7Ikc+1c1bo0yoKJmJsaiqv1YdjbATVWTvTOZEJWbztqPdJMV7xNMH
         UfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DHY7VhQT9qgEOgLNTzp5elUV+Jbj7LJzyVtU0MTV7u0=;
        b=3Vy3SMQHifTU02lfQrnBckGaUB8f/qmc1M3aMfalDOE9kkaKOH25JJHNIMPi+N9nxR
         x2rqGFGb9G6jAFEumKDNaVkE8wPWdgkCrSGL4MjTiK4GkMYw4pkwgdgtibWEVWNxPV/+
         yNCONQd/jZM5UC+IQHcHCk9SWCoHGSIdxy8olS02Ep0Z6xhl0WLJRw8weWLURKTTNaGX
         nBfbistakosGonzSerabzE4s/NOQGH60yDHJe6Q3vLSs7ZFMrS2P2ief5lk1gN2WXzNW
         mMxzsTz86BHt6eeE4tuxX90BUjSuXKlsJ15gJxNDIE/ZZyQW9xb7uZjGBJoK12jE0XEz
         q9Dw==
X-Gm-Message-State: AOAM532yR/VNlXDU5MbBsmDC2vnlHpE6mFrQxXFWAy6gJTtbq/gmtoXM
        3Nu+FnCxiTfL4vyht74KcDE=
X-Google-Smtp-Source: ABdhPJynHpROhEGrP3XoKGr8nXoImP0Gk3bV0Le6WzH86xThLA4c7sYZmfBOVPsWKAeZ8J5UYiQ62w==
X-Received: by 2002:a05:6808:13c6:b0:2cf:84a3:fdfa with SMTP id d6-20020a05680813c600b002cf84a3fdfamr915319oiw.55.1646243567518;
        Wed, 02 Mar 2022 09:52:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bl26-20020a056808309a00b002d4f48e3799sm10233983oib.12.2022.03.02.09.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:52:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Mar 2022 09:52:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 0/3] Support XDPE112
Message-ID: <20220302175242.GA2522403@roeck-us.net>
References: <cover.1646214248.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646214248.git.sylv@sylv.io>
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

On Wed, Mar 02, 2022 at 10:49:18AM +0100, Marcello Sylvester Bauer wrote:
> Add support for Infineon Multi-phase XDPE112 family regulator. The main
> difference to the XDPE122 family is it uses a different format for
> voltage out. Add the required logic to the existing xdpe12284 driver
> accordingly.
> 
> Changes in v4:
> - move VOUT_MODE format detection into identify function
> 
> Changes in v3:
> - detect VOUT_MODE during probing
> - set xdpe122_identify/xdpe122_read_word_data only if VOUT is vid
> 
> Changes in v2:
> - rebase on current hwmon-next branch
> 
> Marcello Sylvester Bauer (3):
>   dt-bindings: trivial-devices: Add xdpe11280
>   hwmon (xdpe12284): Add support for xdpe11280
>   hwmon (xdpe12284): Add regulator support
> 
>  .../devicetree/bindings/trivial-devices.yaml  |  2 ++
>  Documentation/hwmon/xdpe12284.rst             | 12 ++++---
>  drivers/hwmon/pmbus/Kconfig                   |  6 ++++
>  drivers/hwmon/pmbus/xdpe12284.c               | 32 +++++++++++++++++--
>  4 files changed, 45 insertions(+), 7 deletions(-)
> 

Series applied to hwmon-next.

Thanks,
Guenter

