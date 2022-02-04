Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC174AA40F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351174AbiBDXNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiBDXNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:13:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF4CDFB27F1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:13:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m27so30557wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 15:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfYCxFlpbvl7OujUUxXMKcam5bYyjMQ9TxZLwWilF4Y=;
        b=IjKsNTP3UmtI+YfyHZJ0qh5DSvYiShtyinPh2WOTKo2LC1R5Im2gedu5u9xfLooF4+
         UxUJXD/dy/Tl+V8My9opTUaU/uixmq5z0us3RoC7Bgbo700hMuzVj257AuS4ktrqgACR
         JE1XfixdYgbAeynvegt5gll/MPrWdf0b6BQfbhRUpIoONgo6tKgQYpiUple0FwM9IaHG
         CmD96KIrg2NPA61K7dJX0+azXzCvdQsfEjax6u2RHlHWTxFWp89xPocpS8yQG7q5+g0H
         R9WNyOY2Y6TVuu7wHZLpnid1rpTlKUJT2O6qa3lVmtqr6HEuLuR4/QDnfyR3vG9Pq8nW
         THtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfYCxFlpbvl7OujUUxXMKcam5bYyjMQ9TxZLwWilF4Y=;
        b=V8Iefwilny0+lR1MK2SCPmk2HOZmchteDJBBor4v9TrpkQ94GFEhEz2TW1qAHpT24x
         W5LjV+RqUoudr69qOprvcF+euAqgt9b/nk0khsSiny/+fKq9Kko54Mpl6T/LoFq3AL1P
         2JdfS5ImgGoAyotI0zwKvg/DqoYS98RnvT+OFWQLuEqzg++iaOPO/BHP/O80pWk18rWH
         c2mxzCkLwqtigz4KmKgnbsNM3mUHE6k2EryY8uoQ2YjuSaKk9IO4l1qmnvFNLzGOcBJE
         ByLoljqfxtT9eZ57HFPyxkR2+7NGROYbPyrUqB0wvvWBB+NlDlf41N6y2+sMbxEza0L6
         cySg==
X-Gm-Message-State: AOAM530645YWnSFQQAr/2Z3Oorv2w18ea80Qh91AsSasZX0zdwgTGDzt
        cx/QkpGCjRTHtUjmREn6a+sJgBiJKEoM9z8lOZabdg==
X-Google-Smtp-Source: ABdhPJzL6D+TJwXa5HDo4f0yCGthyil6w59QwryxQD1ifMJhEDqjpOIWu7afVuh86c0pKEcjxS8nNWPb2G3HwFNPOes=
X-Received: by 2002:a05:6000:1b88:: with SMTP id r8mr916267wru.447.1644016395758;
 Fri, 04 Feb 2022 15:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20220204203248.2981902-1-frowand.list@gmail.com>
In-Reply-To: <20220204203248.2981902-1-frowand.list@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 5 Feb 2022 07:13:04 +0800
Message-ID: <CABVgOS=JUxV6PRUZvTQhisSP+p34+K9Z6yT7HkXu6qeqtak1tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: dev-tools: clarify KTAP specification wording
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Rae Moar <rmoar@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Feb 5, 2022 at 4:32 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Clarify some confusing phrasing.

Thanks for this! A few comments below:

>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>
> One item that may result in bikeshedding is that I added the spec
> version to the title line.

This is fine by me.

>
>  Documentation/dev-tools/ktap.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
> index 878530cb9c27..3b7a26816930 100644
> --- a/Documentation/dev-tools/ktap.rst
> +++ b/Documentation/dev-tools/ktap.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0
>
> -========================================
> -The Kernel Test Anything Protocol (KTAP)
> -========================================
> +===================================================
> +The Kernel Test Anything Protocol (KTAP), version 1
> +===================================================
>
>  TAP, or the Test Anything Protocol is a format for specifying test results used
>  by a number of projects. It's website and specification are found at this `link
> @@ -186,7 +186,7 @@ starting with another KTAP version line and test plan, and end with the overall
>  result. If one of the subtests fail, for example, the parent test should also
>  fail.
>
> -Additionally, all result lines in a subtest should be indented. One level of
> +Additionally, all lines in a subtest should be indented. One level of

The original reason for this is to accommodate "unknown" lines which
were not generated by the test itself (e.g, a KASAN report or BUG or
something). These are awkward, as sometimes they're a useful thing to
have as part of the test result, and sometimes they're unrelated spam.
(Additionally, I think kselftest will indent these, as it indents the
full results in a separate pass afterwards, but KUnit won't, as the
level of nesting is done during printing.)

Personally, I'd rather leave this as is, or perhaps call out "unknown"
lines explicitly, e.g:
Additionally, all lines in a subtest (except for 'unknown' lines)
should be indented...

Thoughts?

>  indentation is two spaces: "  ". The indentation should begin at the version
>  line and should end before the parent test's result line.
>
> @@ -225,8 +225,8 @@ Major differences between TAP and KTAP
>  --------------------------------------
>
>  Note the major differences between the TAP and KTAP specification:
> -- yaml and json are not recommended in diagnostic messages
> -- TODO directive not recognized
> +- yaml and json are not recommended in KTAP diagnostic messages
> +- TODO directive not recognized in KTAP
>  - KTAP allows for an arbitrary number of tests to be nested
>

Looks good here, cheers.


>  The TAP14 specification does permit nested tests, but instead of using another
> --
> Frank Rowand <frank.rowand@sony.com>
>
