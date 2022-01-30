Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB64A383E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243428AbiA3SsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 13:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA3SsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 13:48:02 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A601FC061714;
        Sun, 30 Jan 2022 10:48:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ka4so35918983ejc.11;
        Sun, 30 Jan 2022 10:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aoIi1xNlWyLsIaWBt8loIMMaCfondWklXIe5cHckPXY=;
        b=F/u7iXKfIY7c/7MmsgcafAjL/R6D4j1JPVHCBPaOeuSGXeCyWf6fTcgqnDEwO8NMgI
         uGKtVlqLYq3zOeKxT4oeuAJDw1RjqQtFAA2Ob0XnMesqt/bL4ECwww4zoJuHxDuB3diq
         ihxLpZpZXH67vnODkTt5fysR03eeYnUGxCuPQzU5032rVZOb7G1RDioV5skOVc3R3cqF
         X90vRsZPhP4nKAoOq8i4qrn7RQYoAfvaeXk3CB6MR+9YY9hvM2bLFqigExY77dkkp/Tu
         OIsc0zs036FSGuyREoXtHszi6waolcgFdVrzaltXp9IM5N2vIjrnWbpcD1EbUbsNs+Qb
         cCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aoIi1xNlWyLsIaWBt8loIMMaCfondWklXIe5cHckPXY=;
        b=NDx8atGKFGgRi7yJOKFlk1UT4+CrciNMl+AhLbOT9nB7PYXEAKXRsLLNPmpb2OFdb5
         Ka6WgKGvdKOd4OXAG84BpXTfJurQcLciI90NHmQaPQjuWJRT7yZ/s2WvPDcP1x1NsL1a
         +sYqCJcsxobDVm2aGMHqOn2sXSpF41bLMg/kmOy4LnsQF/+FrudmxiRbBbew+rwr5pj5
         CQkogX0tnrlBTwiiLjs6qTzW2K2vb9wpJSC+jQ4DglRGkAdCT3c2Hi/h4ps5ZOVqJR6M
         1Gu6hid+f+HM/LBZPcywK6pD9MevI6q6ySdKV/2jtjEPyhK/KseVUKOCNwBeeCn1mXE1
         v44g==
X-Gm-Message-State: AOAM53207WN3P6gawzkw4LEo4DooCvhlmh0FXnqjVin312sR0DxCyaJv
        0yUQYi+MprME82FHFaeZbi/HPBGgkoMbfQL5kyc=
X-Google-Smtp-Source: ABdhPJynTXX9qeIiR8ceufTHQt8Z8Xy4Vq4iwbqRbcJjN6l+Y0Ej2OIWh6p8hW3KZNCDqZAEue+JXmeyiTwBiXL1TTY=
X-Received: by 2002:a17:906:604d:: with SMTP id p13mr14162629ejj.639.1643568479968;
 Sun, 30 Jan 2022 10:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20220129115228.2257310-6-j.neuschaefer@gmx.net> <202201292234.NpSNe4TD-lkp@intel.com>
In-Reply-To: <202201292234.NpSNe4TD-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Jan 2022 20:47:23 +0200
Message-ID: <CAHp75VdVoqRk6bLwaOPfGdfyVoH_9DUj2Lb4VBOHrhM9SpoMNA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] pinctrl: nuvoton: Add driver for WPCM450
To:     kernel test robot <lkp@intel.com>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 4:10 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi "Jonathan,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linusw-pinctrl/devel]
> [also build test WARNING on robh/for-next linus/master v5.17-rc1 next-20220128]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20220129-195955
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
> config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220129/202201292234.NpSNe4TD-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/3fd91ea1bad905592e89c8f987f6bd3740329b80
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jonathan-Neusch-fer/Nuvoton-WPCM450-pinctrl-and-GPIO-driver/20220129-195955
>         git checkout 3fd91ea1bad905592e89c8f987f6bd3740329b80
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=um SHELL=/bin/bash drivers/pinctrl/nuvoton/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):

...

> >> drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:908: warning: "DS" redefined
>      908 | #define DS(lo, hi) (((lo) << DRIVE_STRENGTH_LO_SHIFT) | \
>          |

>    arch/x86/um/shared/sysdep/ptrace_64.h:38: note: this is the location of the previous definition
>       38 | #define DS (HOST_DS * sizeof(long))

This is a good example why short and namespace-less definitions are
not always good even in standalone module.

...

>    drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c: In function 'npcm7xx_get_groups_count':
>    drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:1564:21: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]

Should be %zu

If it's already in for-next, there should be two patches to fix these issues.

-- 
With Best Regards,
Andy Shevchenko
