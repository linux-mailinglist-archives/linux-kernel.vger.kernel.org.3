Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2A52AB21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352336AbiEQSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbiEQSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:44:51 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72638BED;
        Tue, 17 May 2022 11:44:50 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b11so9301495ilr.4;
        Tue, 17 May 2022 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIAjTESKXuKYbBQ9smbJ5hCbcUOqEoo/oz4gEnlQ78Q=;
        b=DPgmtPQWVfA3vIbNMZQ3dlB/yGfi3Ix95EyelERGa2sVYKTgoWsnPHlqe6MI7KR6Za
         Xc56f9NFCWdGj6A+8h9DLBTvnabeJSS8noRHcYS+/rq9a3LyAygydGbD+KWtpZm5UPNP
         3Rbn+rlpL3qwU5ywElBhJLGd0PAQ3JbAe6qc+su2arsmnbAPJYc+hPbHNv+fibtYsI/i
         Mge1RL/gj77qG0xQuzam2uUrun2aQO49inccAs2JNRJexspMRIfi+Xe8EhybHburMiFg
         +FJfywHSoDA/NwOp78r56JLl5icJd8Fo7xBKwdt6VAlkI09mcW4AIpXCJXrIk30h8fJK
         c8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIAjTESKXuKYbBQ9smbJ5hCbcUOqEoo/oz4gEnlQ78Q=;
        b=Ko75p3lvcyZ/HVNStwNrRnKNQcBBj+4HNQm6qZuLmLaXfpSL9QPX6xa/LwOqhF54xX
         2WpOjjUrlF5CTVoJaC2BKABwfnYy+ufPtqPyRiFM7NquQsWX/hiC1Rw1WfzWjqPnwOOk
         jtJSGZJVqZNKL03eQ2j3R4zzhbtH8LrFsLqp1FYUTdPalkCfqnvFqJzWzUWlsFlA15Yp
         IfpoI23Kjk505c0Y+/h1EBp4gYKQGn3gx3udELNYl0dyQG0rxiJ7RI3tL8pH8RyjDMz7
         rMb2HWhjxnX8yFWVgKITnC1gRqMGnDGifu5vkqxsF6g7L7yWIpcy29WdKdeJ8VkjrphP
         azNA==
X-Gm-Message-State: AOAM531QxrmCBK5lYMnDP2scbVmgoAmTXx5xGzxkTMPE2DKPa49JHWny
        SL2LwWhPO0fpoMYtxZR99w01rK4ZSHdXS00U5QY=
X-Google-Smtp-Source: ABdhPJwuI7b6xuzFoTXjG7KE+Q7htUi038IRRyyz2kzkuHY0dU8pIBnJ7MCtA6HBtUEHkVk0DAzG9BsMMgZrbNM3E/s=
X-Received: by 2002:a92:509:0:b0:2d1:2766:1820 with SMTP id
 q9-20020a920509000000b002d127661820mr5123564ile.6.1652813089835; Tue, 17 May
 2022 11:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-5-linux.amoon@gmail.com> <202205161820.8rHIcsvI-lkp@intel.com>
 <874f08d9-e67e-f7f3-4d98-89bdb8333ce5@kernel.org>
In-Reply-To: <874f08d9-e67e-f7f3-4d98-89bdb8333ce5@kernel.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 May 2022 00:14:35 +0530
Message-ID: <CANAwSgSAAmM5iUdeS296dOOhDGN5EfFHkpSMudw6BXrw4oH7ZA@mail.gmail.com>
Subject: Re: [PATCHv2 4/6] thermal: exynos: fixed the efuse min/max value for exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org
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

Hi Krzysztof,

On Mon, 16 May 2022 at 16:14, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 16/05/2022 12:42, kernel test robot wrote:
> > Hi Anand,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on ec7f49619d8ee13e108740c82f942cd401b989e9]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/Exynos-Thermal-code-inprovement/20220515-144336
> > base:   ec7f49619d8ee13e108740c82f942cd401b989e9
> > config: hexagon-randconfig-r033-20220516 (https://download.01.org/0day-ci/archive/20220516/202205161820.8rHIcsvI-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/intel-lab-lkp/linux/commit/eb50b0c2100fabd6d09b87abd11f52c5295512e8
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Anand-Moon/Exynos-Thermal-code-inprovement/20220515-144336
> >         git checkout eb50b0c2100fabd6d09b87abd11f52c5295512e8
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/thermal/samsung/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/thermal/samsung/exynos_tmu.c:929:40: warning: overlapping comparisons always evaluate to false [-Wtautological-overlap-compare]
> >                    if (data->soc == SOC_ARCH_EXYNOS5420 &&
> >                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
> >    1 warning generated.
>
> Ah, I did not notice it and it seems code was not compile-tested with W=1.
>
> Anand, please be sure you compile your code with W=1...
>
Ok I will try to resolve this warning in the next version.
>
> Best regards,
> Krzysztof

Thanks & Regards

-Anand
