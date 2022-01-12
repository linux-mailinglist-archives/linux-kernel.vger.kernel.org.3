Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1348BC62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbiALBXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:23:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50774 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347685AbiALBX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:23:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8894B81D53;
        Wed, 12 Jan 2022 01:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71618C36AED;
        Wed, 12 Jan 2022 01:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641950606;
        bh=QZ8C186oz6QLZxWkrjH4fMePe+uB5CJY45XtohdAkdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=so+hkjIPfTfmZmAUfLyD9LiVALE4yZ6nr07OtC2bTo60qVxjMczc3r89sj+Yn/BEJ
         DE9HIAXQSLkg6isUb8JDc7zwM05ZQ630JG5PFjB5xtYwKs1Ff/4/1YZFM23ioKxLVy
         EKi8iJcGnXzhJeY7WJ5m46jblaZWf8evfiTSOWVXSybDrhOsmUB8q1REp4hlfvfLVP
         u5pIZ6GzWkD/ZEVswY6nCBBuSjGIa5P+5OOztHWiLYz7wj2hdabCIFJAw1NIsP3S+8
         MuUplVFjbzzbW6aM6G5lUlEkTQBWW8TYdY7w0/jN34qRi5PzNVNHisEyaTtSpoydRO
         4f+G21yOdJaVQ==
Date:   Tue, 11 Jan 2022 19:29:50 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Enable -Wcast-function-type for 5.17-rc1
Message-ID: <20220112012950.GA21526@embeddedor>
References: <20220111193855.GA13612@embeddedor>
 <CAHk-=wgTEj354w942PW88eP6BLu8=XREzUaeo1zx816OUFLe2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTEj354w942PW88eP6BLu8=XREzUaeo1zx816OUFLe2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 05:13:24PM -0800, Linus Torvalds wrote:
> On Tue, Jan 11, 2022 at 11:32 AM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > Please, pull the following patch that globally enables
> > -Wcast-function-type.
> 
> This seems to have been in linux-next, so hopefully that means that
> all cases that used to warn are actually fixed and there are no ugly
> surprises waiting..

Yep; this has been in linux-next for a whole development cycle. The
cases that showed up during that time were alredy fixed.

In case any other issue shows up I'll address it ASAP.

Thanks
--
Gustavo
