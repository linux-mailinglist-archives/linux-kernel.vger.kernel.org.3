Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80104B1E22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiBKGHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:07:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiBKGHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:07:32 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B732F10C1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:07:31 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3001C2013A8;
        Fri, 11 Feb 2022 06:07:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 7D85F8061A; Fri, 11 Feb 2022 06:57:03 +0100 (CET)
Date:   Fri, 11 Feb 2022 06:57:03 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2] random: deobfuscate irq u32/u64 contributions
Message-ID: <YgX6r9hsRIbv06hq@owl.dominikbrodowski.net>
References: <CAHmME9rieCnqNp=n2jOp2z+pS8qo59B0ULWBhRjCHM8awRWMPA@mail.gmail.com>
 <20220210171322.165122-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210171322.165122-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Feb 10, 2022 at 06:13:22PM +0100 schrieb Jason A. Donenfeld:
> In the irq handler, we fill out 16 bytes differently on 32-bit and
> 64-bit platforms. Whether or not you like that, it is a matter of fact.
> But it might not be a fact you well realized until now, because the code
> that loaded the irq info into 4 32-bit words was quite confusing.
> Instead, this commit makes everything explicit by having separate
> (compile-time) branches for 32-bit and 64-bit machines. In the process,
> we now easily see that we were truncating the contribution of
> random_get_entropy() in mix_interrupt_randomness() which we rectify by
> using the correct integer type.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
