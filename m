Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37EE48CF33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiALXpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiALXpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:45:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB1C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:45:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i5so16290573edf.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m46KmwVYj1uyOh4BRdx3V9+/uvSoBPgcetJSVsi8eXY=;
        b=QZlCsJxAMgTkMkqGyoepL9OOpynkjXms+zDeWTLqP6Ac96m3lEoGLKNDjLFfLkUS+d
         D5Odq0xaiv7HcBcDdp9l0OvB0keoE9+HzVm34UgDD9vjIjWd3M29q0xNupNfGSO/aTKU
         5MjqLsZcHDXhyUdh7QyvJXN/JIlOi5lNZDbQncyuuDegdpN2xKH/ytNxJIaLvRcfXWsz
         gfZthX3BZ9dgg0AGxZIBocpHsmxDIsguyxBebKkOKShoyNt0/hgwWb4Fmxle/dy2fdwP
         gax1nzlWWN/Dwf3XWvoZ3cWifkE+xDw6V8acM45x3bpYE/M5XC6DCtXpfayoPiLpXd77
         K9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m46KmwVYj1uyOh4BRdx3V9+/uvSoBPgcetJSVsi8eXY=;
        b=gSOQz3zLkeHd1a1CvaWnL4o4hnMyEkExvn4mByTV4xjJlektDG/CDix0SinPFI2NGz
         doLQjtkpnbrzo5E2k9reBAGRIu++fXq7p4mKskzzRE49BN8fX/Hj83yozDmhU1h92E7a
         T3IqDbVfS9jI/1QWk3YX3/aIsjs8ljCibA+d5NimgPEPOnm2skCUGIPNqbn8CZcV7Mqx
         7bjSMncCVbXLf/4DUFNUixhFbnp+efKSI0d44lRPKbFq/KDL7gBSxDDlls0aazQHJ68M
         0OSHNCq001LgcJ90vxPLqCQi6oFzNRYXRNB7hCjgVTFtapkWOpqSpa6Py1SMzwrkrSZ/
         OZRQ==
X-Gm-Message-State: AOAM5309vGUED0UsuaLHpVV8IQbzGr40H9Hdf7u0O+6b4ItZygqHV6Pw
        MFz2XJ/GNrsLxcVpLaNyho3WzCHsQw8IsSdaGMaAGQ==
X-Google-Smtp-Source: ABdhPJyE3BuK60JKFjelP4Ln0nKKddeGvXKX4Df+rXE4g9uVsuCZMCebEghPW2d8pTLKTdJtmDN693gyUWMfmjcKijU=
X-Received: by 2002:a17:907:7f86:: with SMTP id qk6mr1569301ejc.425.1642031108625;
 Wed, 12 Jan 2022 15:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20220112233657.15886-1-michal.winiarski@intel.com>
In-Reply-To: <20220112233657.15886-1-michal.winiarski@intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 12 Jan 2022 15:44:57 -0800
Message-ID: <CAGS_qxpjK0MRWJp9ma6DZoLn-uEf8_R6vOyRkvGVLkjG-W1Z+g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Import missing importlib.abc
To:     =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 3:35 PM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> Python 3.10.0 contains:
> 9e09849d20 ("bpo-41006: importlib.util no longer imports typing (GH-20938=
)")
>
> It causes importlib.util to no longer import importlib.abs, which leads
> to the following error when trying to use kunit with qemu:
> AttributeError: module 'importlib' has no attribute 'abc'. Did you mean: =
'_abc'?
>
> Add the missing import.
>
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks for catching this! I completely forgot to add the import.

For context to others, the relevant line is
216          assert isinstance(spec.loader, importlib.abc.Loader)
which was added by me in commit 52a5d80a2225 ("kunit: tool: fix
typecheck errors about loading qemu configs").

We could potentially add a Fixes: tag on this, but this looks good to me.

> ---
>  tools/testing/kunit/kunit_kernel.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/ku=
nit_kernel.py
> index 44bbe54f25f1..3c4196cef3ed 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -6,6 +6,7 @@
>  # Author: Felix Guo <felixguoxiuping@gmail.com>
>  # Author: Brendan Higgins <brendanhiggins@google.com>
>
> +import importlib.abc
>  import importlib.util
>  import logging
>  import subprocess
> --
> 2.34.1
>
