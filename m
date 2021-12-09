Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD5346E99E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhLIOLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:11:00 -0500
Received: from first.geanix.com ([116.203.34.67]:37696 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhLIOK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:10:57 -0500
Received: from skn-laptop.hinnerup (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 83129E1BC8;
        Thu,  9 Dec 2021 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1639058842; bh=O3N669Y1t5MeBIeL4+y0nF9iRMMYvpmo/umTBGgqoc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Y1IEXrnF4uESXKSCH5miK1ja38hW/CwHvoNEh/tTzppELjS5iGuSsgieFNu51wwgu
         KW/IvMQ2wodHLdrOt4wKKxlk6VFT4zVCFzTC6Mml7Ss9ITrnFm6d2edEZIA6Y0Zqog
         mg0v+R1KfA7HwHnML57JwRjVJk6g4VQdxwc9vCo4C1pNa+KJot+ngCJwtpfnljO4zj
         X/HOXSm3o81eN6wJvbrVmJ2Yjch5xCu8ZOKcqsPwMTkLZd4isQgOwpoCP/7k5eXBPy
         1bp/EXXwnZPvC+74apuTM5dvOhoEB+MrhyVhPPyMkRuLwKixtIxQYHrtUExO5RwnYX
         pwc7rdetPuM3A==
Date:   Thu, 9 Dec 2021 15:07:21 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while in
 suspend
Message-ID: <20211209140721.6ki7gznvxwyn3cze@skn-laptop.hinnerup>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211203143958.40645506@xps13>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 02:39:58PM +0100, Miquel Raynal wrote:
> Hello,
> 
> > > Fine by me, lets drop this series.
> 
> FYI I've dropped the entire series from mtd/next. I'm waiting for the
> fix discussed below (without abusing the chip mutex ;-) ).

Cool, looking forward to test a patch series :)

/Sean
