Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DC05174ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386380AbiEBQyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbiEBQyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:54:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9CB6245
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBC8DB818F3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB65C385AC;
        Mon,  2 May 2022 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651510263;
        bh=evXzquTG5OP5CT6Eo1Ps8xgMCDBksIf8xNaifuB2KeE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HvgQVIkF/x88AdMBrnoflX10ZnFDFVMuxa2WjR5Qs3vHKag3NmZ/bGlDLo987Jdwh
         mTdHw7KWN70HLJPsmSuuGF2Bhae0KK8NuMFTbK24Cc35WNjBYmKXZ2kp3YQCMWumHq
         w6JZYeXJtmKo+aQ/PD5VtciCqT8xc63KK3iX1KO/PH85ahUjaUmYkVVfUOXhpYFjU2
         THLSVAujxScFYulOYyqGpdt5zmtsw8HY2ZvihkZH3gj6U4DvxOG4r7OSwpNOpVI2ZW
         O61UqG+x4OUXXMsylvyTHJQQOAI2wM0WPccIkSfqz9Vi+vli6lNsw3NkXJi/Kh6hYf
         TWpQmmhudX+6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D5165C08DB; Mon,  2 May 2022 09:50:58 -0700 (PDT)
Date:   Mon, 2 May 2022 09:50:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -lkmm] tools/memory-model/README: Update klitmus7 compat
 table
Message-ID: <20220502165058.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <2b237126-88d1-17f2-ce94-2cb679f0b285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b237126-88d1-17f2-ce94-2cb679f0b285@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:05:09PM +0900, Akira Yokosawa wrote:
> EXPORT_SYMBOL of do_exec() was removed in v5.17.  Unfortunately,
> kernel modules from klitmus7 7.56 have do_exec() at the end of
> each kthread.
> 
> herdtools7 7.56.1 has addressed the issue.
> 
> Update the compatibility table accordingly.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: stable@vger.kernel.org # v5.17+
> ---
> Hi Paul,
> 
> herdtools7 release 7.56.1 is available at
> https://github.com/herd/herdtools7/releases/tag/7.56.1,
> and "opam update/upgrade" should catch it soon.

Good catch, thank you!

> I think this is worth for v5.18, albeit it is a minor update
> in documentation.

Good point, but let me give it some thought.

							Thanx, Paul

> Thoughts?
> 
>         Thanks, Akira
> --
>  tools/memory-model/README | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 9edd402704c4..dab38904206a 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -54,7 +54,8 @@ klitmus7 Compatibility Table
>  	     -- 4.14  7.48 --
>  	4.15 -- 4.19  7.49 --
>  	4.20 -- 5.5   7.54 --
> -	5.6  --       7.56 --
> +	5.6  -- 5.16  7.56 --
> +	5.17 --       7.56.1 --
>  	============  ==========
>  
>  
> -- 
> 2.25.1
> 
