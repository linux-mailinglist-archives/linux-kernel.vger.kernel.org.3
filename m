Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9764AA361
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352216AbiBDWnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:43:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbiBDWnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:43:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D1EB83951;
        Fri,  4 Feb 2022 22:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D93C004E1;
        Fri,  4 Feb 2022 22:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644014630;
        bh=2AY54UzKNCP2cnqsZ6l6V3IJp/sTB2kRkcVHmP4eexQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uhl26MUVyoWD6A7JAx5xK/vbtjc6F8VjlqsiymJrlmHXUmB5HEo67i1rECxDbMu9N
         F7EgyZ/+OTo9qaxOSbkPgnriS2ro1zg/TomAeTIe+jcXGssSWjJfRfaBXte0J82GyV
         gP0/hLG3uyTWKYimAUbikPp5NDvf4e7Y8S4kROSSuSe0n1dL8kuvl/RULFQAcXJ7oe
         dyNOE1nDdl3dNif9p+MHXPIVZEea3OPNd+e2L/7C9viKkVOIzZzD3F5YygW2T6NjbG
         udb/e7OsY8gca+cZYTYpIfpLzvY7HN9ly3hs/eEjVa+MSC9qP7kWxdLLD20HV2Cemu
         Mb/xLoIWJboXw==
Date:   Fri, 4 Feb 2022 14:43:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
Message-ID: <Yf2sJaxm3Nd5BUnr@sol.localdomain>
References: <20220201161342.154666-1-Jason@zx2c4.com>
 <YfznyWaVCz3Yl1ma@sol.localdomain>
 <CAHmME9ppY5QY7QCXK1HapEUY9nOn3VSJgvddypmMj_CVfycPeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ppY5QY7QCXK1HapEUY9nOn3VSJgvddypmMj_CVfycPeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:24:07PM +0100, Jason A. Donenfeld wrote:
> > In the above comment, 'key' should be 'seed'.
> > Likewise above.
> 
> Caught this too right after sending. Fixed now for v2.
> 

This wasn't actually fixed in v2.

- Eric
