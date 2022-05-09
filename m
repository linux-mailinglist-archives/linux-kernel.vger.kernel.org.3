Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EB951F79A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiEII6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiEIIu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:50:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4C1668B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:46:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id l11so5891928pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/7elBoAbz4DhwZSp9qhlRxUepEAsfaM092cMSCKhjU=;
        b=Z7LWiMLZqSUmz5TAbdmVr54c46DqUfEWR9eNOrTPgTEYQfPiEZjVVHQDo3y7d0tS4Y
         wwZdsJEg/AUVWulEbnuJrdowoYrVMMZVj5oxng8kF6JmjGtFwh+ESC/mdZi3+WlYS0X7
         8T4DZBhcOaBDg9qS+YEPZ+12Qv3WChxeLApJAlWGVtQs5DKk781vzY1IYMWl5cfbAhDH
         8ZDxxYvUiNa13YcXzsT2bbnmlljCdif77mtAej4xNC7J1sIxorSBdY1/+sxfkgI1pIxC
         9PKsh430rPl/dKqukwzzJuTDjC0YZ9yPl6fgARvmevSqpU/SYSBeTKI8amJxtuL4fFsX
         MQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/7elBoAbz4DhwZSp9qhlRxUepEAsfaM092cMSCKhjU=;
        b=NQOAlTYVXWj/N3L+1kh7kWs/ddFlHabjUh/OxhuIGj/Gl2oZlZTRuptha3yrOIQixu
         hfxH5EGD0o/oCN7K+m9ZpLx7sYIrvHXyr00mTVfkICCi5E58RwArNmMGTqk0V2nPfWun
         LL3ihx6ea+NOOImawDJBlrvRwl2CCXiaVgMah8OBOvfXy3FTr76bRunAW+cNcYcbOnfH
         SVqJkW901ZjT8iCGXj212RYOOEDCM9I7W5CaoWlu1PY2FGtzCDd3y6Qqzm4UrcsDcTE8
         Z2yrpyRRp/GameL50qg16RPa4HF7Ew8WW29OoSmO1egyvBfBe+kEg2XYzpRr1l2s5jpG
         p4Vg==
X-Gm-Message-State: AOAM531of3KWcyLfmRZBk0wj23cs2mGhfe5ts6EF/t/p5R7ATaV37JN7
        UhzmVHlJmRIGfzbzBOOYNYXWyg==
X-Google-Smtp-Source: ABdhPJxtjZYLRINP945+SmzGiyei89c/S6WAnRi5M/Ofwvo4QqR4tCp+UWHSSEYBsNIOqWBJrzQNsQ==
X-Received: by 2002:a05:6a00:1145:b0:4f6:3ebc:a79b with SMTP id b5-20020a056a00114500b004f63ebca79bmr15093728pfm.41.1652085982666;
        Mon, 09 May 2022 01:46:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id b132-20020a621b8a000000b0050dc76281d2sm8312818pfb.172.2022.05.09.01.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 01:46:22 -0700 (PDT)
Date:   Mon, 9 May 2022 16:46:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, James Clark <James.Clark@arm.com>,
        German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH V2 00/23] perf intel-pt: Better support for perf record
 --cpu
Message-ID: <20220509084617.GA352398@leoy-ThinkPad-X240s>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220508150832.GA278102@leoy-ThinkPad-X240s>
 <a9e97cca-8bd6-9a47-a7d9-79198e6b9a81@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e97cca-8bd6-9a47-a7d9-79198e6b9a81@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:44:02AM +0300, Adrian Hunter wrote:

[...]

> > Thanks a lot for this patch set, I believe this is a common issue for
> > AUX trace (not only for Intel-PT), so I verified this patch set for both
> > Arm CoreSight and SPE; unfortunately both cannot see MMAP events for
> > migrated task.  I used below commands:
> > 
> >   # perf record -B -N --no-bpf-event -e cs_etm//u -C 0 -- taskset --cpu-list 1 uname
> >   # perf script  --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l
> >   0
> > 
> > 
> >   # perf record -B -N --no-bpf-event -e arm_spe_0//u -C 0 -- taskset --cpu-list 1 uname
> >   # perf script --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l
> >   0
> > 
> > I didn't dive into details for this patch set, so I cannot say the
> > failure is caused by any issue in this patch set.  But it's definitely
> > we need to look into for Arm platforms to root cause what's the reason
> > it cannot record MMAP events properly when migrate tasks.  Loop James
> > and German for this reason.
> 
> You would need the equivalent of patch "perf intel-pt: Track sideband
> system-wide when needed" which makes use of new helper
> evlist__add_aux_dummy() to set up the dummy event with the option to
> make it "system wide".
> 
> cs_etm_recording_options() and arm_spe_recording_options() have similar
> code.

Thanks a lot for the guidance.

I applied the simliar change for cs_etm_recording_options() and
arm_spe_recording_options(), both can pass below tests:

  # perf record -B -N --no-bpf-event -e cs_etm//u -C 0 -- taskset --cpu-list 1 uname
  # perf script  --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l
  4

  # perf record -B -N --no-bpf-event -e arm_spe_0//u -C 0 -- taskset --cpu-list 1 uname
  # perf script --no-itrace --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l      
  4

And I tested a more complex case for migrating a test program 'sysbench'
in the middle of perf session, it still fails to parse any samples
testing program 'sysbench'.  I need to do more homework for this part,
but welcome any suggestions, thanks!  The testing script is:

---8<---

export PATH=/mnt/export/arm-linux-kernel/tools/perf/:$PATH

perf record --kcore -C 1 -e cs_etm// &
PERF_PID=$!
echo "Perf PID ${PERF_PID}"

sleep 2

taskset 0x1 ./sysbench --test=memory --max-requests=1000000000 run &
TEST_PROG_PID=$!
echo "Test Prog PID ${TEST_PROG_PID}"

sleep 1

taskset -p 0x2 $TEST_PROG_PID

sleep 1

kill $PERF_PID

> You will need to decide if it is worth the extra sideband.  I decided
> if it became an issue, it could be made optional in the future.

Yeah, the condition checking for system wide tracking in patch 16/23
looks good to me.

Thanks,
Leo
