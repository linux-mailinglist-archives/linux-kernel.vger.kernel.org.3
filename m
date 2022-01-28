Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FCD49F217
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345899AbiA1Dy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345880AbiA1Dy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:54:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD82C061747;
        Thu, 27 Jan 2022 19:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F05961E4D;
        Fri, 28 Jan 2022 03:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24020C340E0;
        Fri, 28 Jan 2022 03:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643342094;
        bh=F6nMqm2BNQjdzdmorsoB0MzkOs8aAyfe1virzyMv7AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2ot7KCJasSgw2zrePoc+6uDJQ8W8Aq6gwt9RHYZfIAPNnXMhmkl04oN4V/nWZR2x
         bBlYZ7Z/rHNbYjZZu/O5sW7FLje9EWYOjS0TJNVSIqOznqzpUFwPMdb4/BEoYMg20C
         RQ6YJjtHQuZHgWwzYAvwXRIfbWTtMPLT7JzYovdSEuo0tQEhyw0gNAsDzYs38qkIJ/
         yQPrxu5JF+seZk8FTZNLWy0B6Mv81GXg0IrgT1rryQcz/ul1ag8NZyUDd1J0s2+tWb
         9+g1U9N4PoVhmeYMeluzbsAnqh5cqH/6Xy6Gt/k0k0wo2Z2XIalOJDO/9niPvBL333
         R5UsSTlz9r7LA==
Date:   Fri, 28 Jan 2022 11:54:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: imx8m{m,n}_venice*: add gpio-line-names
Message-ID: <20220128035447.GZ4686@dragon>
References: <20211215001812.9006-1-tharvey@gateworks.com>
 <20220126090739.GH4686@dragon>
 <CAJ+vNU3Xj-b2BSc_6MQrtrh-G=5dMdMmw0S8EtujVz_7FvkQ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3Xj-b2BSc_6MQrtrh-G=5dMdMmw0S8EtujVz_7FvkQ0w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:49:41PM -0800, Tim Harvey wrote:
> On Wed, Jan 26, 2022 at 1:07 AM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Tue, Dec 14, 2021 at 04:18:12PM -0800, Tim Harvey wrote:
> > > Add gpio-line-names for the various GPIO's used on Gateworks Venice
> > > boards. Note that these GPIO's are typically 'configured' in Boot
> > > Firmware via gpio-hog therefore we only configure line names to keep the
> > > boot firmware configuration from changing on kernel init.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >
> > It doesn't apply to my imx/dt64 branch.  Could you rebase?
> >
> 
> Shawn,
> 
> Sure, I'll try to submit another version within a couple of days.
> 
> Did you happen to see 'arm64: dts: imx8mm-venice*: add PCIe support'
> [1]? It seems to have been archived for some reason and it may have to
> be rebased after I re-post this one unless you can take that now.

I forgot to reply, but I had already pick that up.

Shawn
