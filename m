Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC99585145
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiG2OGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiG2OGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:06:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4132D9A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5IjEeQk2j+nPMiWSIvtN9x/RruJpf321jwMLwDJFZTc=; b=BGfR3cb2FkJJ4m916YBe2HiiBQ
        62mu5kNYyrk4NGLFM08pxuAXb9/zWj8tKfK38OktLZj8XdsbNPAv+cILtLtTZUGyrHQPr1o9q1xML
        +vxdZwO0PZtgvFxZ4anj7rIypQ2108Z9sQKBkFrKf2kLZT2Dc3wnRIieDQjTuagFAOAOsqzljeRhx
        EKoWONKa/nQ4MWxO/v4z2h3gyMlkruW3+n7gIYR7rmUo0uA3tWsXWt8LhzXOQKT6vSyijwO7LMfCR
        uvJTJpK4l/iikzxm3SSXV9s0m6gzfnGppAsz2DU2MlV2dooFJia25MKxg+gUMaQjm+QeXYJCGfLlw
        DUJerLOQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oHQdD-005OII-KS; Fri, 29 Jul 2022 14:06:23 +0000
Message-ID: <607e46e9-1b4d-c8be-899f-185afdc83f42@infradead.org>
Date:   Fri, 29 Jul 2022 07:06:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: drivers/mux/mmio.c:76:20: error: variable has incomplete type
 'struct reg_field'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <202207292122.eOyFc13E-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202207292122.eOyFc13E-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/22 06:58, kernel test robot wrote:
> Hi Aswath,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6e2c0490769ef8a95b61304389116ccc85c53e12
> commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
> date:   4 months ago
> config: s390-randconfig-r022-20220729 (https://download.01.org/0day-ci/archive/20220729/202207292122.eOyFc13E-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 8dfaecc4c24494337933aff9d9166486ca0949f1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e4d4371253029528c02bfb43a46c252e1c3d035f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e4d4371253029528c02bfb43a46c252e1c3d035f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/mux/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

Fix is here:
https://lore.kernel.org/lkml/20220728000550.10495-1-rdunlap@infradead.org/


-- 
~Randy
