Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37260575424
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiGNRjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGNRjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:39:47 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991549B69
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=w2WFCuwnVuVTVff7KbKqbCluWBef5dmDH3t5aGQpu50=;
  b=UqczR9uP/0yaouEcmvW+DqqmerlDGA1gaU0AwesrCWv0btgKWxZdYGAr
   A/ZKAB+gcYyM4dT2WfMFewNmZdfdrHnK8abyjlWY8M6adITwNZrqABKPd
   upGwINbPzqZ1cbzl6zT52tO5jsOjVhR6YGzhaYY+IaeXeUJ8+PioFAj1V
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,272,1650924000"; 
   d="scan'208";a="19356322"
Received: from 150.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.150])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 19:39:43 +0200
Date:   Thu, 14 Jul 2022 19:39:43 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] coccinelle: Remove script that checks replacing 0/1 with
 false/true in functions returning bool
In-Reply-To: <20220711164243.092eec75@gandalf.local.home>
Message-ID: <alpine.DEB.2.22.394.2207141939270.3019@hadrien>
References: <20220711164243.092eec75@gandalf.local.home>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Jul 2022, Steven Rostedt wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> There is nothing wrong with current code that returns 0 or 1 for a
> function returning bool. It is perfectly acceptable by the C standard.
>
> To avoid churn of unwanted patches that are constantly sent to maintainers
> who do not care about this change, remove the script that flags it as an
> issue. This issue is not worth the burden on maintainers to accept
> useless patches.

Applied.

julia

>
> Link: https://lore.kernel.org/all/20220705073822.7276-1-jiapeng.chong@linux.alibaba.com/
> Link: https://lore.kernel.org/all/20220429075201.68581-1-jiapeng.chong@linux.alibaba.com/
> Link: https://lore.kernel.org/all/1649236467-29390-1-git-send-email-baihaowen@meizu.com/
> Link: https://lore.kernel.org/all/20220317014740.3138-1-jiapeng.chong@linux.alibaba.com/
> Link: https://lore.kernel.org/all/190b5c2f2f2fb9cc775fce8daed72bf893be48a4.1642065293.git.davidcomponentone@gmail.com/
> Link: https://lore.kernel.org/all/20211214113845.439392-1-deng.changcheng@zte.com.cn/
> Link: https://lore.kernel.org/all/20210824065735.60660-1-deng.changcheng@zte.com.cn/
> Link: https://lore.kernel.org/all/20210824064305.60081-1-deng.changcheng@zte.com.cn/
> Link: https://lore.kernel.org/all/20210824062359.59474-1-deng.changcheng@zte.com.cn/
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Michal Marek <mmarek@suse.cz>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  scripts/coccinelle/misc/boolreturn.cocci | 59 ------------------------
>  1 file changed, 59 deletions(-)
>  delete mode 100644 scripts/coccinelle/misc/boolreturn.cocci
>
> diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle/misc/boolreturn.cocci
> deleted file mode 100644
> index 29d2bf41e95d..000000000000
> --- a/scripts/coccinelle/misc/boolreturn.cocci
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/// Return statements in functions returning bool should use
> -/// true/false instead of 1/0.
> -//
> -// Confidence: High
> -// Options: --no-includes --include-headers
> -
> -virtual patch
> -virtual report
> -virtual context
> -
> -@r1 depends on patch@
> -identifier fn;
> -typedef bool;
> -symbol false;
> -symbol true;
> -@@
> -
> -bool fn ( ... )
> -{
> -<...
> -return
> -(
> -- 0
> -+ false
> -|
> -- 1
> -+ true
> -)
> -  ;
> -...>
> -}
> -
> -@r2 depends on report || context@
> -identifier fn;
> -position p;
> -@@
> -
> -bool fn ( ... )
> -{
> -<...
> -return
> -(
> -* 0@p
> -|
> -* 1@p
> -)
> -  ;
> -...>
> -}
> -
> -
> -@script:python depends on report@
> -p << r2.p;
> -fn << r2.fn;
> -@@
> -
> -msg = "WARNING: return of 0/1 in function '%s' with return type bool" % fn
> -coccilib.report.print_report(p[0], msg)
> --
> 2.35.1
>
>
