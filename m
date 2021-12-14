Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A158473B5C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhLNDOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:14:07 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54030 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhLNDOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:14:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5CF99CE16B3;
        Tue, 14 Dec 2021 03:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37568C34605;
        Tue, 14 Dec 2021 03:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639451643;
        bh=cIbvf3ZL2PJ3kwzgpLwIdMAmHp6jvH/TiYSFbWgc4PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uuud5Ie5RQIAkiTK/yQBzGs4RDLdAMlO4mMr4sUq202zm9dXGOCPiec8f/w1CtCFP
         uttmN16xowCJ0p97LSwsW4I3CJ9L05Jyf/BlKKjX8Y7Zs0FYWT0yKo0tq98/HbYOKE
         TyXAQCXIvmc6895b4CMe88IUVTLLbNn/Eagui/P1+cHzwdGCU19O3kYRXVc9MVYOVS
         47AaXQvV7KlAHK6w5/qTRWtcmJLdCsb+PGCIUgq0Et2KUueQ6D5YFkOKJGh0iHagUt
         ZaCOUGXszkkXVyI7H4lDLwQCXnENv9isccme1tfRpAF8qiZf8S9dFcC+NxXb6ULNng
         dnOCWLs0KOsnQ==
Date:   Tue, 14 Dec 2021 11:13:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 0/9] arm64: imx8mn: Enable more imx8m Nano functions
Message-ID: <20211214031356.GA10916@dragon>
References: <20211128131853.15125-1-aford173@gmail.com>
 <CAHCN7x+yOs3icCV2OsKwAPRcov4Cb9Q+K8b2oy7WZowb3YZnRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+yOs3icCV2OsKwAPRcov4Cb9Q+K8b2oy7WZowb3YZnRA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:03:06PM -0600, Adam Ford wrote:
> On Sun, Nov 28, 2021 at 7:19 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > The i.MX8M Nano is similar to the i.MX8M Mini in some ways, but very
> > different in others.  With the blk-ctrl driver for Mini in place,
> > this series expands the blk-ctrl driver to support the Nano which
> > opens the door for additional functions in the future.  As part of
> > this series, it also addresses some issues in the GPCv2 driver and
> > finally adds support for enabling USB and GPU.
> >
> > V4:  Rebase on top of [1] which fixes hangs caused from CSI and DSI reset
> >      and add the same fixes for CSI and DSI to the Nano
> > V3:  Fixes an the yaml example
> > V2:  Fixes the clock count in the blk-ctrl
> >
> > [1] - https://www.spinics.net/lists/arm-kernel/msg936266.html
> >
> 
> Shawn,
> 
> This series should apply cleanly against your tree now that [1] has
> been applied to your tree.  Should I submit this a resend or are you
> able to test the build now?

I haven't seen any comments on this series from Lucas.

Shawn
