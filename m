Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFF4B1A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbiBKAPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:15:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346214AbiBKAPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:15:37 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F22735
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:15:38 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 192so20182950ybd.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7OoL04aP+MZeQy8gEUASlkgu2toqHuHNgEWJOzWKkI=;
        b=STyD92iMRI0ITMeRrZZIgrsOTqWv1OtmvKboQgkN8aHCeb6qmGBZytZN5kIu8+b5AB
         FM95HInfiaDAapUiv/80ZCTLvpJgeTC/hvl1gCpJ08wK35dPxUz2ctLpohgB7m3nIj0Y
         WmO+83UiTjZSSEygrYn1m1c2lMnsa1k7yzX57aoMAgU82rQg1S9T46OlWV3M8urvhhGD
         7okaYEU+fobCrAf3l6IwhUznoZR4ZQdjP7Z8hsI0Nar2PJGrmalR7C581w0B/kPRqvQ7
         k8tgqGsGgyRu+J7ohCT3R4zi1SdWCWAyUAolivGpxAaxiG376F6K5TYtIjaM4xR+ZN9c
         SAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7OoL04aP+MZeQy8gEUASlkgu2toqHuHNgEWJOzWKkI=;
        b=6YQX1J82Ez52nlzYnCkQnI9Z7sjITxXlHjDJ726d2nOACAz/HJQi6+TVTKIC2nYxz6
         f3mytEGdhX2jn6HUptdkYOPoPkOW5vzw2ps/KFp509BIeHBa5DKmHYpvb/G5wl30aTy9
         WnFjx5ue3mvvrcjaGImYgxzftOiy+KMrfderBS3DIV2hJxxw23Xw0Y1Hd6QMdGB3Gjhv
         k+n881mpLGRXXTKv0h0dp2M98AbPhurgRNq3qcIVw4neKQaotrS0YjECzxcfA1vIL8UJ
         WtJ4bObD4jRLM3hd5hg8v1MPWH+0DYxz2u7qtK7WMbYE8qV8RjNzTEeibiBWyQAPoewI
         495g==
X-Gm-Message-State: AOAM5323Zb12GhfIFETJhJK9l/EhOC90bve9sFiBl8qK9ntA4/k83e3O
        z1rzentQo01Z62Dlr1VBb7Oa/s48OgMNHTlTVJB52Q==
X-Google-Smtp-Source: ABdhPJy/Q5Zr/NTFpZq1apn9uDiuLsg2WFOhJqeZ3lViKWsIgjSwTxtM1oZy17C+JIqGLVdKS7iawzFxAzRAsAjiNVk=
X-Received: by 2002:a25:103:: with SMTP id 3mr9355820ybb.110.1644538537279;
 Thu, 10 Feb 2022 16:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <20220209162607.1118325-11-maz@kernel.org>
 <CANBLGcwKeLn7Q1Ra8pCw=cXy=kJeEFRmBjOxjds10+k70LvzXA@mail.gmail.com> <87zgmz3xbf.wl-maz@kernel.org>
In-Reply-To: <87zgmz3xbf.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 01:15:25 +0100
Message-ID: <CACRpkdbo4seF6t6iFgKhaTZ_PKMdCt+2gSmdCaM+vDeHGZfHcQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:06 AM Marc Zyngier <maz@kernel.org> wrote:
> On Wed, 09 Feb 2022 23:30:55 +0000,
> Emil Renner Berthing <kernel@esmil.dk> wrote:

> > The gpio framework seems to fill in default handlers in the struct
> > above, so unfortunately it can't yet be made const. Is this something
> > you intend to fix in the future?
>
> This is next on my list of things to address. The whole 'let's copy a
> whole irqchip structure and hijack random pointers' should not have
> happened, and it certainly is going to be an interesting ride.

Sorry about that... Probably my bad idea. The only upside is that the
things that are ugly are centralized to one spot.

Yours,
Linus Walleij
