Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68A3476D61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhLPJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhLPJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:28:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECE8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:28:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D67F9B8226E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A896DC36AE4;
        Thu, 16 Dec 2021 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646912;
        bh=FG4xw8e7oOZPRPRNmZQniDm5ZeD1fUtRWPxXFTcLXFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMJCP0WD/YcOpyaBVbJHYlQE4WJ/e25KMZYlBaEUaEVYpW/YLjFB2OoSjifbPakRi
         ql8rAgiCK1HSYt4VHy9dLTlA4CnNGXuMtMzUsLmEO9ccB1Yx9LKbaMxbwrizdneh2N
         5tOWIpdjUmJoppz4+rvepFqnGIO5uSj/WCfxMk8vlAgXjOP23XIcaaDDp8rNhSAgbn
         erC6hScBiWjoJQM36hosRVM8c8xIP7boNFIxbwnMnjxVPWGs/sslIToJsaplHHEo75
         LarXIrz10yy0omk7eFAHizC4kaJTw6eCvXYz5f3L7ll96Q3Hjhw+cvK7xrDuFmLPTO
         QqrRiVLBCyueg==
Date:   Thu, 16 Dec 2021 17:28:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v3 08/10] arm64: dts: lx2160a: enable usb3-lpm-capable
 for usb3 nodes
Message-ID: <20211216092827.GF4216@dragon>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
 <20211214072342.22692-9-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214072342.22692-9-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:23:40AM -0600, Li Yang wrote:
> From: Ran Wang <ran.wang_1@nxp.com>
> 
> Enable USB3 HW LPM feature for lx2160a.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
