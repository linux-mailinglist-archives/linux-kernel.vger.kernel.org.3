Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4B54FF10
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378293AbiFQUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbiFQUeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:34:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4D5D5F5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:33:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso5549464pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XaKlK05FkVg38K2tQ0yL1JaeywALR6WTqE+YQ3YDmzY=;
        b=OOm1kpvEo/74e+WRkOJ3w4J3hO162ecE9m9B4xjVxPitTn2ncpre/3W0wYoswC7ryC
         b8HlZQYonmcAUW7JKY9P7MoFMIulp30HltUA0ulHfxMVV2uib+xdJ/KmKLtEaZ/fLccp
         0swnB9ecFn6An2KkWGv9mSd+pgwQRs3KGwR5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XaKlK05FkVg38K2tQ0yL1JaeywALR6WTqE+YQ3YDmzY=;
        b=R3jQwxi4UEQhdS1svr8vW1Uh938ysI80HTjvRNOSmvoVGErOSNSXtbjWJwk5BNxMbo
         buCSyNoc2SF9DbozSAHOYclDuTC5kWovX0+DYoyw2X2McaZm1NOZe7rlRVpcukc9QOlI
         144fwf5phWNh1fSyfB8M3YfoY/i6ooUpW6xqJyGqEYaODDHXtnZEOvAC/B4aWuf/NYzf
         xu6pm5S3nJVzMSCyvrnXCxVp8eoLgiR9uSysCzqHymZ+apsR4O/PWUNa6JppuNhot/xs
         eHg+Xuipaw9gkJUv6sUIOrAAraavVSIbeOkHs1wblfJbKK3iUQjOjxhD3IzyYDvkUMM4
         ghgQ==
X-Gm-Message-State: AJIora91QSvtBEIkKUvYa0BAJrlJ4L+6A2B22ir9XNHsKBs+/idMv710
        Op6OIcPaJ2XJT+YCEX9ujAHQTA==
X-Google-Smtp-Source: AGRyM1sFFOdG6B7R4gKjOpMcE9JRtRgxcAIIBODunRHJTfy2S4c0YinGTklU6sznx0IkN7XKgnVwUA==
X-Received: by 2002:a17:902:c951:b0:163:efad:406d with SMTP id i17-20020a170902c95100b00163efad406dmr11617140pla.55.1655498034526;
        Fri, 17 Jun 2022 13:33:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6844:cedc:a28c:44b2])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0015e8d4eb2c0sm3948341plk.266.2022.06.17.13.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:33:53 -0700 (PDT)
Date:   Fri, 17 Jun 2022 13:33:51 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched: Drop outdated compile-optimization comment
Message-ID: <YqzlL26IGdIHczaj@google.com>
References: <20220615222745.3371892-1-briannorris@chromium.org>
 <xhsmhk09f7dgy.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhk09f7dgy.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:10:05PM +0100, Valentin Schneider wrote:
> I'd argue that comment is still somewhat relevant but it applies to that
> block:
> 
> #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
> 		update_irq_load_avg(rq, irq_delta + steal);
> #endif

Eh, I suppose. The confusion still stands though ;)

> if !CONFIG_HAVE_SCHED_AVG_IRQ then yes you'd expect the compiler to not
> even add a call to update_irq_load_avg() in there, but compilers aren't the
> most trustworthy things :-) If you feel like it, you could play with
> GCC/clang and see what they emit if you remove those #ifdefs.

FWIW, update_irq_load_avg() is just "return 0" in that case. I think
that'd be considered excessive paranoia if you think a modern compiler
would still somehow produce a suboptimal result for that case :)

But anyway, I tried CONFIG_IRQ_TIME_ACCOUNTING=n +
CONFIG_PARAVIRT_TIME_ACCOUNTING=n with these compilers:

  x86 gcc 11.2.0 (Debian)
  x86 clang 13.0.1 (Debian)
  aarch64-linux-gnu-gcc 11.2.0 (Debian)

and they all dropped the update_irq_load_avg() even without the #ifdef.

I'll drop it in a v2, since that seems to be the consensus.

Brian
