Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B24822CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 09:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhLaIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 03:32:43 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:59168 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhLaIcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 03:32:42 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 299BB201218;
        Fri, 31 Dec 2021 08:32:41 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DD3AA80F5B; Fri, 31 Dec 2021 09:27:01 +0100 (CET)
Date:   Fri, 31 Dec 2021 09:27:01 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: use IS_ENABLED(CONFIG_NUMA) instead of ifdefs
Message-ID: <Yc6+1YFsxLVHG/WW@owl.dominikbrodowski.net>
References: <CAHmME9ppDKOSMeMFjMr1XAt8_8kSSUpUWS1vL2yeZjb27=ePhw@mail.gmail.com>
 <20211230151410.618383-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230151410.618383-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am Thu, Dec 30, 2021 at 04:14:10PM +0100 schrieb Jason A. Donenfeld:
> Rather than an awkward combination of ifdefs and __maybe_unused, we can
> ensure more source gets parsed, regardless of the configuration, by
> using IS_ENABLED for the CONFIG_NUMA conditional code. This makes things
> cleaner and easier to follow.
> 
> I've confirmed that on !CONFIG_NUMA, we don't wind up with excess code
> by accident; the generated object file is the same.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
