Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5659C56B788
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiGHKn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiGHKn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:43:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768E0634A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:43:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j21so35733942lfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9D4FjUXSut7jVRlk3hCRkSgI35DHNwJun5fcNFnhaM=;
        b=TBBOL/jd/350dS6B/21/xO4yO30fMIxm9GPFSjqqVXv/c3fj6V/hDgDVUsJRzI2b9w
         iKqem1G+A72TBXHdbxVdN2ITd4lszRiO+JB7HUSfi8z2BeDOh/Tw7xW9MhFcBYs6pCPf
         dHUgY+NA/0bq6GOlupdm9fgQhsi3J2O1sGzEVb6HJvDYyFwMOHKDOWDjBttqC3/9ILqX
         6k2EK+FyrwHtS0pUCzqCHRU+4iZ9t5n6z51yT9RqEka5sdchlwo7Km/V4dl8KSVzgUnn
         XtyQwF9KrM5RhoEnSUbBuj/DTDsT27SM3VHhg9cjocHhqhR13I3BpC5fynhLVQ7ZdQXZ
         5pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9D4FjUXSut7jVRlk3hCRkSgI35DHNwJun5fcNFnhaM=;
        b=E3T1QW0dQoByAN+r90Pln+W12Ky686XyPl2Gr0CTjeo/HmDL8ead1fATN3e+5SGVgm
         j4EJns7Us2bUY+spgctOYFRdZRrRYpKtH6PaAR7yJ5RP6CvgKQ6E1geMxYvLI0JT5q4Q
         nQphB4hjkYYrSTJNr61vPtfjVMTDnjCKbb2PkR84Rudrb+dSoA5+AzNh5s1Eg4uNvMEH
         SDEekCJnI0iCaVZIXEqe53qI3r+gcfIJHpH7THolhaeEnflPOd+JI8Jkis40/661TWCW
         W/UyLF8mRMw+tUZkY9s4aRK1u4ndS4OcglCQUnWN6Ao5zILEbPVhfkdb42JQnvDnf/pa
         NM6A==
X-Gm-Message-State: AJIora89kon/uUGHAcGUDyJ7g2+ANCW4ROVVaJRNchdQ9xH/hQnfpsXq
        Zde0oMWkTHb6Uapv5kHo/xBkPeW9o7XbNGN5z0ZZL/IHkgw=
X-Google-Smtp-Source: AGRyM1uYL7x8lH4R9mXj8TfhHQN8NSobY9Iji/gbfizvrrb+9YhECz9TBR2cPOkOW1LHTJo0z8wg/lPIv74hOcsw+nA=
X-Received: by 2002:a05:6512:1691:b0:47f:ae89:906f with SMTP id
 bu17-20020a056512169100b0047fae89906fmr1962300lfb.229.1657277033613; Fri, 08
 Jul 2022 03:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
 <20220701120804.3226396-15-carsten.haitzler@foss.arm.com> <Yr+1KZfciYQWdDgK@debian.me>
 <48f1e3f1-4271-c7b2-9ead-9ce574680035@foss.arm.com>
In-Reply-To: <48f1e3f1-4271-c7b2-9ead-9ce574680035@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 8 Jul 2022 11:43:42 +0100
Message-ID: <CAJ9a7Vit_Tzs7Pnej73SfuGw59ge0e_fREsjZBsNvFDXNHmXRQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] perf test: Add relevant documentation about
 CoreSight testing
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-doc@vger.kernel.org
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

Hi Carsten

