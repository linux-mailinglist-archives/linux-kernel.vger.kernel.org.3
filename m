Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD34E586285
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiHACVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiHACU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:20:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1812AE8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:20:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m8so12013616edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FL6269pemMpnmRW6a2WYgw7o9Iwarc5gVNQUemen3CE=;
        b=oQByfmNI24pr79uSmxZ4AT7q3m2Hn0A/YId5eEqPCiLFH2zaHVflt5Ol7XxkurYUCv
         Ly24dX+8zNf6lOHXfQwCRfempBk6LI+G/WpAXHb+Jj0OHHMQVhmXJS8G8ef7537KfRQv
         8jNVnZXFzK/AfocAkGq0QUehKQE7l0rDT09GV0zBcyDcbER60JVG667TWNOobDdrmqEA
         mS3QpSJJH8QiqGM225F4OtIUnuprDyoieZTSeakpBEPZ3l8PlmgY9fJcEcP+tB2Y56sB
         4x3YQT2CTp6ZVLAO8WU1jmcPXW6+r4CrolqHW7jB/Qj8YME+QhQ6k8yi9W3s3UtYNCbp
         xfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FL6269pemMpnmRW6a2WYgw7o9Iwarc5gVNQUemen3CE=;
        b=O2ug4m9TfR3Tu5aPGBcYAHthU+bw5xL9JK+RTNT+3XodHgeRKEJGtNroyeFhVnBkG5
         rsXXsXGvNMJJ/xJHbaLJj9e9TtCcM4uUz9kpCk7F8JBFrv4JO8xldHQr+eJaxohNP1AU
         Y4eN7a2ROpj1SBm5ITMklkJi5NjbpHwboUeMhVCp57TjpZYAqscIRWSWNURTCcIIKuiu
         K6OYWvTeo3Rwrxq4Wt5gzpL5+LtR0V8v+f7Q9L6Q2ATbjAnCsnxVVV7dRIjzvipG3wpn
         ChjHD0SSJsDGG5EeIGY9HzRqw+9gYfLn1/3W696kAyo3SYhnOvgTDi7Klqnap9QeV/cH
         Vz0Q==
X-Gm-Message-State: ACgBeo2gVTx6TA43Mn+GxOQl4uI0rTyMQRdPt39ocQPPjrN9QdJc8kPq
        TIw31Me/ckCv3wHDUuXR3U8zrA==
X-Google-Smtp-Source: AA6agR4KoEUwwcnlwJzKF6MF312WPGfuGy0TVRtge9Kvx1ilRchqSMgHzbNyGUj2IgAlR16VcDySjw==
X-Received: by 2002:a05:6402:34cf:b0:43d:96fd:bdfa with SMTP id w15-20020a05640234cf00b0043d96fdbdfamr3905237edc.40.1659320454535;
        Sun, 31 Jul 2022 19:20:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906311600b0072b13ac9ca3sm4659207ejx.183.2022.07.31.19.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:20:54 -0700 (PDT)
Date:   Mon, 1 Aug 2022 10:20:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: Re: [steev:linux-v5.19.0-rc8-tests 109/182]
 drivers/interconnect/qcom/icc-rpm.c:378:16: error: use of undeclared
 identifier 'src_qn'
Message-ID: <20220801022050.GC101027@leoy-ThinkPad-X240s>
References: <202207311834.fM0dvTaU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207311834.fM0dvTaU-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 06:04:38PM +0800, kernel test robot wrote:
> tree:   https://github.com/steev/linux linux-v5.19.0-rc8-tests
> head:   171125613e081f0d0d9aeb710dc7469ce2c6a219
> commit: 20386c070c2d12a74092d72aef1c8be37a5f5177 [109/182] interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values
> config: arm64-buildonly-randconfig-r005-20220731 (https://download.01.org/0day-ci/archive/20220731/202207311834.fM0dvTaU-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/steev/linux/commit/20386c070c2d12a74092d72aef1c8be37a5f5177
>         git remote add steev https://github.com/steev/linux
>         git fetch --no-tags steev linux-v5.19.0-rc8-tests
>         git checkout 20386c070c2d12a74092d72aef1c8be37a5f5177
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/msm/ drivers/interconnect/qcom/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/interconnect/qcom/icc-rpm.c:378:16: error: use of undeclared identifier 'src_qn'
>                    do_div(rate, src_qn->buswidth);
>                                 ^
>    1 error generated.

This is the same issue that merged old version patches on the repo
https://github.com/steev/linux, branch "linux-v5.19.0-rc8-tests", as I
described in:
https://lore.kernel.org/lkml/20220801020945.GB101027@leoy-ThinkPad-X240s/T/#t

Thanks,
Leo
