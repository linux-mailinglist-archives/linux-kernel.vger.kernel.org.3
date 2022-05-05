Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB90351B6D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbiEEEAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242468AbiEEEAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:00:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D8D4A91F;
        Wed,  4 May 2022 20:56:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8BABB82B79;
        Thu,  5 May 2022 03:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9EDC385A4;
        Thu,  5 May 2022 03:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651722973;
        bh=kH1fz4gNh3mYTjRRJTtbtpytPYOOHrYxMA2L0N7FXuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFAfNlQsIL3gsNXuhBp25HpT9K0sSeEZxDvftGn2iFnTxU81ixbHGAse/lcTD71y9
         Y7Kgnah1E9BnULvgjQ4X4cx4/p5mB2yFhKd/80vaDmUPiR2LD2X4t4EEuf7z93Y+yu
         OZn+IB038aWSKFEISZ8OHZ86d870RzTMBnw6Yd6UCHnzdVkTKsgM849FoW9wClWfKc
         T4OZJM2V55pG6+NPmuwytOsqj/7nXqFuIHPRhqEss+3kewaaBp/RWgJxhozbeyfzBg
         tPfmtCQK35ho6WbPlGgwA0HHtxJfYZAQ00HJ9FEtLDAsA6eQhon1igaIYulbhsDccM
         1IUqSBeqauV6w==
Date:   Thu, 5 May 2022 11:56:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ARM: dts: ls1021a: reduce the interrupt-map-mask
Message-ID: <20220505035606.GT14615@dragon>
References: <20220427075338.1156449-1-michael@walle.cc>
 <20220427075338.1156449-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427075338.1156449-2-michael@walle.cc>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:53:35AM +0200, Michael Walle wrote:
> Reduce the interrupt-map-mask of the external interrupt controller to
> 7 to align with the devicetree schema.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
