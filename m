Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80350AF98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiDVFki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiDVFYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:24:43 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933954F442;
        Thu, 21 Apr 2022 22:21:49 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kc12so117073qvb.0;
        Thu, 21 Apr 2022 22:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hL4RE3KhpgsczmHCd82s+GTL+VM0PpuQ4vRV61iW2so=;
        b=oPZH6cT4eFog/QoZgdRzBGjRtrP5yokMOG7gimEQZYOF7B251XF9oEC/ehKdXpeV7r
         zuMYbACCZhfqN61KvP1Wp39J8ZIJo2B98SXecewmZsXgjiwGEto+p5mHd4V6Sln7eClG
         AxsThV3BEZYUACZQL8eELE8ilrKOuG/WIkPz+jI/bjspk6PdlfmUBxnpkgrLznGnz2BF
         v+MPPtX6MDBsK/W1UKQNU4Q0T/HQUvrdsHKqvmbj2C67mK+dCE6ubv46ZMaWr2M0YFTB
         qWo8b9Anc495wTdv+1IkBVNMe1d4eLZK11PsqP1czTCeFj7PadIFsssut8OWcMJlJz2L
         LWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hL4RE3KhpgsczmHCd82s+GTL+VM0PpuQ4vRV61iW2so=;
        b=ZLWFGvhwqfKO9aVLHPZse68DSkAKMMpYqB6aTy5RF/Z+jmuJmbHdfEvJ2yDeqcBthh
         EdvhFDxkefzhVlF9iaQuCt4tYBnWigUTzcbEn4ZWsWqXcFr2UM2YnFdKQ+3SQF2QhqYw
         51l3I7lI7FqciEwZ7/lh4z1H/LLTHWyrprzIQoYMXJjvzgv/kxhX0S8NAT+x7DkEBBxA
         pwRHry2iMtUZx3HSSrVtmOdxYil4LfADxWQLUDjGavTAS7eQh3q4AO/ZeHSBoa7+BMZy
         EhATigMOKvKfG/Wp1kWq8ZrwAMxTk+SFNwVaBdU2SJTytUENBio9f8PgRciH+yOoIGaB
         Kw9Q==
X-Gm-Message-State: AOAM530ZXB8epIYeWjs+IxRDaXXzgEITbaPqIHW5/qkMWzvJyOSVCN1o
        HsBGugcfYe6LFYl9SW31zNrf4X2YvynF9Ovf/AQ=
X-Google-Smtp-Source: ABdhPJyN3psO4kSFD8fbsmu96H/8mfECMCXljvl609zKdqflOH2NZhqDBoliBbIsFDfFk1+o+6RwvksmzjIoHhXMH/I=
X-Received: by 2002:a05:6214:d0e:b0:446:716a:fff2 with SMTP id
 14-20020a0562140d0e00b00446716afff2mr2099927qvh.38.1650604908751; Thu, 21 Apr
 2022 22:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220413060729.27639-1-arinc.unal@arinc9.com> <CACRpkdbbMFYNNjAKwhysKpu1JVh2JSB-N=Y8QMx1JvMhCPBpwg@mail.gmail.com>
 <26418320-64e0-3ed2-c792-7f72878b7592@arinc9.com>
In-Reply-To: <26418320-64e0-3ed2-c792-7f72878b7592@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 22 Apr 2022 07:21:38 +0200
Message-ID: <CAMhs-H_d8jUa4=4eVjQxo+h-XeRgiMYC1H_xYtPLb8jHDVYL2Q@mail.gmail.com>
Subject: Re: [PATCH 0/14] Refactor Ralink Pinctrl and Add Documentation
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arin=C3=A7,

On Thu, Apr 21, 2022 at 4:44 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> On 21/04/2022 17:27, Linus Walleij wrote:
> > On Wed, Apr 13, 2022 at 8:08 AM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@a=
rinc9.com> wrote:
> >
> >> This patch series brings complete refactoring to the Ralink pinctrl dr=
iver
> >> and its subdrivers.
> >
> > I just merged all the patches, the comments seem minor and any further
> > fixes can certainly be done on top of this. Anyone interested in ralink
> > working nicely is likely in the thread and we mostly care about that th=
is
> > works for OpenWrt, and if it works for them we are happy.
> >
> >>    mips: dts: ralink: mt7621: use the new compatible string for MT7621=
 pinctrl
> >
> > This was a bit scary since we usually take these through the respective
> > SoC tree, but I just applied it anyway, it makes logical sense in the
> > series.
> >
> > I hope it will not lead to conflicts.
> >
> > Good work with this series!
>
> Thanks. There is a v2 of this series which has been waiting for a week,
> I hope that was the one you applied as you replied under v1 (I'm not
> sure which repository you applied this so I can't check myself).

Linus adds patches through the linux-pinctrl tree as pinctrl maintainer. Ch=
eck:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Ddevel

Best regards,
    Sergio Paracuellos
>
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D6323=
70
>
> Ar=C4=B1n=C3=A7
