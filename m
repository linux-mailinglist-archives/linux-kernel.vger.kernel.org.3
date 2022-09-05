Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330815AD059
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiIEKmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiIEKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:42:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAC54CA11;
        Mon,  5 Sep 2022 03:42:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z8so10794581edb.6;
        Mon, 05 Sep 2022 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date;
        bh=gCTzFCzMXflFKHOJqnuqrRXeTvpKIEd+vaSetzeKxoc=;
        b=qV90qOFaA4IcMsWm4Q3WZfEOIeYu7qrQv34TfbCTG/S8VLD864QkPRjWPdbMzf7PAr
         wnZ+D6RIVUH5Yq/+gz8G3lz8kD0dCQ2O6jHzdLHNdsw00mH/nWzXF9TzEZFXhk9JmH9U
         fErkEMFz/u0+c0EOjpe+/D1DZvwXXh1a465mKEJVNA6iIEgTFuDC5IaThQnWqpP1+4eD
         /ij6+9F/p4yEkb6lBR52vEYJui7XCWJqM0xzekbphOmeFgxakXFrbHO2xAtjU2ieqh4H
         fJkl0qj39m2d7beYQhkmhpn66CMWMcPajQ16wyZoPiifQeptcC5SgntRXma6IdqyV2nl
         pMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gCTzFCzMXflFKHOJqnuqrRXeTvpKIEd+vaSetzeKxoc=;
        b=OKNRlOHnM5HlzSfprgLe7BB0qOFZIfgcf4KmXv/bkY4tnzzERTbyjoNATck2VmrIrt
         UlxPCChykuFklAjlXob90DmGezPEzLeaFUt+KP4GxPVdShAyK8y0sIZ+0kfY0Lek9M6J
         qp96Vq6Xut6rZ2uRGstJR2xxLXB4Wh/xbwbC1eehl++kUQ72jeMo+29Xl+s46o7jB6c2
         J30gOjCps+zF63jkGBS3r0aO2vBzS9qYXMIZ21/HAdgqb+LMPltj0wA+cq4hn5XmeL1u
         Q06m+T3buS28Uk1uzt1X61FBD/MgII+54SmP4N8cCJVweCDaPtpQjTYtMRQ90iwAMGKl
         En4Q==
X-Gm-Message-State: ACgBeo3p36ED1FZmGGwMTG7WuOep30ORXjEY07M72ofnAztGE04ys4P0
        BITDYuT5/wAIxma52YLwwaw=
X-Google-Smtp-Source: AA6agR7u9fTqZVIsmI/Sxa/JaibFRI0toGVy/kKmOZEN/mWZAUAXAr17Tbv5IyixVpavtfwYeXdNcQ==
X-Received: by 2002:a05:6402:2945:b0:446:1144:f1aa with SMTP id ed5-20020a056402294500b004461144f1aamr42098217edb.79.1662374536696;
        Mon, 05 Sep 2022 03:42:16 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906264a00b0073cf8e0355fsm4731400ejc.208.2022.09.05.03.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:42:16 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 5 Sep 2022 12:42:14 +0200
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: perf top -p broken for multithreaded processes since 5.19
Message-ID: <YxXShjsmy+iQi07I@krava>
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
 <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
 <YxJW19MwaMOb8D30@kernel.org>
 <ca905aa0-9d7b-d6d8-c789-2bd22057619b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca905aa0-9d7b-d6d8-c789-2bd22057619b@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 10:14:25AM +0300, Adrian Hunter wrote:
> On 2/09/22 22:17, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Sep 02, 2022 at 05:50:22PM +0300, Adrian Hunter escreveu:
> >> On 2/09/22 17:46, Tomáš Trnka wrote:
> >>> Hello,
> >>>
> >>> A bug in perf v5.19 and newer completely breaks monitoring multithreaded
> >>> processes using "perf top -p". The tool fails to start with "Failed to mmap
> >>> with 22 (Invalid argument)". It still seems to work fine on single-threaded
> >>> processes. "perf record" is also unaffected.
> >>
> >> It has been reported here:
> >>
> >> 	https://bugzilla.kernel.org/show_bug.cgi?id=216441
> > 
> > If I do:
> > 
> > ⬢[acme@toolbox perf-urgent]$ git log -2
> > commit dfeb0bc60782471c293938e71b1a1117cfac2cb3 (HEAD -> perf/urgent)
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Fri Sep 2 16:15:39 2022 -0300
> > 
> >     Revert "libperf evlist: Check nr_mmaps is correct"
> > 
> >     This reverts commit 4ce47d842d4c16c07b135b8a7975b8f0672bcc0e.
> > 
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > commit 78cd283f6b8ab701cb35eafd5af8140560a88f16
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Fri Sep 2 16:13:41 2022 -0300
> > 
> >     Revert "libperf evlist: Allow mixing per-thread and per-cpu mmaps"
> > 
> >     This reverts commit ae4f8ae16a07896403c90305d4b9be27f657c1fc.
> > 
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ⬢[acme@toolbox perf-urgent]$
> > 
> > It works again, Tomáš can you please try doing this to see if this works
> > for you?
> > 
> 
> This is the fix I have so far.  I would like to test it some more though.
> 
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Sat, 3 Sep 2022 10:05:08 +0300
> Subject: [PATCH] libperf evlist: Fix per-thread mmaps for multi-threaded
>  targets
> 
> Offending commit did not consider the different set-output rules for
> per-thread mmaps i.e. in the per-thread case set-output is used for
> mmaps of the same thread not the same cpu.
> 
> This was not immediately noticed because it only happens with
> multi-threaded targets and we do not have a test for that yet.
> 
> Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

SNIP

>  static int
>  mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  	     struct perf_mmap_param *mp)
> @@ -528,6 +571,8 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  	int nr_mmaps = 0;
>  	int cpu, thread;
>  
> +	pr_debug("%s: nr cpu values %d nr threads %d\n", __func__, nr_cpus, nr_threads);
> +
>  	for (cpu = 0; cpu < nr_cpus; cpu++) {
>  		int output = -1;
>  		int output_overwrite = -1;
> @@ -569,6 +614,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  			  struct perf_evlist_mmap_ops *ops,
>  			  struct perf_mmap_param *mp)
>  {
> +	const struct perf_cpu_map *cpus = evlist->all_cpus;
>  	struct perf_evsel *evsel;
>  
>  	if (!ops || !ops->get || !ops->mmap)
> @@ -588,6 +634,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
>  		return -ENOMEM;
>  
> +	if (perf_cpu_map__empty(cpus))
> +		return mmap_per_thread(evlist, ops, mp);
> +

could we just enable per-cpu mapping in top? I'd think it should be
enabled anyway because we need ring buffers on all cpus for sampling

jirka


---
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e89208b4ad4b..d6be82315dd8 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1422,6 +1422,7 @@ int cmd_top(int argc, const char **argv)
 			.freq		= 4000, /* 4 KHz */
 			.target		= {
 				.uses_mmap   = true,
+				.default_per_cpu = true,
 			},
 			/*
 			 * FIXME: This will lose PERF_RECORD_MMAP and other metadata

