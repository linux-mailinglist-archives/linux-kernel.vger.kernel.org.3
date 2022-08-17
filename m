Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B355969AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiHQGlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHQGlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:41:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D75B4D4C4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:41:27 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d14so17811329lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gyS63QYVOSXbJbkCMWQTHJu+HMhf9dFWV5AbgmswWB4=;
        b=DlPzpQDdQkyHxNy6Qvs+2JB1BekXQva0JhudLKDBrHIbcqN/KJVVb9QIO5bSgk4YiO
         ob9bkoN55Idu77b3pPG0B9NTrZU7NPRxTHUwKTdxWaDsoJLAvD/eay9gF/oM5nfVJ2Qo
         ioo4H/PfTDyVzhN+eCwjz1jEN08EFrGUCSpCreLG+6DGWqrBzOOE30qySvXSQFGb1Q1+
         tdtzfhSUP1Y8fwJEeCWSU2bf+pE8Xs2OFGKHFU63vj83MMc85t5+UvfGascVsoh261Ca
         wyYQxuYHwyAN50q2K4/JHBKopKKWxy9flXLhvkBeeGv9mLg+ZSf4gHRYe4SM6yyWpC8P
         uVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gyS63QYVOSXbJbkCMWQTHJu+HMhf9dFWV5AbgmswWB4=;
        b=ro4OjPV6dgUxEDCcyJwmOmNbpiV3Pw7l7rwVQLEYkVE2eJkYZ3+soSguCeeztohPTM
         F6oJmnZZUKRTCIM5VJM6/VTjJ9MUccHz0kZSOAmzel8LbIpioss2KPTveE6fj6jcz6GV
         bc0Qk6PaKe3nQWe/8fmpT8hX0U8j622H/n+2GFr/t9QPqKyM5ZluX+X47v3NFD6ILTK+
         WxhvE7QzuItzzfKIE5Ssrg09SLBZGe3A8wVhZxyq/j1pmipXHUerluJOhuve2j/E0DGv
         WkHeJ00S67gACVbFWrm7gzMnSBZ7DgvYcVGBu8jvxbym77LzNQ05jDtHPUUDM4mAkrgH
         juUw==
X-Gm-Message-State: ACgBeo2TyEIhy2hpYqtTKktnAd1sMNtPTDm2B7A7QWSIgCKcMOCjTZTi
        35Yh9Z8Ift5KBSqAFJ5qj4hm3ViUQ0rPLgukOj9AlQ==
X-Google-Smtp-Source: AA6agR7DzH0SNfTXEpTGFS6iRsNRKEgPo7aS1SYAHQNpx4oKojr45DjrvgjaSgSr/F9/wc5OUA9G51WplGI/KFJdVlA=
X-Received: by 2002:a05:6512:1190:b0:48c:bf4e:b64 with SMTP id
 g16-20020a056512119000b0048cbf4e0b64mr8659854lfr.239.1660718485398; Tue, 16
 Aug 2022 23:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220813042055.136832-1-tales.aparecida@gmail.com> <20220813042055.136832-2-tales.aparecida@gmail.com>
In-Reply-To: <20220813042055.136832-2-tales.aparecida@gmail.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Wed, 17 Aug 2022 12:11:13 +0530
Message-ID: <CAO2JNKWjX9UxsjOjEpZ5RM_yq1R2R_BE1Wg8rkt0g-tMiD_vkg@mail.gmail.com>
Subject: Re: [PATCH 1/4] Documentation: kunit: fix trivial typo
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, corbet@lwn.net,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Aug 13, 2022 at 9:51 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Missing closing block-quote
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---


Hi,
I do agree with David on a more descriptive commit message to be
addressed in future patches. Otherwise, it looks good to me.

Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

Best Regards,
Sadiya




>  Documentation/dev-tools/kunit/run_wrapper.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index cce203138fb7..db1e867820e7 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -30,7 +30,7 @@ We may want to use the following options:
>
>  .. code-block::
>
> -       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all
> +       ./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
>
>  - ``--timeout`` sets a maximum amount of time for tests to run.
>  - ``--jobs`` sets the number of threads to build the kernel.
> --
> 2.37.1
>
