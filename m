Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF874D87E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiCNPQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiCNPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2156C633B;
        Mon, 14 Mar 2022 08:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A569561243;
        Mon, 14 Mar 2022 15:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DE4C340EC;
        Mon, 14 Mar 2022 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647270929;
        bh=yH2HvHYugFk66gpwEdhxTtTfC9BU2HzyxT8MBDl663U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uVU7g7tbD/TCzGnq2oVO2I+7QGPpO2RwLudvj7plBnXI7rtVNbQz2ItMuJBkPSrAv
         Ved9yYzAhJ3W2KnuLz76UEX1viTbg8yEFUN3mDk3fjwGkC8PkDPkZZyCV2h0KpQY3d
         SVsbKTmGHncCbpmOORANXABmZHLjuhLlyKj5J2uYwLhLr53p6+7cxuSjF6yRVOMQ63
         x6Ohn4opQRpqA7XemmKxt+nh5cK/J+MFumIFdygnVtn4IM308vthpJHFuSPsT7DOma
         O5fmqgUgfc/DEoR/8gMzvJi8SwzGw0G8bucdLPGkwSBfcPvMdWholet0rkjJiKEM40
         f3zjFinnsmQMw==
Received: by mail-ed1-f49.google.com with SMTP id y22so20421440eds.2;
        Mon, 14 Mar 2022 08:15:28 -0700 (PDT)
X-Gm-Message-State: AOAM532S9CrTqv9vYhZy5E//vrPaw96Qdjul1V1E1kW78lD2Pi0QmJrj
        uWOxDhRvyxwo91HNJe1XrxXZHEVASvqWaNTS2A==
X-Google-Smtp-Source: ABdhPJxeHlt9IaR9wy/leAwESkcfkdTm3hjRDGlP+up+OWe5BIoyKWvHvOp4HcW9Fko6USi11kokUxlYoDvdG1vaSHQ=
X-Received: by 2002:a05:6402:292c:b0:416:8eb:3fc4 with SMTP id
 ee44-20020a056402292c00b0041608eb3fc4mr20732986edb.2.1647270927197; Mon, 14
 Mar 2022 08:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
In-Reply-To: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 14 Mar 2022 09:15:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuD97y=rqRRUw5owvoetLh926ebkmMdGut+gyqTS5hWQ@mail.gmail.com>
Message-ID: <CAL_JsqLuD97y=rqRRUw5owvoetLh926ebkmMdGut+gyqTS5hWQ@mail.gmail.com>
Subject: Re: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Biwen Li <biwen.li@nxp.com>,
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

On Tue, Dec 14, 2021 at 6:59 AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. That
> updated the expected device tree binding format for the ls-extirq
> driver, without also updating the parsing code (ls_extirq_parse_map)
> to the new format.

Sorry, I missed this until mentioned on IRC.

>
> The context is that the ls-extirq driver uses the standard
> "interrupt-map" OF property in a non-standard way, as suggested by
> Rob Herring during review:
> https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/
>
> This has turned out to be problematic, as Marc Zyngier discovered
> through commit 041284181226 ("of/irq: Allow matching of an interrupt-map
> local to an interrupt controller"), later fixed through commit
> de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
> definition of interrupt-map"). Marc's position, expressed on multiple
> opportunities, is that:
>
> (a) [ making private use of the reserved "interrupt-map" name in a
>     driver ] "is wrong, by the very letter of what an interrupt-map
>     means. If the interrupt map points to an interrupt controller,
>     that's the target for the interrupt."
> https://lore.kernel.org/lkml/87k0g8jlmg.wl-maz@kernel.org/
>
> (b) [ updating the driver's bindings to accept a non-reserved name for
>     this property, as an alternative, is ] "is totally pointless. These
>     machines have been in the wild for years, and existing DTs will be
>     there *forever*."
> https://lore.kernel.org/lkml/87ilvrk1r0.wl-maz@kernel.org/
>
> Considering the above, the Linux kernel has quirks in place to deal with
> the ls-extirq's non-standard use of the "interrupt-map". These quirks
> may be needed in other operating systems that consume this device tree,
> yet this is seen as the only viable solution.
>
> Therefore, the premise of the patch being reverted here is invalid.
> It doesn't matter whether the driver, in its non-standard use of the
> property, complies to the standard format or not, since this property
> isn't expected to be used for interrupt translation by the core.

I disagree. The non-standard part is that 'interrupt-map' translation
is not transparent. 'interrupt-map' that can't be parsed in the
standard way is just wrong, and I imagine was never the intention
here. We simply cannot have platforms defining their own format for
standard properties.

Reverting this will cause dtc warnings now (IIRC) and just kicks the
can down the road. Reverting is fine for now (I gave Arnd the okay on
IRC), but I think the parsing will need to be updated to honor
#address-cells and detect an old DT (probably by looking at the total
size of 'interrupt-map') and mark that change for stable. That would
only leave a new dt with an old kernel without stable updates broken.
Seems unlikely a device is getting firmware updates, but not OS
updates.

Rob
