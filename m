Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C781A490FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiAQRfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:35:04 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47086 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239393AbiAQRfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:35:00 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id DC1E1200278;
        Mon, 17 Jan 2022 17:34:58 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 3FE91807EA; Mon, 17 Jan 2022 18:34:30 +0100 (CET)
Date:   Mon, 17 Jan 2022 18:34:30 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] random: selectively clang-format where it makes sense
Message-ID: <YeWopoOFYaHfBgE2@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220116163547.154991-1-Jason@zx2c4.com>
 <20220116163547.154991-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116163547.154991-4-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jan 16, 2022 at 05:35:47PM +0100 schrieb Jason A. Donenfeld:
> This is an old driver that has seen a lot of different eras of kernel
> coding style. In an effort to make it easier to code for, unify the
> coding style around the current norm, by accepting some of -- but
> certainly not all of -- the suggestions from clang-format. This should
> remove ambiguity in coding style, especially with regards to spacing,
> when code is being changed or amended. Consequently it also makes code
> review easier on the eyes, following one uniform style rather than
> several.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
