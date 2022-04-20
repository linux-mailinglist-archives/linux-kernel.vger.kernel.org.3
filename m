Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D3508D80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380683AbiDTQmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380685AbiDTQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:42:31 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E1C4615A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:39:45 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so2429086iov.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzS2G8lh8IFf105c1rGwkDws5NXApyWthp6AQcgQ72g=;
        b=UycO/TOyAzaFWtYuRL1zPTZPpSLu8Q9LC3yn+mV/OIoI6GRnKAxyF2IjUBFBljxOY4
         wFEzi5gvhlgDpWuBY4NPrIMekiM77ZYeMqB6FTZB8YTEnGgzMRJ858GPdAAWRc0PtJFt
         nFK3q2c+zxqlstAQuiElymuS6Ej8lULYzydds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzS2G8lh8IFf105c1rGwkDws5NXApyWthp6AQcgQ72g=;
        b=vsfGnZf49qiCgnX7q2NWEwH5pEWM99WW6QIdMCy++woHLAvkuzPyCfwmpOhF6hsz7H
         sihIvv50u5QmMneR6vXb2EvKCGqlXR+ZvPJ0R4D+C+CLa/0he5aDORSWog7Ceg3DiZbf
         pZPQutnyLD89aOGA+kqLeqPr6Lj6hnz6lMaA/nN3UpKWpRETfYQD7edWqhT07l4PB9fW
         M+sNxSDTJvux8jvqD3V/eyq8EPx0gY3DISUz7HnqR/dESRtxa77V97pZ4XVjdrtLTfkB
         0/2gyiaf+2CDdiqB+8EIGfGB3sNYTI1gFE2kFCa+zmrHlmpm10Mf+8zivLoPqibf8U0c
         sYCw==
X-Gm-Message-State: AOAM530Aj08GfV8I9jOzXrinM4p+rW2tVDpRjVyrzUjmTAFsVnok9TKq
        Y/c/GbbD2HRF328SKqlj37IlBa8APeHPV5MFTykdmg==
X-Google-Smtp-Source: ABdhPJx4/BAeX68qPJZ8pZ+6C2GHRTFtvqy+1dPqrhWNa8EYBtp9UJv+wakF3VTU3A4yo2dvIBzU9lU0Uw6s1mC9UrU=
X-Received: by 2002:a02:2410:0:b0:323:fb30:183c with SMTP id
 f16-20020a022410000000b00323fb30183cmr10471216jaa.2.1650472784775; Wed, 20
 Apr 2022 09:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <202204201732.oTzYh0Xo-lkp@intel.com> <20220420134918.GZ4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220420134918.GZ4285@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 20 Apr 2022 12:39:33 -0400
Message-ID: <CAEXW_YSieVAKUushETvppRAsbKrt0rkFrfYo8qgTK96tXwkqYg@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev 28/28]
 kernel/rcu/tree_nocb.h:1213:3: warning: misleading indentation; statement is
 not part of the previous 'if'
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 9:49 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Apr 20, 2022 at 05:57:46PM +0800, kernel test robot wrote:
> > tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
> > head:   ad68d8bf085421e4f22731c8b64c0b774a154e06
> > commit: ad68d8bf085421e4f22731c8b64c0b774a154e06 [28/28] rcu/nocb: Add an option to offload all CPUs on boot
> > config: riscv-randconfig-r024-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201732.oTzYh0Xo-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install riscv cross compiling tool for clang build
> >         # apt-get install binutils-riscv64-linux-gnu
> >         # https://github.com/ammarfaizi2/linux-block/commit/ad68d8bf085421e4f22731c8b64c0b774a154e06
> >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> >         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
> >         git checkout ad68d8bf085421e4f22731c8b64c0b774a154e06
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
>
> I am dropping this commit, and thank you for your testing efforts!

I discussed privately with Paul and things are a bit late for -next as
other testing efforts are underway. So we'll revisit this patch in the
future. Just wanted to clarify to the onlooker that Paul isn't
dropping it because of a NAK or anything ;-)

 Thanks,

 - Joel
