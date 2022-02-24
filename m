Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833B44C249B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 08:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiBXHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 02:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBXHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 02:49:47 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428B517CC49
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 23:49:18 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A8B072000AF;
        Thu, 24 Feb 2022 07:49:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id F3C7280943; Thu, 24 Feb 2022 08:48:34 +0100 (CET)
Date:   Thu, 24 Feb 2022 08:48:34 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: only wake up writers after zap if threshold was
 passed
Message-ID: <Yhc4Ug8hQUBiqa6l@owl.dominikbrodowski.net>
References: <20220222130503.45043-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222130503.45043-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Feb 22, 2022 at 02:05:03PM +0100 schrieb Jason A. Donenfeld:
> The only time that we need to wake up /dev/random writers on
> RNDCLEARPOOL/RNDZAPPOOL is when we're changing from a value that is
> greater than or equal to POOL_MIN_BITS to zero, because if we're
> changing from below POOL_MIN_BITS to zero, the writers are already
> unblocked.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
