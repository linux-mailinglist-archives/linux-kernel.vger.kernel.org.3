Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9254E476D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhLPJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhLPJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:29:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0980DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:29:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC9B0B82319
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA47C36AE4;
        Thu, 16 Dec 2021 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646953;
        bh=wYZaZmq3IBeC5Gbj02uBtH5ax5/iy+aj7QBVSw1iftU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JoqlUn3AGhLcUEuEk78r9FONMbPX6ns+sjj/3VlqnwKCgMNsKMxQ/Srt89CGPejFW
         ecPChnSvkDMiNnF7FwJmyZ0XQxuW7UwrFSquBba4ddyL1yCjMq2JgmGKuFvWTh9nTa
         MRBA+ZEZWxi3QUPBv4xbBJOxo+QdHVDvbt8qXX6liUc7N7iY4mGJROVVjosI9fHKkl
         nTGcVza+7Hrg1J80H6wuY4YMAfu8Yd0cI+p9cDwhoGNfw8f/VtlHZ3ZqS2VxbeVM1l
         2bwYFTldaDCmLcXZut8kmVsadH7GiWbRndZm8FomEL4lMyibonyE2/8OE1qzvd99+r
         yIMsJc35EWThA==
Date:   Thu, 16 Dec 2021 17:29:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH v3 09/10] arm64: dts: lx2162a-qds: support SD UHS-I and
 eMMC HS400 modes
Message-ID: <20211216092908.GG4216@dragon>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
 <20211214072342.22692-10-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214072342.22692-10-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:23:41AM -0600, Li Yang wrote:
> From: Yangbo Lu <yangbo.lu@nxp.com>
> 
> The default NXP SDHC adapter cards for LX2162AQDS are SD 2.0/3.0
> adapter card for eSDHC1, and eMMC 5.1 adapter card for eSDHC2.
> Add speed modes properties supported by the two adapters in device
> tree node.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
