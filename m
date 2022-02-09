Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BDF4AEB1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiBIHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiBIHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:33:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24EFC0613CB;
        Tue,  8 Feb 2022 23:33:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E9B8B81F03;
        Wed,  9 Feb 2022 07:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876DCC340E7;
        Wed,  9 Feb 2022 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644392000;
        bh=Rzge9oAQz4dbWS5RgHIqc15BqtGl9ShBQCtd3fASJXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvUqNy2tT+NEgFGw7BnwE2Dca4xIFY/4a8zTuBbAq8X+bRRoS5fd+n3jc7xHFXofs
         Iv85lAIGdgTVgh6uobVdjkdLI9yA1riob3q9a6h5KED5h4IpPHxFGj7oiiD2VJ7jSl
         5pbjHGHVB6y74cN4RNgdGmEvesH4bcNKrbyHDgnkEROJHeOfQuvXZTTD/a75QzqXF4
         65Z9uTDLZe9KKKEwyzV6aAn6bRQcs/qeGpEPyl0w+Jhfe2pAtvS1C+myuAu7jkyiNb
         /ONgmTQgPBK+l0HaxzH3wqHsBjRWu1X2VcNBCZOKj14aUvobR3mWwWp3IFuWumh0n6
         fjmEzKfij9bYw==
Date:   Wed, 9 Feb 2022 15:33:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-media@vger.kernel.org, aford@beaconembedded.com,
        cphealy@gmail.com, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH V4 08/11] arm64: dts: imx8mm: Fix VPU Hanging
Message-ID: <20220209073312.GG4909@dragon>
References: <20220125171129.472775-1-aford173@gmail.com>
 <20220125171129.472775-9-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125171129.472775-9-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:11:25AM -0600, Adam Ford wrote:
> The vpumix power domain has a reset assigned to it, however
> when used, it causes a system hang.  Testing has shown that
> it does not appear to be needed anywhere.
> 
> Fixes: d39d4bb15310 ("arm64: dts: imx8mm: add GPC node")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
