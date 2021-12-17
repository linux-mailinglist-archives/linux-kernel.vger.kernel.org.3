Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5647837D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhLQDHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhLQDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:07:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A26C061746;
        Thu, 16 Dec 2021 19:07:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DD79B82620;
        Fri, 17 Dec 2021 03:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BB9C36AE2;
        Fri, 17 Dec 2021 03:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639710441;
        bh=hfUvq5sE8wcSbnpnAf7uOZjs3igj2MW6Lz37oTkQF8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9dmIOaMmzwFq7e9K1+zVRxl87A+qYCtxWc3HtyJgENpKHLUxx6wtbV/HZDr6a2dp
         VslMaoTdc7A+mi+XDkXE/Wo5TlrmIXDNbYgrw7Cw+gfm5nsGEsGjzdDzuE+PN40Gwo
         S9ZRaJ/IIqZabxdCV+pNiyqMoB9K9qK8s+SDGaLVNG7HwVuPIYEHrRU5Ch7IBTFk3R
         cKNVb+djwwt0CpSIjG9IG0OC5PGIRUFZqC66C6/WiZcJ/+ZcR218GAnUkvjI0KOxgz
         ILZW2tLM+71yeAOMWfVY5wEIa0+M5t/hZBhEALZ0lYHd03nrl7jLpDbg57nNplT3gZ
         lyhtw69R/JuOA==
Date:   Fri, 17 Dec 2021 11:07:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yunus Bas <y.bas@phytec.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the imx-mxs tree
Message-ID: <20211217030714.GN4216@dragon>
References: <20211217105338.315a26b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217105338.315a26b3@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:53:38AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:

Fixed. Thanks for the reporting!

Shawn
