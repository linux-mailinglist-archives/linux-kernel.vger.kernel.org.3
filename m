Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5243E5266EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382359AbiEMQUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382351AbiEMQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:20:39 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB61E0E6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:20:37 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id b11so2112398ilr.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vj6iHTpwnNPNthSpf+UlINnz/zwz5+cgtl0jb+MR6I=;
        b=x2psA05mi/gdg5bjz0mRU+Jqgyy7B+cep7kkQYHg4uH06mtKQQpHIffqPat5nScsWF
         KyrYWsC/TRYrGZY9KM+B51iAkJ/onNu+Xq625Mz3bemp2RkIcR5o66DpWSUu3B2yQ1R3
         xTsvMHNSDzaF0gSMEaE1kXGUDac5ii1X2MLZau9ScOYBJ5Y4sNThLINSt71JnZfdSwq1
         jg2HQ28VQCtLLA+co/NU3OweisrjgfwmcdX60fAyscctL0I4O0alKB47yYigXtaPMSCA
         q00frppwKP02a3miq4ZAVN8giJiYv2MQ0K7VmeWd4oXtnm4o5DW3gZQJnzFC4xZcdJBw
         3G5Q==
X-Gm-Message-State: AOAM532vl3syby6UQeJZSZopAygzcXU7lkhNyesHd7lVYrcKflyRXcGj
        vk2RiLL084Qm8IxoPePe9uc0u9mAdWCeLtNifcE=
X-Google-Smtp-Source: ABdhPJzQn8LNZ3bHLkysnnLIOUWh5U/UhoiXSGG1bW8gc6cHavnkm/ZBJvbYLkih0rpBif12D5E53kRlE34q6eu1yOY=
X-Received: by 2002:a05:6e02:1788:b0:2cf:947d:bd93 with SMTP id
 y8-20020a056e02178800b002cf947dbd93mr2892810ilu.302.1652458837116; Fri, 13
 May 2022 09:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143439.26104-1-pauld@redhat.com> <f819f288-7f67-77d1-5d92-f0a5545c1c48@redhat.com>
In-Reply-To: <f819f288-7f67-77d1-5d92-f0a5545c1c48@redhat.com>
From:   Tejun Heo <tj@kernel.org>
Date:   Fri, 13 May 2022 06:20:25 -1000
Message-ID: <CAOS58YNYoFQy9gv9qiUX-PDkhEJ0CAwKeNibUghrT68vSSckYQ@mail.gmail.com>
Subject: Re: [PATCH] kselftest/cgroup: fix test_stress.sh to use OUTPUT dir
To:     Waiman Long <longman@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you send a quick patch?

Thanks.

On Fri, May 13, 2022 at 6:19 AM Waiman Long <longman@redhat.com> wrote:
>
>
> On 5/12/22 10:34, Phil Auld wrote:
> > Running cgroup kselftest with O= fails to run the with_stress test due
> > to hardcoded ./test_core. Find test_core binary using the OUTPUT directory.
> >
> > Fixes: 1a99fcc035fb ("selftests: cgroup: Run test_core under interfering stress")
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> >   tools/testing/selftests/cgroup/test_stress.sh | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
> > index 15d9d5896394..109c044f715f 100755
> > --- a/tools/testing/selftests/cgroup/test_stress.sh
> > +++ b/tools/testing/selftests/cgroup/test_stress.sh
> > @@ -1,4 +1,4 @@
> >   #!/bin/bash
> >   # SPDX-License-Identifier: GPL-2.0
> >
> > -./with_stress.sh -s subsys -s fork ./test_core
> > +./with_stress.sh -s subsys -s fork ${OUTPUT}/test_core
>
>
> I would suggest using "${OUTPUT:-.}" as the variable OUTPUT may not be
> defined if test_stress.sh is run interactively.
>
> Cheers,
> Longman
>


-- 
tejun
