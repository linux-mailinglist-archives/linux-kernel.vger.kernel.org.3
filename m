Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA2596EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbiHQNCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiHQNCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:02:39 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C1D50074
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:02:38 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 67so13065783vsv.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JEpY0RlSeNKZEJVlprf831gSjjfs90GuJUkUulGJpXE=;
        b=HhwjHoELRn0n2dtUiR/VcsdJqCy/a2xBD+R5nenQKQWxOlIESLF9n0qlR5EOjKBR3v
         b+TbLF79FlfjMmtuS09ym0DOoszsDhtR5AJQcy0rT0UdaSru5MqiSn2wcvCBzWrh4wTr
         dTDdABjI278o6rNHK4MvpfgEAKNJW8qfUzlPn5PY7MkJKImp9xbxpRs6ziWQYKK0j6/M
         JDW+ebvCOExqVRUDf7d3riYGFI2ulJOk+J/LN/ooYQdHGgFWZWLSLb2UyBRiMTjOVKsX
         MipcEUK8kn7R/tyKniGxuOk2MGg83iFMqXy+7mP/t30zVUu6pcJmhib6FWk+qAqYW/Gz
         ompw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JEpY0RlSeNKZEJVlprf831gSjjfs90GuJUkUulGJpXE=;
        b=N/PLil1DHyDGIiyMFJxYu0c+wl/i/ctrQtt1yy/KN0GDkRx8rqGJ1z7KEVHP/Dj/3r
         SspBH5MQk8wapfD2ci3xHApIo+ho7K/8DTrLKnpeZO1kPSsr05/Mb+k7aKsHZR7Ww5GE
         R67+A77AchwITLRY4JfOwgvqcFocNgp36qoxZoqLZAMQhN7x80rqCZjbDDsRk0KN8the
         4rMRvLZ9oonxgLOoqa8HgJgFbrTTheUJgsSfkrNS7r7Qr82I/gc15QSB2kJV/QTmS5Xa
         lAZAf0rae82jhPJwtGs/pM7MYECq0m8ich9Hn1ge9xK4V3uYxG3L7diLZ/Qju9gEWZZ4
         VTAQ==
X-Gm-Message-State: ACgBeo18fDCblj4BAL53TsB7bCH8rEbxs+iKGaTTTPFFB2bcNBjCltHu
        b+mdvD6X+npL2fEAbi+OWFWQHNA8hbhiZJjXEbmuSw==
X-Google-Smtp-Source: AA6agR5xZEq+JYJ8NeDjjkQ6b/O3OdnvHus5amnMCRh5iTGg+w3myZ+kESjCxE+ExhG3WsA3fIVF4kR6TVhJZ1Mn138=
X-Received: by 2002:a05:6102:ec7:b0:388:d2a2:41c5 with SMTP id
 m7-20020a0561020ec700b00388d2a241c5mr10069927vst.41.1660741357054; Wed, 17
 Aug 2022 06:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com> <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com>
In-Reply-To: <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 17 Aug 2022 06:02:25 -0700
Message-ID: <CAP-5=fUq4N+X+3VMsT=he3Q9_4qHKkqxdPDcMdDE=_3qdV9aCg@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 1:55 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 15/08/22 17:56, Ian Rogers wrote:
> > On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Hi
> >>
> >> I notice man pages on man7.org e.g.
> >>
> >>         https://www.man7.org/linux/man-pages/man1/perf.1.html
> >>
> >> do not get updated every release, and I wondered if the perf tools
> >> man pages should also be under:
> >>
> >>         https://docs.kernel.org/tools/index.html
> >>
> >> Thoughts?
> >
> > Sounds good to me. I'm assuming it would be some kind of build step
> > that would take the man pages and add them to what linux-doc needs?
> >
> > Fwiw, there has been some effort to try to improve the wiki:
> > https://perf.wiki.kernel.org/index.php/Main_Page
> > For example, the useful links are now broken apart and have more
> > links, there is a work-in-progress glossary. Perhaps there can be some
> > guidance on what to capture and where.
>
> Speaking of the wiki, anyone know how to change the
> "Set $wgLogo to the URL path to your own logo image." image?

+1000

Someone at RedHat knows :-)

Ian
