Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DBC4A3728
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355365AbiA3PHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 10:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347345AbiA3PHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 10:07:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDCFC061714;
        Sun, 30 Jan 2022 07:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1DF761242;
        Sun, 30 Jan 2022 15:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B717C340E4;
        Sun, 30 Jan 2022 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643555249;
        bh=iuo37CD5qHk1n9pawYxodgVuEwF9nXOq27mneEJQ6GA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NBBd4oyMjUBx/BsW/dY2HNfaI7PfZLyOxs40U8ln+YR5vFJywUqs07Alrd8257sGa
         Pp2wq2j+t1k9TVvS50JNgYAfPGdO3RiQFvJczuSw47X4EIyi1TXhmcimDzZuzMhS0q
         7PP70LSV1Gq5PDJTAMXC9bz9U9k3CWjAFOcRl5FsgBtgWaF1BfsaDk1Uff4sLoPrRI
         7KEU5lBw8+buYzclNfaBV/G+c/nREKisO58jM9tIcNIkSciJLHQG1NYctPlPwUU9pu
         QM/aGOYEBXCfs6PBzktX05ooRDERdvgSNXpdPsQH10p9ibIWNKckV9dW8qQsQKkq/P
         Y9ZBWzVRa3krA==
Date:   Sun, 30 Jan 2022 15:13:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <festevam@gmail.com>, <linux-imx@nxp.com>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mailmap: Update email address for Cai Huoqing
Message-ID: <20220130151353.1ddcd70e@jic23-huawei>
In-Reply-To: <20211216164051.10225276@jic23-huawei>
References: <20211206025034.2729-1-caihuoqing@baidu.com>
        <20211216164051.10225276@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 16:41:00 +0000
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On Mon, 6 Dec 2021 10:50:34 +0800
> Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > The caihuoqing@baidu.com would be deprecated and use cai.huoqing@linux.dev
> > as the main email address.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>  
> 
> Which maintainer wants to pick this one up?  I can take it via iio if that
> is fine with others.

Long enough for someone else to shout.

Applied to the togreg branch of iio.git and pushed out as testing so
0-day can poke some other stuff I've just applied.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  .mailmap | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/.mailmap b/.mailmap
> > index a83599921b1a..f82b0378df7c 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -68,6 +68,7 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
> >  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
> >  Brian Avery <b.avery@hp.com>
> >  Brian King <brking@us.ibm.com>
> > +Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
> >  Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
> >  Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
> >  Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>  
> 

