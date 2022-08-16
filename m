Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F915963E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 22:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiHPUoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 16:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiHPUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 16:43:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66F33F311;
        Tue, 16 Aug 2022 13:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC635B81A7A;
        Tue, 16 Aug 2022 20:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AB0C433D7;
        Tue, 16 Aug 2022 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660682626;
        bh=PjZnNtHZFDXPKR4FXdEbC4KKb4ewbtMP73c6JeyqAWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YhAwy8dVdPBwdxHPoMFP9vL2r4D8YV0qL4ZkhTUVCbW5oNeS9Sw6ZK+p8Jpd/1wVQ
         I9lp2olW0z30/DSPbslDDFNEwHLxMRwiWldE8Jzc6esqd5wChYfy8aa+FcDXncWltM
         KeEyskq7HxxUQx3sxO3JW2snqt/KTb7r2sYt/rIRWDj1VMUot6J0MoJM/gG8/xaF9d
         ijw+w3j542JAHRgMVclkrXbD5k6wBMYo1lkb0qC1vL+SFhOFuQVTt1QlOsWWOQMKeD
         9StXJaW+aMCjp0gkLBc/g8/eBXAjQY/5Tq8rjBeiCXi2zUDSAJlVSHil54n0GCFBYO
         8bDNubfwkKOBA==
Received: by mail-vk1-f173.google.com with SMTP id bq26so5754478vkb.8;
        Tue, 16 Aug 2022 13:43:46 -0700 (PDT)
X-Gm-Message-State: ACgBeo1JBbfmkW8WWNMlMEpwkVaI+BYLIaPhMKr1YsVmEM4P9ZkHvDv8
        EuaI0rfqZU4Q47691ylZsQzeppOkpUX3FquPHw==
X-Google-Smtp-Source: AA6agR5/90q292A5cudWioezccd+gm85RYFjHgO9y12p2++zZcEPr8ig990xtRFy1iERxThGpel7gzgdMJuhb9MQwsk=
X-Received: by 2002:a1f:ecc4:0:b0:377:8f7c:8873 with SMTP id
 k187-20020a1fecc4000000b003778f7c8873mr9777908vkh.14.1660682625591; Tue, 16
 Aug 2022 13:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220816174150.GA2428940-robh@kernel.org> <CA+V-a8vayVoHONavLMTdfQkYsT_+7NLXid3V58FU+ABzB9kgBg@mail.gmail.com>
In-Reply-To: <CA+V-a8vayVoHONavLMTdfQkYsT_+7NLXid3V58FU+ABzB9kgBg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 16 Aug 2022 14:43:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKs2Vtd2RevajLyEaBHjwoHozpw8763-v6jbG9t9mk4Ng@mail.gmail.com>
Message-ID: <CAL_JsqKs2Vtd2RevajLyEaBHjwoHozpw8763-v6jbG9t9mk4Ng@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:40 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Rob,
>
> On Tue, Aug 16, 2022 at 6:41 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Aug 15, 2022 at 12:17:08PM +0100, Lad Prabhakar wrote:
> > > renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
> > > is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
> > > to the soc/renesas folder instead. This is in preparation for adding a new
> > > SoC (RZ/Five) from Renesas which is based on RISC-V.
> >
> > Please post this as part of the above.
> >
> Sure, I just wanted to get some feedback on this so had it posted separately.
>
> > bindings/soc/ is just a dumping ground for stuff that doesn't fit
> > anywhere. We've mostly cleaned bindings/arm/ of that, so I don't really
> > want to start that again. I would propose bindings/board/ instead if we
> > move in this direction.
> >
> OK. So to clarify, how do we separate it further bindings/board/<based
> on SoC vendor> or bindings/board/<board manufacturer>?

The latter doesn't work with how the schemas are structured.

Rob
