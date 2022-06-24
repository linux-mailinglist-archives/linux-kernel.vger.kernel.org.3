Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF629559AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiFXOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiFXOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7194DF5A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:01:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EC7AB826F3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69827C34114;
        Fri, 24 Jun 2022 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656079302;
        bh=L3UxcFSRFzRm4IxO5AJK8gW85IcbNFNYEnBScld15Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU1+xM/WCYpB/O5l08t0GDpZG/Tj5Wd+wEOsmsD49RyPuVuxOiwHZlgXdLFekivFL
         2/NPEgzVXEkSDRufrySe6+pf2lMyrnClXgt/HK0QZ8ciNaE+x8hIrvun0/GDi2d9fD
         u9yOSFrDE1/8B6uHrvlAjIIP4/fxS3svYj+qiENdV7fLJjBj2jmJL0VZeYD+GtQ4nw
         vl3znPhuXBI27YohAKHRcgU+IZKOw59BJGh8AeHW1J25GBIZhObJs1YL/dSKz2c2vF
         Z0fNPCHoszz+g+eaA9T7CvcUzUHMVuIFw29a6AXEqkV0HXlI+yXciKm4z3lpJhqdlr
         JJOzYpyRm87cA==
Date:   Fri, 24 Jun 2022 16:01:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] xtensa: context tracking updates
Message-ID: <20220624140139.GA2050137@lothringen>
References: <20220619231837.1150499-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619231837.1150499-1-jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 04:18:35PM -0700, Max Filippov wrote:
> Hi Frederic,
> 
> your recent conversion of CONTEXT_TRACKING to CONTEXT_TRACKING_USER
> missed the xtensa architexture. These two patches hopefully fix it.
> Please take them to the tree that holds the rest of the conversion.
> (Even better if they could be folded into the corresponding conversion
>  patches).
> 
> Max Filippov (2):
>   xtensa: rename context_tracking_user_{enter,exit}
>   xtensa: rename CONTEXT_TRACKING to CONTEXT_TRACKING_USER
> 
>  arch/xtensa/Kconfig        | 2 +-
>  arch/xtensa/kernel/entry.S | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> -- 
> Thanks.
> -- Max

Thanks a lot for these fixes. I'm likely going to reissue this
patchset so I'm going to fold your changes inside if you don't mind
(with your Signed-off-by).
