Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE77B47EAD9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351147AbhLXDZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:25:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58450 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234131AbhLXDZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:25:14 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1n0bCh-0006Gi-58; Fri, 24 Dec 2021 14:25:12 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Dec 2021 14:25:10 +1100
Date:   Fri, 24 Dec 2021 14:25:10 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     sgoutham@marvell.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        sunil.kovvuri@gmail.com, Bharat Bhushan <bbhushan2@marvell.com>,
        Joseph Longever <jlongever@marvell.com>
Subject: Re: [PATCH v2] hwrng: cn10k: Add random number generator support
Message-ID: <YcU9lt5QZZip7lg2@gondor.apana.org.au>
References: <1639479068-22101-1-git-send-email-sgoutham@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639479068-22101-1-git-send-email-sgoutham@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 04:21:08PM +0530, sgoutham@marvell.com wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
> 
> CN10K series of silicons support true random number
> generators. This patch adds support for the same. Also
> supports entropy health status checking.
> 
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Joseph Longever <jlongever@marvell.com>
> ---
> v1 -> v2:
> 	Fixed warnings reported by kernel test robot.
> 	Also modified TRNG read logix to address an issue where TRNG_STATUS
> 	read from HW could be incorrect.
> ---
>  drivers/char/hw_random/Kconfig     |  11 +++
>  drivers/char/hw_random/Makefile    |   1 +
>  drivers/char/hw_random/cn10k-rng.c | 181 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/char/hw_random/cn10k-rng.c

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
