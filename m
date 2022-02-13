Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A7A4B3D2D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiBMTr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 14:47:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBMTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 14:47:27 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29CC48;
        Sun, 13 Feb 2022 11:47:20 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id AF2A520140E;
        Sun, 13 Feb 2022 19:47:18 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 88D6A80727; Sun, 13 Feb 2022 20:42:00 +0100 (CET)
Date:   Sun, 13 Feb 2022 20:42:00 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Kalle Valo <kvalo@kernel.org>, ath9k-devel@qca.qualcomm.com,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: pull add_hwgenerator_randomness() declaration
 into random.h
Message-ID: <YglfCDoerzbaviDP@owl.dominikbrodowski.net>
References: <20220213152522.816777-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213152522.816777-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Feb 13, 2022 at 04:25:22PM +0100 schrieb Jason A. Donenfeld:
> add_hwgenerator_randomness() is a function implemented and documented
> inside of random.c. It is the way that hardware RNGs push data into it.
> Therefore, it should be declared in random.h. Otherwise sparse complains
> with:
> 
> random.c:1137:6: warning: symbol 'add_hwgenerator_randomness' was not declared. Should it be static?
> 
> The alternative would be to include hw_random.h into random.c, but that
> wouldn't really be good for anything except slowing down compile time.

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
