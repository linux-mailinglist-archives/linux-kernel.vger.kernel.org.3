Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA22748FD41
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiAPNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:45:24 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53520 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiAPNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:45:12 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 6D4532010EB;
        Sun, 16 Jan 2022 13:45:08 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 626C680407; Sun, 16 Jan 2022 14:25:04 +0100 (CET)
Date:   Sun, 16 Jan 2022 14:25:04 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 6/7] random: remove unused OUTPUT_POOL constants
Message-ID: <YeQcsEB+aO/DxGts@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220113154413.29513-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113154413.29513-7-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Jan 13, 2022 at 04:44:12PM +0100 schrieb Jason A. Donenfeld:
> We no longer have an output pool. Rather, we have just a wakeup bits
> threshold for /dev/random reads, presumably so that processes don't
> hang. This value, random_write_wakeup_bits, is configurable anyway. So
> all the no longer usefully named OUTPUT_POOL constants were doing was
> setting a reasonable default for random_write_wakeup_bits. This commit
> gets rid of the constants and just puts it all in the default value of
> random_write_wakeup_bits.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
