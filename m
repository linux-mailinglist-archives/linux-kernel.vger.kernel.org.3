Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930014CAB90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiCBR2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbiCBR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5185DCA33B;
        Wed,  2 Mar 2022 09:27:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 051AFB820DD;
        Wed,  2 Mar 2022 17:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EF6C004E1;
        Wed,  2 Mar 2022 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646242035;
        bh=XX+gbWN6d/khISVOWirF+epY3OmJ0EbDPOgJ5dqOVDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8aGkykE+wQjURHstd0nScvLq8LPy77ZrjSFnVf+lF80AE6XC02uex2sTI348BTE5
         y608MdYjz4A2HvtzFxrJi3pDwfL58AGLvoRCLHyzFlAZ3A5BSr2ob8PhCC0JkkGfSi
         1H6uGKXMak+XL9qEh59sRwZrHwik0fFXLXHx4ueV4CUwMAFbzZ3StOM0ciVB/ACHKc
         5Fc1tLapf64ahl1VZQJKUoAQOmQrRuydoDkR6TU4xIw5GZCyhIoJYD5OgsEynMIH5v
         f4871jWWDv6fR1FSYKTHX07XXbUZqNCzdHpwTIsFJi9ctB6LSVQgVomnoEeR/yFH3S
         FBgAENBJ4C8wg==
Date:   Wed, 2 Mar 2022 22:57:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng
 combo phy register compatible"
Message-ID: <Yh+o7/D0QqJypHga@matsya>
References: <20220302143427.447748-1-vkoul@kernel.org>
 <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
 <CAMdYzYoCeSKPQjUqigtP7GiAB8iDre9BRwVTqvmq_OA-N06NQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYoCeSKPQjUqigtP7GiAB8iDre9BRwVTqvmq_OA-N06NQw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-22, 12:12, Peter Geis wrote:
> On Wed, Mar 2, 2022 at 12:04 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Mar 2, 2022 at 8:34 AM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
> > > combo phy register compatible") as that was wrongly merged, so better to
> > > drop the wrong patch
> > >
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > > I am applying this to phy-next to fix the issue
> >
> > Reverting will just cause a different warning that it is undocumented.
> > The fix in the other thread won't apply either if you revert.
> 
> Reverting and reapplying the original patch would work.
> https://patchwork.kernel.org/project/linux-rockchip/patch/20220208091326.12495-2-yifeng.zhao@rock-chips.com/

It does not apply to phy-next!

-- 
~Vinod
