Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC358F532
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHKAU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHKAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:20:23 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F22F665
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:20:22 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id t64so2247771vkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kjtR+7ABCsvSY53uoKHALTawd7IuvqM2GK1EO/X3/pI=;
        b=tTBkrGnrm8fBeWHB7rdqaznsceNDwCKKvf0Uk8197ZTjNodNrjyxeB9uPUtF1gMgGy
         8KoezoTLLkFwUYM4AKXkqIotp4ibYmTv1nxaBKnAVXl2vApHL+IWFwXOdNfPGPlHTBcW
         Md7XuMshM9InVhb3isLjveWnAtgOhGlCd2ck4N2oaS7mczJ5lmbP/M06gyCNbzR+xbhj
         Pazhy4hxFiIWdOA4zi33OtrRynSlVrWDFNl3047QJfacCxx5qCnb4fSgRGtEPbRxtgkO
         /3wvc75jNRVa0Ni6zF/RoSYvizSlNqzd+CD6OdeAr9kc0HgTP2YL/azxAurfxtR9S5Xd
         rmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kjtR+7ABCsvSY53uoKHALTawd7IuvqM2GK1EO/X3/pI=;
        b=HrdEZA0XCyQv9uaV4i6vZ0qIgMF/WOVeyiHdAXsNGTX64VEjkCvVRgG43ewPmaQf9S
         o/V8PXFGQfA4qggDnEgJrAjg+MhStX4yhzBWKCEpCxZb3ign7MOjfUWFM7NRMgSvOXgi
         GIws1moprMBOwReEGMFoUwtwLFOpI0lp3/zGQ8PI9eJ51IoD7V2OC+a4tRbLAl/CXGwi
         LYm4sV/jQ/QZ/BESjnZS9xWvr2/5GLFhWuQ+0u7fzPD9eeKnPC6RUJRK/JmlFS9FwhaG
         1xpqAj6C6mxlehxXju5vTWy/DGRjN04yKwEFmwJSTPWG4k2Pv726V4tZvPY33FfiSOlV
         qAMw==
X-Gm-Message-State: ACgBeo13l3d0fGS8nV1r5z2sZkPgRJHmE0V2XhLp3Wf0SJg4JJefZWui
        XJO4xXbo1Q/BvB0RK+tsFJYhQZjRZzQa9mB8pokIIVIFiwa/ht9m3o0=
X-Google-Smtp-Source: AA6agR6bpJtbxkl82DmsbKU+7tsTOmuNRmmdwUIR8+HZQwYFLt13luLSfUz+NRXaBIO70gfVRGtR1t6sAHsGsOaSssQ=
X-Received: by 2002:a67:cb0c:0:b0:357:9897:32d4 with SMTP id
 b12-20020a67cb0c000000b00357989732d4mr12894315vsl.18.1660177210770; Wed, 10
 Aug 2022 17:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220810234056.2494993-1-npache@redhat.com>
In-Reply-To: <20220810234056.2494993-1-npache@redhat.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 11 Aug 2022 08:19:59 +0800
Message-ID: <CABVgOSmUgkeuKKS_UYMOTUE4vARLpw--j77J9=zAkk5Zr30N9g@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix Kconfig for build-in tests USB4 and Nitro Enclaves
To:     Nico Pache <npache@redhat.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>, alcioa@amazon.com,
        lexnv@amazon.com, Andra Paraschiv <andraprs@amazon.com>,
        YehezkelShB@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        michael.jamet@intel.com, andreas.noever@gmail.com
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

On Thu, Aug 11, 2022 at 7:41 AM Nico Pache <npache@redhat.com> wrote:
>
> Both the USB4 and Nitro Enclaves KUNIT tests are now able to be compiled
> if KUNIT is compiled as a module. This leads to issues if KUNIT is being
> packaged separately from the core kernel and when KUNIT is run baremetal
> without the required driver compiled into the kernel.
>
> Fixes: 635dcd16844b ("thunderbolt: test: Use kunit_test_suite() macro")
> Fixes: fe5be808fa6c ("nitro_enclaves: test: Use kunit_test_suite() macro")
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

Hmm... I'm not quite sure I understand the case that's broken here. Is it:
- KUnit is built as a module (CONFIG_KUNIT=m)
- USB4/nitro_enclaves are also built as modules, with the test enabled.
- The kunit module is not available at runtime, so neither driver
module can load (due to missing kunit dependencies)

If so, that's not a case (i.e., the kunit.ko module being unavailable
if it was built) we've tried to support thus far. I guess a de-facto
rule for supporting it would be to depend on KUNIT=y for any KUnit
tests which are built into the same module as the driver they're
testing.

Alternatively, maybe we could do some horrible hacks to compile stub
versions of various KUnit assertion symbols in unconditionally, which
forward to the real ones if KUnit is available.

(Personally, I'd love it if we could get rid of CONFIG_KUNIT=m
altogether, and it's actually broken right at the moment[1]. There are
still some cases (unloading / reloading KUnit with different filter
options) which require it, though.)

Cheers,
-- David

[1]: https://patchwork.kernel.org/project/linux-kselftest/patch/20220713005221.1926290-1-davidgow@google.com/

>  drivers/thunderbolt/Kconfig         | 3 +--
>  drivers/virt/nitro_enclaves/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thunderbolt/Kconfig b/drivers/thunderbolt/Kconfig
> index e76a6c173637..f12d0a3ee3e2 100644
> --- a/drivers/thunderbolt/Kconfig
> +++ b/drivers/thunderbolt/Kconfig
> @@ -29,8 +29,7 @@ config USB4_DEBUGFS_WRITE
>
>  config USB4_KUNIT_TEST
>         bool "KUnit tests" if !KUNIT_ALL_TESTS
> -       depends on (USB4=m || KUNIT=y)
> -       depends on KUNIT
> +       depends on USB4 && KUNIT=y

This can probably just:
depends on KUNIT=y


>         default KUNIT_ALL_TESTS
>
>  config USB4_DMA_TEST
> diff --git a/drivers/virt/nitro_enclaves/Kconfig b/drivers/virt/nitro_enclaves/Kconfig
> index ce91add81401..dc4d25c26256 100644
> --- a/drivers/virt/nitro_enclaves/Kconfig
> +++ b/drivers/virt/nitro_enclaves/Kconfig
> @@ -17,7 +17,7 @@ config NITRO_ENCLAVES
>
>  config NITRO_ENCLAVES_MISC_DEV_TEST
>         bool "Tests for the misc device functionality of the Nitro Enclaves" if !KUNIT_ALL_TESTS
> -       depends on NITRO_ENCLAVES && KUNIT
> +       depends on NITRO_ENCLAVES && KUNIT=y
>         default KUNIT_ALL_TESTS
>         help
>           Enable KUnit tests for the misc device functionality of the Nitro
> --
> 2.36.1
>
