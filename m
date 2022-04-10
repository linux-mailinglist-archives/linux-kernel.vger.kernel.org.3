Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D61C4FAB61
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiDJBe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiDJBey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3584F140AC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 18:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B3E60E26
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 01:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C04EC385A4;
        Sun, 10 Apr 2022 01:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649554364;
        bh=ynfEPwoFwYmFUswcCqs1LxJiNY8AVZwcm2J0YbXk8Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qN96ZKgsipA5HJNqv0AoEbsZEM9QDqCXlV/Ge9FA7s8MS/ZxndGabmmchpFu1WVAq
         jn1EwtwjsQrx1+y1JZyMxlttOfIln/cJ4Sd+oYjxGW4knSeAcdetiQwcV7Nheuad8O
         Y4E9Ljubf4y9S4R2Y+TiHgzex7FMkHia87YDSov1avMKAZjscnNmnw2t6A72fJu4jq
         wWOmTjqHX9PW4JnJxAyQw0roLDgbeuLOsKPPSNJ801XvCd1tUiR6k1zaaS27tB4c9E
         3806FZdCpwjTk1vWwRGkgw2nxGEdViF9qkJishCCCCjTPNpJmy2WIHQ1X9IH/RGPTl
         fH0iH4/oIEYmg==
Date:   Sun, 10 Apr 2022 09:32:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] soc: imx: imx8m-blk-ctrl: Fix IMX8MN_DISPBLK_PD_ISI
 hang
Message-ID: <20220410013239.GL129381@dragon>
References: <20220320205212.701548-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320205212.701548-1-aford173@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 03:52:12PM -0500, Adam Ford wrote:
> The imx8mn clock list for the ISI lists four clocks, but DOMAIN_MAX_CLKS
> was set to 3.  Because of this, attempts to enable the fourth clock failed,
> threw some splat, and ultimately hung.
> 
> Fixes: 7f511d514e8c ("soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
