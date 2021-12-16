Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54B476D60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhLPJ2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhLPJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:27:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1680EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:27:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E3BA61CB3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB05C36AE4;
        Thu, 16 Dec 2021 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646878;
        bh=8uejualvfxMt+IP4x8HlUDcPtsbVtHGkLAaa1WGmSQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiU9wNiDyJitwqMHyf/5/cueQC93OplASoHaMFMqFbmLiCDLi1AVftuivuLnTENny
         r2B3K915OsQ/9hBZBtrjm9AD4dRXos8cw6BZiVltsAisCQbHqEv7T7fipl9e1fTv+K
         dyI7spjM3qGz+8XqWbZvnDbIZGvU7xUhp2r4N+FNKueYBGi281HH9r3cROI/cWsqHh
         HKvPL4P6cQI8X7yBFt8InI4mAuo/No21jKe9OXPkE7ABu/mMIN7LBTREGnJwXzWe5c
         Ukd1RWq5oO1WKHPp6TS0E5/Ez/w0VQhV8rwhtEvvsD3xnO30AilXEzMgGqjJKzbisC
         b57PSjGQz+pFg==
Date:   Thu, 16 Dec 2021 17:27:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>
Subject: Re: [PATCH v3 04/10] arm64: dts: lx2160a-qds: Add mdio mux nodes
Message-ID: <20211216092753.GE4216@dragon>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
 <20211214072342.22692-5-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214072342.22692-5-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:23:36AM -0600, Li Yang wrote:
> From: Pankaj Bansal <pankaj.bansal@nxp.com>
> 
> The two external MDIO buses used to communicate with phy devices that
> are external to SOC are muxed in LX2160AQDS board.  These buses can be
> routed to any one of the eight IO slots on LX2160AQDS board depending on
> value in fpga register 0x54.  Additionally the external MDIO1 is used to
> communicate to the onboard RGMII phy devices.  The mdio1 is controlled
> by bits 4-7 of fpga register and mdio2 is controlled by bits 4-7 of fpga
> register.
> 
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
