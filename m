Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D8347B250
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhLTRok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:44:40 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41860 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhLTRoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:44:38 -0500
Received: by mail-wr1-f48.google.com with SMTP id a9so21614366wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COpSoZwmnRvBNoLHp+2DxbYAIb0dSgQ0tqkVz4IdVjY=;
        b=1t9gqZ43iRXfn6B9k9biRCIz7g+AKV/nZ6DHiXjbjkyVpPENcjvyeSFLKZKC2eDmap
         ToOkOGk68cwxvQ4iKr1d6jaGdpfvapOsPtoEDvYApmqBoEKTosL/H/2YUuPddyteZINs
         U44cNw1Qj8yn/yRygkaglDEO7R1IzybfQdmZPR5QHeYPgdPV53sETZljU53aYwhucsJA
         0K1tQqqWYhTv9RaJZq+WwRVT7jbcCu/lRy6xhIDoXbPes+2WsdFxNfKCbOxlGww7QxlO
         z/0LfG6lAgl8jfPxQ5IcNQmmmJ6v6ezHL4nr2/Mi/ZkztpmywQH9SnTrLcZpqEvm2yjZ
         Rf2A==
X-Gm-Message-State: AOAM531bxELSr6ICcahkU2IAMxNUHxinvlOc0Z8oTNtCQTu3Z3KbDnwa
        tNARW0tG/PQu4QCoEICi84E=
X-Google-Smtp-Source: ABdhPJzRF+ZPpVA5NWW+LdDQ/fybqOOqa0SuF9Tqv5iH/rurEe4M3yMlfZN03Z4YyH6eXS2K7+uE8w==
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr13798439wrv.299.1640022277280;
        Mon, 20 Dec 2021 09:44:37 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k9sm6165763wro.80.2021.12.20.09.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 09:44:37 -0800 (PST)
Date:   Mon, 20 Dec 2021 17:44:35 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kernel test robot <lkp@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [hyperv:hyperv-next 4/5] drivers/hv/vmbus_drv.c:2082:29:
 warning: shift count >= width of type
Message-ID: <20211220174435.2mv4gna5eu7awzt5@liuwe-devbox-debian-v2>
References: <202112181827.o3X7GmHz-lkp@intel.com>
 <20211219122937.7zi3etrcl6rpob3t@liuwe-devbox-debian-v2>
 <YcC1CobR/n0tJhdV@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcC1CobR/n0tJhdV@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 09:53:30AM -0700, Nathan Chancellor wrote:
> Hi Wei,
> 
> On Sun, Dec 19, 2021 at 12:29:37PM +0000, Wei Liu wrote:
> > On Sat, Dec 18, 2021 at 06:20:43PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> > > head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
> > > commit: 6327882f7b4a476ea902de4bee5657f1028d6859 [4/5] scsi: storvsc: Add Isolation VM support for storvsc driver
> > > config: x86_64-randconfig-a013-20211216 (https://download.01.org/0day-ci/archive/20211218/202112181827.o3X7GmHz-lkp@intel.com/config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4c9e31a4814592bbda7153833e46728dc7b21100)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=6327882f7b4a476ea902de4bee5657f1028d6859
> > >         git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> > >         git fetch --no-tags hyperv hyperv-next
> > >         git checkout 6327882f7b4a476ea902de4bee5657f1028d6859
> > >         # save the config file to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hv/
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > >> drivers/hv/vmbus_drv.c:2082:29: warning: shift count >= width of type [-Wshift-count-overflow]
> > >    static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
> > >                                ^~~~~~~~~~~~~~~~
> > >    include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
> > >    #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > >                                                         ^ ~~~
> > 
> > I don't think there is anything wrong with the code. When n is 64 the
> > problematic expression is not evaluated.
> 
> Yes, unfortunately, this is an outstanding bug in clang where it does
> not properly build a control flow graph for expressions at a global
> scope:
> 
> https://github.com/ClangBuiltLinux/linux/issues/92
> 
> We should absolutely fix that but it has not come up too often so other
> fires have been prioritized. Now that -Werror is a thing, that issue's
> priority should probably be upgraded, as this warning will break
> allmodconfig for clang.

Thanks for the explanation.

> 
> If you were feeling generous, just changing that to ~0ULL directly would
> solve the warning but I get that it is less documentation that way.

I would actually like to keep the code as-is because it gives a clear
idea what it is doing.

Wei.

> 
> Cheers,
> Nathan
