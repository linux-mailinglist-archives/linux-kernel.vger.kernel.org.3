Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9023B473E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhLNI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhLNI1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:27:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E842C061574;
        Tue, 14 Dec 2021 00:27:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0948D61353;
        Tue, 14 Dec 2021 08:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A87C34604;
        Tue, 14 Dec 2021 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639470434;
        bh=r8TdqGJCnb9kOuKR7NwN5SqESX/fhNyX99iaKeTy3dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayjkAxTZaLTm21EMX2bKk1zx6oVcqbVHcRM7id+wtdaWn/xCNH05XhMu2YgWbulKj
         44mncPTt+iTjVtYn94yBjGArySYKft0rfMs5XmoxmmHKVsZf/PnqNLO4i/uMxfqwfQ
         Ma7fzc1Dde3MBxrEEpdyhQsW2ednLKEL5lILkmxVjoqarWWDaPv9gUM/vQRL7ZVsxv
         maGczdydH5Li5Jpxn4XTefqJGn75BzJwFAIugqmkiKNhXmbBRAoy32DO4KeCkSkQoJ
         bqfDkoo8VMtYjLa6mo6ZArZHSWmlDNuhsWndvKpPQqTdR97bivFMvUwaKWYOqvMerS
         Xbp3emqjm2b2A==
Date:   Tue, 14 Dec 2021 16:27:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, ping.bai@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/3] add i.MX8ULP scmi power domain
Message-ID: <20211214082707.GD14056@dragon>
References: <20211208131755.1799041-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208131755.1799041-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 09:17:52PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  There is no dependency now.
>  Use Hyphen for node name in patch 2/3
>  Add A-b in patch 1/3
> 
> This patchset is to add device tree support for i.MX8ULP SCMI firmware,
> and enable it for USDHC node
> 
> Peng Fan (3):
>   dt-bindings: power: imx8ulp: add power domain header file
>   arm64: dts: imx8ulp: add scmi firmware node
>   arm64: dts: imx8ulp: add power domain entry for usdhc

Applied all, thanks!
