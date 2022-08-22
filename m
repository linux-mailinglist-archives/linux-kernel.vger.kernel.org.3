Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704259C454
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiHVQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiHVQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB25518E25;
        Mon, 22 Aug 2022 09:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 570726120C;
        Mon, 22 Aug 2022 16:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB504C433C1;
        Mon, 22 Aug 2022 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661186695;
        bh=hFhF+HtHsqWMVE4q3w289LQbuAM7D1wcvxRb+QUpfz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JZWYE0xu4YHJCN761L/B/S7shttEN9JIplBp8bjrBVbaTuxf5lqzOwY958FZcdd2E
         CS9PmsVuBmZFL66bOK9NYptOLyhNPXcUxjklnbfGLy9VXzQIrjgdhv6dblfWPXLrFh
         L5DnEOFsAkAYlKbmD22qD5pY+OtaSzqZMdmWtdQvKGtDYxTmblrraCiHo1AFsc4YaG
         4lG6frtyvLdVletNg57g4HeDjntAGCpUEfLY6668a6KAvSMaVE3xzf8ienyI4ufk84
         OwMnAF1t3H8im1vaO1ZEPq4JlPIAe7SaAVP0qh/LkFxWieDbJQ8mVtoJsR+j8a2WR6
         jWi3Fj9R+z7PQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4C7925C05A0; Mon, 22 Aug 2022 09:44:55 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:44:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shao-Tse Hung <ccs100203@gmail.com>
Cc:     corbet@lwn.net, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc/rcu: Update LWN articles at the beginning
Message-ID: <20220822164455.GH6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220820083244.28338-1-ccs100203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820083244.28338-1-ccs100203@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 04:32:44PM +0800, Shao-Tse Hung wrote:
> This patch adds LWN articles about RCU APIs which were released in 2019.
> Also, HTTP URLs are replaced by HTTPS.
> 
> Signed-off-by: Shao-Tse Hung <ccs100203@gmail.com>

Good catch, queued, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.rst | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 77ea260efd12..682529123b9d 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -6,13 +6,15 @@ What is RCU?  --  "Read, Copy, Update"
>  Please note that the "What is RCU?" LWN series is an excellent place
>  to start learning about RCU:
>  
> -| 1.	What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
> -| 2.	What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
> -| 3.	RCU part 3: the RCU API      http://lwn.net/Articles/264090/
> -| 4.	The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
> -| 	2010 Big API Table           http://lwn.net/Articles/419086/
> -| 5.	The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
> -|	2014 Big API Table           http://lwn.net/Articles/609973/
> +| 1.	What is RCU, Fundamentally?  https://lwn.net/Articles/262464/
> +| 2.	What is RCU? Part 2: Usage   https://lwn.net/Articles/263130/
> +| 3.	RCU part 3: the RCU API      https://lwn.net/Articles/264090/
> +| 4.	The RCU API, 2010 Edition    https://lwn.net/Articles/418853/
> +| 	2010 Big API Table           https://lwn.net/Articles/419086/
> +| 5.	The RCU API, 2014 Edition    https://lwn.net/Articles/609904/
> +|	2014 Big API Table           https://lwn.net/Articles/609973/
> +| 6.	The RCU API, 2019 Edition    https://lwn.net/Articles/777036/
> +|	2019 Big API Table           https://lwn.net/Articles/777165/
>  
>  
>  What is RCU?
> -- 
> 2.25.1
> 
