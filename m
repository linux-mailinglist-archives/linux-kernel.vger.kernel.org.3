Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6E476D70
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhLPJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhLPJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:29:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B53C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 01:29:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECD0261CF2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4C6C36AE4;
        Thu, 16 Dec 2021 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639646995;
        bh=aljkijfCTz/p1sFYd3ASVUoEeyxMS16mbSqdgoOhxoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2uW9vZvsUbXZRpjUpQIc0G1CfAx80CnUfAYimigTgQ//PyyBJtHqkM6hLMeWu6E1
         tpj6opm7YMnxylJDoUBKovdGEe0TAdbIOFdpcrwkgvMBJi+HzG4Gsi7Lv4LSW54L3q
         rocPf42MeTvfLOpKStGC3qLmLhbXYTnblY7sUn2wZGUtXWUhzbzTjVFKjKaN0m0guw
         wa+hon7PLH0e0odxR27tUrn27F10YZoOEyi/aTLVwYysHlRgJb8s6uPulq0XDT/QJf
         o2xddsCrqCPYuapZHPFGWAZpfJL4bepmnzR5pFtkJRYzZvhRorChDTehuApJxyBamz
         lm4n3ZkSyjeyg==
Date:   Thu, 16 Dec 2021 17:29:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH v3 10/10] arm64: dts: lx2162a-qds: add interrupt line for
 RTC node
Message-ID: <20211216092950.GH4216@dragon>
References: <20211214072342.22692-1-leoyang.li@nxp.com>
 <20211214072342.22692-11-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214072342.22692-11-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:23:42AM -0600, Li Yang wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> Add interrupt line for RTC node on lx2162a-qds
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>

Applied, thanks!
