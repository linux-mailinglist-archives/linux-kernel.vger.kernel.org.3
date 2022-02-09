Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928BE4AEB29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 08:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbiBIHfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 02:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiBIHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 02:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47762C05CB92;
        Tue,  8 Feb 2022 23:35:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E78BB81F46;
        Wed,  9 Feb 2022 07:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7EEC340E7;
        Wed,  9 Feb 2022 07:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644392116;
        bh=p/fVFN4fhl2mww8hF6/jEu3Mn0a4mJN2CbZQGUxSDBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBBnP6pIN3DyDXScZiMzazjCU6A34llpx51UlEWh15wRsnIRnWFpwpi0c+s5e5WGG
         8WCMjFw56wrlbESJvj/0QbixjkDm8ObJVwD2MXxmkgUd/dVsQCD/FXYOcBzCNyaUy6
         Cc2jnclMX7Z1EzZUoBktVKZnYGraRDKyzH09Vqn3aWPd5a5AlwMvSpdLK592VwOO4m
         8LX4/87Hf5gbe7gKJ0nWHTm2qLNqmQp+4GVPmqAYK4SrIMQR7Oj8PPs9ni6heVBZsf
         RRXopnekQYlrsSqoht4fuEU8mDSq+PAtS8iEnOwCkTbYlVCW/2bpal9cirwYzNnmkY
         SYA7sSKfJekAw==
Date:   Wed, 9 Feb 2022 15:35:10 +0800
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
Subject: Re: [PATCH V4 11/11] arm64: dts: imx8mm: Enable Hantro G1 and G2
 video decoders
Message-ID: <20220209073447.GH4909@dragon>
References: <20220125171129.472775-1-aford173@gmail.com>
 <20220125171129.472775-12-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125171129.472775-12-aford173@gmail.com>
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

On Tue, Jan 25, 2022 at 11:11:28AM -0600, Adam Ford wrote:
> There are two decoders on the i.MX8M Mini controlled by the
> vpu-blk-ctrl.  The G1 supports H264 and VP8 while the
> G2 support HEVC and VP9.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Applied, thanks!
