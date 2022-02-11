Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087394B1A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346284AbiBKASq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:18:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbiBKASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:18:45 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA2E5C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:18:45 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id bt13so20363496ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMY5UqXozThmnEGL6VTvYYuov/0istPm6mDOFMt55aw=;
        b=Ge1mJglCEoVv1tPGphTjc9N2O0Y7v7rrpLnip3aCRdyi6TSK2fHzACqyCHSKoXK4EY
         /TaL7jirG+YyKietyVCWdDkTMhSdmnXPCeRn3zKlH9SfVAPkiguDr9bv0/Tjy66wxWQH
         +VYFiQrsmkFwwOJoWiQRZKNGNKfOR81cRaVlQtBqPHJ/9RlcrC60mqo8bdbNsoN7RPtG
         wnTw1YU8YfoNqGP5mk+VzU7vowOXNWkiRRtsHvnQFkUNc7BJsHYAt37jc0BE68P2CFir
         ZvEEdrjOzrdynBZVnAYrsqywmOSgJ41GzxELQOBcUoxa7v/rFSERl4nNQMiyFwrwBxKs
         6hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMY5UqXozThmnEGL6VTvYYuov/0istPm6mDOFMt55aw=;
        b=zQB44w8YwZnpi1+K9Xag3RLlFCXC3fapgwJ6yGHRQPQldVvX6gwJlsH9B/lMFTeqBm
         iCIyJFbDqvGMnssu8RRNQmVEqMyUzY0J8Qkl1L5IMFgL65Jz5uF/Q2KyAMwi7i9k4p24
         whzTran7JsdIpQwyrSRRTSFC/RF4whJgkpjqm3Y+2Z2F37D7kiPeMM21EMlhAeojjlgW
         1wiIIZS12CwvQKrrGDsPYymiqwQYQ3PUZ4txjIRl9mE4RgS676t+VXtSCtZddKEZYZid
         Kw4p3EfZ8axMLbiZzjDCZ99N7UeLauk/NIFcPw+3LLTcGZO9jXDHElmeMMOHyL8Ydiej
         7vRA==
X-Gm-Message-State: AOAM531w5ka86g5WArnge1YdzOGrBHqqM1h1MASxV2/tMlxh4yi1FHN6
        Z7/YIL9OCwx7aWbz58lKyumkhYoWCr2DaK7ETWhMCA==
X-Google-Smtp-Source: ABdhPJz8+9q3TlR5jHTzGDb/RJAAW8lIeMgQxDkmbcoWDdEbQJPM459HI2JXDkwPXsHpadZNDid49l092tgMpa8etAU=
X-Received: by 2002:a25:30d4:: with SMTP id w203mr9202973ybw.511.1644538724831;
 Thu, 10 Feb 2022 16:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <20220209162607.1118325-11-maz@kernel.org>
 <CANBLGcwKeLn7Q1Ra8pCw=cXy=kJeEFRmBjOxjds10+k70LvzXA@mail.gmail.com>
 <87zgmz3xbf.wl-maz@kernel.org> <CANBLGcwwrqkYS2cxX5dYAaoWdj5pRp9c+qBDAMb3=0D5oBD+Zg@mail.gmail.com>
 <87v8xm4zkm.wl-maz@kernel.org> <CANBLGcyvMVdTnndMSWDFnN6207Nareps=AdzVvt0OaMdeAXEHg@mail.gmail.com>
 <87tud64yqa.wl-maz@kernel.org> <CANBLGcxg0qKWw4aifr+dHWge1aXE66e4wZzDwwpJjSad3xaeTQ@mail.gmail.com>
 <87pmnu4wpt.wl-maz@kernel.org>
In-Reply-To: <87pmnu4wpt.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 01:18:33 +0100
Message-ID: <CACRpkdahg=r9Ugc55A9A1wNP2gf2r79XNU8HAG73nQ2L6hV5_A@mail.gmail.com>
Subject: Re: [PATCH 10/10] pinctrl: starfive: Switch to dynamic chip name output
To:     Marc Zyngier <maz@kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        kernel-team@android.com
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

On Thu, Feb 10, 2022 at 3:34 PM Marc Zyngier <maz@kernel.org> wrote:

> Either way, I don't mind. For the record, see below what I'm
> suggesting we take in before 5.17-final.
>
> Linus?

I'm game! :)

Can you send a separate patch because b4 doesn't let me pick a patch
in the conversation
of a patch...

Yours,
Linus Walleij
