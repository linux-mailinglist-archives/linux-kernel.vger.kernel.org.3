Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67279549DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350719AbiFMTbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245219AbiFMTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:30:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4C3A5C5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:55:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o7so12647751eja.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qnmd/iXwgOAAlMSgI58Wt3WqINV1dXxUsm+6NoZ5u8g=;
        b=CM6sbcBzjbo8jcx6FrpKxdA0+hnApCbPoz5aS6hM55/UCzzbW5lBIMBSv3ZCUmyzhu
         ck/HBBgRPJKAaMaxtqLQsdS5ZwY40yDhXWMYeDqF7eYfJnYirtKw/B2MTrFojJHovlbi
         LeWUTk2dRPSAL6ujLahMqKWNxgzTFpSo4v6Ng71GH0VdwsV3F0XC0Ynwy6e3Iaw+VGRp
         VRxICAjcU1Vbguh/WcbSKwhsAIn2RA64FR/m15+YHFuVO4Y1c+QwLFUc1F9nZyYm1R2X
         5P1UR2oPyzE6UPlptbt5jMmuPD4QFOIis1lawV89Cu0cPPjcqofF2Ptc5lvRuLxHErTw
         TJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qnmd/iXwgOAAlMSgI58Wt3WqINV1dXxUsm+6NoZ5u8g=;
        b=o6+UV8sFl3LhbDv5Z7PDiLV+JkmuLJSwrvipNEFiOIfsNnv1aJYmqj0T9gX0DlFhAI
         6n5b2Wx95rMnib1wCN/3sSxECyilaXuwVKq1cnShgp3eWg9BqTePNYfx2DNLTyeDchlX
         GzDBvVARq2HVZ4K3q85ny16mJkjoVuLplCoVobWxEk795YhMupw0n18rhF92jbeYNC8L
         Z0iSwgy43XQeGi9+9QZYHgA5WX5FbTfACm7LYl+q/bDQ5bhLMsksqetaJnCdiXliuUGN
         iFVH3SRq3S1XdL35sYBoHjPNyFtjuLeziUZRfpS/XHNQbhRnnXil2RyU+RFnw2mJI0PT
         Abtw==
X-Gm-Message-State: AOAM532NyxXxp8+XokIKNXOinkMxKZrSPRJ0KIOpGtZJFoqfP5Top/6K
        26QX5We2pgUB7kpjqWXXPEWJl91Ra9v4NZNvLQnN5w==
X-Google-Smtp-Source: AGRyM1vDh4u0EqUkAEC2QaY3FmKLC/4K7J/GzeNxqF+oFeSa4v0oV8VhwdwV55GJtAMZdjjndGLRdCT5PCkCx6hcazg=
X-Received: by 2002:a17:906:c193:b0:718:d076:df7 with SMTP id
 g19-20020a170906c19300b00718d0760df7mr896612ejz.358.1655142913232; Mon, 13
 Jun 2022 10:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <202206120046.YKeKzlVN-lkp@intel.com>
In-Reply-To: <202206120046.YKeKzlVN-lkp@intel.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 13 Jun 2022 10:55:02 -0700
Message-ID: <CAGS_qxquSGoHD2NeRiS-basVg-nOP8s4kSGi90e2QuMc-Pt0Pg@mail.gmail.com>
Subject: Re: lib/overflow_kunit.c:644:1: warning: the frame size of 2832 bytes
 is larger than 1024 bytes
To:     kernel test robot <lkp@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Vitor Massaru Iha <vitor@massaru.org>,
        David Gow <davidgow@google.com>
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

On Sat, Jun 11, 2022 at 9:44 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Kees,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0885eacdc81f920c3e0554d5615e69a66504a28d
> commit: 617f55e20743fc50c989b498f9dee289eb644cfd lib: overflow: Convert to Kunit
> date:   3 months ago
> config: powerpc-buildonly-randconfig-r006-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120046.YKeKzlVN-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=617f55e20743fc50c989b498f9dee289eb644cfd
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 617f55e20743fc50c989b498f9dee289eb644cfd
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    lib/overflow_kunit.c:191:19: warning: 's64_tests' defined but not used [-Wunused-const-variable=]
>      191 | DEFINE_TEST_ARRAY(s64) = {
>          |                   ^~~
>    lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
>       24 |         } t ## _tests[]
>          |           ^
>    lib/overflow_kunit.c:94:19: warning: 'u64_tests' defined but not used [-Wunused-const-variable=]
>       94 | DEFINE_TEST_ARRAY(u64) = {
>          |                   ^~~
>    lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
>       24 |         } t ## _tests[]
>          |           ^
>    lib/overflow_kunit.c: In function 'overflow_size_helpers_test':
> >> lib/overflow_kunit.c:644:1: warning: the frame size of 2832 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      644 | }
>          | ^
>    lib/overflow_kunit.c: In function 'overflow_shift_test':
>    lib/overflow_kunit.c:451:1: warning: the frame size of 7232 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      451 | }
>          | ^

I have an RFC series out to reduce the stack usage of KUNIT_EXPECT_*
even further, but they won't help enough here.
https://lore.kernel.org/linux-kselftest/20220525154442.1438081-1-dlatypov@google.com/

So If we want to try and "fix" this, I think the only answer would be
to split up the test funcs as appropriate.
But I don't really know if that's warranted to fix this warning here,
which largely indicates a compiler quality problem over a code quality
one.

Daniel
