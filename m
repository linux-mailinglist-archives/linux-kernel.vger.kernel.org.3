Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6A57C256
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiGUCgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiGUCgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:36:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680A1F2EF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:35:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv24so327371wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqmzPsRoQUtQQLCqBZaksSJCZdedraAjaKBqFxITMf0=;
        b=XwrCn5FUkCoJgYv24Y9WOPzewP9cZ+h84e8RO1ACno2pA0lyagADV+s//yvCpc5Usd
         dvxBAxOQ4PDBlTcdiRhBdN4XmsS91P2rW+wkqtSUwtMN0wk7Bjo6j2nz0AJYilAXx8Yq
         0liDzgRBePKy3qYqV6E/WaexRuEnW8hD8edEvoKjeLMxb2qbdY4MQODd0z9BhOopghrI
         ZdBmXvBDcMCDaJ32hyCEXRjYxLmni1UFskDOYxYC+/V6ykBKHOqa4hYNA9FtlmWZlyN5
         UnCpwiuyeMQ+LwyGsJtyuFRhoMsf+Rf4np+JNzY38ZGHTn6ZnKKaXCutrtAaQ8O1UjiZ
         lk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqmzPsRoQUtQQLCqBZaksSJCZdedraAjaKBqFxITMf0=;
        b=6jf8Mnl98NHjMMiaMhNXQ5ZhO0KEcsh3WrFbRxcDaYW6p1+f9gNvtMDef4BULYCV47
         iFrg/IdjiMbbxOj9/eu132A5TkOuw5PdByoTdWOTPGJYIqPHZALarOBp1c/16XZNyLVa
         CwhUcfYLkXIgtyskyDvUO8iRzQ3EfD6rbSqdLp34PFjMgDw19NxaTmlQKYrRy124c2QL
         NcUFUWmhJNJnbKrva/jAJ4X5iNAz5WdkE/cLQ2sG3uGX72N7VDQIlrl+qn/WSyWIfwQI
         WsClDTcDbUdaxfVD206efEo9EXJRJU9y2WFZoMQPueNeFGmlHO2+zQqPOMb/WqlKcWcb
         x8Tg==
X-Gm-Message-State: AJIora+iOnhrHm70Tml/B2+cpwv0GoVmvx25GjUZwam2LIwTPWtFAvkA
        ipMaqzNXI5GtJhtbiKDhFKYIG+FgNK5N2g6weplLiA==
X-Google-Smtp-Source: AGRyM1vLldRzfJBxIPk3X5buyWrLNnStBvGVL8RiAnMbD2FCnu5GVC3c/94CrP+XUiDL5BR9sPQzj0WKVynUZ8o9yg4=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr3739209wri.300.1658370958022; Wed, 20
 Jul 2022 19:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220721090500.35774b43@canb.auug.org.au>
In-Reply-To: <20220721090500.35774b43@canb.auug.org.au>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 19:35:45 -0700
Message-ID: <CAP-5=fV+Oo+__sWTgfqyVKwyr1FxYYSv9H6H72CgdQN_Jv1ZAQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the perf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 4:05 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the perf tree, today's linux-next build (native perf)
> failed like this:
>
> Traceback (most recent call last):
>   File "util/setup.py", line 31, in <module>
>     from setuptools import setup, Extension
> ImportError: No module named setuptools
>
> Caused by commit
>
>   ee87a0841aa5 ("perf python: Avoid deprecation warning on distutils")
>
> I installed python3-setuptools.

Thanks, could you give more details? Are you overriding python to be
an older version on the command line? What does "python --version" and
"python3 --version" show? Installing python3-setuptools should be what
you need, but I'm not sure why that's not working for you.

In any case. sorry for the inconvenience of this. Thanks,
Ian

> --
> Cheers,
> Stephen Rothwell
