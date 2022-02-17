Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208904B9B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiBQIeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:34:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiBQIed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:34:33 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6D25BD72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:34:19 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id l125so11543534ybl.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cc4rMQf7EbxLBLzlXV5lN5a8DRDh8qHMeBBzvLwYYRc=;
        b=nVlka0LVsB/xIOy+y+dajGvldFEaJNx4Fx+VZ39xe/wtqSXrBu6G9RkD0oaorGK/pr
         Q5zNdYb98K1RQiN4m6l48WulTSBJrzt3EwrQNftMXEbnt2krkFrpkliAA2dT/nmXHa09
         scfyI3nHYNVNEfBt8Gi3qeG4IYo0LNzO5S7G1CFHabv5hO+m0S4o3RG6wXWKTLW9MFtk
         ruNGntO3mLx1Vv1UQi79lKPG0r1S8ws5IhlhSsmNrPQSFwuFMzQ+8T9leqKOWwz1Osub
         28o6I/AJI0hbxGKi55rgkyKXcdkAPsXH5Bj+g01VxekgolwOQZLslev+XDxB7YiTDo79
         pTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc4rMQf7EbxLBLzlXV5lN5a8DRDh8qHMeBBzvLwYYRc=;
        b=t2/pFGu5G86JYlrNZA2EbRhWCH0yXavWyIyxw1XXMWAoZkdNWs0mAYeR/yjxMZML74
         jGVs5HrGWLt3gw43D5TfmK7gpWZsdC3FCYQD9xcz6DUnnEFU3BPuE85ANFD5T9Ca5DXX
         Yl47KG8AkOYLPj92v3mjPMOD8kJs0Q+5BwRCKz79pZ/xtbQYQTTerGJD4RDwwGSdnEw6
         rOSgMjLY4TIBFkZ4k0hn+XurVXoQblRiDLGlma+ItowjHJgvKmm2Oh+v7+xwKU4XycOA
         fi7okfPIlR/GXDy+uDu173XcOd12Pt1EVJueCA7/vhrNGbfQhGSzA2SQwNKdx75NTwWX
         D3kw==
X-Gm-Message-State: AOAM532xm1cZYZLTB1B1OH7nSHB4plscdLqmgokN7qHd8sNACofsxv3k
        D5sbGyPf+0MRpBSyhhCynZHn19tX95MDs5kOPYOfsw==
X-Google-Smtp-Source: ABdhPJzVFZgEWRXqN5476Uw90FS862JCIudM/72ymeg8OCLat3/sq7kCQiFXqtrXXfR8pLbsgxJ3Vn+neQ2sRA+Ewac=
X-Received: by 2002:a25:3412:0:b0:623:a267:9d18 with SMTP id
 b18-20020a253412000000b00623a2679d18mr1429754yba.236.1645086858024; Thu, 17
 Feb 2022 00:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20220217004204.99773-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220217004204.99773-1-yang.lee@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 17 Feb 2022 09:34:06 +0100
Message-ID: <CANpmjNNhbdr6gsQ-za=7mUH2etXqQ3voWncd2mg3fcdiEWWnnQ@mail.gmail.com>
Subject: Re: [PATCH -next] kernel/fork: Remove duplicated include in kernel/fork.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, ebiederm@xmission.com, eb@emlix.com,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, fenghua.yu@intel.com
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

On Thu, 17 Feb 2022 at 01:42, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix following includecheck warning:
> ./kernel/fork.c: linux/sched/mm.h is included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This looks like a reasonable fix -- but why is this "To" me? At the
very least you'd have to get the email of the original author that
added that line and perhaps the committer. Cc'd the right people.

Looks like another robot sent the exact same fix:
https://lore.kernel.org/all/20220217015348.1900270-1-deng.changcheng@zte.com.cn/

Too many robots sending the same things will be interesting...

> ---
>  kernel/fork.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 64dbfb9426fd..2bfc74c2d2e3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -97,7 +97,6 @@
>  #include <linux/scs.h>
>  #include <linux/io_uring.h>
>  #include <linux/bpf.h>
> -#include <linux/sched/mm.h>
>
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> --
> 2.20.1.7.g153144c
>
