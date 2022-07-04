Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA2E565E29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiGDTui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:50:36 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0CE10A7;
        Mon,  4 Jul 2022 12:50:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l144so5899782ybl.5;
        Mon, 04 Jul 2022 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eedd7IoRs6ZWphM8UV7NfXV4UZ/8z7psz/7E2jpJhws=;
        b=FYTJRQYbcH+/3o3HfTjpBG2KrRahSdePIFoDiEHrMiL26sKyz/Yznk2JUYu5sXccfS
         zBy/2Z6cDrfzz1Y3+1XUDOBvV/52cu/Z8VfNf7MCFbGF1xJGBfCDBebvvMkm++EoGYnl
         FPPKxtNkHRMLOBs2WsNcEjE7p1F+a1j2xTPzNj0yKs03jbtxpCFEcMXZZnlj1+Bt4OkB
         +y24b2V/3zAtHgfFp4LFazQ8eap2g7txt8fzf9OUDuZKd5Z5dZL33PAyu0hEdJlLp1ed
         lQ8cys9N3o0IFWb2+M3yzHZud8di8buSkj8KUPK338w9TdMI8qNhyVXt5raI0w7xwsNK
         F6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eedd7IoRs6ZWphM8UV7NfXV4UZ/8z7psz/7E2jpJhws=;
        b=y5v+FVQ5aP4GCK/alAbuP8ZzTDW/7rGLZGNDPB36IqzM2iOGuimCNkb4GTc4h+h6MY
         WN741STm2Ku0cETeHxoajHzxeeIT+QbCCkmUHc9MP66cD3APNdN3YSlt5FPt+Ol/hKgr
         34FXKmddA/okhfj2klE4nIBlyNvvh4OelavRN5FT0gelgArI4P8fRbtaRpkO27LWjOSz
         0KiP1LbhSeHBv+kAFfnxQrRQI7S/TnOXqzhaVBpy1EE5ljZRGKBNd42i5idVeAc2q/+b
         S2K/0KkNiZu7CXQqyYbD5ftnJsVa9CFWEYZYtDyJ5p71ZAdwyXgJ/UvPp4ZINKEdRl6r
         8VAA==
X-Gm-Message-State: AJIora8YF8kLjsSkzb46zI1OuJL5jHCU8zLcpfdUzvnlFMllkHPgFDUp
        YsWAw71e7ajN8R0DaDlSEJFOHx3fsaxNJTvIFdE=
X-Google-Smtp-Source: AGRyM1vmRz3epSVVkltVS0t6WZt747lUodP08EwhxWju7lyRYt7Cth1ug/nvvb80W0mOVFXOvewMPofxS7TDewp0p24=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr33329236ybs.93.1656964235398; Mon, 04
 Jul 2022 12:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <YsGVa8KFmdvGY92e@debian.me> <20220704034041.15448-1-bagasdotme@gmail.com>
In-Reply-To: <20220704034041.15448-1-bagasdotme@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 21:49:58 +0200
Message-ID: <CAHp75Vdg=NG9fnd0EQWg5D4WoW9hGJM+MMBRLSacgQUptuGe9Q@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: bno055: separate SPDX identifier and
 page title
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation List <linux-doc@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 5:41 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> kernel test robot reported htmldocs warning:
>
> Documentation/iio/bno055.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
>
> The warning above is caused by missing blank line separator between SPDX
> identifier and page title.
>
> Add the blank line to fix the warning.
>
> Link: https://lore.kernel.org/lkml/202207031509.DlBrHyaw-lkp@intel.com/
> Fixes: ec0c70cb45507d ("docs: iio: add documentation for BNO055 driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrea Merello <andrea.merello@iit.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> Cc: jacopo@jmondi.org
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)

It's a very noisy Cc list which will go in the git history. Instead,
use --to and --cc parameters of `git format-patch`. Maintainers
usually use `b4` tool that adds a Link tag to the patch itself on the
Lore archive which will keep track on the Cc list anyway.

-- 
With Best Regards,
Andy Shevchenko
