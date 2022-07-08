Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753EB56B742
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiGHK2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiGHK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:27:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE677248E0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:27:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t24so35656434lfr.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbsF5PTAq6FOA3zKl5faJoW6Yw9lknHZbslw9NFOih4=;
        b=WBqc2lbXy7wamNrW8VgelKVhbLDu0hlvzTRL3zXa6IdalgE26IQG65MM1tGbynRAFk
         LReuauOhG3rnKfwocWTcxbpGCGf0agmvECChYSrc0sL7b+jv5C2lj+jNrnDvi7Qp3azF
         YZSM69nX2yO0dXKZKsGY1AJEytjKl7yBP4qho794UZh1d529B8IQr+hjr/AycB36T8dn
         qLcMAPv2igeIfj/YdLJi8miZxJriw9PG7ekLsTDeafjH7yQaNFRovR6446xmkvzDjpjd
         z0PfdYRyx5whOdWN7vp4xskYi0U+8ujciYNdfNSWkcntx8dV17ft+0JF+VYXmmPggwi6
         nnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbsF5PTAq6FOA3zKl5faJoW6Yw9lknHZbslw9NFOih4=;
        b=dwwJQprEZMUAGjtddrTTS67xyIlyP4pljupULqh7MbFQEZ77NN3oqewleBplGF5fkf
         3r4gJaxJHL6x19XZoj/PY9/SNp2A5f12RMnNceJBs2HWP5yX4cDKskKmAGZBWmzUYup3
         CkVJPnefpSFEVnmjCaAj0SKdCsw7qh4TTtwICtlSZ5r9/L9zJLwts24PTO61+X2cVZOP
         MU1690RznrgNNdSFn4XjuTJ0keyp3dJpn0hMUXIFrzYagaTMiLyZYMsvew1pHxKJFhv8
         a/J3RUAp+7FUzv/KwIiIpi54hA5UoAPxBHwj5dqVdn/dE/JYjvtbR4eTkCxaa4EZggDZ
         wQxw==
X-Gm-Message-State: AJIora8u4UGaObdzTgcJRZrJd32a4yJyirJrGjJ65NktkiUgZU8pjTCi
        KFzxjzWS26JYYzfQjt3QdNOrVW9g6MEX01+VaP8Pbg==
X-Google-Smtp-Source: AGRyM1vsTR6kwCBMil+gK4+M+5pKdbW5Sir/wIxDrF7VNoCtl3ku7sjgDoUJMhOQTTOwJxKESuVfdL3Dk2+niZUqdSQ=
X-Received: by 2002:a05:6512:10c3:b0:47f:a97e:35c with SMTP id
 k3-20020a05651210c300b0047fa97e035cmr1911173lfg.417.1657276073129; Fri, 08
 Jul 2022 03:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
 <20220701120804.3226396-11-carsten.haitzler@foss.arm.com> <a14e7015-7446-8cb3-612c-00dcb469c939@arm.com>
 <e55094af-557e-8044-fc14-00189bd392a2@foss.arm.com>
