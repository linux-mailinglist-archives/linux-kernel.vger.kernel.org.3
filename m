Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B423B4964D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382021AbiAUSLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:11:19 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49660 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351906AbiAUSLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:11:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id B9A9A1F464C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642788677;
        bh=puFQfV2qs1P5GiBXbGYGLI3CuoMa0yPk+MB1rCXDW7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MB1VQeWC1/iBDRcjP7HC7OVuYMZ7pRJj/izmVeszIT8A75QAsYq8eQ0VZlHCkNbo5
         tJVFvDT54T5rvd1KidIV6LDdDPTvhFARPEm/cnV6XryeJoiXNz/FdsI6KH8G+Uex3N
         84L18gfJLSII0sON/va0LGuUiKRgkCXqZTA+ohOFTsQ8XIUI2xmfthPvsItdU+mLQB
         AnewK1QA+4Ekkm3LP9KZQKKU4bctYjDqwmWjA5mPn8ht+7TO9aRBWWphBw+pOZqKv2
         sRnK49nv3qxgpLN32zx7JRFVCwKyT3uz8l0y7Ot/6DJn7D3QzvgW8LbuoMfYwGXwiB
         NX6JLhM9/dg6w==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 1/9] regulator: rpi-panel: Register with a unique backlight name
Date:   Fri, 21 Jan 2022 13:11:15 -0500
Message-ID: <3643770.kQq0lBPeGt@falcon9>
In-Reply-To: <Yeremcbzpj2LqFOD@sirena.org.uk>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com> <20220121152056.2044551-2-detlev.casanova@collabora.com> <Yeremcbzpj2LqFOD@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 21, 2022 11:26:01 A.M. EST Mark Brown wrote:
> On Fri, Jan 21, 2022 at 10:20:48AM -0500, Detlev Casanova wrote:
> > Use the parent dev_name. It's not as readable, but is unique.
> > 
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> > 
> >  drivers/regulator/rpi-panel-attiny-regulator.c | 3 +--
> 
> You've not provided a Signed-off-by for this so I can't do anything with
> it, please see Documentation/process/submitting-patches.rst for details
> on what this is and why it's important.

Oh ok, I thought only the author had to be there but I'll add myself as well. 
Thanks for clarifying this.



