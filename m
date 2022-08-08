Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288858CF9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbiHHVWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHVWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:22:35 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011321834C;
        Mon,  8 Aug 2022 14:22:33 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id p22-20020a9d6956000000b00636a088b2aeso7302256oto.9;
        Mon, 08 Aug 2022 14:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2dB/oWE41ZJoWC2gckJ+2Ap55kUOeESrqQysvusxcqE=;
        b=QcpD0L830z/1w8+FStFnP87paauOFNJwJznBqJyei6aDn1F1C7XMNmnqWdKrWx6nSL
         IFM0lYymV03qvHq0Ly1DlK3V0a2Xm1EhYY49ucQnLaHSRZYFli+hfBPMVnTzhbw60WaV
         hFnUzqHTh3Trtk3oId6Iw8CDpceUTQltTyVtreDXPxv5XC7MHoAzQE59MPgXcQExSnMJ
         IE1He/ghPKvJfXih/4EI5kCvDLs2TRsI4403xlIkBxe1q13YirnXHhVQWfpAAaXR1m9h
         HKj9w4V2bfsUtLVmk8cuqmOlGwlW/zzWGd3BUUpgXsb1KrhXn2jvr8DHXz7vOYvZ027+
         vxaA==
X-Gm-Message-State: ACgBeo3OZs5fNwl9h10W9HvVZZ3DNXG1/YDfrI52xMfuuDlE3cqFwKEe
        fA4z2j3E2V0Mw4SaPSSgGt8APUSLf0ghX6UKhCg=
X-Google-Smtp-Source: AA6agR51c7YU1mfiHlZXfXJvCCfMUOK65nmX34uBneWzZxoN8c11sqBGleUTGaoSUZxlTxPspoyA9sFGpVP5mMSDmYA=
X-Received: by 2002:a05:6830:6388:b0:61c:80a9:d5b6 with SMTP id
 ch8-20020a056830638800b0061c80a9d5b6mr7658767otb.124.1659993753257; Mon, 08
 Aug 2022 14:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220808092408.107399-1-yangjihong1@huawei.com>
In-Reply-To: <20220808092408.107399-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 8 Aug 2022 14:22:22 -0700
Message-ID: <CAM9d7cj3HcijAz_C1Y-u87H4XXeR4zW2TFQOxhmSjMuTqHQAzA@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf kvm/sched: Use strstarts instead of strncmp to
 match subcommands
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 8, 2022 at 2:27 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Yang Jihong (2):
>   perf kvm: Fix subcommand matching error
>   perf sched latency: Fix subcommand matching error

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/builtin-kvm.c   | 8 ++++----
>  tools/perf/builtin-sched.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --
> 2.30.GIT
>
