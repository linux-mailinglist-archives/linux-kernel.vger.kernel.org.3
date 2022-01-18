Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2E492AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbiARQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347541AbiARQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:16:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941BC06173F;
        Tue, 18 Jan 2022 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xjulHOS5CUwNIm036P6j8UbjrwgqOIyQQzkCAKbIpbY=; b=UOfvy6QYbtpEnRIvhnRAmZV8tM
        uUPwsa0FpluV8AQMrNgGhnOpfr1ceFlKhbLO6j6TXzZPl1RSSEUFJQUHQUbIBDcOmQ6XPgRk5Dhon
        gdE9+fYI0sRyMIrNeEqt/HZ9P1B0EMqwcfuBFSaT0xbOOttoczaMAWpF63kQVtILnbYspnywhTLQk
        c67JRHO9HeQp041bd3xWpAbmscXASfrZVG4yG3AujijkVppqlzCIsWMR3GhYW+4LPLanMQ0RmW8jI
        Hm7risGLwvd09syPIsD7cwoYDFnBoX1hIWXNNyuzpi7s0099ZVn79PsBEQC/YJkGJyCPrq3yAB0Lb
        DytI5P4A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9rAC-002D80-0z; Tue, 18 Jan 2022 16:16:52 +0000
Date:   Tue, 18 Jan 2022 08:16:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Yu Chen <chen.yu@easystack.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org
Subject: Re: Modules updates for v5.17-rc1
Message-ID: <Yebn8wWvCa4T6ppC@bombadil.infradead.org>
References: <YeITMG7bKozB2xVQ@bombadil.infradead.org>
 <CAHk-=wjCajUWAZBNrQv3zrrjZBH7e7x2UrQ2n18+yk3TpGD9ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCajUWAZBNrQv3zrrjZBH7e7x2UrQ2n18+yk3TpGD9ag@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 07:38:25AM +0200, Linus Torvalds wrote:
> On Sat, Jan 15, 2022 at 2:20 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Although this change was only merged on January 11th, the patches have
> > been being reviewed since early december. There was at least one fix
> > already found for it and merged.
> 
> Grr..
> 
> And that's exactly why it matters not about "being reviewed", but when
> they were in linux-next etc.
> 
> I've pulled this, but consider this a complaint. Things should not be
> "reviewed" before the merge window. They should be ready and merged
> and have actually seen some testing.
> 
> Review is good. But nothing beats actually being out there and
> actually seeing real-life testing (of course, linux-next probably
> mostly gets build-testing, but what testing it gets is still better
> than not being there).

Understood, that gives me a better ballpark idea of when to defer
things for a next release. Thanks for the feedback.

  Luis
