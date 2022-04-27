Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70E7511B36
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiD0No6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiD0Nov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:44:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D817FBDE;
        Wed, 27 Apr 2022 06:41:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id be20so1969097edb.12;
        Wed, 27 Apr 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCpiXIu3nq73RxGaZx1WoL3R1rHmiodl/liNhywm500=;
        b=XpAOstzAHkLF78OLo0w8Ad3S/RN1CVFO5WGyh3L0JGU8r2W5yRlWTwA1ARUPJtULTW
         UDol8lT3VQBd8LjJq17KQj07yeHtPJ1d0L1ychLJhfbu4mZhk51aq3wAMf5eJg+IEryk
         3pqK1MjEDP6OrcAcr1Ai1aTXnvB4E/JuXTtX/qgTaa3RBJ9rnMaEIZwdqefGGkF4vUxo
         UUjFrFRVueIwuuB7sWv+7US1WSduPbcqPebet7Eo15kPA0IG+Rhc0zASQdo+Czd6Pz5G
         jPdFc9UYUkFVk/2KWinQYsi0WpsBZy3h6b6jpL74cshLWH0qoh4KUA+2Z4n8R35zKwFd
         /4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCpiXIu3nq73RxGaZx1WoL3R1rHmiodl/liNhywm500=;
        b=TIXJRXE6q6W+XI/URIckvuB15/ZrM3LZdAEuCRZew3CgeELAO8nTJGnLug1p8Zyol0
         ETm+tWd6twct0VAmAAY45pn+TA9n8oFBvy3aB2kNaO5CmZk/N7lVpXgYs9U8GU6W6gAo
         GhbznrQIHPlliYN+IT6UPch+h7gF+HlbzxOzRHvt3nig6ZIJSmfKqSDsNQyUSgdSjbFM
         hUbURpRx7Mc4vMei7xIgjpM7frOZ0o2sDGZEaLO86xKfX19BHIV+CIdN46VRoAGwcuNV
         0K0jZP90NdDr/H8kSq97QkcdzI3IVm0QtUMJenzx6mZWxGDZP54psOi5Ojah7OObk4N2
         Uc+A==
X-Gm-Message-State: AOAM532QVOaDJl9/TLD2eRDOBgqMOI7BMa1Wo8R74uFzNpz3neOvdAzk
        +ymYYRNZAgs2px94c2XrWnXAx+nTaNoXcSc+tyU=
X-Google-Smtp-Source: ABdhPJyxERFm36uWDfRYGPwhyWzytql1H5nA9knbA61sEk82utfLeb8YTVdwsx2A7p5NycNZso2qdzQTZAgS4/rKo0k=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr30028337edu.158.1651066898385; Wed, 27
 Apr 2022 06:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-13-andrea.merello@gmail.com> <202204271554.EiuIRNPI-lkp@intel.com>
In-Reply-To: <202204271554.EiuIRNPI-lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 15:41:02 +0200
Message-ID: <CAHp75Vc34K=5U=kMCqtDm_h3VBmqyCqcWr0em+8fZBiM2n76rA@mail.gmail.com>
Subject: Re: [v5 12/14] iio: imu: add BNO055 serdev driver
To:     kernel test robot <lkp@intel.com>
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:11 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Andrea,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on linus/master linux/master v5.18-rc4 next-20220426]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220427/202204271554.EiuIRNPI-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/675ca9cd13af45cc5943dd15caad5e866fd7c971
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
>         git checkout 675ca9cd13af45cc5943dd15caad5e866fd7c971
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> make[5]: *** No rule to make target 'drivers/iio/imu/bno055/bno055_ser_trace.o', needed by 'drivers/iio/imu/bno055/built-in.a'.
>    make[5]: Target '__build' not remade because of errors.

You need to add a C-file with the only line

#include <..._trace.h>

And drop that include from the ..._core.c.


-- 
With Best Regards,
Andy Shevchenko
