Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945A74DBD68
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358527AbiCQDMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358520AbiCQDL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:11:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DEB21272
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:10:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t11so5540381wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4Cs871ryV3jskArlUJXNj/tgZDn1LSZklEa26kOZ1c=;
        b=Mm0GSMqaQyv0EPiuAIPo+8UUsDKGk7BSCXjML4fwUhA7o4ncIZ/IfZzhYBRuOYKFFK
         mfjjR6ySkLHqqr/lO3syWnnka1dSl6KWxCVDTKMXefWiOqKR1GiUx1vYTpw+v6SH5fCS
         xocd+GVbstnngxmvzfazk+La1ldqjGMH4XNn2+fXSnjj9JbJeGKpjMpFa/Ec3/MfPICl
         HnjA38IrgBYQAJ19rNjs7a42wqIDYaYZFi4zC+wiVSUSg+TdOpiKrQYih1rk/6k0BAE6
         k8hrZeleEUsMgXP9gIm9Cd44dV8VN/F5u7R5kqKjZaQvBe2nR3r8i36n3RzOXmsT+g1x
         4YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4Cs871ryV3jskArlUJXNj/tgZDn1LSZklEa26kOZ1c=;
        b=S/7yBJlmTWTtixVVBTjoxa20cIJ7CHqGaTKVBpO+YZjn5Cq06qxtL6WnoZEGya6YqO
         0xKMBX43Urtr0VmYl2QJT1AzkiuWR6d51PvVia3xvjKdbndNhIxjY0usQr5GkwbeEpXz
         KbXWjKolhnuVYx3y6rWbG25drWQVjbCah+VuPRW6M9q0HH2M2uWStVBBf2YFtb9BzUsn
         MSKI95ZIFa4AyBG1imvjnyXOdDPbasL33NidWmvO8ZGasB/Li5Dc7RuD4H4H8Nfc7+K4
         HaAUwtRmesb3OOuA8j9EuiLYXF5j1FnWQtYvyyFIbKbUYzoDjFoHJrSycgSrQI1aGaM6
         tq0w==
X-Gm-Message-State: AOAM532dKUDvhxBRG8xZbNkV7jGt9B/J0n3B2UXzCBxLVy5IRkybFW31
        Wu3ce38hMt0GMLxZ1ZUE9eDM67QNnPVMn916GXrhGvkbf/LCNA==
X-Google-Smtp-Source: ABdhPJxUEpbLmZwl6Sw1kWg+uL3XJMn9zOtRkxxlnIJ8gwPfHabGLQ0spsfin5WGxjTjObtVf2p60c7BcCBRX3yyX5U=
X-Received: by 2002:a05:6000:11d0:b0:1f1:f6ea:f9a with SMTP id
 i16-20020a05600011d000b001f1f6ea0f9amr2226315wrx.40.1647486640162; Wed, 16
 Mar 2022 20:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232452.53062-1-colin.i.king@gmail.com>
In-Reply-To: <20220316232452.53062-1-colin.i.king@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Mar 2022 20:10:28 -0700
Message-ID: <CAP-5=fWA=OGggwz730ScghTmUqeWGSG3hXv2swCRKGafOOSiDg@mail.gmail.com>
Subject: Re: [PATCH] perf build-id: Fix spelling mistake "Cant" -> "Can't"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
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

On Wed, Mar 16, 2022 at 4:25 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a pr_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/build-id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 7a5821c87f94..82f3d46bea70 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -762,7 +762,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
>
>                 len = readlink(linkname, path, sizeof(path) - 1);
>                 if (len <= 0) {
> -                       pr_err("Cant read link: %s\n", linkname);
> +                       pr_err("Can't read link: %s\n", linkname);
>                         goto out_free;
>                 }
>                 path[len] = '\0';
> --
> 2.35.1
>
