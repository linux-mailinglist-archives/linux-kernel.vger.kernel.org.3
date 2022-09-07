Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27685B052E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIGNdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIGNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:33:09 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1373B7CA9E;
        Wed,  7 Sep 2022 06:33:08 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5D08C2013FE;
        Wed,  7 Sep 2022 13:33:06 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
        id 98AF0A00BF; Wed,  7 Sep 2022 15:04:53 +0200 (CEST)
Date:   Wed, 7 Sep 2022 15:04:53 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: use hwgenerator randomness more frequently at
 early boot
Message-ID: <YxiW9doIXhbZBd+V@shine.dominikbrodowski.net>
References: <20220904101753.3050-1-linux@dominikbrodowski.net>
 <YxiWajR2FEW6YRud@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxiWajR2FEW6YRud@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Am Wed, Sep 07, 2022 at 03:02:34PM +0200 schrieb Jason A. Donenfeld:
> Hi Dominik,
> 
> On Sun, Sep 04, 2022 at 12:17:53PM +0200, Dominik Brodowski wrote:
> > Mix in randomness from hw-rng sources more frequently during early
> > boot, approximately once for every rng reseed.
> 
> Nice idea.
> 
> > Jason, if you prefer that this patch can be applied first (as it
> > makes sense also independently of the other patch), this ordering
> > should be trivial to change.
> 
> I'll apply this patch first, yea, since it's independent.
> 
> > -static bool crng_has_old_seed(void)
> > +static unsigned int crng_interval(void)
> 
> crng_reseed_interval() instead?

Sounds good. Thanks!

	Dominik
