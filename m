Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77854EBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377297AbiFPVCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbiFPVCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:02:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A64B7F2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:02:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y19so4994785ejq.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=asn117f4eyt+iXohUjxXZmDp8iptTgbbA4qD4fixMbQ=;
        b=qzzqOmzWYubrcc90aIkqwXJfUnQcvo5WKX/6BUw3G6PyQxdaMBuHqTz76KxJvquo6O
         Yebve/5oexbW7SOEzoYohFUa30ik6Y5hQpBEhuX6qcF+gVcToDyhjlvxk+FqQ9f0ERlv
         jQO4IMnys2MPzDTUrB6mX1iRM8kEU1R+53pT0M44gKtZCKjZrBtIn0XAoXnyNM92bW6X
         nTr9m99rbRiSJJ3D3KWlGkmh+5GPIbORXZCnQNw1UdVPugC0CwMLEJKCBiTlm+PMhr3Z
         Wp4BcFFNd5ASHJm0veRebowOmAFKeMQHcX7iGkAV2DtD1XrvE0dp+h43nJtbDdghopnK
         62FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=asn117f4eyt+iXohUjxXZmDp8iptTgbbA4qD4fixMbQ=;
        b=KZEkMwkdXZueHtrikMwi2e21xSEjxvqyTcexEsfa6nQlbbewe9E2w41Sv72Dzl5uD6
         KNHMdjKCFgCyZ0NevNiQuL6r/7izzZoK4JWmiujF/dlT3A6lPDD0EkRLnxx5DH/F4rpc
         sxk7gRIxoOVJZPqhAhgbDqeVJL/4osKpO+lJM7u8tHoed3CB1VUI51eEik+9BgyBTZGS
         TxhuJjckJgg7m9g1NFxI4MLXszx/G/WTxqojNxJhcyP5iM0VR2dN+WvMv6DgOa6msVa5
         apzYqFydrrZ+SHU954Nn/YakXiS9k9zZiVwlCykbPGyedFbtnE7Zsj9pkvdjkP7kFi0L
         IWig==
X-Gm-Message-State: AJIora9fmhd11FyejJw7Bjhumffpt4P1sVwFgvQysyMttNnO73NMz41t
        +BSLDKv/doC/N6OnRUv1HPPqjH9arZU=
X-Google-Smtp-Source: AGRyM1uxrKeFSGnGYsdiXmebDdX/44HqHinoKKLl3LUYc4x1UxqLO1y18706JwThpIOuQwHINMlC2A==
X-Received: by 2002:a17:907:7da2:b0:711:f36e:b855 with SMTP id oz34-20020a1709077da200b00711f36eb855mr6369094ejc.308.1655413362377;
        Thu, 16 Jun 2022 14:02:42 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b006fea2705d18sm1201310ejf.210.2022.06.16.14.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:02:41 -0700 (PDT)
Message-ID: <62ab9a71.1c69fb81.4a827.2a61@mx.google.com>
X-Google-Original-Message-ID: <Yquab9NgOVikXFuN@Ansuel-xps.>
Date:   Thu, 16 Jun 2022 23:02:39 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [jkirsher-next-queue:master 1/5] ld.lld: error: undefined
 symbol: qcom_smem_get
References: <202206170405.fqVbBgOE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206170405.fqVbBgOE-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 04:55:55AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git master
> head:   5dcb50c009c9f8ec1cfca6a81a05c0060a5bbf68
> commit: 9ec092d2feb69045dd289845024301fb91c064ee [1/5] net: ethernet: stmmac: add missing sgmii configure for ipq806x
> config: riscv-randconfig-r042-20220616 (https://download.01.org/0day-ci/archive/20220617/202206170405.fqVbBgOE-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=9ec092d2feb69045dd289845024301fb91c064ee
>         git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
>         git fetch --no-tags jkirsher-next-queue master
>         git checkout 9ec092d2feb69045dd289845024301fb91c064ee
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: qcom_smem_get
>    >>> referenced by socinfo.c
>    >>>               soc/qcom/socinfo.o:(qcom_socinfo_probe) in archive drivers/built-in.a
>    >>> referenced by socinfo.c
>    >>>               soc/qcom/socinfo.o:(qcom_socinfo_probe) in archive drivers/built-in.a
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for QCOM_SOCINFO
>    Depends on QCOM_SMEM
>    Selected by
>    - DWMAC_IPQ806X && NETDEVICES && ETHERNET && NET_VENDOR_STMICRO && STMMAC_ETH && STMMAC_PLATFORM && OF && (ARCH_QCOM || COMPILE_TEST
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Mhhh is patch QCOM_SOCINFO to select QCOM_SMEM instead of depends on it
the correct fix for this?

(btw smem should always be selected for ipq806x as it's used for other
critical stuff like cpufreq speedbin and thermal)

-- 
	Ansuel
