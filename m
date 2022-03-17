Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CB74DBD65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbiCQDL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiCQDL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:11:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2504221252
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:10:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t11so5539417wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DK6P0vsqvqxWi0Zvgtd3pmUt6OtvktIwMYnSOV1EMeo=;
        b=bGaZY09cU0XgGRfnDAVp2vOIGStTcryrqsMhU1TyKAgsYNcozH0dDGXzJQkE3P8/V1
         fqSgsFkHSHaAqaD8VkhjnIeVx3Hnmm8bJNBvq8RHnhPL5kobiViDWhMABBPLyzGjIwsa
         votXUrc/9/zhJeW+eXmCxVs0NqRhONq4iIDuWTqwxcwyReIXtd6TNxaUqNqdB6r9fhaU
         Azp6hPioSDEsJgu0bwcANwsBprV4XCwyGaFK0xILbojy+qsn/zKyk1KWGDY3YYRgx4sV
         276gCshT/PeMu9M3DmUbmobKrjOWsbLTXIH17NHmEk/snwPGckve5TMP+j7MF7qfS+8Q
         9zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DK6P0vsqvqxWi0Zvgtd3pmUt6OtvktIwMYnSOV1EMeo=;
        b=5wQ2Ig94rvDlkkVDUdc5IdNLw5BbrodqXKvP3Y3RokwW5nIPKZ/TmKTfPQ3qO0g4bG
         peuWt3GUmSy4kn3g/YiLK47KfF3Byy7BKS5LjiLyTFml1EywmELEhmSLjpD6+9X/Pw5y
         5tXsAXkci/qHjdOrgmr0ybWayu56lzi7gHeslvaXbfB4olv51vykcSldRH5XVo8m7BkV
         D8EpwEAvmw0mJX8kXEki7qKSjFV5bTUqxCRBokoauV5zGzWIQUNQ6kdtBLKir3EXlhdu
         4Tr9o4tVTmsYCwOi10Ac20vx/vArtOgsrsU2a035R8SaSPtHBEbcAo5G0ozC9Iqfv/0K
         Yt2w==
X-Gm-Message-State: AOAM533/e59u3EQTB1SMSqlUrkmsjnsSgkTsg6ao8tO09J+f7bCYqV3l
        AyOsQ7giodcXzOfzxy8hDQKCLHSJ1QevSB0tdSkcUQ==
X-Google-Smtp-Source: ABdhPJwc4MP3hf5ky2/ukJUnLS79rR1XwMXn+/aci0lvkPWmm2yQmgLAbWf5gNVX+WklAX31SZt7g+RxSvS2R0fRPos=
X-Received: by 2002:a5d:6c68:0:b0:203:691f:b95b with SMTP id
 r8-20020a5d6c68000000b00203691fb95bmr2127564wrz.375.1647486610606; Wed, 16
 Mar 2022 20:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232212.52820-1-colin.i.king@gmail.com>
In-Reply-To: <20220316232212.52820-1-colin.i.king@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Mar 2022 20:09:58 -0700
Message-ID: <CAP-5=fXbGWec6RVoEhhR4YnCSBOA5iU--_fOA6_+=375wm3SQA@mail.gmail.com>
Subject: Re: [PATCH] perf header: Fix spelling mistake "could't" -> "couldn't"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 16, 2022 at 4:22 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a pr_debug2 message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 6da12e522edc..4a44a0740f43 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1335,7 +1335,7 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
>
>         dir = opendir(path);
>         if (!dir) {
> -               pr_debug2("%s: could't read %s, does this arch have topology information?\n",
> +               pr_debug2("%s: couldn't read %s, does this arch have topology information?\n",
>                           __func__, path);
>                 return -1;
>         }
> --
> 2.35.1
>
