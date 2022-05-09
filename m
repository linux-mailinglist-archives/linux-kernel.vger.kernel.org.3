Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE251F2CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiEIDN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiEIDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:10:36 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565F7326C3
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:06:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y3so10131716qtn.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 20:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=oRfD8M5O9dWN8GNUtDEivgmOVQxQcyA5r2ya1J7njDo=;
        b=e05uXAgTwF0xDilgxFWvqR309UtyqBCC7ohv87z+ckDcJu3lT7jMRCoN8U9d75uj8L
         rtchWV+3trkObIcMl8VZI/aJqGbiquMXzsiYothqRnZcMx8hfsmSS9TE3ap6S5zHNRsu
         NALYp91n0Ogd3XDw713pwnQsoL2cUPzmny6t+AL0ESnGcOZIZsnQ0IiRVdqYv8Q53ADr
         Rft3QClBRgPOd9F7bLpt6+Q8m2IZACF2MKEGKCwV9kNz64CpbgELNwq5tkpHeMlYgMLD
         oNxxEL/5Fzfl8O8M+QYax+A+SVI6E/luf2UBqmKW0pES4StHHfHCasmBr0Uvx+EyOE4d
         +/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=oRfD8M5O9dWN8GNUtDEivgmOVQxQcyA5r2ya1J7njDo=;
        b=RtkopCiQUH5Tk1NPL63rSul7By6fK5rvstAHn8H9jgUG30En3Jm73srnStZkBS8xgu
         I3UoB+wKjYbSkv/fagXL4X3pecoxh5MQLB5d3kBgtHvPHOvL2JbDytMeQweFDYbP4W0z
         XlzsBJk/JNwgkASGeo/FERHbwHKe008sDtiRKcTPlcjjXQacZ2aUzyukWYH8dW9TsbIy
         I676Pvx/BIUG2nzGCZmE0EdKjxMOY2BeIsqVOSh23fnY92A2cKIofkZSl3agdVzdzEYH
         dnA+Tp3VUmJi0rFEEz86o9M3Dc60v3OZpm1kybspqoe37/3tkv9HAOZ7eOYYa13mQvvL
         Ve6w==
X-Gm-Message-State: AOAM53330MTvlt5zTOoTlp88BUBY08TDadFO2hDfWZ6s+Fs4YJkQQ17i
        7C39azGvNqsnSjRg0atunBMcyUmS3XtKCIuLRrU=
X-Google-Smtp-Source: ABdhPJxfowAA4sAPSA2yE4MWE/avUDcEwPILW9ic1+JvHWVco0LrWJwbX6vAhrFcwak0k9V2Y9zjPXsihltAhlL2IUE=
X-Received: by 2002:a05:622a:4d1:b0:2f3:d1c7:b31f with SMTP id
 q17-20020a05622a04d100b002f3d1c7b31fmr7486618qtx.163.1652065603428; Sun, 08
 May 2022 20:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <202205042019.gOXJsH4f-lkp@intel.com> <CAHp75Vf9wUOKpxa5q8=tJNju_3uzTMbEGcQxAr_f14c_wp-jAQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf9wUOKpxa5q8=tJNju_3uzTMbEGcQxAr_f14c_wp-jAQ@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Mon, 9 May 2022 12:06:07 +0900
Message-ID: <CAGTfZH2Z1aFChMdkg1Quc5UceQuB5+QF2HzzPx8gX5Tk+_U3Jw@mail.gmail.com>
Subject: Re: [chanwoo:devfreq-testing 5/5] include/linux/list.h:638:9:
 warning: this 'for' clause does not guard...
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 11:58 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, May 4, 2022 at 7:02 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
> > head:   40eaf97ddb3a7e661942296ccf192af0edd3d77d
> > commit: 40eaf97ddb3a7e661942296ccf192af0edd3d77d [5/5] PM / devfreq: Use cpufreq_policy instead of NR_CPU
> > config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220504/202205042019.gOXJsH4f-lkp@intel.com/config)
> > compiler: mips-linux-gcc (GCC) 11.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?id=40eaf97ddb3a7e661942296ccf192af0edd3d77d
> >         git remote add chanwoo https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
> >         git fetch --no-tags chanwoo devfreq-testing
> >         git checkout 40eaf97ddb3a7e661942296ccf192af0edd3d77d
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Seems like LIST_HEAD_INIT() calls in the above mentioned patch miss the &.

I had already fixed this build issue and then updated them to devfreq-testing.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=2fc72863d5a5d21e7a7c8da9fdab7c67554a9ab6

Thanks for checking.

-- 
Best Regards,
Chanwoo Choi
