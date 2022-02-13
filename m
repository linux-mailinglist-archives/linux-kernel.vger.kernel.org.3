Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8A4B39E2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiBMG5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:57:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiBMG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:07 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA55DE58
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:02 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id DC82F2013FF;
        Sun, 13 Feb 2022 06:56:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8CB19809A1; Sun, 13 Feb 2022 07:55:05 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:55:05 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] random: re-group and re-document functions
Message-ID: <YgirSXcAxKyO9BhD@owl.dominikbrodowski.net>
References: <20220212122318.623435-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, Feb 12, 2022 at 01:23:08PM +0100 schrieb Jason A. Donenfeld:
> We previously had massive documentation comments and functions strewn
> all about. This attempts to restore sanity by dividing the code into a
> few sections:
> 
> - Initialization and readiness waiting.
> - Fast key erasure RNG.
> - Entropy accumulation and extraction.
> - Entropy collection.
> - Userspace read/write.
> - Sysctl.
> 
> The result of this ordering and this grouping is only 2 forward
> declarations, indicating that this is probably a sensible grouping.
> Also, some documentation that was just hopelessly out of date been
> removed. We'll later look into re-adding parts of this to the Linux man
> pages project.
> 
> No functional changes.

Hi Jason,

thanks for your massive patchset. While some of it was a bit tedious and
repetetive to review, feel free to add my

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

to patchs 1-3, 6 and 8-10. For patches 4, 5 and 7, I have some comments;
once addressed, feel free to add my reviewed-by tag to those as well.

Thanks,
	Dominik
