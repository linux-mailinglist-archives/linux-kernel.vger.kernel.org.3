Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A15735AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiGMLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiGMLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:39:11 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28638357FE;
        Wed, 13 Jul 2022 04:39:09 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31cf1adbf92so109542467b3.4;
        Wed, 13 Jul 2022 04:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYOcW9IOsSFEnSNVI3NabOAcHzwmMOPMhoi3vC/X7Hc=;
        b=dfwZRxcxSwuilXXeR4b3QvFbxZjt/I6Tg7w6J53VQ+9j3eyYy6G+/dRqjASSaL7hL0
         1W6c3cIeDRBmqFwsJqGMSjBAhzvEsZULBO6Uw9tObPOEqCAvrjFOPkEy9KAeI3Qkkrhf
         zoGFBc3r8QeR0FSJmSM9hRG+Hg5DKmPKK79TylPGYxHUR9kN9/7n6kC2b/JNE6aFx4/B
         I3KFTIjl2v/+F60H7z67h5AFpAKq4pEv9r9FeXhn9NTPLX1mzBh+x/agdfkobcUhL0bw
         VC/T/JKSWq1QrqxlGUJdYybY5Kud928zjcgm7/hnuX3fdb2zM3tSb+nTjQM9tXPwXgh6
         OZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYOcW9IOsSFEnSNVI3NabOAcHzwmMOPMhoi3vC/X7Hc=;
        b=OrKmPMPlsVEbsgV6Kx15JiQM1ngrZr5fq2ik5Tx+b9a1kuoKw3C0iIU2hZqChld0d9
         lkdUBySDIn5T8EOmaLYGLKWw7QK65ZCN+lqzB9MjzBbtxRz6oSj1ticHrHe9Go16+/jy
         Qzmhd5Xfegnl08k8luTYffaiKoP3ABOQm5W7TKtY+TiXhwJB+baZLM5Cmw/cACXEK1IQ
         uLmZQvcCV/zgNlG6i90/qZaQp2VjzC4jfeFeBhfvLnsAMfNPMyPNFpviEZ4gtxgI2OVN
         l0oNsdPzCmqIuVz3bddDdlg+4JgFRexSxRgaJ70EBBbJP5TXXTKOvf6+RO0pqY2znRSJ
         mnfg==
X-Gm-Message-State: AJIora8mBRpyHM5mTbT4NAud5f8oUa9rWzu3b8azVFNVSbpis84g6+XR
        KoezJ+Le3aBu2VokfxKKZSt8UY6j2hKlXMVEGIY=
X-Google-Smtp-Source: AGRyM1uzHohqIj7ZTkoa06270nJ5xAK25DuTxZrQQd7rusScoT52Or0I7ljEBXlp2E/Wg/RbPubq5kFYRxEEa+wVIFM=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr3954784ywa.131.1657712348183; Wed, 13
 Jul 2022 04:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657216200.git.william.gray@linaro.org> <6be749842a4ad629c8697101f170dc7e425ae082.1657216200.git.william.gray@linaro.org>
 <CACRpkdZn-PV6H+uBcoONt=SThGBAODy-YG=rkx5OX-rcpeE+aw@mail.gmail.com>
 <YszlP1+sBhxvz3Fo@fedora> <CAMRc=Mc0=nL_t9Fwmb1uNbsa_v4L4M5BJm2y-vZ8PV47Ryk+Sw@mail.gmail.com>
 <CAHp75Vd5QThEE9S+iL0e3rG+FHoPdts082R4H_beMv990ouGzQ@mail.gmail.com> <Ys6jMPk/6MsFCjv3@fedora>
In-Reply-To: <Ys6jMPk/6MsFCjv3@fedora>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 13:38:31 +0200
Message-ID: <CAHp75VeBszkr7igtwgve2REMjgN7+rOmwwZs0BsouyECZcckfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] gpio: i8255: Introduce the i8255 module
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fred Eckert <Frede@cmslaser.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
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

On Wed, Jul 13, 2022 at 12:49 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
> On Wed, Jul 13, 2022 at 12:10:51PM +0200, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 9:40 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Tue, Jul 12, 2022 at 5:06 AM William Breathitt Gray
> > > <william.gray@linaro.org> wrote:
> > > > On Mon, Jul 11, 2022 at 03:02:10PM +0200, Linus Walleij wrote:

...

> > > > I think I'll move this to gpio/driver.h as per Andy Shevchenko's
> > >
> > > I don't think this is what Andy meant. I think he suggested moving
> > > this header into drivers/gpio/ because it doesn't make sense for it to
> > > be publicly accessible for anyone else than the GPIO drivers.
> > >
> > > Andy: correct me if I'm wrong.
> >
> > No, you are right. I was talking about localizing the header to drivers/gpio.

> Sure, I can move it to drivers/gpio/i8255.h to keep it local to the GPIO

Please, keep it named in the same pattern as the C-file, but having .h
extension. I believe it's gpio-i8255.h.

> drivers. It'll be trivia to move this out if the need ever arrives in
> the future so I have no problem with that.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
