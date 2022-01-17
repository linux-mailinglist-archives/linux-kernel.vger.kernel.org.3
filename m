Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418FC490FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiAQRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:35:06 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47102 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239452AbiAQRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:35:01 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E37C02006CA;
        Mon, 17 Jan 2022 17:34:58 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 31FBA80756; Mon, 17 Jan 2022 18:32:15 +0100 (CET)
Date:   Mon, 17 Jan 2022 18:32:15 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] random: access input_pool_data directly rather than
 through pointer
Message-ID: <YeWoHwNA5j6cvVBl@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220116163547.154991-1-Jason@zx2c4.com>
 <20220116163547.154991-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116163547.154991-3-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jan 16, 2022 at 05:35:46PM +0100 schrieb Jason A. Donenfeld:
> This gets rid of another abstraction we no longer need. It would be nice
> if we could instead make pool an array rather than a pointer, but the
> latent entropy plugin won't be able to do its magic in that case. So
> instead we put all accesses to the input pool's actual data through the
> input_pool_data array directly.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
