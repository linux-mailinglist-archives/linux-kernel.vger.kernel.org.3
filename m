Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD06583299
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiG0S7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiG0S6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:58:50 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2966E2F9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:08:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31e47ac84daso184253417b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMXcRI87yufdY6/XT5cLLLORQt3sxSxSpP/LTh5+LvM=;
        b=S+TOJiLqHXqCcXVfOGmduOCIM0kskUGMNI92Ai1NEPb0uxl8PI2/KmpWvLVjiD919D
         ZvZS4emRhEfkqWESzGR5OlA4oWesobF5FDdCT+pj3IUTAQvEbfG3bcxkh6iWymMF1RU+
         tTN0RwcYj1C6I2G7aaAoMjgrPeFGRE3ffcUa7oMvXlq0nIpJh7SmEjEyb1XXB6pVt9xr
         pWhBykPSHwtd4h0Xq157RIzg6P7UY4aEAIHcCKecJU5iKJOzl4QL6m54x48zjZP/7V//
         S6xdyM+FN8dU9RizSaLb4lV8OS/TPMjkoHJKI1dY/+79Oc3l+B/7a6THeWohcl2Ww4M8
         A9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMXcRI87yufdY6/XT5cLLLORQt3sxSxSpP/LTh5+LvM=;
        b=5JpYMyR1akM8/PF8Wr4ofwcSMVTVlZmPyVBqk267nsZ0a2h16tc39UwByN64NZXqUs
         5xCwrZupVl1wzqN9c1UrSs/vG4mTehNWvmUaqnJGhZZOTBtH+JcbVbuuezoDCmwC8kwX
         AwleNrkiQTmwd0/uugE2X687TX/K+b/Jx08NmZG0ri9Ei2/I3oZB6pROQ7DOt2LYGegL
         VEiHOvrhbL4Q8Wz7Trg0wXJxalTeHHj1vgYrqytgtWcui8906encfAjhguztg3QsCXlC
         TuOyRdQ35ja/gMSOasDJlnY3d4tzivmjudGJloAzrQitDgkqXbY3LcqzDMN++A2j4Unv
         bsSg==
X-Gm-Message-State: AJIora8kyzcLPyQGWo6+/pMk2O5DtVu2AGegcXn4Uxb+WhA5dYS3B/90
        CZawooXUG1QOmtNQj7VPpwEiw5+o1hcJoUr1LJ85y1X8YEY=
X-Google-Smtp-Source: AGRyM1uD7b1fr29udoQDI9d1E7IIKfgZyoN4ai5FBzz23w5LGSBRFo2LyXt+kDCYDfuXed2hJDzynnxut0qJtcvmw4c=
X-Received: by 2002:a81:4807:0:b0:31e:7002:46cc with SMTP id
 v7-20020a814807000000b0031e700246ccmr20494789ywa.83.1658945287641; Wed, 27
 Jul 2022 11:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
 <20220302211100.65264-2-paul.kocialkowski@bootlin.com> <YiaTfsMDs7RGob2N@robh.at.kernel.org>
 <CAGETcx9u9RO_5nSp+=qgwDGY=jL_Q1hAcj+RfVN=q-H_8iuT4w@mail.gmail.com>
 <20220727120631.iefzititedahdsdt@houat> <CAGETcx_o=L+Ku9CPGbQW2wS15etvi+ofkKZ0K=C7imP4=JcXeQ@mail.gmail.com>
 <YuFzG9SykSHw1bVe@aptenodytes>
In-Reply-To: <YuFzG9SykSHw1bVe@aptenodytes>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 27 Jul 2022 11:07:31 -0700
Message-ID: <CAGETcx_=UJWtNoqZUbOx9LmQWKg070cL265nk4W2nXQdZ940bA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/8] of: Mark interconnects property supplier as optional
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:17 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Wed 27 Jul 22, 09:06, Saravana Kannan wrote:
> > On Wed, Jul 27, 2022 at 5:06 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Mar 07, 2022 at 07:34:22PM -0800, Saravana Kannan wrote:
> > > > On Mon, Mar 7, 2022 at 3:21 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > +Saravana
> > > > >
> > > > > On Wed, Mar 02, 2022 at 10:10:53PM +0100, Paul Kocialkowski wrote:
> > > > > > In order to set their correct DMA address offset, some devices rely on
> > > > > > the device-tree interconnects property which identifies an
> > > > > > interconnect node that provides a dma-ranges property that can be used
> > > > > > to set said offset.
> > > > > >
> > > > > > Since that logic is all handled by the generic openfirmware and driver
> > > > > > code, the device-tree description could be enough to properly set
> > > > > > the offset.
> > > > > >
> > > > > > However the interconnects property is currently not marked as
> > > > > > optional, which implies that a driver for the corresponding node
> > > > > > must be loaded as a requirement. When no such driver exists, this
> > > > > > results in an endless EPROBE_DEFER which gets propagated to the
> > > > > > calling driver. This ends up in the driver never loading.
> > > > > >
> > > > > > Marking the interconnects property as optional makes it possible
> > > > > > to load the driver in that situation, since the EPROBE_DEFER return
> > > > > > code will no longer be propagated to the driver.
> > > > > >
> > > > > > There might however be undesirable consequences with this change,
> > > > > > which I do not fully grasp at this point.
> > > >
> > > > Temporary NACK till I get a bit more time to take a closer look. I
> > > > really don't like the idea of making interconnects optional. IOMMUs
> > > > and DMAs were exceptions. Also, we kinda discuss similar issues in
> > > > LPC. We had some consensus on how to handle these and I noted them all
> > > > down with a lot of details -- let me go take a look at those notes
> > > > again and see if I can send a more generic patch.
> > > >
> > > > Paul,
> > > >
> > > > Can you point to the DTS (not DTSI) file that corresponds to this?
> > > > Also, if it's a builtin kernel, I'd recommend setting
> > > > deferred_probe_timeout=1 and that should take care of it too.
> > >
> > > For the record, I also encountered this today on next-20220726 with this
> > > device:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun5i.dtsi#n775
> > >
> > > The driver won't probe without fw_devlink=off
> >
> > Really? I basically ended up doing what I mentioned in my original
> > reply. next-20220726 should have my changes that'll make sure
> > fw_devlink doesn't block any probe (it'll still try to create as many
> > device links as possible) after 10s (default deferred probe timeout).
> > Can you try to find more info on why it's not probing?
> > <debugfs>/devices_deferred should give more details.
>
> By the way last time I checked the initial issue that I reported appeared to be
> fixed by the patch (Extend deferred probe timeout on driver registration).

Thanks for the confirmation.

-Saravana
