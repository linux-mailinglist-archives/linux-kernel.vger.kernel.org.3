Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7EF54C29D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbiFOH36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiFOH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:29:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA82CCAB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:29:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so1233183pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1McsJNnLvrqzrHYMPKDInCXH6EJctCix0Cbq3LM9G0=;
        b=NABI4D0t3m5x2syejX89LWq65D2UrHq6lCZeBwW/C3ZatgM6ljmnZ2lBfwiRLGFTK3
         vFevCAaVhxMwLxYjTSeCY6VIErShoj8zlJJIQXlsDCkonPk2OVaE6U00Km+gPHSi6lg+
         4AyCr7rNER/6wSeKdrpGdfJA2SSDbFFInZZ172j7Q/PwtQy1/770YfXog9q8CFWrN7/h
         ST/zVZK0WmkNAq/abtKphBm4H1qAvdPiSoVuzq07SlUlqjwlToR+2P2EmRiaIDkgl8TJ
         4pemSH+VfbRdV3OXRAOpSstYiWyPsA/xrHYxYpm6DKMkS0GpMr19oNCsW7BfWyp+IVsx
         CZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1McsJNnLvrqzrHYMPKDInCXH6EJctCix0Cbq3LM9G0=;
        b=YRaYqauMGQRosCi5p0coL7QEsDT3sp9//9cy+Rf2TlTheAecFaSS/IM/BqzLMHst1k
         Q/mixIgupnIGdjExiy2Hm5+kAmwfjwkIzDejOIH5vyN6k9DJuATjFzEAMFjWw8Mu+owY
         CtUoZhb5GA6lC1TcCJ4RwpI3YWP3N7Y7pGcfTyM/miLpanv73GeSNK7MfZNvRFNMSL+m
         aloG3uKf1m2QK58yUJaEkqiS6kR2iKYcbfyBliDKtfqsiRMOULTshcWJ2WIMc7DDbFc7
         M1tvaeAh2PIfcoTTPuBVHZrA9GSlY1axnHxSHkouNQCXn5o59ymr5ePnH61KU2hMcxAG
         MP4w==
X-Gm-Message-State: AJIora8PGmaohtbigFMBlcAGDl3P50K6a+EjRcOTzt8F+KpVEyZlQMn8
        gbVJoW3AqUFEgwoOSupX2I54jrwvXDI=
X-Google-Smtp-Source: AGRyM1s6jJMN8aRjKhxzf67syj+/RwBbH3rZzC8yLp8O61v6uJpxl4z18N2Eosu68/fPZW+1CmaJpA==
X-Received: by 2002:a17:90a:4503:b0:1ea:4718:829f with SMTP id u3-20020a17090a450300b001ea4718829fmr8463554pjg.103.1655278193474;
        Wed, 15 Jun 2022 00:29:53 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a0023c800b0051c49fb62b7sm8926476pfc.165.2022.06.15.00.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:29:52 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:29:51 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [stffrdhrn:or1k-virt 1/4] drivers/parport/parport_pc.c:68:10:
 fatal error: asm/parport.h: No such file or directory
Message-ID: <YqmKb4thAtT6za5A@antec>
References: <202206151530.3eDDbhQ1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206151530.3eDDbhQ1-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:08:55PM +0800, kernel test robot wrote:
> tree:   https://github.com/stffrdhrn/linux.git or1k-virt
> head:   a0ea15d897c0baa5a4dc8f4ec3c8839527c43e89
> commit: a65c4ddd8782b2255f4387fd1273b96dacc7c8a6 [1/4] openrisc: Add pci bus support
> config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20220615/202206151530.3eDDbhQ1-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/stffrdhrn/linux/commit/a65c4ddd8782b2255f4387fd1273b96dacc7c8a6
>         git remote add stffrdhrn https://github.com/stffrdhrn/linux.git
>         git fetch --no-tags stffrdhrn or1k-virt
>         git checkout a65c4ddd8782b2255f4387fd1273b96dacc7c8a6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/parport/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/parport/parport_pc.c:68:10: fatal error: asm/parport.h: No such file or directory
>       68 | #include <asm/parport.h>
>          |          ^~~~~~~~~~~~~~~
>    compilation terminated.

Interesting, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
systems") all PCI systems also need to support parport.  I have added a generic
include to provide asm/parport.h now to this branch.

Thanks,

-Stafford

> 
> vim +68 drivers/parport/parport_pc.c
> 
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  64  
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  65  #include <linux/parport.h>
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  66  #include <linux/parport_pc.h>
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  67  #include <linux/via.h>
> ^1da177e4c3f41 Linus Torvalds 2005-04-16 @68  #include <asm/parport.h>
> ^1da177e4c3f41 Linus Torvalds 2005-04-16  69  
> 
> :::::: The code at line 68 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
