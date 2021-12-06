Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE15E46A065
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388220AbhLFQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:03:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54446 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388414AbhLFPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:50:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EACFB81118;
        Mon,  6 Dec 2021 15:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E133C34900;
        Mon,  6 Dec 2021 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638805601;
        bh=RFO+bVxbHV3mq5EEAmgUkozr39/zBwPlaBDL918A0+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zdiLsBdlsg77QlkHCFER7EA2iXPfwZooU2hGytX4tR56M8wR4g7GN0VsAUDs+BuWf
         OBSIQpr0o73sUVcGKNokCVCp0QxN3HVM4cgOLZnlQsG9UBcaBYxm2Y84axDLinG17h
         ut/aDDeqgNvqJgTKuFzAhliFtN49tGlEwZ6FpQHE=
Date:   Mon, 6 Dec 2021 16:01:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wayne Campbell <wcampbell1995@gmail.com>
Subject: Re: [RFC PATCH 19/19] drivers: android: Binder IPC in Rust
Message-ID: <Ya4lu3k9HxLRe1Tv@kroah.com>
References: <20211206140313.5653-1-ojeda@kernel.org>
 <20211206140313.5653-20-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206140313.5653-20-ojeda@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:03:13PM +0100, Miguel Ojeda wrote:
> From: Wedson Almeida Filho <wedsonaf@google.com>
> 
> A port to Rust of the Android Binder IPC mechanism.
> 
> This module is a work in progress and will be sent for review later
> on, as well as separately from the Rust support.
> 
> However, it is included to show how an actual working module
> written in Rust may look like.

Have you all tested this against the userspace binder tests?  And is it
up to date with the features of the in-kernel binder driver?

thanks,

greg k-h
