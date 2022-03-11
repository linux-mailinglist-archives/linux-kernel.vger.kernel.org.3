Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BA54D6442
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbiCKPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiCKPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:04:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE623B549;
        Fri, 11 Mar 2022 07:02:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B74EB829A4;
        Fri, 11 Mar 2022 15:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2CEC36AE2;
        Fri, 11 Mar 2022 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647010975;
        bh=+7wVC05d5SSUcDUrc40AC3oA+s+3hd6pHYOwxaDor9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZUTRP4Cm8LBfn6/KXI+G2bBgllAlpz6Eq78RD0OMglXVTQ4yuwDfAfRMnWzW8M5Vd
         3KrDlpIhXq6B76Km1NJUDvXGR8k9vVrnwPrln06V5nYJHXwXAkBj9mnpMfuTkAFZGi
         xJ1/FN4zB7AWkKStZPMFi4sypEdKiU3bOddHQ3xmJMrhEro9fYPU0UGChwckRItHx4
         cQi2UnBtEoBOgE4Kc8+8VMoR4bT9J5cyqZse1G8BLs+8fGDYEF0z9MHE2O0xxdSFa7
         cFAHLdFBJwxHih4h+q5sXZaatJL75Z3EHP1AK6xf0RxaCTPFCoBcN7/lkkQtSijQ/e
         fZiQhWjFduJFQ==
Received: by mail-ed1-f46.google.com with SMTP id g3so11288929edu.1;
        Fri, 11 Mar 2022 07:02:55 -0800 (PST)
X-Gm-Message-State: AOAM53396vSBfEiRiUVYSVWGINOmcv4FEcXnuagcLWdvwwLWFiU/I7GK
        QtMzHDb1g7LQDcA6AVddyDfdFMuzITfAC8SRDQ==
X-Google-Smtp-Source: ABdhPJwYq/vJdt94i6eQ/56CKRLPMYZBOz5FJe4G+2giKB68DPNLMZ0O0dRforZvg6kBjeNFI/F6lo5Tb/V20Gngl/A=
X-Received: by 2002:aa7:d355:0:b0:415:f703:569 with SMTP id
 m21-20020aa7d355000000b00415f7030569mr9325992edr.215.1647010974075; Fri, 11
 Mar 2022 07:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20220308130643.260683-1-cbranchereau@gmail.com>
 <20220308130643.260683-5-cbranchereau@gmail.com> <Yip8AiKNOILjf0uj@robh.at.kernel.org>
 <PC0L8R.DOJJ0CSJMHTW@crapouillou.net>
In-Reply-To: <PC0L8R.DOJJ0CSJMHTW@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Mar 2022 09:02:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKfypZRq1D02+fyNABoHRrEYdySzfP7nW62Cv44QymBA@mail.gmail.com>
Message-ID: <CAL_JsqJKfypZRq1D02+fyNABoHRrEYdySzfP7nW62Cv44QymBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: display/panel: Add Leadtek ltk035c5444t
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Christophe Branchereau <cbranchereau@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 7:05 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
> Le jeu., mars 10 2022 at 16:30:26 -0600, Rob Herring <robh@kernel.org>
> a =C3=A9crit :
> > On Tue, Mar 08, 2022 at 02:06:43PM +0100, Christophe Branchereau
> > wrote:
> >>  Add binding for the leadtek ltk035c5444t, which is a 640x480
> >>  mipi-dbi over spi / 24-bit RGB panel based on the newvision
> >>  NV03052C chipset.
> >>
> >>  It is found in the Anbernic RG350M mips handheld.
> >>
> >>  Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> >>  ---
> >>   .../panel/leadtek,ltk035c5444t-spi.yaml       | 59
> >> +++++++++++++++++++
> >>   1 file changed, 59 insertions(+)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-s=
pi.yaml
> >
> > We have 18 SPI based panels already:
> >
> > $ git grep -i 'spi.* {'
> > Documentation/devicetree/bindings/display/panel/
> > Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml:
> >   spi {
> > Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml:
> >   spi {
> > Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml:
> >   spi {
> > Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml:
> >   spi {
> > Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54n=
t.yaml:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/lg,lg4573.yaml:
> > spi {
> > Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml=
:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/nec,nl8048hl11.yaml:
> >   spi0 {
> > Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml:
> >   spi {
> > Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.yaml=
:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.yaml=
:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml:
> >    spi {
> > Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml:
> >   spi {
> > Documentation/devicetree/bindings/display/panel/tpo,td.yaml:    spi {
> > Documentation/devicetree/bindings/display/panel/tpo,tpg110.yaml:
> > spi {
> >
> > Most except for the Samsung ones look like they'd fit in our
> > definition
> > of 'simple panels' which primarily means 1 supply.
> >
> > So I think it is time for a panel-simple-spi.yaml binding to combine
> > all
> > these. But I'm not going to make the person adding the 19th case to do
> > that, and this otherwise looks fine:
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> I actually thought you sent a patch for this already (I remember you
> talking about it last a binding for a new SPI panel has been added).

It was just adding spi-peripheral-props.yaml reference that I sent.

> I will work on it next week - provided Cristophe's patch has been
> merged before.

Thanks!

Rob
