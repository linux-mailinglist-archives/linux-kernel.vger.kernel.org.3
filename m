Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC084F18C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378709AbiDDPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378649AbiDDPpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:45:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB7C48
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:43:57 -0700 (PDT)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MGiAs-1no42T2Ib4-00Drjl for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022
 17:43:55 +0200
Received: by mail-wr1-f49.google.com with SMTP id r13so15097213wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:43:55 -0700 (PDT)
X-Gm-Message-State: AOAM531TEQEtQj2zKROmXjtTZkpN4oeoqCSmGYpwXaBfQDhCiRVp8rsr
        1TCyunSyFTRRFP0qYKSpL1K2E7ZJBzBzf5EYZB8=
X-Google-Smtp-Source: ABdhPJz95bfb2fOoyj6Q5qs/8Hlh7qY+u+ORQ+G5WmUvO6RPdGrvGR5f0giccvQ1ZWG0hhIHbPt887/HlHfq5Cxk8X8=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr237866wru.317.1649087035187; Mon, 04 Apr
 2022 08:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <202204042312.fVSuandr-lkp@intel.com>
In-Reply-To: <202204042312.fVSuandr-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Apr 2022 17:43:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0RmaSpWrRANa6Us162GPPhptJAhGWpKsVvW4OkfYP2eA@mail.gmail.com>
Message-ID: <CAK8P3a0RmaSpWrRANa6Us162GPPhptJAhGWpKsVvW4OkfYP2eA@mail.gmail.com>
Subject: Re: arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype
 for 'iop_enable_cp6'
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kjsG/8s+OS5ZFhk/IFGS5RzVziUuQtRY/1TSQ8gXR7THz4jGH/R
 mtdGs1EYJjStJKPxfdH2uvSHd0fBCsjSK/1qAQJhtY7iRhwG04D/KaNZdNOgF6fPBFGk9IT
 BHeNnb4IcjFnH3DQazO0dR6Ynlvc3fs4JlHGcecZ3agHcrTzm7qR5KAjKqlpU76xglsHxtI
 jXl6jjU3pxBbsTMlVvfAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NkifR6pKLVg=:fAqCh90BcqxwlZvn9F7zG9
 OMU70y7QrQKama7/Vpvq4Xvt+mgVwsQrKrRVe337kIrNH6I4y8H6oJyJ8kliAMDtcGYVdZjzu
 AElXTdMtcz461rLWsHq87xN29zHR4Txx4BNgPQWvC9ucjiXTxl5QtqWao5OxMkuu10ZTLIRD/
 S2uC51HVMFxh43pSTdY550ATYJllEYCmawR4J28iFIxfHl+kvqF70v9UDjezfsqqfTEKCzGA6
 3yNU7/cJzl+EzYfwKHFMd4EVUndvFEnLHwNuzhC/1m60K1Z3ttpW2QtHqGRVjQ/YdM783SQAC
 npfWFHo4PKwGX7TxntsBnY2bDYGPLeg02VuMuS7UxvChemX1hDEq6i4o/9gBCNeWqNW/Wil0d
 eGWD4FCA3kBYpKDE5MJJwsRlJ+GdHBlPijnZ+yNE+CCR0jEQ+hOQwBIb/wnusSKgu1reHz90+
 Haxn0+2dvuES38+y7RmMspV0Fg7DAhFFQ4qJO2a0GJ6oxw3W67+0N1gyTzYlw7KpCXmGf89u6
 6RyralpqWxKnxwK93q2PiaQ2sEqBqva5oM5IRzbJVBPuHFrIEWOeJcFamcKTkRpSXI124+p9F
 2G/sTNqigjLDHSaFOx/raXDLIPpCiIEFBWMHI+JHyoNomTr6+bu/h7Hk7b20xzWTl2Lvja9Bv
 zTGhtja+l4Pc7aqCrI3iK+F35cBJ/wjqeVtQf/0Qcyok5sfbnF9Mg+uow8l4b+Pnf8DQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 5:27 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Arnd,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3123109284176b1532874591f7c81f3837bbdc17
> commit: 6f5d248d05db9c4991366154f1a657a630faa583 ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER
> date:   4 months ago
> config: arm-randconfig-r002-20220404 (https://download.01.org/0day-ci/archive/20220404/202204042312.fVSuandr-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f5d248d05db9c4991366154f1a657a630faa583
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6f5d248d05db9c4991366154f1a657a630faa583
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I've added a fix to the arm/fixes branch now, thanks for the report.

        Arnd
