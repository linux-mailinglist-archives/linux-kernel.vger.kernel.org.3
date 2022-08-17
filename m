Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DC596793
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiHQC7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiHQC7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 22:59:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B29675B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:59:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u133so10968822pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc;
        bh=/tO4DCm3u+0w3PVCkx0WyWuvz7PYFu5oe9lMYDeyNbw=;
        b=NyIpz72DIbP7xVNP6HW4NhNaME+eghGBdleag4Y6re9LujRPjzRxwNUk8xAIsgzoYH
         H7Z1iYadfvRv7oicq2E/hUUmXDm90hf6a/+PNjoZ+9BYHj5ZEuNK/LR4MkhUR8eaDCiQ
         o66HO8YymT9y/X/PFc1bUL6mCk5HCB0xm/F/lxzv1XnLDGv59zzaMLtLQLT+EbNdLyER
         y+ZvhtxWbevjSV/15sajJ6ixVlPNC46sfbAF9pBeBvURpxbTqTHztk0h9x7bsZL0/vQh
         RW1T2cyRm9agwl+hbj9CI/WwLNG+UDrFPl/j26rA4/ui4bUMeaSp3fl/pD1ZqnksFmaH
         WP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc;
        bh=/tO4DCm3u+0w3PVCkx0WyWuvz7PYFu5oe9lMYDeyNbw=;
        b=xyDNnnu5lmaF2xQMG0ZU/Hbz9evf4PlZgBDJRoMkfCkjEr3YHqvwiib2jajq4NgMFu
         gsWK316zUQccsmFERrsR2xnrv042DkZQs/6VrlDRiCM1LyB4aGYxI3Qjlp7/zq8Wu2xW
         zgxbmoy9OjCvDCDQVMe0P3PyKluTXbQMzFWfOr3cQOEgcZzTpbwsg0RY5U5atfUlEzkf
         gw+eyMAHuoLwGMGfUXXg6r/hpTE+doCjoDiZrtJKcTlSgOgHsVr05yTvWv7zdqw510qw
         wgPH6/f8C3LNZBxGN8EG1owkGBS3IVOMdmg/ORJCxPt3gx8+ADHDnmBZlwOXQg11fCXs
         TkXA==
X-Gm-Message-State: ACgBeo0iaS0OqajNXFHIGJ9TvFMqNVSc/ktoah7xsI/kjOJuOC0eLpHd
        horK+DlqklS1OCe5MQ0B/3I=
X-Google-Smtp-Source: AA6agR4nUscc8bnOCJT3ZxVy5m1K/hVbp4yo7ytPZPRRQp1Xt43/bBv312f9Q2ycjDJlssKfTNPwOg==
X-Received: by 2002:a05:6a00:16cb:b0:52b:cc59:9468 with SMTP id l11-20020a056a0016cb00b0052bcc599468mr23397196pfc.46.1660705187829;
        Tue, 16 Aug 2022 19:59:47 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z7-20020aa79587000000b00528c22fbb45sm9472021pfj.141.2022.08.16.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 19:59:47 -0700 (PDT)
Message-ID: <62fc59a3.a70a0220.b9a52.01f3@mx.google.com>
X-Google-Original-Message-ID: <20220817025945.GA84631@cgel.zte@gmail.com>
Date:   Wed, 17 Aug 2022 02:59:45 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, tj@kernel.org, axboe@kernel.dk,
        vdavydov.dev@gmail.com, ran.xiaokai@zte.com.cn, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgel <cgel@zte.com.cn>,
        Peter Zijlstra <peterz@infradead.org>, yang.yang29@zte.com.cn
Subject: Re: [RFC PATCH 1/2] psi: introduce memory.pressure.stat
References: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
 <Yup+W/EFzkfSqRnW@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yup+W/EFzkfSqRnW@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:55:39AM -0400, Johannes Weiner wrote:
> On Mon, Aug 01, 2022 at 12:42:04AM +0000, cgel.zte@gmail.com wrote:
> > From: cgel <cgel@zte.com.cn>
> > 
> > For now psi memory pressure account for all the mem stall in the
> > system, And didnot provide a detailed information why the stall
> > happens. This patch introduce a cgroupu knob memory.pressure.stat,
> > it tells the detailed stall information of all memory events and it
> > format and the corresponding proc interface.
> > 
> > for the cgroup, add memory.pressure.stat and it shows:
> > kswapd: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> > direct reclaim: avg10=0.00 avg60=0.00 avg300=0.12 total=42356
> > kcompacted: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> > direct compact: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> > cgroup reclaim: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> > workingset thrashing:   avg10=0.00 avg60=0.00 avg300=0.00 total=0
> > 
> > for the system wide, a proc file introduced as pressure/memory_stat
> > and the format is the same as the cgroup interface.
> > 
> > With this detaled information, for example, if the system is stalled
> > because of kcompacted, compaction_proactiveness can be promoted so
> > pro-compaction can be involved earlier.
> > 
> > Signed-off-by: cgel <cgel@zte.com.cn>
> 
> > @@ -64,9 +91,11 @@ struct psi_group_cpu {
> >  
> >  	/* Aggregate pressure state derived from the tasks */
> >  	u32 state_mask;
> > +	u32 state_memstall;
> >  
> >  	/* Period time sampling buckets for each state of interest (ns) */
> >  	u32 times[NR_PSI_STATES];
> > +	u32 times_mem[PSI_MEM_STATES];
> 
> This doubles the psi cache footprint on every context switch, wakeup,
> sleep, etc. in the scheduler. You're also adding more branches to
> those same paths. It'll measurably affect everybody who is using psi.
> 
> Yet, in the years of using psi in production myself, I've never felt
> the need for what this patch provides. There are event counters for
> everything that contributes to pressure, and it's never been hard to
> rootcause spikes. There are also things like bpftrace that let you
> identify who is stalling for how long in order to do one-off tuning
> and systems introspection.
> 
We think this patch is not for rootcause spikes, it's for automatic optimize
memory besides oomd, especially for sysctl adjustment. For example if we see
much pressure of direct reclaim the automatic optimize program might turn up
watermark_scale_factor.
The base idea is that this patch gives user a brief UI to know what kind of
memory pressure the system is suffering, and to optimize the system in a fine
grain. It could provide data for user to adjust watermark_boost_factor,
extfrag_threshold, compaction_proactiveness,transparent_hugepage/defrag,
swappiness, vfs_cache_pressure, madvise(), which may not easy for to do
before.

It's not easy for automatic optimize program to use tools likes bpftrace or
ftrace to do this.

While we may use CONFIG_PSI_XX or bootparam to turn on/off this patch to avoid
additional footprint for user who not need this.
