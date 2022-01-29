Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E794A2C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiA2HBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbiA2HBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:01:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED8C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 23:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 662C360B65
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 07:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DA0C340E5;
        Sat, 29 Jan 2022 07:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643439665;
        bh=BamMGzH8nXZci1GRam4W2FajTEbOEjdeeV7Z0ODh6xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mffmIT29FQGgwpUdF6lGEoghZE44l1CXYl7FwtXNdfb2wJb1R3JZPQwNNsWxVQ61a
         tPV4wizXYKSvJY9fJqkBW/qjnt3bwopmwoX41GP1PT9ZZ1lejmQloaeW5rwfih1xJi
         33W2pGyZUd0gjYmAhc1buOx66zBLNKZcG5rHWWTPFMgBvKhSPCpuwtrey+MbDy2T10
         +fhio6qkAf/N1eT/7VVGSwsbmMvofeyYXDdqiv9zaCV3+qxql9V3LQQ3ld9tFv/jSc
         W10ApU4BeSZOYlIgcSCSHnRorRMf95ywVToCgTjZTvIOeSrjttHI2ummdZ6smPROGX
         pzAARalaQPQMw==
Date:   Sat, 29 Jan 2022 15:01:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Marginean <alexandru.marginean@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1028a-qds: define mdio slots for
 networking options
Message-ID: <20220129070100.GY4686@dragon>
References: <20220126092650.19962-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126092650.19962-1-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:26:50AM -0600, Li Yang wrote:
> The ls1028a QDS board support different pluggable PHY cards.  Define the
> nodes for these slots to be updated at boot time with overlay according
> to board setup.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
