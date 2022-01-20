Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0701249497C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbiATIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359226AbiATIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:30:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C8C061748
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:30:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n8so10311678wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwGv/8SwrgHrrCdD+znAh14qmRCXOFOe1aQhnNfhrho=;
        b=VeCt/8C9JFyQWmFn0h8Me/FbyrtYM1CBBgou8p+ugm9uUDLSM06LuVzMdc5GGNpi6k
         Zf66K9dKqHmH0XDg8g8sXdZDoidK777CM7WCMk7zr79iu7Gwl4/KZcKPxvLzPvoUR2gl
         fy/UJpiNFpgyT8JQqw/aUtxfr6RyrjG1T7ocaGqYqFl+BF2xLhTgI6rf99es95iqmvaV
         Ajxp9MaqUn1KfO6AyEEYUe+CvfdUjRIOPurTrwqi5SvM+dn6kS1I7AmqXfTyI7fiAS7f
         dnB0/1bRSed+4CqfY9n84s5lfVvQtCCzGDISB9ajRjrAfRwvuxA8FYogIu/VQmFsMLF3
         e7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwGv/8SwrgHrrCdD+znAh14qmRCXOFOe1aQhnNfhrho=;
        b=rFdvwXhdYVrYyLkQcrBNqIj6u+AYO1Bzqw0XWgYKM76Zz04SkU+MuTZD3xi7g7hoOJ
         5HXA9iSqetOtLu1rWbKsNNb31c4kgCKu6WN6sw9BcujV8U4BYC1/N0oeJ2A3HkuM5TO0
         tTZB3WWHn6FwXs90j/6q2vXHaW8OAT9e/DgnIwZAFTxZhkmWVNuyJAQ23p+QLnQy+4YG
         TVXYWjgfAxP0RDKujhAqxoHRXyqb/WgVcaANiNJvBAk1P2PebVpjAeLCnypNaVrlt9dT
         ITDr6o0Xu8SAbX2eZAcZRrNmgmXd/kCqx0UCS8YHUAzwo41RW0nbLoeE30yizm+SDVj8
         ifxw==
X-Gm-Message-State: AOAM533E7IZaaVG2quDn3eZWvYBhJ3KDbftw0FXAK2YT6OVH5aWFFwek
        mkEw1bshu8hQkcxOV1KA4dfTxkI3V4oC3616ozZR1A==
X-Google-Smtp-Source: ABdhPJwTkcuZQfeVqYEksff78+o7mq5FMu1onryN8ZF/bwp0cD0njfJHKM0V2MqP/f/7srKx7XbtSlFnmnH1jhYBEt4=
X-Received: by 2002:adf:f48a:: with SMTP id l10mr32377787wro.220.1642667400108;
 Thu, 20 Jan 2022 00:30:00 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-3-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 20 Jan 2022 16:29:48 +0800
Message-ID: <CABVgOS=290dX4JnBj+d9jTMVvEJXude0Xxk9fdSZbU9xNQ8_pw@mail.gmail.com>
Subject: Re: [PATCH 3/5] kunit: tool: drop unused KernelDirectoryPath var
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit be886ba90cce ("kunit: run kunit_tool from any directory")
> introduced this variable, but it was unused even in that commit.
>
> Since it's still unused now and callers can instead use
> get_kernel_root_path(), delete this var.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  tools/testing/kunit/kunit.py | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index bd2f7f088c72..4cb91d191f1d 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -63,8 +63,6 @@ class KunitRequest(KunitExecRequest, KunitBuildRequest):
>         pass
>
>
> -KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
> -
>  def get_kernel_root_path() -> str:
>         path = sys.argv[0] if not __file__ else __file__
>         parts = os.path.realpath(path).split('tools/testing/kunit')
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
