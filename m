Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637AF59191C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 09:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiHMHEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 03:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237399AbiHMHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 03:04:12 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B862BB03
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:04:10 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 38so1089539uau.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JkpTd2lx/Y7WIS3TAJAROUSBlo87wCC8feGuimexJrU=;
        b=iBq9V+8jyPDvnsS6vDhVT3IXGpCn1lPIa10ZJQORFgVkAh2frhQoVcDNGRB7iszfOF
         GRMnX3drN/zleyVRCmpT0OZPLbTC8VfYjXec7/EbiceGDYpCyrvMSFxuly7VjfqojhmO
         /QDokrp4VoObEEkYTWH4x68bDP/M6CUO2doxXY1mCqerGwJ1hkawaIKLC7OoGU+2t9Ih
         iyi/QBRaqJFUpfu9Y0tJTpskoktlV28y2pXSu4tFpeyqXF3gUsXCoHBHqCG0x+1gKJRx
         9NkBs8wcGENBPkV+qy5WJWhGEEASyilzGphNhtJ/U14bhWbgdfghkDynZZbbfcv3SyHc
         BAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JkpTd2lx/Y7WIS3TAJAROUSBlo87wCC8feGuimexJrU=;
        b=PgTTqWuO2xWmQugfdOmfFdYR7Z4eBOmpjdzSo9uxl5ydRGg5CL6Vit8ailI+/dAXj8
         LUpro0wgF6yYJCJorAIr25ajMLa8KYoUcMVFgieST3qLEHKIhx0NIr3Gt/B4bvDEEml6
         PsV+R+HN9LZAI6ulNanoki4skpnan8HCo5NX7qyMVo2xN6+sUKr0t2PKh26j96BKduvK
         K6+LXAbiyNS+s/NhmmL8uOedle5QWqH+JzuLNqPGyzuyIRxxgpSb4X4WNml2a3kZ/FmO
         AuBRjUhhbPvuFPdXQ7RBbm5U6xtM4rB+5U4Fmd9KONUg/yLffxdVM6p0uukf0MGfvG9h
         niyA==
X-Gm-Message-State: ACgBeo2OFgUULgxSt8tRcnwgL4XbGzZnjPVmMPBlPPI9AtuAfYKdtADW
        plxFULsGI0g+vXl4uZ9kNyN2OqwtyBmLpSClXxLJbg==
X-Google-Smtp-Source: AA6agR41YD78B4nu4AR0tYVIBqSQG9S7hcXRV4eYHlV+7JUByAnffHbhVyk+rl8KL0U+a6vZaWfjp+MODklq+hln5L4=
X-Received: by 2002:ab0:2359:0:b0:387:2dff:87d5 with SMTP id
 h25-20020ab02359000000b003872dff87d5mr3299629uao.104.1660374249998; Sat, 13
 Aug 2022 00:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220813042055.136832-1-tales.aparecida@gmail.com> <20220813042055.136832-2-tales.aparecida@gmail.com>
In-Reply-To: <20220813042055.136832-2-tales.aparecida@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 13 Aug 2022 15:03:58 +0800
Message-ID: <CABVgOS=WKEos8XH3VAXUiUmcvABiy07jYFZN9nL95XCiARuvqw@mail.gmail.com>
Subject: Re: [PATCH 1/4] Documentation: kunit: fix trivial typo
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 12:21 PM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Missing closing block-quote
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---

This is fine. A couple of minor nitpicks:
1. A slightly more descriptive commit title would be nice (e.g. "fix
missing quote in run_wrapper")
2. The whole --jobs=`nproc --all` bit shouldn't be necessary anymore,
thanks to: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad659ccb5412874c6a89d3588cb18857c00e9d0f

Neither of those seem worth sending another version out for, but may
be worth keeping in mind in the future.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


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
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220813042055.136832-2-tales.aparecida%40gmail.com.
