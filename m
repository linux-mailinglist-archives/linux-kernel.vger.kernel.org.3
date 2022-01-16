Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24A348FD3F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiAPNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:45:20 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53488 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiAPNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:45:09 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 59042200230;
        Sun, 16 Jan 2022 13:45:07 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id CE2F380326; Sun, 16 Jan 2022 14:24:45 +0100 (CET)
Date:   Sun, 16 Jan 2022 14:24:45 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/7] random: cleanup integer types
Message-ID: <YeQcnbDEfWJfSMwf@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220113154413.29513-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113154413.29513-3-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Jan 13, 2022 at 04:44:08PM +0100 schrieb Jason A. Donenfeld:
> Rather than using the userspace type, __uXX, switch to using uXX. And
> rather than using variously chosen `char *` or `unsigned char *`, use
> `u8 *` uniformly for things that aren't strings, in the case where we
> are doing byte-by-byte traversal.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

> -	unsigned short	reg_idx;
> -	unsigned char	count;
> +	u16		reg_idx;
> +	u8		count;

As you do not change other unsigned shorts to u16, and that change is
not explained in the changelog, please defer that to a separate patch.
Otherwise, feel free to add:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
