Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8058F477176
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhLPMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:15:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58442 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLPMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:15:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AE47B8239D;
        Thu, 16 Dec 2021 12:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DB4C36AE4;
        Thu, 16 Dec 2021 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639656926;
        bh=zJxqF2eobN3eH3wNa/+PlZOl9aLErNlJj//R9nQfzVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q6zdRDatoydMPAMbui8I2jN1zTOoZ8IiUlRZz0/Aym8FcpRkvXnWRV6VfQ9m2x4Fn
         TRKLB02OmNywhY66G0K3aHUH3jNQtFpEqY/oe4ZBCw4TGMBPD9zKs902aag6h7x1kC
         xQ5b8uP5GNKzBVUJ+e4GRPeleBZhZnCwELfUJNADnijt0eaIU1a/gP+Wj7OVljCLtQ
         rPu4VhbvlJ6qcIZIn9XtnWjaHneFkHjN7o1Rtlg2xqOywocQLf5ltgXtxXkiYz511g
         tx1YVNDsjUul29U9t3KxmBahPZhBoOSMkg3brvQknijUpFKg7M/PonYuby26fmGmI8
         yMPP4JelByEMg==
Date:   Thu, 16 Dec 2021 13:15:22 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-media@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: prefer generic SPDX-License expression to
 deprecated one
Message-ID: <20211216131522.4e7b148d@coco.lan>
In-Reply-To: <Ybsrdll5sqIakINT@kroah.com>
References: <20211216103132.8087-1-lukas.bulwahn@gmail.com>
        <20211216122311.0c9d154e@coco.lan>
        <Ybsrdll5sqIakINT@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 16 Dec 2021 13:05:10 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Thu, Dec 16, 2021 at 12:23:11PM +0100, Mauro Carvalho Chehab wrote:
> > Em Thu, 16 Dec 2021 11:31:32 +0100
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> >   
> > > Commit 8d395ce6f04b ("media: dvb-core: Convert to SPDX identifier") and
> > > commit e67219b0496b ("media: b2c2: flexcop: Convert to SPDX identifier")
> > > introduce the SPDX-License expression LGPL-2.1-or-later for some files.
> > > 
> > > The command ./scripts/spdxcheck.py warns:
> > > 
> > >   drivers/media/dvb-core/dmxdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > >   drivers/media/dvb-core/dvb_demux.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > >   drivers/media/dvb-core/dvbdev.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > >   drivers/media/common/b2c2/flexcop.c: 1:28 Invalid License ID: LGPL-2.1-or-later
> > > 
> > > The preferred SPDX expression for LGPL-2.1 or any later version is with
> > > the more generic "+"-extension for "any later version", so: LGPL-2.1+
> > > 
> > > This makes spdxcheck happy again.  
> > 
> > It doesn't sound right to apply such patch.
> > 
> > See, the latest SPDX version uses LGPL-2.1-or-later:
> > 
> > 	https://spdx.org/licenses/LGPL-2.1-or-later.html
> > 
> > And it deprecated LGPL-2.1+:
> > 
> > 	https://spdx.org/licenses/LGPL-2.1+.html
> > 
> > So, those files are perfectly fine with regards to SPDX, and are
> > adherent to its latest specs. We do need the latest specs on media,
> > as our documentation is under GFDL-1.1-no-invariants-or-later, which
> > only exists on newer SPDX versions.
> > 
> > So, the right thing to do here seems to fix spdxcheck.py, letting it
> > either allow both variants (as we probably don't want to replace it
> > everywhere) or to emit a warning if the deprecated ones are used.  
> 
> No, we are not going to add a "warning" for older SPDX versions like
> that, otherwise the majority of the kernel will start spitting out
> warnings.
> 
> Let's worry about actually fixing all of the files that do NOT have SPDX
> tags before even considering to move to a newer version of the spec.  We
> started this work before the FSF made the crazy change to their tags,
> let's not worry about any deprecated issues at the moment.

Yeah, agreed.

Thanks,
Mauro
