Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB34A2B90
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 05:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352339AbiA2EPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 23:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiA2EPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 23:15:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6C2C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 20:15:14 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r7so5925921wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 20:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4oel1aQBoCtI/b7gkK6UL5x2odlkFP6no8sfDKO+Pg=;
        b=LUPkVY/TcyzOL0KUTKOMPPkxjWtZRrwB3qQhWUHq/enS3OBA9r9jFpseAGdPZDowxw
         eF57APKjuCQ446mmevqtldVRmIx9TCA7Y2oAZYfk3QdLaYEI2qn7wlflWc64wuHPzQZp
         NkwuxKKnksGZSXrFMsFyvdUXMAu/kdtOzLYHSXtzN1MfgTcDwCfA2HhxQERheaAcL9tx
         Slwqmt0A6TsUrFTFecX7gWVLuiZtnOOn71jHFc5Qr0ntDYSVpuncXEaJbqtmC3CZ9JZn
         CxnvxQSJ8aZ/D2a12dzwePAzmo7vzSQ/r9EZ5nHmxq/KAA/kJ6cMPhrWZi7ety/6ZjN+
         0Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4oel1aQBoCtI/b7gkK6UL5x2odlkFP6no8sfDKO+Pg=;
        b=njjrO7lJdQWvEbAZJgabE+sLTTNxmUDmwpbYepSrTvO+blGN63vwk51vHifmIlr+yB
         gWNCxVKcEiDgeetaFB6wnAX5LOAHbIj/a5zjrMJnrt6EzxTNHxr7bRU14R4Avy9kekic
         qpdNpxL/U8pOWl2yaglCxk5AFHnKi2IUlOa6qNr0vyQ4fxE/FkFH8+e2tZc5ATbvHa1q
         hUgkx2SdIiptZGXrCC8bgubLymJYQuW+yNVbN/sVyjwr9qLXBJ/IFBVNSCrVyrFTVbpK
         M5mVwbhwwD3QRidGDj2mw5i5qlFcOO4zOcUnh9WlSwQSjnfD2qHWau8itN8WL2cxwXWR
         Y9Uw==
X-Gm-Message-State: AOAM531PNFqJ7gbLeNCjU1zwW098U8gd0DBrhM5jSMDuY93SkwDy8J8Q
        TUbOh/U8bPQ1LfVKXpadzq4v9rgXlWGWZCLVx+XCLQ==
X-Google-Smtp-Source: ABdhPJyJtOmRyTmN1Db/Nvc1SI43ufGP0GPkypCaSyJvYg+TaDwEsgkzTiKthZmm5E5iVrOnyYIDmJ/0nCw5YRvKqxI=
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr18501063wmc.18.1643429712927;
 Fri, 28 Jan 2022 20:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20220127221710.165733-1-dlatypov@google.com>
In-Reply-To: <20220127221710.165733-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 29 Jan 2022 12:15:01 +0800
Message-ID: <CABVgOSncO56y02RkUMeBU2rpqxXgDudL24gG0UUqzhX58JqjJg@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix missing f in f-string in run_checks.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 6:17 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> We're missing the `f` prefix to have python do string interpolation, so
> we'd never end up printing what the actual "unexpected" error is.
>
> Fixes: ee92ed38364e ("kunit: add run_checks.py script to validate kunit changes")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/run_checks.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
> index 4f32133ed77c..13d854afca9d 100755
> --- a/tools/testing/kunit/run_checks.py
> +++ b/tools/testing/kunit/run_checks.py
> @@ -61,7 +61,7 @@ def main(argv: Sequence[str]) -> None:
>                 elif isinstance(ex, subprocess.CalledProcessError):
>                         print(f'{name}: FAILED')
>                 else:
> -                       print('{name}: unexpected exception: {ex}')
> +                       print(f'{name}: unexpected exception: {ex}')
>                         continue
>
>                 output = ex.output
>
> base-commit: 6125a5c70acddd9fc1fb7329047a254c74d0173c
> --
> 2.35.0.rc2.247.g8bbb082509-goog
>
