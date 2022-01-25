Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287D249B069
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573457AbiAYJgN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 04:36:13 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:58021 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574399AbiAYJd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:33:57 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E7322200011;
        Tue, 25 Jan 2022 09:33:52 +0000 (UTC)
Date:   Tue, 25 Jan 2022 10:33:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the mtd-fixes tree
Message-ID: <20220125103351.2be25d78@xps13>
In-Reply-To: <61ee92ef.1c69fb81.95ef3.4aa6@mx.google.com>
References: <20220124072800.14c492a5@canb.auug.org.au>
        <61ee92ef.1c69fb81.95ef3.4aa6@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ansuelsmth@gmail.com wrote on Mon, 24 Jan 2022 12:52:12 +0100:

> On Mon, Jan 24, 2022 at 07:28:00AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >   2b3d77cb5ce3 ("mtd: parsers: qcom: Fix kernel panic on skipped partition")
> > 
> > Fixes tag
> > 
> >   Fixes: 803eb12 ("mtd: parsers: Add Qcom SMEM parser")
> > 
> > has these problem(s):
> > 
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed in the futrure by setting core.abbrev to 12 (or more)
> >     or (for git v2.11 or later) just making sure it is not set (or set to
> >     "auto").
> > 
> > In commit
> > 
> >   7815173a7ccb ("mtd: rawnand: ingenic: Fix missing put_device in ingenic_ecc_get")
> > 
> > Fixes tag
> > 
> >   Fixes: 15de8c6 ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
> > 
> > has these problem(s):
> > 
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed in the futrure by setting core.abbrev to 12 (or more)
> >     or (for git v2.11 or later) just making sure it is not set (or set to
> >     "auto").
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell  
> 
> Hi, sorry for the mistake. I wrongly copied the Fixes tag from a prev
> commit. Should I resend the series with the correct fixes?

Hey Stefan, thanks for the warnings.

Ansuel, Miaoquian, I've fixed the tags inline, don't forget to fix your
tooling for the next time ;)

Thanks,
Miquèl
