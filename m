Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0914BEB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiBUTVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:21:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiBUTVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:21:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951065BA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:20:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49320B81247
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE0EC340E9;
        Mon, 21 Feb 2022 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645471248;
        bh=652DeglPgL0gFvYrAElPGrDsnj0C+6NqBvfrohYQhAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6tdotazLD2WekteiAWEt/d4t/YgTrALWxLW+BYubj0OYHQoCsmL4metJzTPztbXj
         llXB86MiL9ttm3o53Yr2veo/DhdnbUNb3lHm9y8wPOMux2lzi6J0rCxssobLrdCfL5
         WCW/JyAOeXnnIlLCbs/WFqAA708Aa1fM4hiHY1pEA00K4xpMeMAgYXg5oFcsKOgaKl
         Rdfo+hLYMjYOEA+bNjUNOGiddLPynxw1Umrsyv0VCsjdZvg6fHi9pSSnPJdPPDV8Jh
         S+9KVxeSVVvDPGI5xm9l1pxhAFX7+UjkCmcxM/X7nthLzlroXt6n47ZPhGnElmBIW9
         Vp/pQE1q5h/2Q==
Date:   Mon, 21 Feb 2022 11:20:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] random: group initialization wait functions
Message-ID: <YhPmDyCqIiekAmCO@sol.localdomain>
References: <CAHmME9r5+9JLN8KjDwmuc1+p1O7THPmzW3sz0jMKKf9k6gCDtQ@mail.gmail.com>
 <20220221151405.2287328-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221151405.2287328-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:14:05PM +0100, Jason A. Donenfeld wrote:
> This pulls all of the readiness waiting-focused functions into the first
> labeled section.
> 
> No functional changes.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v3 removes the duplicate declarations for _get_random_bytes() and fasync.
> 
>  drivers/char/random.c | 333 ++++++++++++++++++++++--------------------
>  1 file changed, 172 insertions(+), 161 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
