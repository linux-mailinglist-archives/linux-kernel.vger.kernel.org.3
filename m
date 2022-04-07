Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2604F84BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345668AbiDGQUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiDGQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:20:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8531EFE2F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:18:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b21so10524537lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-iitr-ac-in.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wjO0bs1qvXp5AP5h5pS2WCcaezCLjsHDm5T0Nl0HxQY=;
        b=ghBT/e4ySWCB0ovgQR8E03ayNEJigtDReWTbUsMXn/TLVJWCV9WApQT02QFREECsyD
         s/HktNUEtI3RVxP2V2zPzpA5moJaxOJYdhwcM7+KdzPzGXRJhk/jaH1psFS7Y++lFj2n
         VVLnIUvxVmBFmfkBh0ERTAQ2VFtTinCjFJSmxNaZN92z0Yx0bDvI3lu4XCWsTN8Q5DGO
         Y98s6aH+yyFnKYK5Kuk/M3ahk2/wdpPU1Z+/97AmhOKLPExaC8reR6gYRtH5dh3tRhYy
         T/hUP867TYL3Q2ER8ffKJcjtCV7SbOCLCLyquwEMJkRIqAeP/wiq4AG1OlG7vN0dZvI7
         WIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wjO0bs1qvXp5AP5h5pS2WCcaezCLjsHDm5T0Nl0HxQY=;
        b=lRmkkL2+HTSxPf3YNKQHK5XbtC7vb7lyA6uOqRgBxU3Gve0jPzQkzXWxzqlA6nmkZ8
         uwATlTHcucbmsxslz4ZL3uiI/3gpi9FnYzy8rFA3UjWjwwpOqw8whTpLsr7GlrHdQwLo
         /+Gk93QGG4QX/NW8LR4BSe5AUvytjgk/rptyrB5Cq9zOSRZW8GbxEFWvkiERt8xd77wo
         IJT29gD2KYJCPNo+yu+45F9AY9PcZGl0rPj7tfD5MbMA5dnTk173xC90gW3HOVTSKRf2
         qOdOxMV2wIC2LbepXm5goMJNp4lqgbj+qUTUtq01vKynihyUIbcnaEfLhz4nQboLtJ2a
         F4aQ==
X-Gm-Message-State: AOAM5301glS2RGh7SSFOcrzBNpLVAcvJt0Vd9NxkACp1Cl29yMhlVpJx
        qWcRNMmwGbxBCi1kORkIsclolkN4R33qE4EFe8LPoewYmE7zLy1s
X-Google-Smtp-Source: ABdhPJx1AntGzS/rBalHe6cpDFXldbK0o8QTe7Iu4ifkfngxq4NABQay5eYCVKcNzCDUc0j4GKW3Mg4laLmQa6ViisA=
X-Received: by 2002:a05:6512:3c6:b0:44a:b66d:6d04 with SMTP id
 w6-20020a05651203c600b0044ab66d6d04mr10174664lfp.428.1649348265832; Thu, 07
 Apr 2022 09:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220407120945.31030-1-mahak_g@cs.iitr.ac.in> <alpine.DEB.2.22.394.2204071414080.2213@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2204071414080.2213@hadrien>
From:   MAHAK GUPTA <mahak_g@cs.iitr.ac.in>
Date:   Thu, 7 Apr 2022 21:47:09 +0530
Message-ID: <CANnaPbD7C8kvz-fK4js=zprck58=Yxp8h+wBLmXfQNKsHMDytw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8712: fix camel case in function r8712_generate_ie
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 5:44 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Thu, 7 Apr 2022, Mahak Gupta wrote:
>
> > Adhere to linux kernel coding style.
> >
> > Reported by checkpatch:
> >
> > CHECK: Avoid CamelCase: <beaconPeriod>
>
> As another patch, you could also adjust the structure field name.
>
> julia
>
> >
> > Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
> > ---
> >  drivers/staging/rtl8712/ieee80211.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
> > index f926809b1021..7d8f1a29d18a 100644
> > --- a/drivers/staging/rtl8712/ieee80211.c
> > +++ b/drivers/staging/rtl8712/ieee80211.c
> > @@ -162,13 +162,13 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
> >       uint sz = 0;
> >       struct wlan_bssid_ex *dev_network = &registrypriv->dev_network;
> >       u8 *ie = dev_network->IEs;
> > -     u16 beaconPeriod = (u16)dev_network->Configuration.BeaconPeriod;
> > +     u16 beacon_period = (u16)dev_network->Configuration.BeaconPeriod;
> >
> >       /*timestamp will be inserted by hardware*/
> >       sz += 8;
> >       ie += sz;
> >       /*beacon interval : 2bytes*/
> > -     *(__le16 *)ie = cpu_to_le16(beaconPeriod);
> > +     *(__le16 *)ie = cpu_to_le16(beacon_period);
> >       sz += 2;
> >       ie += 2;
> >       /*capability info*/
> > --
> > 2.17.1
> >
> >
> >

Sure, on it. Thanks.

Mahak
