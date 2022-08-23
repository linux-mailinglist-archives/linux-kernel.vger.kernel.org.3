Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F310359ED8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiHWUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiHWUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:40:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26DC10569;
        Tue, 23 Aug 2022 13:30:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x25so14570143ljm.5;
        Tue, 23 Aug 2022 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ANocm8E2uy/jBMLL71e6vsyUKSi9nweumKazyVLQ5ak=;
        b=J//ksofmSYZpmsIpnVWzTKd5cegv6H6q/ikBN6Fq/db2rLD+9J4ybKHaNbsElkw50V
         PmsgbiICDnipJKeUlgnNCPLNgveAehPpqHqrfIyaptXu3btkmmDhSWdXp75BD4Tcy8pU
         6FuuXtde79Wa5lRDMuk+xKQ/s6DOjK5T0QfijSXLqk7a/nc/eyRJDzihVlJ0Kd91LXDh
         FFyrua/3HEBvr8eKyPAQ7iAiwP5kKCgaFtK5559/d26//3wkDfLYr92OdROjZxvmqVdV
         7nKCLYKzJMBUAH/jQ8VDBjzdorluJMVrYyGNbcWOAbJSGUrLAlwEqQBPUFb87ul6jzbE
         JELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ANocm8E2uy/jBMLL71e6vsyUKSi9nweumKazyVLQ5ak=;
        b=B4RfDvvH1tCtwc18OamN9mGnmgeDxUC7ArKGeQztaHvCfpqp8JcTzlqXtO9c1FnKAt
         3xbpPTjNHmQhCQQmuSdJpOUJHWv3Mg4NU57Zl+zCVaQv6I1BICargI3QMP9SCJNDDWBE
         ESIOAxMPKCmvq+IjYQMYuimi0PdvyZGThGYZXKBPSK8+o9RCTQQiwB/6lqLhpMgQIyCv
         yc+aHk2hOUKw50YtVqEwKJR123REhBY/jbVEgM/c8Vd5KzIbd+9DV8NDjxDeiIEjxJJd
         KWhnjovJAYofhk94XKpxj9VbwxEm2MqW+cMtcmxdRpaxIfmDYrUPleVLTJ5DvWk48POq
         Zr3A==
X-Gm-Message-State: ACgBeo3iaKewxV0lDSKNR7dXMvTVRE2I7nqucW2Gx1IqGi7jTosZA9oh
        mluC9uSOTbXQhbIPhnyVzX4=
X-Google-Smtp-Source: AA6agR4Vl9QT4NovByq9zRcaltSU7uZqnyMg04odslwUOSiPHyfZc8Aci2bnC4t7vPZhhzCjrOU+wQ==
X-Received: by 2002:a2e:bf29:0:b0:25f:fbd5:b693 with SMTP id c41-20020a2ebf29000000b0025ffbd5b693mr7698393ljr.372.1661286656012;
        Tue, 23 Aug 2022 13:30:56 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id g21-20020a2eb5d5000000b00261c19bbb6asm1942544ljn.97.2022.08.23.13.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:30:55 -0700 (PDT)
Date:   Tue, 23 Aug 2022 23:30:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Add deferred controller registration support
Message-ID: <20220823203052.swtnlf4ixjmkop6t@mobilestation>
References: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
 <YwTCtOp30H2JIkkV@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwTCtOp30H2JIkkV@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 01:06:12PM +0100, Mark Brown wrote:
> On Mon, Aug 22, 2022 at 09:18:53PM +0300, Serge Semin wrote:
> > It's pretty possible to have the spi_register_controller() method
> > returning -EPROBE_DEFER status in case, for instance, if the GPIOs used
> > for the CS implementation aren't ready to be requested due to the
> > corresponding platform devices still pending to be probed. Let's make sure
> > the DW SSI driver won't print error message in that case by calling the
> > dev_err_probe() function if the SPI-registration procedure exited with
> > a non-zero status.
> 

> This isn't adding any new support, it's making the logging less verbose
> - deferred probe worked perfectly fine without this patch.

Thanks for the note. Indeed a more correct subject would be something
like "Prevent error msg printed on deferred probe". Anyway since
you've already merged the patch in, no v2 then.

-Sergey

