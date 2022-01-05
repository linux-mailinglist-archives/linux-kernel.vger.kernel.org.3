Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37770485AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiAEVm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:42:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38596 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiAEVm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:42:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD85761958
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 21:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4E6C36AE9;
        Wed,  5 Jan 2022 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641418976;
        bh=oUtu4v/IfMektWGAONsrdZgmJ9d9XISGoa6QFTyM8lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOetG3wvYou9MJCtc79o31meSLVtur1IDN+vc/FFbMPWZs9d/HI9FXNlmmQdGNv76
         S1jFutgapbm12z2mnn+RukzJNuG+kOX+ake8f2DoiwiZVR7h86pZn/AGRhlaGFdmsO
         BfvaWqGjmEv/5L11gUUS9ssqJ4ZflInbNGoeyhvGm9qRnQdIZBAl3/l9hqHlZwWJnT
         Rj+L/k42CN4X4/jQ8K+BYhBxJm0iIHDYQCe0vg1DK0RObj+RM3/Dw51Lhq/4MA+L4D
         7Tc59oiQ/Zg7k1+ZswBfh23XGuFTIS0GyxaHogLTTrnZYEOfjMiaMjpjdZkBv+r0WK
         2E9A2KedgU32Q==
Date:   Wed, 5 Jan 2022 13:42:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        gregkh@linuxfoundation.org,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
Message-ID: <YdYQ3g9XB9+ZW9s2@gmail.com>
References: <20211223141113.1240679-1-Jason@zx2c4.com>
 <20211223141113.1240679-2-Jason@zx2c4.com>
 <YcY0BR8cfviTkUqj@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcY0BR8cfviTkUqj@quark>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Dec 24, 2021 at 02:56:44PM -0600, Eric Biggers wrote:
> Also, this patch was only sent to linux-kernel, not to linux-crypto, so I only
> found it because I happened to see it in the above git repository, then dig it
> up from lore.kernel.org.  How about Cc'ing all random.c patches to linux-crypto,
> and putting that in the MAINTAINERS file entry?

Any thoughts about this?  I see more patches appearing in random.git, but they
were only sent to linux-kernel.  I'd expect the MAINTAINERS entry to contain:

	L:      linux-crypto@vger.kernel.org

- Eric
