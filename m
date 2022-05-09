Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D106651F474
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiEIGUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiEIGLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:11:03 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813AB13C099
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:07:09 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3EE71201342;
        Mon,  9 May 2022 06:07:07 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D6B4F80822; Mon,  9 May 2022 08:06:03 +0200 (CEST)
Date:   Mon, 9 May 2022 08:06:03 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] random: use symbolic constants for crng_init states
Message-ID: <YnivSwI+IczXnJ4q@owl.dominikbrodowski.net>
References: <Ynf8qMmN+AAofKMy@zx2c4.com>
 <20220508173610.151998-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508173610.151998-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, May 08, 2022 at 07:36:10PM +0200 schrieb Jason A. Donenfeld:
> crng_init represents a state machine, with three states, and various
> rules for transitions. For the longest time, we've been managing these
> with "0", "1", and "2", and expecting people to figure it out. To make
> the code more obvious, replace these with proper enum values
> representing the transition, and then redocument what each of these
> states mean.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
