Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A1473AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhLNCiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:38:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E0C061574;
        Mon, 13 Dec 2021 18:38:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1916A612DC;
        Tue, 14 Dec 2021 02:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE49C34603;
        Tue, 14 Dec 2021 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639449531;
        bh=/aQ0TtIZ+kzWB5Abht82P2wcjqy/Z3erSZiZRabXKn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXj5BLlU44Oh1y8cOV9pdGDUlKZU80J4vDiteHqsyoFe7A5P3go3p6A7UC/NJf6ny
         o5bmkRvl8omA7Ve0YFUp2oddc+3TNURelnSKAygIVXZNkMRzWF+V49ejfBCqXO7BwL
         2cv1FYzxKpxDsfUc3hUGAXKvHDikPvi+AyEsqOydt8ieOEKUp7NZohP7ek39H8axkt
         IQXYP9ilAF9lww45LRtjEktmeqwWOmLl7IGAqCnD+IDTcbdd1Sp1VEkI3n0DFHOAPK
         lWORX+CqsJI83aGlrjdCf1rcRnuiYKTMeYkytfboA3/X8VpdwqrPfFCBnyL8jUw1JF
         HeXT71yZDQL0Q==
Date:   Tue, 14 Dec 2021 10:38:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 0/4] NXP LS1028A-RDB preparation for device tree sync
 with U-Boot
Message-ID: <20211214023846.GN4216@dragon>
References: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:15:24PM +0200, Vladimir Oltean wrote:
> An effort was started for the NXP LS1028A to share device trees between
> Linux and U-Boot, and so far the common SoC dtsi is shared, but
> individual boards still aren't. This patch makes some minor changes to
> the Linux device tree so the DT for the reference design board can be
> successfully shared with U-Boot.
> 
> Vladimir Oltean (4):
>   arm64: dts: ls1028a-rdb: sort nodes alphabetically by label
>   arm64: dts: ls1028a-rdb: add an alias for the FlexSPI controller
>   arm64: dts: ls1028a-rdb: add aliases for the Ethernet ports
>   arm64: dts: ls1028a-rdb: update copyright

Applied all, thanks!
