Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1844BD4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbiBUE10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:27:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbiBUE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:27:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454933E9E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:27:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0521DB80CF9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C60C340E9;
        Mon, 21 Feb 2022 04:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645417620;
        bh=oMBPgNv4RE9kRVq7UIGG4AFkl5HCPVkjZbFd1Wztdlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRF1mNcI6wHJyObCzkKinFr+s3vK/gNKEQ6QKEO1q1VFLNd0B18UxfWbtT+lvoW8u
         5lXMivQT7ykR/vcz9fSnbAlW2icgq9Bn7TlAjjPWwvRgZBtvkJLHRNBrTeC2Xyvo/U
         4US0oXNQzD+Cw09GjXu5ORFcDQGwWo5GhbhR4/xaaMdgGvxjWS3UKFZXUNOM2WIFiu
         0bVNrmBjtHYO6GoaV2LrFBchs6VTfNyfZSbnNAhqPeyPUckuAaDiWoh2l3RWdegsap
         9uIoP3RmalEIN5nwvASv6sYPDQXd4WhLkhfIV/rOaUu2v2yIpFbzBdguALBYPib6iO
         DEML8ocpZ0NaA==
Date:   Sun, 20 Feb 2022 20:26:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/3] random: remove ifdef'd out interrupt bench
Message-ID: <YhMUkwfdI/GbxCT2@sol.localdomain>
References: <20220210155012.136485-1-Jason@zx2c4.com>
 <20220210155012.136485-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210155012.136485-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 04:50:10PM +0100, Jason A. Donenfeld wrote:
> With tools like kbench9000 giving more finegrained responses, and this
> basically never having been used ever since it was initially added,
> let's just get rid of this. There *is* still work to be done on the
> interrupt handler, but this really isn't the way it's being developed.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 40 ----------------------------------------
>  1 file changed, 40 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
