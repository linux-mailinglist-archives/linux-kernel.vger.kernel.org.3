Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B169C4CAB3F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiCBRPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiCBRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:15:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125445676C;
        Wed,  2 Mar 2022 09:14:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABBC8B81F76;
        Wed,  2 Mar 2022 17:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75300C004E1;
        Wed,  2 Mar 2022 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646241268;
        bh=SOwFFF1Iq+bs3gvz8AxW8+ACa2Xzt/OHDUy2LcN4t4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVXBqVqWvkyQdraxGqpHYbW56m0sDK6dga0TJE2eCl12sXOukgforDdWC+PmmXqiV
         yLUqxyNmZ8Yh0nM9+UWYn2xspcy0vF3WB5RcIfXRMiNgci9w0K7tqELjZ/TOB7f4FH
         wVR90qm+bWO81OQ9sqNcpcqeYu9qrWDsTjNFNNbaLBejlLfMREfmqC4y75qM5QVZ2j
         AP52UGmGXuoXBWlbxabP5tpObaKrlrzhz2Ouvp5ykFMpvaePKPKi8udcmVHLDNekrX
         K43O+pe3eeEvIguILzcbK07en58thnRRb9Xenro9plN3zTpnzJmR7/8TvwGmbYctrm
         ToPC4c+sZFgIg==
Date:   Wed, 2 Mar 2022 22:44:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Geis <pgwipeout@gmail.com>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng
 combo phy register compatible"
Message-ID: <Yh+l7+7zDvI/9e6n@matsya>
References: <20220302143427.447748-1-vkoul@kernel.org>
 <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJMZ8PHqJk6drNbNHprmfeV9UvJzJnech7sz_JwcdbckA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-22, 11:04, Rob Herring wrote:
> On Wed, Mar 2, 2022 at 8:34 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
> > combo phy register compatible") as that was wrongly merged, so better to
> > drop the wrong patch
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > I am applying this to phy-next to fix the issue
> 
> Reverting will just cause a different warning that it is undocumented.

Right, but a patch for that would fix that

> The fix in the other thread won't apply either if you revert.

It is not applying for me, so that needs to be updated anyways..

-- 
~Vinod
