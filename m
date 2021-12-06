Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2290F46A0A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354543AbhLFQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:08:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38706 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351129AbhLFQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:06:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 094C6B8106E;
        Mon,  6 Dec 2021 16:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA70C341C1;
        Mon,  6 Dec 2021 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638806572;
        bh=aEA+zbr/2e313qxCZtQKliOVh8taWZktVYjisW7n1q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x+5mcrelHG21G3wg59PiRl6Pb88/oJBV5tjSfEMSuAJalPJCVrKAvdCCqdo2oI1Ex
         /KZ3nPGhhvEWAxgSGriUQln7i+Ue5cYxybNvxFGyo4Eiq3/1rliLDLoqSx6YD/WRZC
         0VrX+xkj/rmQWzUL9qkv01hUGoSIGLkiPbaLeLXo=
Date:   Mon, 6 Dec 2021 17:02:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH 11/19] vsprintf: add new `%pA` format specifier
Message-ID: <Ya40Bcv+eFkqc9jv@kroah.com>
References: <20211206140313.5653-1-ojeda@kernel.org>
 <20211206140313.5653-12-ojeda@kernel.org>
 <Ya4mAqoOa8zIeZGZ@kroah.com>
 <CANiq72kCmLgrv++mFygR6dt0xOhfv04o9j6jYLQ1N+zLNvqohQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kCmLgrv++mFygR6dt0xOhfv04o9j6jYLQ1N+zLNvqohQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:56:32PM +0100, Miguel Ojeda wrote:
> On Mon, Dec 6, 2021 at 4:46 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > That should be in a .h file somewhere.  Remember, don't put #ifdef in .c
> > files please.
> 
> Will do, thanks for reviewing!
> 
> > Same here, this should not be needed if you put it in a .h file
> > correctly.
> 
> This one is mimicking the `CONFIG_BLOCK` one (`case 'g'` a bit above)
> -- but we can change it, of course.

That should be changed as well :)
