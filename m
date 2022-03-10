Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8405A4D540E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbiCJWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344208AbiCJWAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:00:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F0C194A9C;
        Thu, 10 Mar 2022 13:59:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c192so4079563wma.4;
        Thu, 10 Mar 2022 13:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATGsKfsEtSYY26wkV1+kYw4dYxXJQNfEMLPoJWHhAhM=;
        b=l2ib4k03ezr3E+w+uSGlgSZaXyowvxEhVU+P6ySILubSAD8FmOhnXsPkzfP0JT0JQT
         nCz7H55yKli6hwWPXrpKClt0qWQokGsHGBViNX3SDqVd9Sgj5L115cMM7IOSHauaHQbl
         LEkjN/PDy2CKlM9IxPEWsp8LiG3MNg0d2M4R9C5/5zbJrbLMKFFjgayJTCXJD5izB8RX
         LY7H8i49u9b9wzRTSUOeVI4EQ24/6LJGtvAqkJz5GzADkEeb0hcHGZWyXsXPxgZFpmD6
         /ZMiJ9KwSON1RQJEwLmUKp7XAoxY67j++ehaQEr5YCkE8Nj/Utc4udnOOTYDMSef/Wsp
         TR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATGsKfsEtSYY26wkV1+kYw4dYxXJQNfEMLPoJWHhAhM=;
        b=ZzPXmuZA1ndpL/sGBDI+UuKEBmYT05YIangJUR4opXnZYoSGeQlklS5K0tehPpcmxx
         bRaJWL5YAFJ9IubNswaQT4UlIsuckLbv27UUiT7pI3BnQnRa5c/pGUaD7L+zPsypYHCm
         4i/LhY53aelLcjsKT3/3ZBdlmXqWzG6yriZVRmdn2nidolsA/qT2gx1ev5M82tjsob0f
         GiPP2UhTJc1bPykPMOtsd1/jtsj9ih/GxlEkSFyRo3GtUPYif/bnlvuvdctMiTitFZ8w
         eksOoGLNBAD/Y37vjNzmUR7GVyWxpsj93w2hmKw8j8PjFleiCBqQJyM2eCn0ArzTiH3H
         i42w==
X-Gm-Message-State: AOAM5315hy79IkLQw9qWmd/gQl7eQmgY7b5W7vt02KetXtyh4PqSLJtz
        UBa8t00zvnLyktyGDH9cQTY=
X-Google-Smtp-Source: ABdhPJyFmW0nbFLa/DkX7XyMVXKmus0uuq3D6mmfhOwRhVHwnKbgAncpyTTWuKNzBGM01KrULtLFdw==
X-Received: by 2002:a05:600c:21d1:b0:381:4fed:159a with SMTP id x17-20020a05600c21d100b003814fed159amr5265987wmj.143.1646949590579;
        Thu, 10 Mar 2022 13:59:50 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id o12-20020adfa10c000000b001efb97fae48sm5378277wro.80.2022.03.10.13.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 13:59:50 -0800 (PST)
Date:   Thu, 10 Mar 2022 22:59:49 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v3 10/18] ARM: dts: qcom: add saw for l2 cache and
 kraitcc for ipq8064
Message-ID: <Yip01cebik6drIbT@Ansuel-xps.localdomain>
References: <20220309190152.7998-11-ansuelsmth@gmail.com>
 <202203101733.hkbTGp6Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203101733.hkbTGp6Y-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:46:31PM +0800, kernel test robot wrote:
> Hi Ansuel,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linux/master linus/master v5.17-rc7 next-20220309]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Ansuel-Smith/Multiple-addition-to-ipq8064-dtsi/20220310-031750
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20220310/202203101733.hkbTGp6Y-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/0day-ci/linux/commit/52c3b4af226c7a50772c40012b3789b5348e49b5
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Ansuel-Smith/Multiple-addition-to-ipq8064-dtsi/20220310-031750
>         git checkout 52c3b4af226c7a50772c40012b3789b5348e49b5
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: Input tree has errors, aborting (use -f to force output)
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Just as an info this error comes from the fact that we require
pxo_board, introduced by another series already merged in linux-arm-msm.

I didn't find how to propose this series directly to the linux-arm-msm
branch.

-- 
	Ansuel
