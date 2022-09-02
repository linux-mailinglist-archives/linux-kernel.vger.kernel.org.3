Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA5E5ABAC4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiIBWUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiIBWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:20:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74586527E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:20:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lx1so6381742ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MnthNxIiFeaOCUSOEozywdNetMkLAmt+YGycE0QV4QM=;
        b=NfXhAeOjDbvXltWBSu37ZF/YA3RYAZaaGHMDc1F2/Dysb/I13Qzon5Xh9xqzY9gk7u
         BakD0wloYQbP1+LabGCwbdoA4AS2EXA+weFBzebpHBpzQ8V/b2lCntgfsfQBusodLwrt
         TMFMmRD8U6LSGYaX1sZ3z4LaV7tfj2MKGoWoyNJLhiQ/Jy+uRm0kTpLmLa5xY9wntnsK
         /eQbetP61njkSrUJybrFWqp+CnGbWclTH1EqOe9aI+Z7FTneOVHDRWqm1dAJuJPKpsdZ
         FAvKsgxrKX0JqZR2NQG4BoM36lh7bX9RrZ+VPBez9gNtDcYCKZ1TeRTXytnCSZjjhvB0
         f1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MnthNxIiFeaOCUSOEozywdNetMkLAmt+YGycE0QV4QM=;
        b=ONGcH/VLp5HYc9xwprMTzTovEsdNyRyWOnxqQ73S2tzvUx7T8pn8vyYyRGZrgnUC06
         1j5zqQw8avN43KYN9KYn/Zsj79LRZJJKhCeXTy3Izlwwy82oY7lj9Ni7PV0YzfIZdrRB
         A+5kRaKX41V748eGKsdOFW26KkMfyej+JM6/pV3yFcoAOKP3DOGXhvTqHp1iHKHROm7V
         9/ANT5S8wEAMNnEGGcwVCwr/ZS9ptc0wFVBmMQrz1ImIVLlZ/rvteJ097qmoZOFeceyF
         A7bfdUw+li0GlUZ9m1f3/K87nZllE+hUjp0TMKGXp7mc53n69se2C7sue51cw8hHPaIT
         Jdmg==
X-Gm-Message-State: ACgBeo286P3Ur2ujJkdg6fBNhNLZELnKYBnPdJ02Il60Ci7RCqzoMO8K
        cWJaBX4xDlyAu6+nbbazSUzHrM7l3XtdFehgqv0zwA==
X-Google-Smtp-Source: AA6agR4iRgKtyOZNhp11XLNwwluig/zcoqFih0licH++8iY0fBbsO8qKVZh8mZRl9lWXjgFGrMdJ/Rm9O2NUbut4tqY=
X-Received: by 2002:a17:907:6293:b0:73d:b27b:e594 with SMTP id
 nd19-20020a170907629300b0073db27be594mr29165863ejc.526.1662157204499; Fri, 02
 Sep 2022 15:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
In-Reply-To: <20220831135636.3176406-1-claudiu.beznea@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Sep 2022 00:19:53 +0200
Message-ID: <CACRpkdbz7YmThCa2-q2XWrvN3diB_TR+dntL2YTGXCsmaYP-wA@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: at91: cleanups
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 3:54 PM Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:

> Machine specific PM code was calling gpio driver specific code to enable
> wakeup interrupts. Moved this code to the pinctrl-at91 driver as close
> as possible to the moment machine specific code is executed (in .noirq
> member of struct dev_pm_ops). The code has been tested on sama5d2_xplained,
> sama5d3_xplained, sam9x60ek, sama7g5ek.
>
> Along with it added 2 cleanups.

Patches applied!

Yours,
Linus Walleij
