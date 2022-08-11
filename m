Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8458FD05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiHKNDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiHKNDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:03:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AB5D0E9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:03:37 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z20so19254933ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4j8p5VnEDNP9qvlCKcXbGgfz7xVz2ywlWnOTULa7BY4=;
        b=hxg+1Jt2blE20MDWcV+VzDgTT+T6zOx9mfJZQpa3s+XmOk3BoUcUK8wBZ3BTVyhlbL
         M2gBsAHDKST9WfBsTa1GcqFPCD2fhNCb0yeMvZBYKuCwG61qh9dIfGL5C3WaWSKms076
         ehHSkVDoAaJ4rQSYfs9AkOv0LCkiEDDRS82Eq50aU+uwbUnNg9hyhqSPKooFOKBbgD8+
         hV/N+4p2rdNoQZw5zpel43kBKDNZikKneQqTG/HtBWSafaA5fNb0BoO1mDVgzceVK5lw
         Y2HJjAPTFWFzRKzRSO9t8VGsGpsX3FLcG1ApLQLglDdho3iijxesg9VdcTIuCaw4Unws
         Krxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4j8p5VnEDNP9qvlCKcXbGgfz7xVz2ywlWnOTULa7BY4=;
        b=i3edyev8IA0f10wFw14RmhodRPbnsfGUIkknpI1evQbxoRqtJ75Zmek3Y2Ji6Frh4w
         D51O1agHoA8oR24rAq1iXeFvJQh3qvvH0xevaJWs5mrjYeEHl6hhmap6Ar65hvsBh2Lq
         dz1WuGqJZ1koOBFdzP3UhxVaard29xjgbqUTo2OorZA3GjbfphDYC11F9um4+Uq1hE/J
         pByfmjniSAcRUdaaCkTJzd+Ka4byonGuMp6aXrAXuNCzPc5zB5Ek2XV/KFzKiplFtchr
         bOrtctylcAwO/oEzASr06fzuraKwzEzqZA/KQe0jGIaos6GS0GegQcPsXLMNo+lRfJHl
         z4ew==
X-Gm-Message-State: ACgBeo361U001VALZWCCVubimpS0NJ8t1SJ9Syr5Lw65h0qUcseTu8Hr
        wIQQ0sXdjjCHrF/4WjbmYULHD8irZp2dy8Q7ARWKDQ==
X-Google-Smtp-Source: AA6agR67c1wsi5mCk5SlTeJhS/Q0MVLaU6rgyVGxnKcViM7ji0rTCqydYcL/zn1GifFapAhSg0aWGUkciUACQHxmsNw=
X-Received: by 2002:a2e:9604:0:b0:25e:4ed7:ef45 with SMTP id
 v4-20020a2e9604000000b0025e4ed7ef45mr9863360ljh.389.1660223015874; Thu, 11
 Aug 2022 06:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-15-carsten.haitzler@foss.arm.com> <20220807070318.GL34254@leoy-ThinkPad-X240s>
 <bcf50484-f80a-dfd6-b06d-fe1505f89999@foss.arm.com>
