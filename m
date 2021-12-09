Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23746E9F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhLIObu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 09:31:50 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55037 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhLIObt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:31:49 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 73DEDE0015;
        Thu,  9 Dec 2021 14:28:13 +0000 (UTC)
Date:   Thu, 9 Dec 2021 15:28:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211209152811.318bdf17@xps13>
In-Reply-To: <20211209140721.6ki7gznvxwyn3cze@skn-laptop.hinnerup>
References: <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
        <20211123140715.280b2f70@collabora.com>
        <20211129101908.6f1aa715@xps13>
        <20211129094129.xn364czofrgtvfb4@skn-laptop>
        <63be9121-18c3-1ef2-c448-f99fb861490f@samsung.com>
        <20211130124131.6pgu7enjgk6y536m@skn-laptop>
        <20211130141551.400331c8@collabora.com>
        <20211130132912.v6v45boce2zbnoy3@skn-laptop>
        <20211130143705.5d0404aa@collabora.com>
        <20211203143958.40645506@xps13>
        <20211209140721.6ki7gznvxwyn3cze@skn-laptop.hinnerup>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

sean@geanix.com wrote on Thu, 9 Dec 2021 15:07:21 +0100:

> On Fri, Dec 03, 2021 at 02:39:58PM +0100, Miquel Raynal wrote:
> > Hello,
> >   
> > > > Fine by me, lets drop this series.  
> > 
> > FYI I've dropped the entire series from mtd/next. I'm waiting for the
> > fix discussed below (without abusing the chip mutex ;-) ).  
> 
> Cool, looking forward to test a patch series :)

Test? You mean "write"? :)

Cheers,
Miquèl
