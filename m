Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3144CAC37
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbiCBRgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241848AbiCBRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:36:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F4C6256;
        Wed,  2 Mar 2022 09:35:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8ADE3CE228E;
        Wed,  2 Mar 2022 17:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D7EC340F6;
        Wed,  2 Mar 2022 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646242493;
        bh=SlAmbk9/xjdnL8kM6WDsdNQeKwNX2M1bWU9YFjAU3aY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IFt60GuJkS5DtA8BfW7oaR7leouEyWKb5MaVoj7DZa59ZdmefXDrrStAVFmGNltYD
         SFSxi7ZWv6/PATONAgfNe22iLQLcUIfn7pJS7HvagfIMhC//jGsSEd0Ft6NrRI9FaQ
         mdlBFWAJ6LAWxpiel2Yc35VKEtYzjliaTRgTMBssqWhL5BWXIfnMK1xJLuVnz5Va7c
         Iz8mP+Gjl0gSa8HYF07OiUllyuwCYPyhLjAOeDL8IRaQVq3jlVZqQCz36JsgM22OJP
         FT1G2Mla2LLvIqgeIKHTlE40Vg7bFQp5grPNAKRpIKiLEhGt3FmxxGnIqsKmn8HglT
         QTFR32LECgGvQ==
Received: by mail-ej1-f41.google.com with SMTP id gb39so5286879ejc.1;
        Wed, 02 Mar 2022 09:34:53 -0800 (PST)
X-Gm-Message-State: AOAM5330HEjr2PlqMRZgjJgdOyfJQQNfTSKI5PHMErXhm7ZsZhQIuP06
        chm6viRw/p3Y+7oshHdVVUnBPT/74lPDpblqHg==
X-Google-Smtp-Source: ABdhPJwe7sM9TJHi5/SezdL3sY1rKQ5twC5kIxRpOAddVqrFJfvX+9QV36N3KqX/3JcFZ6Rl+bCUP9nRidljrHLN3aA=
X-Received: by 2002:a17:906:d204:b0:6d6:df17:835e with SMTP id
 w4-20020a170906d20400b006d6df17835emr8542760ejz.20.1646242491912; Wed, 02 Mar
 2022 09:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20220302143427.447748-1-vkoul@kernel.org> <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
 <Yh+l7+7zDvI/9e6n@matsya> <CAMdYzYoVz4wk-EhfxQdwu9FqRg8Vj-HGMFG+CFjfsHeM8HcnNQ@mail.gmail.com>
In-Reply-To: <CAMdYzYoVz4wk-EhfxQdwu9FqRg8Vj-HGMFG+CFjfsHeM8HcnNQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 2 Mar 2022 11:34:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1cYyU=LCmEn=dEk712CECpxj8sUWrwpi8_XpoaXEQig@mail.gmail.com>
Message-ID: <CAL_JsqL1cYyU=LCmEn=dEk712CECpxj8sUWrwpi8_XpoaXEQig@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng
 combo phy register compatible"
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 11:25 AM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Wed, Mar 2, 2022 at 12:14 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 02-03-22, 11:04, Rob Herring wrote:
> > > On Wed, Mar 2, 2022 at 8:34 AM Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
> > > > combo phy register compatible") as that was wrongly merged, so better to
> > > > drop the wrong patch
> > > >
> > > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > > I am applying this to phy-next to fix the issue
> > >
> > > Reverting will just cause a different warning that it is undocumented.
> >
> > Right, but a patch for that would fix that
> >
> > > The fix in the other thread won't apply either if you revert.
> >
> > It is not applying for me, so that needs to be updated anyways..
>
> It seems phy-next has fallen out of sync with -next.
> It's missing this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/soc/rockchip/grf.yaml?h=next-20220302&id=7dbb47d64acf4aac131a2aaade726913aa62abe7

That is not how things work. linux-next is a tree that no one can
apply patches to (in the worst case like this one). It's useful for
integration testing and a shortcut for getting a maintainer's tree,
but should not be the basis for patches to the lists. You should
generally use the last rc1 or a maintainer's tree when there is a
known dependency. Using a stable base means 'git am -3' works and the
merge tools work rather than git just failing to apply anything.

Rob
