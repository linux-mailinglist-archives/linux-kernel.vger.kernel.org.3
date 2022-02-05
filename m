Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142FF4AA7A3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244778AbiBEIXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:23:50 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49414 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiBEIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:23:37 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 6CB1020141E;
        Sat,  5 Feb 2022 08:23:35 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 4E64B81211; Sat,  5 Feb 2022 08:22:50 +0100 (CET)
Date:   Sat, 5 Feb 2022 08:22:50 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A . Donenfeld " <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: remove use_input_pool parameter from
 crng_reseed()
Message-ID: <Yf4lyqaPOxGoG8/q@owl.dominikbrodowski.net>
References: <20220204221733.39411-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204221733.39411-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Feb 04, 2022 at 02:17:33PM -0800 schrieb Eric Biggers:
> From: Eric Biggers <ebiggers@google.com>
> 
> The primary_crng is always reseeded from the input_pool, while the NUMA
> crngs are always reseeded from the primary_crng.  Remove the redundant
> 'use_input_pool' parameter from crng_reseed() and just directly check
> whether the crng is the primary_crng.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
