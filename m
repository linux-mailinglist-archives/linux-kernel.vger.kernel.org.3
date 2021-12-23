Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7134347E239
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347913AbhLWLZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347908AbhLWLZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:25:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7877CC061756;
        Thu, 23 Dec 2021 03:25:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E452B82004;
        Thu, 23 Dec 2021 11:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FDCC36AE9;
        Thu, 23 Dec 2021 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640258723;
        bh=hP0ZPwGrLJ5L9ght86XMHMVAyvOjs4D499mJuEVzkzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWPUwxkchGsUwNeAa6Ufmmd2KK9sc0B/fABWV6OLUNi/XgLzuel7mCELfrtS0xDon
         Cl6PBPr7Apyio4nTwOj3bFcqzkubz/jkA3Psr8pn7n+YTFxORuuQVDwiSHORT5wPSY
         kaP2UISdxvkuMwEdfV0fbdiJGot9pq9c7AVt4ZoiOFR69g40Kauc0nxYgAZqyG2fqA
         bJaAAQo4B1FGsVx0MKRScw57rzUlaoboi9zS9olZlT5DCjfnkgk9E9NUgbklY5IeEL
         dImwfzBxAVPn1UIlj9Gq4WNv/BgEl8P2VH3BzYMxZW13WYOwaHDGl9jrGTCj2nd7cR
         QH+zEGZ/dEoag==
Date:   Thu, 23 Dec 2021 16:55:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v3 0/8] phy-rockchip-inno-usb2: support rk356x usb2phy
Message-ID: <YcRcn17RMRGsLr5M@matsya>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-12-21, 16:02, Peter Geis wrote:
> Good Afternoon,
> 
> This is my series to support the usb2 phy devices on the rk356x.
> The rk356x phy has a single muxed interrupt and has moved the usb2phy
> nodes out of the grf and into their own nodes.
> The phy needs to tie back into the grf for register control, similar to
> the rv1108.
> By moving the phys into their own nodes, they now have full
> #address_cells = 2 register addresses, but they still reside below the 32bit
> mmio range.
> 
> This driver series only supports the host configuration for the rk356x.
> I have have tested it on the following:
> rk3566 - Pine64 Quartz64 Model A
> rk3399 - Pine64 Rockpro64
> 
> Please provide feedback and comments as you see fit.

Applied patches 2-6 to phy-next

Thanks

-- 
~Vinod
