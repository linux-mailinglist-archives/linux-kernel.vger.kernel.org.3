Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5A59DF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357235AbiHWLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357180AbiHWLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:09:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC4870B1;
        Tue, 23 Aug 2022 02:16:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f17so6746093pfk.11;
        Tue, 23 Aug 2022 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=vO2cufFWHkBmjDzjn1mkSS/vk95uz/MHe9FsZcNCmWA=;
        b=NvbIS02J+dPcYVJkoAeLyAQ6qVgLcL5CQeUCtNA+7O+798nCg71DZyLJD6JmEGhuIL
         uCbKKlAqNmENEDN2dUEGiyfVhwDOlijgUln+tBM8DgVKPmWxdrzBXYab4xbIUWJR5YCg
         sjmB4FrRTbJK83T4SH452vnNs1tuIbEv8HNimvYYcl+2udNMcVkX89EZFFKpLa1virGk
         Ny9oE4hYYCr3LLfqqMZvel9StxH6qRnFFtckp5Z6TfVxYaZbpsqOJB4VLHDGP5wZktrH
         V+U1b7giT7OhzGXZopV4AR6EbyMMUdVZzf6aJqxA2jksamPYiva7lRvozr9g53F/I5/f
         mg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vO2cufFWHkBmjDzjn1mkSS/vk95uz/MHe9FsZcNCmWA=;
        b=PxFHdQZK7yL0RyL6LQwbGUa8v6WSxtc7ALSrroq1E2LYBEMX6fag8PHoFwhs4ralZh
         Yoj0wa+9YvHuixDYTCJ8/hNtiOczdPdr7wVvRDdH+EEIqos7i9eOKRYBsZsbezfsV88h
         g5tnIiQFFRUsBt6REnPc/AHEvoAhgl7WfRsPpUozA2MSJANlK29TIqkDbGfz/WIxoMid
         RsE9PTytFnRuaYpHd/eXYWX5j8j9zMVH9XZrJsCakbFbPODbZ1IUZeZaMHnVq3jTaf1B
         9gb1ZjXly4BHSVdNGXlnp5ZnX1lIaF1euvErH8GX/2/83zGTDSN2FglJkB1fhAB2ierh
         ieBQ==
X-Gm-Message-State: ACgBeo39i/WMqEFj39VWeNOKALEC1XfhcQpThRnS0HYuwkoZ+luru4AF
        /B1kqmyvzO+KTCup+u+Ft2OV+E56TusffgX0Q/hinNb9
X-Google-Smtp-Source: AA6agR4Z9Ug76sHdgr5vqfFPsa4GngIEWJKchsnJ3mFR9gFPsOS5jOPPCSp1RUrvJZ2wvBWFUsKerbxbqrwRqK9UHCA=
X-Received: by 2002:a65:68cd:0:b0:42a:9a57:157d with SMTP id
 k13-20020a6568cd000000b0042a9a57157dmr9134050pgt.426.1661246187885; Tue, 23
 Aug 2022 02:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220822232046.1230-1-afd@ti.com>
In-Reply-To: <20220822232046.1230-1-afd@ti.com>
From:   Daniel Tang <dt.tangr@gmail.com>
Date:   Tue, 23 Aug 2022 19:16:17 +1000
Message-ID: <CAPnH9d=HhPRVNkveEPBe01g-JK0K5bR7suiTZzmCwm80Vpo0sw@mail.gmail.com>
Subject: Re: [PATCH 0/2] TI-Nspire cleanups
To:     Andrew Davis <afd@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fabian@ritter-vogt.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've CC'd in Fabian, who has previously been able to assist testing
kernel patches for this platform.


On Tue, 23 Aug 2022 at 09:20, Andrew Davis <afd@ti.com> wrote:
>
> Hello all,
>
> I don't have the hardware to test this (yes I know who my current
> employer is), but it does look right and this lets us remove the rest
> of mach-nspire/ without losing any functionality.
> Does anyone have one of these to test with?
>
> The second patch removes a couple defines that do not seem to have ever
> been used, but if one want to implement it, then it should be a simple
> generic syscon DT node.
>
> Thanks,
> Andrew
>
> Andrew Davis (2):
>   ARM: nspire: Use syscon-reboot to handle restart
>   ARM: nspire: Remove unused header file mmio.h
>
>  arch/arm/boot/dts/nspire.dtsi |  7 ++++
>  arch/arm/mach-nspire/Kconfig  |  2 ++
>  arch/arm/mach-nspire/mmio.h   | 16 ----------
>  arch/arm/mach-nspire/nspire.c | 60 +++++++++++------------------------
>  4 files changed, 27 insertions(+), 58 deletions(-)
>  delete mode 100644 arch/arm/mach-nspire/mmio.h
>  rewrite arch/arm/mach-nspire/nspire.c (61%)
>
> --
> 2.36.1
>
