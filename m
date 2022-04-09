Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488174FA1EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 05:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiDIDLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 23:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiDIDLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 23:11:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B346B37033;
        Fri,  8 Apr 2022 20:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D8D7622A0;
        Sat,  9 Apr 2022 03:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09599C385A4;
        Sat,  9 Apr 2022 03:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649473748;
        bh=Rpu8Inf7+uShNfGmV5smMp6deLedEk+JMmMPJzOsVSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkZR5HcH6s72t3ZQZU37oxTEq95eRMfaw32sb6yFgN16Tfr8ron62KjoMAr6n5YMq
         yz8vRiPqLS5Xtn9ELb3ccJv/fB6LS1hb7D7vaeUn5pgBY43dTv0nBhickKhalXjxgn
         NPckdPSHJzbN4as8ohRhrp2pN3mHsufQOTMa1HDFqfBSdNGw/kaJojwBrAVzQRDJCZ
         gIo7DRlIJ7wnuYbslp1DAE+o8YcbqmXhKiEV2+l5uh2WkQY4WPSJkzgP8Un+b7k2pe
         2K9+sNWdqODsATC/AQ60h2keI75zO2CouZN8Z89UlHYb0eB3djRcMX0NV5pgdXedSn
         craaFFRYhCjSQ==
Date:   Sat, 9 Apr 2022 11:09:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx: Fix imx8*-var-som touchscreen property
 sizes
Message-ID: <20220409030902.GB129381@dragon>
References: <20220304202527.316532-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304202527.316532-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:25:27PM -0600, Rob Herring wrote:
> The common touchscreen properties are all 32-bit, not 16-bit. These
> properties must not be too important as they are all ignored in case of an
> error reading them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
