Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2C47A07D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhLSM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 07:29:41 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39856 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhLSM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 07:29:40 -0500
Received: by mail-wr1-f54.google.com with SMTP id s1so8785364wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 04:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/nOnLrUtXLrdXzK8zEtzWYdMs/JTFryzu35YjyVQIs=;
        b=TG1oa45Fpdyl742OQAhrkQc96uWKEvMHy/bQ6rNCxf/skKKIqht7QzFvozcKQD14m4
         EuCt02q/uPEiAfI6HZ1tdtfC6N/8EwGw91J7CrQrCaA+v99OpWioqXKxl2A+XHTcU5Nt
         jbN7Hhi4Cyl5QuEu0kuvtuHeaC0khn5tfkeOBI5n5HvgmRb/NFfqnCgd1nsAYLW0qmEH
         m2LEAlZzGc2mzdhOof0Z1uO7cbhb+sniPDgODm15g5OZMeBg8UirJHoa+JmkkoDGKJh5
         sbkdoREILhTWwBY4AM0RoAIeNY8mHmx9H0Xt/YTA5JdYB84b2BQsUq5bJJhEYciek8EF
         YV9g==
X-Gm-Message-State: AOAM533PSn8wEBdH0uRULZ9E/D8XMVwlda6H0RgN7qAO6U4ACM/8ONez
        Q2Ke8dtRTdkYwp1YVZ7HP2EOwwa6cDU=
X-Google-Smtp-Source: ABdhPJysFM6BWBZTOk5G+YgnuuZ4kNGbN46pkZcNsmQK1+ha5AI4dHgEynWCKy5DDVZEsNzKYaegNg==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr9586156wra.715.1639916979473;
        Sun, 19 Dec 2021 04:29:39 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c187sm13879999wme.33.2021.12.19.04.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 04:29:39 -0800 (PST)
Date:   Sun, 19 Dec 2021 12:29:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [hyperv:hyperv-next 4/5] drivers/hv/vmbus_drv.c:2082:29:
 warning: shift count >= width of type
Message-ID: <20211219122937.7zi3etrcl6rpob3t@liuwe-devbox-debian-v2>
References: <202112181827.o3X7GmHz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112181827.o3X7GmHz-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 06:20:43PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
> commit: 6327882f7b4a476ea902de4bee5657f1028d6859 [4/5] scsi: storvsc: Add Isolation VM support for storvsc driver
> config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181827.o3X7GmHz-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c9e31a4814592bbda7153833e46728dc7b21100)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=6327882f7b4a476ea902de4bee5657f1028d6859
>         git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>         git fetch --no-tags hyperv hyperv-next
>         git checkout 6327882f7b4a476ea902de4bee5657f1028d6859
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hv/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/hv/vmbus_drv.c:2082:29: warning: shift count >= width of type [-Wshift-count-overflow]
>    static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
>                                ^~~~~~~~~~~~~~~~
>    include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
>    #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>                                                         ^ ~~~

I don't think there is anything wrong with the code. When n is 64 the
problematic expression is not evaluated.

Wei.
