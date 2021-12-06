Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C820646A0A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385821AbhLFQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:08:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38730 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388867AbhLFQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:06:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87AC6B81085;
        Mon,  6 Dec 2021 16:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FBFC341C1;
        Mon,  6 Dec 2021 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638806575;
        bh=uVeYzty1HG19livy6ELAjstEtph8/Hc5u5Bi9nTH8kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAYDrWm9W8KJgUkQoumuvor614pQUlcQ8Dc4x8o90uekejGpdm9+i3ys4C7fw4wRu
         0dWc9S3PYl7JsdHvnnUbFjAKVHSBInmUt6JSB7tyXWAZ+RSRZrZgnu8tRJ8ouC9Nlk
         SUxchdNZAOWm6kWyy6A5nIKKk+gERMLVqEHZ7Mtw=
Date:   Mon, 6 Dec 2021 17:02:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wayne Campbell <wcampbell1995@gmail.com>
Subject: Re: [RFC PATCH 19/19] drivers: android: Binder IPC in Rust
Message-ID: <Ya40GOSIrWVC2ZSq@kroah.com>
References: <20211206140313.5653-1-ojeda@kernel.org>
 <20211206140313.5653-20-ojeda@kernel.org>
 <Ya4lu3k9HxLRe1Tv@kroah.com>
 <Ya4zco0QFG0K5kO+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya4zco0QFG0K5kO+@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:59:46PM +0000, Wedson Almeida Filho wrote:
> On Mon, Dec 06, 2021 at 04:01:15PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 06, 2021 at 03:03:13PM +0100, Miguel Ojeda wrote:
> > > From: Wedson Almeida Filho <wedsonaf@google.com>
> > > 
> > > A port to Rust of the Android Binder IPC mechanism.
> > > 
> > > This module is a work in progress and will be sent for review later
> > > on, as well as separately from the Rust support.
> > > 
> > > However, it is included to show how an actual working module
> > > written in Rust may look like.
> > 
> > Have you all tested this against the userspace binder tests?  And is it
> > up to date with the features of the in-kernel binder driver?
> 
> Very little has changed here since the last submission, namely: using
> credentials for security callbacks, and replacing `Arc` with `Ref` (i.e., using
> refcount_t to manage ref-counted allocations).
> 
> As the message tries to indicate, this is submitted as an example and WIP, it
> doesn't have feature parity with the C version yet.

You might want to say that in the changelog text so I don't keep asking
every time it gets posted :)

thanks,

greg k-h
