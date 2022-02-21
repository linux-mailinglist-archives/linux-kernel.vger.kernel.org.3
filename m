Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE04BEB1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiBUTYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:24:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBUTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:24:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C665BA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:23:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D656B816F9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A5AC340E9;
        Mon, 21 Feb 2022 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645471430;
        bh=CgCHOljWJ16dd1nUnkg19W0XkUTFm71FBzyOIRwZ5yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFJmtzSzAZ2H54IoPLec6j06RtnvHUVprz6cOreqUUoTl/C+Nf25b6Q8maX+O2oGv
         zP/TTT+nKJ19oZdIq9L1m7zGqHTvNEiKFvu1WcMaUa5g+OvYQ56OwoVBp7Qs2ELm2b
         uv9Xq5/QqjAFQnx/aGigzosJMA8qge3vhqdQn5C0BsET00e7hatNu5x3OgN483mTPX
         uB9H7hiQ/7cQDCuty7vWdemx4Wt/KLQEqjGbTFD9Oq9Yizf5Tn4wPL63ajmPVAJeap
         J2ANV0P3VGB4yCfxPwPARFNgXSj7kLy0pmOxVgJgZMQqUGk7PaVUG/yzlz9IhVmrfw
         greTuPjtax9TA==
Date:   Mon, 21 Feb 2022 11:23:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v3] random: group entropy collection functions
Message-ID: <YhPmxY1Zd1qcgmJx@sol.localdomain>
References: <CAHmME9qs5gBFrGXGktB9kOx8oSdfow+-Tc=ie7b1J8aT5SfQ7Q@mail.gmail.com>
 <20220221151819.2287853-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221151819.2287853-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:18:19PM +0100, Jason A. Donenfeld wrote:
> This pulls all of the entropy collection-focused functions into the
> forth labeled section.

forth => fourth

> 
> No functional changes.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v3 adjusts the comment to follow the order of functions, per Eric's
> request.
> 
>  drivers/char/random.c | 370 +++++++++++++++++++++++-------------------
>  1 file changed, 206 insertions(+), 164 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
