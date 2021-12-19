Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9447A07E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhLSMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 07:30:41 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53236 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhLSMak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 07:30:40 -0500
Received: by mail-wm1-f43.google.com with SMTP id g132so2199650wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 04:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zQLe5zRGi9a/3oGkJNNTO9O6dxdj7gf4jazXfJiYwvQ=;
        b=pZOTEK95c25aGN2Q646uo9kp2o5qVQYyjyzKRe+dySyjG/rRQOy6Iw81L01qeM1qeh
         psWLDgiuGS+vrH6aILVkuf/yQ167ssIHhSA4d7JL/xWAs/7qPxw850YbCfhBNJY1mUwB
         uLaS4TSz4oUa6kTdWa+51O5qLxuMnC+XYhRIkQ95pRUADga3OJXwjSlT60ryWksmKCQI
         tsOceP9AzF2bCaRl7bbkgFURnib0vi6ryLgMpkV9GeRGPJSONC1nDzC1oDvSY5twdoKX
         JD1nY9rR6/e/kFHOGkdV+gKUfpAqO+/peGBY80hGGfkOijEfGT0TvLTa86UVd3MuOCWD
         z3Gg==
X-Gm-Message-State: AOAM532SijSvprkPXUAy7HDmikW+AT4PDG9ZKsn+j1wFXGH+fyJ0pTeX
        l1teZYqh3P5/RJrhrH/rpSg=
X-Google-Smtp-Source: ABdhPJxIk51QGGwqul5O0w0jEw2BtUwrV4d17r5hVHLtxFG0DCB2TI14RSnnomFTL9xT6X9/c3ZNdQ==
X-Received: by 2002:a05:600c:34c1:: with SMTP id d1mr12706891wmq.139.1639917039095;
        Sun, 19 Dec 2021 04:30:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a1sm13019336wru.113.2021.12.19.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 04:30:38 -0800 (PST)
Date:   Sun, 19 Dec 2021 12:30:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [hyperv:hyperv-next 1/5] kernel/dma/swiotlb.c:166:7: warning: no
 previous prototype for 'swiotlb_mem_remap'
Message-ID: <20211219123037.uamx2iblzp2mzs7e@liuwe-devbox-debian-v2>
References: <202112181114.Vxt6EAJR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112181114.Vxt6EAJR-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 12:03:07PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
> commit: 32be866293fe5355adbf91da1cd612f439fc71e5 [1/5] swiotlb: Add swiotlb bounce buffer remap function for HV IVM
> config: x86_64-randconfig-r001-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181114.Vxt6EAJR-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=32be866293fe5355adbf91da1cd612f439fc71e5
>         git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>         git fetch --no-tags hyperv hyperv-next
>         git checkout 32be866293fe5355adbf91da1cd612f439fc71e5
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/dma/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/dma/swiotlb.c:166:7: warning: no previous prototype for 'swiotlb_mem_remap' [-Wmissing-prototypes]
>      166 | void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
>          |       ^~~~~~~~~~~~~~~~~
> 

Adding static should fix this issue.

Wei.
