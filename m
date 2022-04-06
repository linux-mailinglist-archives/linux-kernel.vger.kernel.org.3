Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7973F4F6265
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiDFOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiDFOwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:52:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A54278540;
        Tue,  5 Apr 2022 18:24:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 66so869924pga.12;
        Tue, 05 Apr 2022 18:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kvmNeaIx7IB5BYMxWZTmG2UdGRttU94dBZuAtL4Mmo=;
        b=LEzG1yPF+iOw/30hd5E7mWGalRFTazmZ26PA34EyQTbkg0YljKXLaPf2eOppyTj4H6
         yLrLvmCh4vLS4e2+5tjq6DOsc6DDq3GCdY9pxzAAVprQOEvgGRqi/GvrU1xlenMON/oq
         vqkTGOyRs5HC02ZNBLpMhFjGj8eayV8R8iQ4TlHoXJUQ6x8p1czQStn3js4L+fBTje6D
         D9DXldHCWPPs3LnMdGHflwmMfHA4JbQ0XtCSRo6SWODePkGh6Q2o1+rlWu9XV6ZxJBvE
         WKfi+upKy5fetBruNDSKmuKInPS/KDtKhk4gPSPMsFIHEDOfnCEdEMka4RBlnM5rIHVv
         VTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kvmNeaIx7IB5BYMxWZTmG2UdGRttU94dBZuAtL4Mmo=;
        b=GeKK+TT4Os8Iv3J1j3gn2/gs5w6uyLZK6ljYAUGFEIPl6MntscdHodiAwCYOwN/BKb
         h1N9cUPWfA1H8L0IaRHCxOTB6MOfI7mf4pDtaUXih0vxBALU/h0THXR/zN7xl3usUVYV
         7mEmSQamYg1WtJi7v04QeMcLDPuDA08yT64+9ALE81pi8IuWaIRILPfTLrcC0dCXQKlN
         HOkNk/b47lZ0/hHGrmFoJrIh0zRR1v+F+w6aRvNin2GWhX+kV143ZsUFqNmyeG9+KGKF
         ohcFgX3z4+ibni5MHwjD8143494noTazIXtP6EMVz9G8vHFsBqIEKkliUlkr53ediXaa
         +YpQ==
X-Gm-Message-State: AOAM530BNqw5YP0UqCXx4CRsG8BatEWATRKw3fNMHabTiXA4WbOTWf+0
        OeeeNAiy6D15auOavZlBj0n36fWzQ1bht35ZACGpzMqIl1QL9lY=
X-Google-Smtp-Source: ABdhPJxTPLh2sMTHkDH1jcm5HIN822wKj5fW0FIFDwf+vBCsisO7uLWVer2kyP1/VgsP1RgN6oAFUVzW0GGO1epC5+4=
X-Received: by 2002:a62:4e4e:0:b0:4fa:b1d4:3405 with SMTP id
 c75-20020a624e4e000000b004fab1d43405mr6433730pfb.71.1649208271487; Tue, 05
 Apr 2022 18:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjmFhqTLBscHHVZ1VTSqrJBT1VEevA+KkjY+y9_ZtdRkMg@mail.gmail.com>
 <CAMuHMdUiEo8q9x0C0x5zOM=ax1=S06=s0JjcJvZYD4aMGLmEaQ@mail.gmail.com>
 <a564f6af-31fa-79a2-72c3-578f2c095b23@gmx.de> <202204051946.43277.linux@zary.sk>
 <527a8c23-609f-5f8a-e076-a8a59da59865@gmx.de>
In-Reply-To: <527a8c23-609f-5f8a-e076-a8a59da59865@gmx.de>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Wed, 6 Apr 2022 09:24:20 +0800
Message-ID: <CAMhUBjmBm3=CY=cCZuH0+ZeemNVT=9XywSoYiR7WLcYOUGu9VQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtCVUddIGZiZGV2OiBpNzQwZmI6IERpdmlkZSBlcnJvciB3aGVuIOKAmHZhci0+cA==?=
        =?UTF-8?B?aXhjbG9ja+KAmSBpcyB6ZXJv?=
To:     Helge Deller <deller@gmx.de>
Cc:     Ondrej Zary <linux@zary.sk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 2:23 AM Helge Deller <deller@gmx.de> wrote:
>
> On 4/5/22 19:46, Ondrej Zary wrote:
> > On Tuesday 05 April 2022 08:33:57 Helge Deller wrote:
> >> Hello Geert,
> >>
> >> On 4/4/22 13:46, Geert Uytterhoeven wrote:
> >>> Hi Helge,
> >>>
> >>> On Sun, Apr 3, 2022 at 5:41 PM Helge Deller <deller@gmx.de> wrote:
> >>>> On 4/3/22 13:26, Zheyu Ma wrote:
> >>>>> I found a bug in the function i740fb_set_par().
> >>>>
> >>>> Nice catch!
> >>>>
> >>>>> When the user calls the ioctl system call without setting the value to
> >>>>> 'var->pixclock', the driver will throw a divide error.
> >>>>>
> >>>>> This bug occurs because the driver uses the value of 'var->pixclock'
> >>>>> without checking it, as the following code snippet show:
> >>>>>
> >>>>> if ((1000000 / var->pixclock) > DACSPEED8) {
> >>>>>      dev_err(info->device, "requested pixclock %i MHz out of range
> >>>>> (max. %i MHz at 8bpp)\n",
> >>>>>          1000000 / var->pixclock, DACSPEED8);
> >>>>>     return -EINVAL;x
> >>>>> }
> >>>>>
> >>>>> We can fix this by checking the value of 'var->pixclock' in the
> >>>>> function i740fb_check_var() similar to commit
> >>>>> b36b242d4b8ea178f7fd038965e3cac7f30c3f09, or we should set the lowest
> >>>>> supported value when this field is zero.
> >>>>> I have no idea about which solution is better.
> >>>>
> >>>> Me neither.
> >>>> I think a solution like commit b36b242d4b8ea178f7fd038965e3cac7f30c3f09
> >>>> is sufficient.
> >>>>
> >>>> Note that i740fb_set_par() is called in i740fb_resume() as well.
> >>>> Since this doesn't comes form userspace I think adding a check for
> >>>> the return value there isn't necessary.
> >>>>
> >>>> Would you mind sending a patch like b36b242d4b8ea178f7fd038965e3cac7f30c3f09 ?
> >>>
> >>> When passed an invalid value, .check_var() is supposed to
> >>> round up the invalid to a valid value, if possible.
> >>
> >> I don't disagree.
> >> The main problem probably is: what is the next valid value?
> >> This needs to be analyzed on a per-driver base and ideally tested.
> >> Right now a division-by-zero is tiggered which is probably more worse.
> >
> > I still have an i740 card so I can test it.
>
> Good. Someone wants to come up with a proposed patch?

I have submitted patches for the i740fb driver and other drivers which
have similar bugs as follows:
https://lore.kernel.org/all/20220404084723.79089-1-zheyuma97@gmail.com/

Zheyu Ma
