Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1E04B3FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiBNCz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:55:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiBNCzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:55:55 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AE85047B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:55:48 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id om7so13193358pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JBMqJAg0Iu8wQSp5eguZrpPDFddsizTvYGRVzmbAV2Y=;
        b=mbvTo0Yaf6j4By95XOoWzflRCzZVmZ1BFetLopkBqaHUdJDLeBb3hGDAMALRUyfNyK
         af8Xe/HQ2qxJ9sZRhoTF2rU6EjeczIRpZi8SbUm56mmBNCwmPQZgRrdI+j+gywwu7oPh
         NQaog/rOYRVTp94ZiAnuMEzg0fsHKujO8nwVtBZhqMg4YXXTKrESjTbksqdb4tuY6SxX
         WRCJe5A9Kj0wQF++IntkZhiA+X3O/O+S/fKHdcuu6mJCXqgLM7SReaE6Lg/fuyPiVjfW
         0WAFz/wwgz+mw3qmDW2M4mTvDyIy7RKSFta+S7S6bd+4TKykeNam4R5sOhJkOhkKIfwi
         IaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JBMqJAg0Iu8wQSp5eguZrpPDFddsizTvYGRVzmbAV2Y=;
        b=WnPvmjka/Kg3cQea1dKxcQt2a0I5NwtzdpSfRuZUSfskOx6+okpTTfIxGPYBQbm+Eu
         2Y+960mqQPhegv8g+DmRc1I5X++diVEfAOkGTEgXaUbKaf8S503AE2ieYH9ET/IsjWFZ
         DmbccilTrHmJU4LpmLMYC3O2BqM7RCDya//ra2kxWaYPN9zGCAjXghv80EndnyhMiau2
         guIRf84Vn04RogjPOUuzGcIufFZL5xEXbUFZj5bjHb/TohOpfYz/6xWit6u+FAvDJ7e0
         0NRCcamRomvFjItgoBqC0ctP5qnzLH6wjdMLn88dSrbxkkTt+au6APRhq0XJwBtASIMI
         6+Dw==
X-Gm-Message-State: AOAM533f+bDI23/hzw3BFeJo5BR9YlUf9rywlQjz0oIqZhrL3E/Co1dl
        DO4yMXYSTM2I85+yI9ZzKeM=
X-Google-Smtp-Source: ABdhPJym/R0+TTD89S8UMNbnc7HFPDm4jDBwBxW2jgWiytWUb2/24uVZJOnj7NStH+BLfRGklIEZNQ==
X-Received: by 2002:a17:902:f707:: with SMTP id h7mr12415226plo.96.1644807348279;
        Sun, 13 Feb 2022 18:55:48 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bfd9:7c7:cdd6:dcdc])
        by smtp.gmail.com with ESMTPSA id f22sm34904390pfj.206.2022.02.13.18.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 18:55:47 -0800 (PST)
Date:   Sun, 13 Feb 2022 18:55:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: kernel/module_decompress.c:264:36: error: 'module_kset'
 undeclared; did you mean 'module_use'?
Message-ID: <YgnEsbnHXiuanfY/@google.com>
References: <202202140027.K0xZn3T2-lkp@intel.com>
 <b45a15ec-549d-25ba-f818-ed503ba991de@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b45a15ec-549d-25ba-f818-ed503ba991de@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 04:34:49PM -0800, Randy Dunlap wrote:
> 
> 
> On 2/13/22 08:57, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
> > commit: b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7 module: add in-kernel support for decompressing
> > date:   5 weeks ago
> > config: sparc-randconfig-r005-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140027.K0xZn3T2-lkp@intel.com/config)
> > compiler: sparc-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout b1ae6dc41eaaa98bb75671e0f3665bfda248c3e7
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash
> 
> FTR/FYI:
> # CONFIG_SYSFS is not set

Ugh, why is this even a thing?

> 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    kernel/module_decompress.c: In function 'module_decompress_sysfs_init':
> >>> kernel/module_decompress.c:264:36: error: 'module_kset' undeclared (first use in this function); did you mean 'module_use'?
> >      264 |         error = sysfs_create_file(&module_kset->kobj,
> >          |                                    ^~~~~~~~~~~
> >          |                                    module_use
> >    kernel/module_decompress.c:264:36: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > 
> > vim +264 kernel/module_decompress.c
> > 
> >    259	
> >    260	static int __init module_decompress_sysfs_init(void)
> >    261	{
> >    262		int error;
> >    263	
> >  > 264		error = sysfs_create_file(&module_kset->kobj,
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> -- 
> ~Randy

Thanks.

-- 
Dmitry
