Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473AA59542B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiHPHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiHPHzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:55:07 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F18B6D15;
        Mon, 15 Aug 2022 22:08:11 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10e6bdbe218so10500145fac.10;
        Mon, 15 Aug 2022 22:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=exk/owatbaybmyXCHtqcxUg6N21UBOdOV3/tLRc9jrc=;
        b=twQ1FInlr5g0PcutYTUXKtvjENH/TwcCHsnnkoV/c23gXTJyzMOxTKxK+Fpqtf7lSe
         4CUYAnOZn+88TCvIzy3RttIDwLSqj7mNnjESl6twXiSDxSX6DtEY4bnzW+dXccql+T1W
         F0K8YC8pQ1Zo8UfRi2bxPllCIDHXoZe7hr7w9s8ezzQh43tZTJUWg/dmCEpn48wWdNPg
         CqCOZ1rRoWeDwcCmLcRHPGuWkVn/jz8WwObUM9HJ5zJN9h8eckfCfNbD+z6QDA9Shkeo
         3hiVqMxKjNyOkSmH2lJVPL9BlLT2xZnkcys4+tkWXMjySO29sLg2FmhiMR4ao7mvVmOg
         cZRw==
X-Gm-Message-State: ACgBeo2CFDi+7FD2noebxSzHvPqLY+N/FeTc1T2U8ucZYEBLE+t8hwdS
        dQfhu0MGSMP6tcn23AilZ4MeK2PMMrCTsifusQEZzfdA
X-Google-Smtp-Source: AA6agR50A56F0op9y/rn5UtyGi5DkxXsFGUxcDI0OdhGD5g21+T7lp31gMbsCyFU4fnQRJwOtsqBrF95W181Ber5DZQ=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr8307379oab.92.1660626490393; Mon, 15
 Aug 2022 22:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com> <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
In-Reply-To: <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 15 Aug 2022 22:07:59 -0700
Message-ID: <CAM9d7cgWXP2s25XUM90=b5Eaojutxi=LobkqrUkRoF5gek4DPQ@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Ian and Adrian,

On Mon, Aug 15, 2022 at 7:56 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Hi
> >
> > I notice man pages on man7.org e.g.
> >
> >         https://www.man7.org/linux/man-pages/man1/perf.1.html
> >
> > do not get updated every release, and I wondered if the perf tools
> > man pages should also be under:
> >
> >         https://docs.kernel.org/tools/index.html
> >
> > Thoughts?
>
> Sounds good to me. I'm assuming it would be some kind of build step
> that would take the man pages and add them to what linux-doc needs?

I guess it's the RST format.  I'm not sure if there's a converter
from asciidoc to RST.  Anyway having the perf man pages in the
tools section looks good.

>
> Fwiw, there has been some effort to try to improve the wiki:
> https://perf.wiki.kernel.org/index.php/Main_Page
> For example, the useful links are now broken apart and have more
> links, there is a work-in-progress glossary. Perhaps there can be some
> guidance on what to capture and where.

Thanks for working on this.  I really need to take a look...

Thanks,
Namhyung
