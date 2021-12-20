Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5347B240
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhLTRkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:40:16 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:41963 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhLTRkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:40:15 -0500
Received: by mail-wm1-f53.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so455932wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y7ZEZLqOw5Axnk14+9+aQfWjzNTQeqzG+GxBsOpdHy8=;
        b=DjI1R5ZDvQYCYV0onlya2t/CB44x0SyMTXYRrSpnVzBi87CUpk4sMsZ1fiqGF2B9hm
         Ig/fbMoOdUT8GeLNLMylxVvNjjuRL7Ldz8u4tj+uVFk2j30vUgMaAn20p3wLX+6GuFga
         pcBNucdsMSTnifkN6H4YswMh8jqec6pwmv95/jX1zjFAMeL11mz4maAzwt3XFvWJmJat
         zl/BSJudh4UJb5JMl0YEh0b5mFImNGmRT/QW/YBsqBtBFG6QAh8W4mdBmxpL7jdvUUCl
         ZXvn79rR7SAqRifd34/KY7zmCfTB3Wlzkek4v5ICPK2ksH2sfWR6Ii4Uh70GD4qjhB47
         GnWg==
X-Gm-Message-State: AOAM531LD57VnWGBIUPNzj7cRBgPN+VFGVBBCNOBzTxZ1DoVZkO5j2vR
        q2g2jX5OKUkPVgKwsoOp0erudRgB1pc=
X-Google-Smtp-Source: ABdhPJxVRAvH4a/2UQjhQ/JiCOWaRGIj3pxVtF0X5slOe6NKP916IeOPxBXd85j6YNsgY/xXq6Hn5g==
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr30219wmf.134.1640022014284;
        Mon, 20 Dec 2021 09:40:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p13sm492wms.41.2021.12.20.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:40:13 -0800 (PST)
Date:   Mon, 20 Dec 2021 17:40:12 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [hyperv:hyperv-next 1/5] swiotlb.c:undefined reference to
 `memremap'
Message-ID: <20211220174012.6noufkckz3bdwdzt@liuwe-devbox-debian-v2>
References: <202112202134.o20RMLOK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112202134.o20RMLOK-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 09:20:27PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> head:   63cd06c67a2f46009da6e88ca46f9c7231ab8998
> commit: f16dc95481e2ef2c385008f8b7bd382ea6919ee2 [1/5] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
> config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20211220/202112202134.o20RMLOK-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=f16dc95481e2ef2c385008f8b7bd382ea6919ee2
>         git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>         git fetch --no-tags hyperv hyperv-next
>         git checkout f16dc95481e2ef2c385008f8b7bd382ea6919ee2
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    s390-linux-ld: kernel/dma/swiotlb.o: in function `swiotlb_update_mem_attributes':
> >> swiotlb.c:(.init.text+0x146): undefined reference to `memremap'

Hi Tianyu, can you take a look at this? It seems like the code is
missing come ifdefs.

Wei.

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