On Fri, 8 Jul 2022 at 10:27, Carsten Haitzler
<carsten.haitzler@foss.arm.com> wrote:
>
>
>
> On 7/2/22 04:02, Bagas Sanjaya wrote:
> > On Fri, Jul 01, 2022 at 01:08:03PM +0100, carsten.haitzler@foss.arm.com wrote:
> >> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> >>
> >
> > Hi Carsten,
> >
> > This doc patch can be improved, see below.
>
> I'll look at addressing the below - with some exceptions as they are not
> what you think they are.
>
> >> This adds/improves documentation helping people get started with
> >> CoreSight and perf as well as describing the testing and how it works.
> >>
> >
> > Use imperative mood instead of descriptive one for patch description.
> >
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
> >> index 000000000000..de25082447dd
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
> >> +can log such data with a perf record command like:
> >> +
> >> +    perf record -e cs_etm//u testbinary
> >> +
> >
> > Use literal code block.
> >
> >> +This would run some test binary (testbinary) until it exits and record
> >> +a perf.data trace file. That file would have AUX sections if CoreSight
> >> +is working correctly. You can dump the content of this file as
> >> +readable text with a command like:
> >> +
> >> +    perf report --stdio --dump -i perf.data
> >> +
> >
> > Same as above.
> >
> >> +You should find some sections of this file have AUX data blocks like:
> >> +
> >> +    0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
> >> +
> >> +    . ... CoreSight ETM Trace data: size 73168 bytes
> >> +            Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
> >> +              Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
> >> +              Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> >> +              Idx:26; ID:10;  I_TRACE_ON : Trace On.
> >> +              Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
> >> +              Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> >> +              Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> >> +              Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> >> +              Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
> >> +              ...
> >> +
> >
> > Here too.
> >
> >> +If you see these above, then your system is tracing CoreSight data
> >> +correctly.
> >> +
> >> +To compile perf with CoreSight support in the tools/perf directory do
> >> +
> >> +    make CORESIGHT=1
> >> +
> >
> > Here too again.
> >
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
> >> +Ensure it is enabled with:
> >> +
> >> +    CONFIG_CORESIGHT=y
> >> +
> >> +There are various other CoreSight options you probably also want
> >> +enabled like:
> >> +
> >> +    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> >> +    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> >> +    CONFIG_CORESIGHT_CATU=y
> >> +    CONFIG_CORESIGHT_SINK_TPIU=y
> >> +    CONFIG_CORESIGHT_SINK_ETBV10=y
> >> +    CONFIG_CORESIGHT_SOURCE_ETM4X=y
> >> +    CONFIG_CORESIGHT_STM=y
> >> +    CONFIG_CORESIGHT_CPU_DEBUG=y
> >> +    CONFIG_CORESIGHT_CTI=y
> >> +    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
> >> +
> >
> > Same as above again.
> >
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
> >> +    Check Arm CoreSight trace data recording and synthesized samples
> >> +    Check Arm SPE trace data recording and synthesized samples
> >> +
> >
> > Use bullet lists.
>
> Actually this would be a code block - it is literally the stdout from
> perf test (just 2 lines of it for those tests).
>
> >> +Some others will actually use perf record and some test binaries that
> >> +are in tests/shell/coresight and will collect traces to ensure a
> >> +minimum level of functionality is met. The scripts that launch these
> >> +tests are in the same directory. These will all look like:
> >> +
> >> +    CoreSight / ASM Pure Loop
> >> +    CoreSight / Memcpy 16k 10 Threads
> >> +    CoreSight / Thread Loop 10 Threads - Check TID
> >> +    ...
> >> +
> >
> > Same as above.
>
> This too - a code block.
>
> >> +These perf record tests will not run if the tool binaries do not exist
> >> +in tests/shell/coresight/*/ and will be skipped. If you do not have
> >> +CoreSight support in hardware then either do not build perf with
> >> +CoreSight support or remove these binaries in order to not have these
> >> +tests fail and have them skip instead.
> >> +
> >> +These tests will log historical results in the current working
> >> +directory (e.g. tools/perf) and will be named stats-*.csv like:
> >> +
> >> +    stats-asm_pure_loop-out.csv
> >> +    stats-memcpy_thread-16k_10.csv
> >> +    ...
> >> +
> >
> > These above causes htmldocs warning (unescaped wildcard), so I have to apply
> > the fixup:
> >
> > ---- >8 ----
> >
> > diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
> > index de25082447dd50..a25fcda5c37c55 100644
> > --- a/Documentation/trace/coresight/coresight-perf.rst
> > +++ b/Documentation/trace/coresight/coresight-perf.rst
> > @@ -102,13 +102,13 @@ tests are in the same directory. These will all look like:
> >       ...
> >
> >   These perf record tests will not run if the tool binaries do not exist
> > -in tests/shell/coresight/*/ and will be skipped. If you do not have
> > +in tests/shell/coresight/\*/ and will be skipped. If you do not have
> >   CoreSight support in hardware then either do not build perf with
> >   CoreSight support or remove these binaries in order to not have these
> >   tests fail and have them skip instead.
> >
> >   These tests will log historical results in the current working
> > -directory (e.g. tools/perf) and will be named stats-*.csv like:
> > +directory (e.g. tools/perf) and will be named stats-\*.csv like:
> >
> >       stats-asm_pure_loop-out.csv
> >       stats-memcpy_thread-16k_10.csv
> >
> > ---- >8 ----
> >
> > Also, the output list above could be inside code block (since these
> > are output).
>
> Yup.
>
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
> >> +test like:
> >> +
> >> +    export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
> >> +    perf test
> >> +
> >> +They will also store resulting perf output data in the current
> >> +directory for later inspection like:
> >> +
> >> +    perf-asm_pure_loop-out.data
> >> +    perf-memcpy_thread-16k_10.data
> >> +    ...
> >> +
> >> +You can alter where the perf data files are stored by setting the
> >> +PERF_TEST_CORESIGHT_DATADIR environment variable such as:
> >> +
> >> +    PERF_TEST_CORESIGHT_DATADIR=/var/tmp
> >> +    perf test
> >> +
> >
> > Use code block.
> >
> >> +You may wish to set these above environment variables if you whish to
> >> +keep the output of tests outside of the current working directory for
> >> +longer term storage and examination.
> >> diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
> >> new file mode 100644
> >> index 000000000000..f94743a4d161
> >> --- /dev/null
> >> +++ b/tools/perf/Documentation/arm-coresight.txt
> >> @@ -0,0 +1,5 @@
> >> +Arm CoreSight Support
> >> +=====================
> >> +
> >> +Please see docuentation in the central CoreSight location in the
> >> +kernel tree under Documentation/trace/coresight
> >
> > s/ducuentation/documentation/
> >
> > So here's the improv:
> >
> > ---- >8 ----
> >
> > diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
> > index a25fcda5c37c55..0dd4689a699ecd 100644
> > --- a/Documentation/trace/coresight/coresight-perf.rst
> > +++ b/Documentation/trace/coresight/coresight-perf.rst
> > @@ -10,37 +10,37 @@ CoreSight - Perf
> >   Perf is able to locally access CoreSight trace data and store it to the
> >   output perf data files. This data can then be later decoded to give the
> >   instructions that were traced for debugging or profiling purposes. You
> > -can log such data with a perf record command like:
> > +can log such data with a perf record command like::
> >
> > -    perf record -e cs_etm//u testbinary
> > +   perf record -e cs_etm//u testbinary
> >
> >   This would run some test binary (testbinary) until it exits and record
> >   a perf.data trace file. That file would have AUX sections if CoreSight
> >   is working correctly. You can dump the content of this file as
> > -readable text with a command like:
> > +readable text with a command like::
> >
> > -    perf report --stdio --dump -i perf.data
> > +   perf report --stdio --dump -i perf.data
> >
> > -You should find some sections of this file have AUX data blocks like:
> > +You should find some sections of this file have AUX data blocks like::
> >
> > -    0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
> > +   0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
> >
> > -    . ... CoreSight ETM Trace data: size 73168 bytes
> > -            Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
> > -              Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
> > -              Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> > -              Idx:26; ID:10;  I_TRACE_ON : Trace On.
> > -              Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
> > -              Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> > -              Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> > -              Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> > -              Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
> > -              ...
> > +   . ... CoreSight ETM Trace data: size 73168 bytes
> > +           Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
> > +             Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
> > +             Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> > +             Idx:26; ID:10;  I_TRACE_ON : Trace On.
> > +             Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
> > +             Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> > +             Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> > +             Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> > +             Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
> > +             ...
> >
> >   If you see these above, then your system is tracing CoreSight data
> >   correctly.
> >
> > -To compile perf with CoreSight support in the tools/perf directory do
> > +To compile perf with CoreSight support in the tools/perf directory do::
> >
> >       make CORESIGHT=1
> >
> > @@ -60,23 +60,23 @@ Kernel CoreSight Support
> >   ------------------------
> >
> >   You will also want CoreSight support enabled in your kernel config.
> > -Ensure it is enabled with:
> > +Ensure it is enabled with::
> >
> > -    CONFIG_CORESIGHT=y
> > +   CONFIG_CORESIGHT=y
> >
> >   There are various other CoreSight options you probably also want
> > -enabled like:
> > +enabled like::
> >
> > -    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> > -    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> > -    CONFIG_CORESIGHT_CATU=y
> > -    CONFIG_CORESIGHT_SINK_TPIU=y
> > -    CONFIG_CORESIGHT_SINK_ETBV10=y
> > -    CONFIG_CORESIGHT_SOURCE_ETM4X=y
> > -    CONFIG_CORESIGHT_STM=y
> > -    CONFIG_CORESIGHT_CPU_DEBUG=y
> > -    CONFIG_CORESIGHT_CTI=y
> > -    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
> > +   CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> > +   CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> > +   CONFIG_CORESIGHT_CATU=y
> > +   CONFIG_CORESIGHT_SINK_TPIU=y
> > +   CONFIG_CORESIGHT_SINK_ETBV10=y
> > +   CONFIG_CORESIGHT_SOURCE_ETM4X=y
> > +   CONFIG_CORESIGHT_STM=y
> > +   CONFIG_CORESIGHT_CPU_DEBUG=y
> > +   CONFIG_CORESIGHT_CTI=y
> > +   CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
> >
> >   Please refer to the kernel configuration help for more information.
> >
> > @@ -88,18 +88,18 @@ tests will cover CoreSight (only if enabled and on ARM64). You
> >   generally would run perf test from the tools/perf directory in the
> >   kernel tree. Some tests will check some internal perf support like:
> >
> > -    Check Arm CoreSight trace data recording and synthesized samples
> > -    Check Arm SPE trace data recording and synthesized samples
> > +* Check Arm CoreSight trace data recording and synthesized samples
> > +* Check Arm SPE trace data recording and synthesized samples
> >
> >   Some others will actually use perf record and some test binaries that
> >   are in tests/shell/coresight and will collect traces to ensure a
> >   minimum level of functionality is met. The scripts that launch these
> >   tests are in the same directory. These will all look like:
> >
> > -    CoreSight / ASM Pure Loop
> > -    CoreSight / Memcpy 16k 10 Threads
> > -    CoreSight / Thread Loop 10 Threads - Check TID
> > -    ...
> > +* CoreSight / ASM Pure Loop
> > +* CoreSight / Memcpy 16k 10 Threads
> > +* CoreSight / Thread Loop 10 Threads - Check TID
> > +* etc.
> >
> >   These perf record tests will not run if the tool binaries do not exist
> >   in tests/shell/coresight/\*/ and will be skipped. If you do not have
> > @@ -108,11 +108,11 @@ CoreSight support or remove these binaries in order to not have these
> >   tests fail and have them skip instead.
> >
> >   These tests will log historical results in the current working
> > -directory (e.g. tools/perf) and will be named stats-\*.csv like:
> > +directory (e.g. tools/perf) and will be named stats-\*.csv like::
> >
> > -    stats-asm_pure_loop-out.csv
> > -    stats-memcpy_thread-16k_10.csv
> > -    ...
> > +   stats-asm_pure_loop-out.csv
> > +   stats-memcpy_thread-16k_10.csv
> > +   ...
> >
> >   These statistic files log some aspects of the AUX data sections in
> >   the perf data output counting some numbers of certain encodings (a
> > @@ -137,23 +137,23 @@ is inside.
> >
> >   You can change where these csv logs are stored by setting the
> >   PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
> > -test like:
> > +test like::
> >
> > -    export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
> > -    perf test
> > +   export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
> > +   perf test
> >
> >   They will also store resulting perf output data in the current
> > -directory for later inspection like:
> > +directory for later inspection like::
> >
> > -    perf-asm_pure_loop-out.data
> > -    perf-memcpy_thread-16k_10.data
> > -    ...
> > +   perf-asm_pure_loop-out.data
> > +   perf-memcpy_thread-16k_10.data
> > +   ...
> >
> >   You can alter where the perf data files are stored by setting the
> > -PERF_TEST_CORESIGHT_DATADIR environment variable such as:
> > +PERF_TEST_CORESIGHT_DATADIR environment variable such as::
> >
> > -    PERF_TEST_CORESIGHT_DATADIR=/var/tmp
> > -    perf test
> > +   PERF_TEST_CORESIGHT_DATADIR=/var/tmp
> > +   perf test
> >
> >   You may wish to set these above environment variables if you whish to
> >   keep the output of tests outside of the current working directory for
> > diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
> > index f94743a4d161f2..c117fc50a2a956 100644
> > --- a/tools/perf/Documentation/arm-coresight.txt
> > +++ b/tools/perf/Documentation/arm-coresight.txt
> > @@ -1,5 +1,5 @@
> >   Arm CoreSight Support
> >   =====================
> >
> > -Please see docuentation in the central CoreSight location in the
> > -kernel tree under Documentation/trace/coresight
> > +For full documentation, see Documentation/trace/coresight/coresight-perf.rst
> > +in the kernel tree.
> >
> > ---- >8 ----
> >
> > Note: since this is documentation patch, don't forget to Cc linux-doc list.
> > I add it for you.
>
> I'll split this out to a separate stand-alone patch from this series. I
> put docs in the place I was told to by the perf coresight maintainers,
> but that now complicates everyone to send the patch series to and so
> only the docs are relevant to the doc mailing list, so I'll split it off.

Please keep the documentation with this patch set - both for
continuity sake and to make sure that the docs are available to the
reviewers.

The easiest way to ensure that just this patch goes to the doc list is to put a
Cc: linux-doc@vger.kernel.org
above your Signed-off-by in the patch description.

git send-email will then automatically read the Cc: list for the patch
and send to the doc list.

Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