In-Reply-To: <e55094af-557e-8044-fc14-00189bd392a2@foss.arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 8 Jul 2022 11:27:42 +0100
Message-ID: <CAJ9a7VjQ4B8yudKqHZ_f8pGRGcM9t=6M0zfQK9-LmyTf4pZbZw@mail.gmail.com>
Subject: Re: [PATCH 10/14] perf test: Add thread loop test shell scripts
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Jul 2022 at 10:22, Carsten Haitzler
<carsten.haitzler@foss.arm.com> wrote:
>
>
>
> On 7/5/22 14:53, James Clark wrote:
> >
> >
> > On 01/07/2022 13:07, carsten.haitzler@foss.arm.com wrote:
> >> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> >>
> >> Add a script to drive the thread loop test that gathers data so
> >> it passes a minimum bar (in this case do we get any perf context data
> >> for every thread).
> >>
> >> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> >
> > Hi Carsten,
> >
> > I checked this on N1SDP and I get failures in both threads tests. This is
> > because it's looking for "CID=..." when in my output threads are shown as
> > "VMID=...":
> >
> >      Idx:628048; ID:10;       I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000AAAAE3BF0B18; Ctxt: AArch64,EL0, NS; VMID=0xa588c;
> >
> > I think with a change to the grep it should work.
>
> Errrr... I get no VMID= ... it's all
>
> Idx:563008; ID:12;      I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64
> bit, IS0.; Addr=0x0000AAAAE4B00A60; Ctxt: AArch64,EL0, NS; CID=0x00004aff;
>
> are you using containers or something? because:
>
>              if(context.updated_c)
>              {
>                  oss << "CID=0x" << std::hex << std::setfill('0') <<
> std::setw(8) << context.ctxtID << "; ";
>              }
>              if(context.updated_v)
>              {
>                  oss << "VMID=0x" << std::hex << std::setfill('0') <<
> std::setw(4) << context.VMID << "; ";
>              }
>
> I'm running without any containers etc. - bare metal. Haven't bothered
> with any VM stuff.
>
> In OpenOCD the CID should be the the pid/thread id. It seems to not be
> the same thing as VMID. I haven't traced this beyond here as to exactly
> what this represents though my first reaction is "This is extra VM info
> and not the PID/TID being looked for". OpenOCD is full of tests with log
> dumps that produce CID and VMID:
>
> Idx:1676; ID:10;        I_ADDR_CTXT_L_64IS0 : Address & Context, Long,
> 64 bit, IS0.; Addr=0xFFFFFFC000096A00; Ctxt: AArch64,EL1, NS;
> CID=0x00000000; VMID=0x0000;
>
> A quick git grep CID= in OpenCD will show them all. My understanding is
> CID is the thread/process ID and thus the test/check "Do we get reported
> data from all threads? - anything?".
>
> I don't think using VMID is right. The fact you are missing a CID is an
> issue though...
>

The register used for linux TID trace is dependent on the EL of the kernel.
EL1 => CONTEXT_IDR_EL1
EL2 => CONTEXT_IDR_EL2.

By design, the trace hardware traces CONTEXT_IDR_EL2 as the VMID packet.

So, depending on your kernel build, TID can validly be traced as CID or VMID

Regards

Mike

> > Thanks
> > James
> >
> >> ---
> >>   .../coresight/thread_loop_check_tid_10.sh     | 19 +++++++++++++++++++
> >>   .../coresight/thread_loop_check_tid_2.sh      | 19 +++++++++++++++++++
> >>   2 files changed, 38 insertions(+)
> >>   create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
> >>   create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
> >>
> >> diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
> >> new file mode 100755
> >> index 000000000000..7c13636fc778
> >> --- /dev/null
> >> +++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
> >> @@ -0,0 +1,19 @@
> >> +#!/bin/sh -e
> >> +# CoreSight / Thread Loop 10 Threads - Check TID
> >> +
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> >> +
> >> +TEST="thread_loop"
> >> +. $(dirname $0)/../lib/coresight.sh
> >> +ARGS="10 1"
> >> +DATV="check-tid-10th"
> >> +DATA="$DATD/perf-$TEST-$DATV.data"
> >> +STDO="$DATD/perf-$TEST-$DATV.stdout"
> >> +
> >> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
> >> +
> >> +perf_dump_aux_tid_verify "$DATA" "$STDO"
> >> +
> >> +err=$?
> >> +exit $err
> >> diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
> >> new file mode 100755
> >> index 000000000000..a067145af43c
> >> --- /dev/null
> >> +++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
> >> @@ -0,0 +1,19 @@
> >> +#!/bin/sh -e
> >> +# CoreSight / Thread Loop 2 Threads - Check TID
> >> +
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> >> +
> >> +TEST="thread_loop"
> >> +. $(dirname $0)/../lib/coresight.sh
> >> +ARGS="2 20"
> >> +DATV="check-tid-2th"
> >> +DATA="$DATD/perf-$TEST-$DATV.data"
> >> +STDO="$DATD/perf-$TEST-$DATV.stdout"
> >> +
> >> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
> >> +
> >> +perf_dump_aux_tid_verify "$DATA" "$STDO"
> >> +
> >> +err=$?
> >> +exit $err



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