In-Reply-To: <bcf50484-f80a-dfd6-b06d-fe1505f89999@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 11 Aug 2022 14:03:23 +0100
Message-ID: <CAJ9a7VggvhKoA025P6wZgPu8pA7qTF+kYAnywYSK-kvysHjpaA@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] perf test: Add relevant documentation about
 CoreSight testing
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 at 18:59, Carsten Haitzler
<carsten.haitzler@foss.arm.com> wrote:
>
>
>
> On 8/7/22 08:03, Leo Yan wrote:
> > On Thu, Jul 28, 2022 at 03:52:56PM +0100, carsten.haitzler@foss.arm.com wrote:
> >> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> >>
> >> Add/improve documentation helping people get started with CoreSight and
> >> perf as well as describe the testing and how it works.
> >>
> >> Cc: linux-doc@vger.kernel.org
> >> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> >> ---
> >>   .../trace/coresight/coresight-perf.rst        | 160 ++++++++++++++++++
> >>   tools/perf/Documentation/arm-coresight.txt    |   5 +
> >>   2 files changed, 165 insertions(+)
> >>   create mode 100644 Documentation/trace/coresight/coresight-perf.rst
> >>   create mode 100644 tools/perf/Documentation/arm-coresight.txt
> >>
> >> diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
> >> new file mode 100644
> >> index 000000000000..401a097aea4b
> >> --- /dev/null
> >> +++ b/Documentation/trace/coresight/coresight-perf.rst
> >> @@ -0,0 +1,160 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +================
> >> +CoreSight - Perf
> >> +================
> >> +
> >> +    :Author:   Carsten Haitzler <carsten.haitzler@arm.com>
> >> +    :Date:     June 29th, 2022
> >> +
> >> +Perf is able to locally access CoreSight trace data and store it to the
> >> +output perf data files. This data can then be later decoded to give the
> >> +instructions that were traced for debugging or profiling purposes. You
> >> +can log such data with a perf record command like::
> >> +
> >> +   perf record -e cs_etm//u testbinary
> >> +
> >> +This would run some test binary (testbinary) until it exits and record
> >> +a perf.data trace file. That file would have AUX sections if CoreSight
> >> +is working correctly. You can dump the content of this file as
> >> +readable text with a command like::
> >> +
> >> +   perf report --stdio --dump -i perf.data
> >> +
> >> +You should find some sections of this file have AUX data blocks like::
> >> +
> >> +   0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
> >> +
> >> +   . ... CoreSight ETM Trace data: size 73168 bytes
> >> +           Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
> >> +             Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
> >> +             Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> >> +             Idx:26; ID:10;  I_TRACE_ON : Trace On.
> >> +             Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
> >> +             Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> >> +             Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> >> +             Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> >> +             Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
> >> +             ...
> >> +
> >> +If you see these above, then your system is tracing CoreSight data
> >> +correctly.
> >> +
> >> +To compile perf with CoreSight support in the tools/perf directory do::
> >> +
> >> +    make CORESIGHT=1
> >> +
> >> +This requires OpenCSD to build. You may install distribution packages
> >> +for the support such as libopencsd and libopencsd-dev or download it
> >> +and build yourself. Upstream OpenCSD is located at:
> >> +
> >> +  https://github.com/Linaro/OpenCSD
> >> +
> >> +For complete information on building perf with CoreSight support and
> >> +more extensive usage look at:
> >> +
> >> +  https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md
> >> +
> >> +
> >> +Kernel CoreSight Support
> >> +------------------------
> >> +
> >> +You will also want CoreSight support enabled in your kernel config.
> >> +Ensure it is enabled with::
> >> +
> >> +   CONFIG_CORESIGHT=y
> >> +
> >> +There are various other CoreSight options you probably also want
> >> +enabled like::
> >> +
> >> +   CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> >> +   CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> >> +   CONFIG_CORESIGHT_CATU=y
> >> +   CONFIG_CORESIGHT_SINK_TPIU=y
> >> +   CONFIG_CORESIGHT_SINK_ETBV10=y
> >> +   CONFIG_CORESIGHT_SOURCE_ETM4X=y
> >> +   CONFIG_CORESIGHT_STM=y
> >> +   CONFIG_CORESIGHT_CPU_DEBUG=y
> >
> > So far CORESIGHT_STM and CORESIGHT_CPU_DEBUG are irrelevant with perf
> > recording.  Perf only creates path from source (ETM) to sink (TMC-ETR
> > or TMC-ETF), so it's good to drop them.
>
> will do.
>
> >> +   CONFIG_CORESIGHT_CTI=y
> >> +   CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
> >> +
> >> +Please refer to the kernel configuration help for more information.
> >> +
> >> +Perf test - Verify kernel and userspace perf CoreSight work
> >> +-----------------------------------------------------------
> >> +
> >> +When you run perf test, it will do a lot of self tests. Some of those
> >> +tests will cover CoreSight (only if enabled and on ARM64). You
> >> +generally would run perf test from the tools/perf directory in the
> >> +kernel tree. Some tests will check some internal perf support like:
> >> +
> >> +   Check Arm CoreSight trace data recording and synthesized samples
> >> +   Check Arm SPE trace data recording and synthesized samples
> >> +
> >> +Some others will actually use perf record and some test binaries that
> >> +are in tests/shell/coresight and will collect traces to ensure a
> >> +minimum level of functionality is met. The scripts that launch these
> >> +tests are in the same directory. These will all look like:
> >> +
> >> +   CoreSight / ASM Pure Loop
> >> +   CoreSight / Memcpy 16k 10 Threads
> >> +   CoreSight / Thread Loop 10 Threads - Check TID
> >> +   etc.
> >> +
> >> +These perf record tests will not run if the tool binaries do not exist
> >> +in tests/shell/coresight/*/ and will be skipped. If you do not have
> >> +CoreSight support in hardware then either do not build perf with
> >> +CoreSight support or remove these binaries in order to not have these
> >> +tests fail and have them skip instead.
> >> +
> >> +These tests will log historical results in the current working
> >> +directory (e.g. tools/perf) and will be named stats-\*.csv like:
> >> +
> >> +   stats-asm_pure_loop-out.csv
> >> +   stats-memcpy_thread-16k_10.csv
> >> +   ...
> >> +
> >> +These statistic files log some aspects of the AUX data sections in
> >> +the perf data output counting some numbers of certain encodings (a
> >> +good way to know that it's working in a very simple way). One problem
> >> +with CoreSight is that given a large enough amount of data needing to
> >> +be logged, some of it can be lost due to the processor not waking up
> >> +in time to read out all the data from buffers etc.. You will notice
> >> +that the amount of data collected can vary a lot per run of perf test.
> >> +If you wish to see how this changes over time, simply run perf test
> >> +multiple times and all these csv files will have more and more data
> >> +appended to it that you can later examine, graph and otherwise use to
> >> +figure out if things have become worse or better.
> >> +
> >> +This means sometimes these tests fail as they don't capture all the
> >> +data needed. This is about tracking quality and amount of data
> >> +produced over time and to see when changes to the Linux kernel improve
> >> +quality of traces.
> >> +
> >> +Be aware that some of these tests take quite a while to run, specifically
> >> +in processing the perf data file and dumping contents to then examine what
> >> +is inside.
> >> +
> >> +You can change where these csv logs are stored by setting the
> >> +PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
> >> +test like::
> >> +
> >> +   export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
> >> +   perf test
> >> +
> >> +They will also store resulting perf output data in the current
> >> +directory for later inspection like::
> >> +
> >> +   perf-asm_pure_loop-out.data
> >> +   perf-memcpy_thread-16k_10.data
> >> +   ...
> >> +
> >> +You can alter where the perf data files are stored by setting the
> >> +PERF_TEST_CORESIGHT_DATADIR environment variable such as::
> >> +
> >> +   PERF_TEST_CORESIGHT_DATADIR=/var/tmp
> >> +   perf test
> >> +
> >> +You may wish to set these above environment variables if you whish to
> >
> > s/whish/wish/
>
> good catch. :)
>
> >> +keep the output of tests outside of the current working directory for
> >> +longer term storage and examination.
> >> diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
> >> new file mode 100644
> >> index 000000000000..c117fc50a2a9
> >> --- /dev/null
> >> +++ b/tools/perf/Documentation/arm-coresight.txt
> >
> > You could see we have a document perf-arm-spe.txt, for alignment it's
> > good to rename this file as perf-arm-coresight.txt.
> >
> > The rest of this patch is good for me, with addressing the above minor
> > comments:
>
> will do.
>
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> >
> >
> >> @@ -0,0 +1,5 @@
> >> +Arm CoreSight Support
> >> +=====================
> >> +
> >> +For full documentation, see Documentation/trace/coresight/coresight-perf.rst
> >> +in the kernel tree.
> >> --
> >> 2.32.0
> >>


Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
