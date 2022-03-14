Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BEB4D88CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiCNQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiCNQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CB38BCF;
        Mon, 14 Mar 2022 09:08:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC07611E2;
        Mon, 14 Mar 2022 16:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1801FC340E9;
        Mon, 14 Mar 2022 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647274131;
        bh=1ry5Be+DEJ/WTlPDuvzh39VOlKL+9h9m5A2hzUz9Pzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vKzVxOXvTsEwyEgJKstMcx1XD8H5DHo6/TtHpV5/bgtRck/JjMiqOdXClV06oX/DV
         EtT5monyWeXLh2Y6O3RVVk0DJ5j4wuHhqrFSMa2mPs3Sg1T8Rc22vqG8Avn715LP6a
         /XS3/PmlMzDZ4GbH1jQDiygFT9AaXnjsRIcUl4dGfEHhUA6Nv3nArlbht/z4U/tgm+
         Emc3R25ayY9qv9yu/U7yHk7YqLCeiOorvNpiWb/l9cwOJ5lYdq1ypHwQefzOyE0dkI
         ynP2v/g/T2JiSRcYnb9oLNE/2LqyhaYI8bfR5Xa5N4FCmhkUizfkBnZwwUt7nYgMHp
         y4i6fwWUTC8og==
Received: by mail-ej1-f45.google.com with SMTP id dr20so34414546ejc.6;
        Mon, 14 Mar 2022 09:08:51 -0700 (PDT)
X-Gm-Message-State: AOAM533wMTaQap8RrOk+rLgaUUCF+rNRbTMqfgjc6tfTyf7uhQiyvSmm
        gRp/FgievorZTXuQjKZyZ+Zrc0YFNpEMiwZGXw==
X-Google-Smtp-Source: ABdhPJwcqUbhlXD3YbYialKZTSunHlrCxqch0paO5wCVK/vSsLl0UeoZOgqPWAYNFn03mzOJWtVvKqqGHLsGhdB3HC4=
X-Received: by 2002:a17:906:58ce:b0:6da:b548:1bbb with SMTP id
 e14-20020a17090658ce00b006dab5481bbbmr19130367ejs.14.1647274125897; Mon, 14
 Mar 2022 09:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
 <CAL_JsqLuD97y=rqRRUw5owvoetLh926ebkmMdGut+gyqTS5hWQ@mail.gmail.com> <87k0cwzgy0.wl-maz@kernel.org>
In-Reply-To: <87k0cwzgy0.wl-maz@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 14 Mar 2022 10:08:33 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+gDJBMbjROsaVO=X+skPnq0tE0U970qEeDdi7xVW_d5w@mail.gmail.com>
Message-ID: <CAL_Jsq+gDJBMbjROsaVO=X+skPnq0tE0U970qEeDdi7xVW_d5w@mail.gmail.com>
Subject: Re: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
To:     Marc Zyngier <maz@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 9:34 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 14 Mar 2022 15:15:15 +0000,
> Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Dec 14, 2021 at 6:59 AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > > Therefore, the premise of the patch being reverted here is invalid.
> > > It doesn't matter whether the driver, in its non-standard use of the
> > > property, complies to the standard format or not, since this property
> > > isn't expected to be used for interrupt translation by the core.
> >
> > I disagree. The non-standard part is that 'interrupt-map' translation
> > is not transparent. 'interrupt-map' that can't be parsed in the
> > standard way is just wrong, and I imagine was never the intention
> > here. We simply cannot have platforms defining their own format for
> > standard properties.
>
> That ship sailed a long while ago. We have a list of offenders, and we
> can make sure we don't get additional ones.
>
> > Reverting this will cause dtc warnings now (IIRC) and just kicks the
> > can down the road. Reverting is fine for now (I gave Arnd the okay on
> > IRC), but I think the parsing will need to be updated to honor
> > #address-cells and detect an old DT (probably by looking at the total
> > size of 'interrupt-map') and mark that change for stable. That would
> > only leave a new dt with an old kernel without stable updates broken.
> > Seems unlikely a device is getting firmware updates, but not OS
> > updates.
>
> Being able to rollback firmware and OS independently is important. The
> tooling can be taught about the broken instances, which should be
> enough.  Adding to the parsing only makes things harder to maintain,
> for no real gain.

It's up to individual platforms to care about that. If they don't,
then compatibility has been broken multiple times most certainly
because in general there is 0 testing for it. Why make our lives more
complicated in those cases?

Rob
