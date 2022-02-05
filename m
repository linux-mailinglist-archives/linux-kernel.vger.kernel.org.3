Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7BF4AA7A2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354027AbiBEIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:23:46 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49412 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiBEIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:23:37 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 6A80620139F;
        Sat,  5 Feb 2022 08:23:35 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id A4FC0811AC; Sat,  5 Feb 2022 08:21:09 +0100 (CET)
Date:   Sat, 5 Feb 2022 08:21:09 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH v2 4/4] random: make credit_entropy_bits() always safe
Message-ID: <Yf4lZU7mAArZ6xCi@owl.dominikbrodowski.net>
References: <20220204135325.8327-1-Jason@zx2c4.com>
 <20220204135325.8327-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204135325.8327-5-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Feb 04, 2022 at 02:53:25PM +0100 schrieb Jason A. Donenfeld:
> This is called from various hwgenerator drivers, so rather than having
> one "safe" version for userspace and one "unsafe" version for the
> kernel, just make everything safe; the checks are cheap and sensible to
> have anyway.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
