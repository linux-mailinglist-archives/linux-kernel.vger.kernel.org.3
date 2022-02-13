Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F484B39E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiBMG5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:57:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiBMG5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:10 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863035DE66
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:05 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 228AD20140A;
        Sun, 13 Feb 2022 06:57:00 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id EE82F808C5; Sun, 13 Feb 2022 07:54:45 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:54:45 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 07/10] random: group entropy collection functions
Message-ID: <YgirNWqk6d4y/Z0k@owl.dominikbrodowski.net>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-8-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-8-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + * add_device_randomness() adds data to the input pool that
> + * is likely to differ between two devices (or possibly even per boot).
> + * This would be things like MAC addresses or serial numbers, or the
> + * read-out of the RTC. This does *not* credit any actual entropy to
> + * the pool, but it initializes the pool to different values for devices
> + * that might otherwise be identical and have very little entropy
> + * available to them (particularly common in the embedded world).
> + *
> + * add_input_randomness() uses the input layer interrupt timing, as well
> + * as the event type information from the hardware.
> + *
> + * add_disk_randomness() uses what amounts to the seek time of block
> + * layer request events, on a per-disk_devt basis, as input to the
> + * entropy pool. Note that high-speed solid state drives with very low
> + * seek times do not make for good sources of entropy, as their seek
> + * times are usually fairly consistent.
> + *
> + * The above three routines try to estimate how many bits of entropy

	*two* (add_device_randomness() does not credit any entropy).

Thanks,
	Dominik
