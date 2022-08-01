Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D158626C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiHACJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiHACJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:09:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D84BF57
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:09:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i13so12005240edj.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BBLGJgqrxKmOlYwdqLQrhZ+frwZmlh/xKfWie6DoDoc=;
        b=BTeKOMOqDGkJgtZ0Tw457yqJsxlQFBfuepvwXJo1HGHM4q1SZEyTM3OW9c+rJ8yxJJ
         sSJ4ndjY/dnqK4l4I9stbetdydL88F7vPldrz2ulAcm8nIyRzQWLYVjgDX+XBKO8xAbi
         3FauDLxGhFJK7kxcxDJN0HgPBvPL+FXzRLirgep9CC9n5bDEqXJ8E8vRH0XxyZNWsFdU
         /43U4BujaDTEX1Vstxh/QFGBBo9S/9anuO/iMjb+x8885NjkiqLjeo0cv9P1OP3YJyIc
         2f/9VsnCZopRplnCpTZClUCAIkooUTp9e5D8yXpxWNGH0K3HmV/fz8tYo7JIh1TuIke2
         9iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBLGJgqrxKmOlYwdqLQrhZ+frwZmlh/xKfWie6DoDoc=;
        b=JOP4s1pzqLsreXzYpiWwusCsyx2DcTK+8y/yLpsdPqjBh5FtkKZMNn5Ei/zlR3u+rR
         ABdytw0xBvCqruJXbXfZN4kBsfwkEfyQlHrhmHza0KAmI1w07exPQxA3VFdaSa7wPRSt
         Rw+ZTlaS/R0gGuP1kNxr7rsOQu3ftsecn0WxP/9RlSrjjQP93YnV0Zqy7CdpjaZFDLZT
         36uDsM1ljel58ypOXXrs29nmUk/O/YyQstt+VfFsghtTi9XkbMjpTj91XXEPNd5B51Rt
         Q/OXYNkKXh0Dw09uowFAdE3Hnz2oas/zawp7M6gdGW72J1ALs1d//pSswLqYO86qZVlB
         inZg==
X-Gm-Message-State: AJIora8C2Aw6qtl321nymsJo9Jq5Dl4rswbm1jl5aZyTNahnWKyf6vKF
        +X8JjWcqXC319uWVCSaLpKZgWDrtUlTESlXVUUc=
X-Google-Smtp-Source: AGRyM1uK+3aQ1CAg+DFag6c+VmdWVaQ2j7RoEr/hmbtfPBQqxNwTrAZiHrD9Q27Gq1l1JvrEI89lmA==
X-Received: by 2002:a05:6402:4016:b0:43a:f310:9522 with SMTP id d22-20020a056402401600b0043af3109522mr13703761eda.200.1659319789493;
        Sun, 31 Jul 2022 19:09:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709064d4200b0072a430d2abdsm4637922ejv.91.2022.07.31.19.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:09:49 -0700 (PDT)
Date:   Mon, 1 Aug 2022 10:09:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [steev:linux-v5.19.0-rc8-tests 109/182]
 drivers/interconnect/qcom/icc-rpm.c:335:13: warning: variable 'max_peak_bw'
 set but not used
Message-ID: <20220801020945.GB101027@leoy-ThinkPad-X240s>
References: <202207311704.9ojLA4JI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207311704.9ojLA4JI-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 31, 2022 at 05:43:31PM +0800, kernel test robot wrote:

[...]

> tree:   https://github.com/steev/linux linux-v5.19.0-rc8-tests
> head:   171125613e081f0d0d9aeb710dc7469ce2c6a219
> commit: 20386c070c2d12a74092d72aef1c8be37a5f5177 [109/182] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20220731/202207311704.9ojLA4JI-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/steev/linux/commit/20386c070c2d12a74092d72aef1c8be37a5f5177
>         git remote add steev https://github.com/steev/linux
>         git fetch --no-tags steev linux-v5.19.0-rc8-tests
>         git checkout 20386c070c2d12a74092d72aef1c8be37a5f5177
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/interconnect/qcom/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/arm/include/asm/div64.h:107,
>                     from include/linux/math.h:6,
>                     from include/linux/kernel.h:25,
>                     from include/linux/clk.h:13,
>                     from drivers/interconnect/qcom/icc-rpm.c:6:
>    drivers/interconnect/qcom/icc-rpm.c: In function 'qcom_icc_set':
>    drivers/interconnect/qcom/icc-rpm.c:378:30: error: 'src_qn' undeclared (first use in this function)
>      378 |                 do_div(rate, src_qn->buswidth);
>          |                              ^~~~~~
>    include/asm-generic/div64.h:220:28: note: in definition of macro 'do_div'
>      220 |         uint32_t __base = (base);                       \
>          |                            ^~~~
>    drivers/interconnect/qcom/icc-rpm.c:378:30: note: each undeclared identifier is reported only once for each function it appears in
>      378 |                 do_div(rate, src_qn->buswidth);
>          |                              ^~~~~~
>    include/asm-generic/div64.h:220:28: note: in definition of macro 'do_div'
>      220 |         uint32_t __base = (base);                       \
>          |                            ^~~~
> >> drivers/interconnect/qcom/icc-rpm.c:335:13: warning: variable 'max_peak_bw' set but not used [-Wunused-but-set-variable]
>      335 |         u64 max_peak_bw;
>          |             ^~~~~~~~~~~

I observed on the repo https://github.com/steev/linux with the branch
"linux-v5.19.0-rc8-tests" doesn't contain the latest patch set for
"interconnect: qcom: icc-rpm: Support bucket", it contains patch:

https://github.com/steev/linux/commit/20386c070c2d12a74092d72aef1c8be37a5f5177

We can compare with Greg's char-misc.git branch, it contains patch:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/drivers/interconnect/qcom/icc-rpm.c?h=char-misc-testing&id=e3305daad62c90068e755cdae36a86ac4f02af22

I don't know how these old version patches have been merged to the
repo https://github.com/steev/linux, but it's good to sync with latest
patch set.

Thanks,
Leo
