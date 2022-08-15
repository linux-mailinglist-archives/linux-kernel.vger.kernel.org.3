Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBB593115
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiHOO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiHOO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:56:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7B20F51
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:56:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b4so6241324wrn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SNEwN3qf4cTPak4P3uJkYoBDFHuw13WWi+vOH5Zd4Ac=;
        b=c2TeqN6ajJt/R05lUrbaU/cW8aitjSNIIkCewNDl9j/5olXm2dAggQ54HiQFhIB8xS
         1ysjI8wb6P7OKswHBtc5qRHgXGxD5U1N3Lq2ahjJYLVjKcVtLLiadcyNH/srISGGBO8+
         3BCm9zqYR3CXLNeOGkg6aeBVRQ3Srveh6jLH0jNLmUbfxcsR5AizhVzcoCQdKYKcBCt5
         Ir9452ZyBgHg8qj0k4zMJ1Bk2GZsxUT8+XHyYwZWz7Ia5CwCyQ1bjkDYzOOZ0bm4LtaS
         aPBFWV3AKAmFuEJxPj4JSKanWag4vyc3FqbGTpPICfePrxdbII1Xv/KNA+6DN5wMT7Px
         sSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SNEwN3qf4cTPak4P3uJkYoBDFHuw13WWi+vOH5Zd4Ac=;
        b=lqz8FhKRkGsv7L3OH3oSFSCy0kJ6lcccBI2Zi0tOsxEVf3ezURgWk/RNVC4gna10ac
         Cmw5ptUYS0vdVFOX36EzJ2kxsu4kdvpGBtiKvNkDqL4vsNfeF7JH/IxAdchStslLlrPP
         nWp4wXky9K6/HmX3oZUm7waFO3L2Bm2gM+25PAx/vPfM0W5/qBIse5ncyGCxeMAAIr5L
         BuxaEOCpGmx3m4bWEP0yWrQnawXRAUxzNNomYKZiHG9hQhQ1+f8yhYxGhfXw7pQbNJOm
         Yx6wjVt6i1CdnaSjSfTThLFiQKdcvH/Cmi9x0KUqePxJxWhdZj+XcC2KvoaC6zFWWizZ
         0vyA==
X-Gm-Message-State: ACgBeo0tw5C87IroXeJWlAuLkDz00CfPZ6cmjJ9BKz+Uf00UeKUNBOU0
        k1hUl/Mw0bXRUdlNvTi8h+zW5TwqZlE0sYQKdEI3aw==
X-Google-Smtp-Source: AA6agR4wiUckDTDALcDEn5Dgm86gur7YVyasP8WtZkwG8dhPc2lAvm+1sKa+ebt8tKnqTv0xrMMcQVySwm4DVH24oNU=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr8679323wri.300.1660575406510; Mon, 15
 Aug 2022 07:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
In-Reply-To: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 Aug 2022 07:56:34 -0700
Message-ID: <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> I notice man pages on man7.org e.g.
>
>         https://www.man7.org/linux/man-pages/man1/perf.1.html
>
> do not get updated every release, and I wondered if the perf tools
> man pages should also be under:
>
>         https://docs.kernel.org/tools/index.html
>
> Thoughts?

Sounds good to me. I'm assuming it would be some kind of build step
that would take the man pages and add them to what linux-doc needs?

Fwiw, there has been some effort to try to improve the wiki:
https://perf.wiki.kernel.org/index.php/Main_Page
For example, the useful links are now broken apart and have more
links, there is a work-in-progress glossary. Perhaps there can be some
guidance on what to capture and where.

Thanks,
Ian

> Regards
> Adrian
