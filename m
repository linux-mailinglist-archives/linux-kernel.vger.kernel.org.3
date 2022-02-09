Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95EB4AFC79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiBIS67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbiBIS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:57:26 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6DC050CEE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:57:23 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 87CAE20141A;
        Wed,  9 Feb 2022 18:57:21 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id EEA1480160; Wed,  9 Feb 2022 19:56:42 +0100 (CET)
Date:   Wed, 9 Feb 2022 19:56:42 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] random: make more consistent use of integer types
Message-ID: <YgQOao5U0askpaZk@owl.dominikbrodowski.net>
References: <20220209135211.557032-1-Jason@zx2c4.com>
 <20220209180507.646941-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209180507.646941-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Feb 09, 2022 at 07:05:07PM +0100 schrieb Jason A. Donenfeld:
> We've been using a flurry of int, unsigned int, size_t, and ssize_t.
> Let's unify all of this into size_t where it makes sense, as it does in
> most places, and leave ssize_t for return values with possible errors.
> 
> In addition, keeping with the convention of other functions in this
> file, functions that are dealing with raw bytes now take void *
> consistently instead of a mix of that and u8 *, because much of the time
> we're actually passing some other structure that is then interpreted as
> bytes by the function.
> 
> We also take the opportunity to fix the outdated and incorrect comment
> in get_random_bytes_arch().
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
