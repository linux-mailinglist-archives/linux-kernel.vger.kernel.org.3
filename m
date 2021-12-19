Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99BF47A07F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbhLSMb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 07:31:28 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:37606 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhLSMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 07:31:26 -0500
Received: by mail-wr1-f53.google.com with SMTP id t26so14198263wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 04:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Ic8ffTWmVfmEB2gzCBz7/NluzmJMQIJw8N84cAZjDQ=;
        b=XJ9i1vnhPetH6O9w3XHm1cEwgWPkFr50u7Is0rEDn/uD0pIKv0ZPY+N8xgrC+1eyPQ
         lT46G84tz0gk32P49oDXJ8vFxQjjd+sqPYc31WxmZqPtxUeHiCilPFpG7EFaYRTFJPkR
         wxKIKJniYBSY0Bf0tx3jUjk6d/h8d0bQZivcgXR3QlSObzHZlEx474cUPPWnaZkVVcpD
         amL62q2hicrtXE8SYrJIW5bqlPDXPWmpscCoXvlF67S6s1pgrC9U88o0TqayrKmMXlm2
         5KumR7ou+XNnlqRlvBcL/NHivyUxgI6KsvhVo9G4+7qJMKW1M0hY1qyrHQEfEnmiOHsW
         hfmg==
X-Gm-Message-State: AOAM532Sqt4wRazavKiuwyh5MDcOrAHkUgJmmXss1Xa+EPrfr0mBj+nB
        FvfJ30ZNkP/UX1qS1M5dCTxmDDkt7fY=
X-Google-Smtp-Source: ABdhPJzuN69aSkDKKezMeqycuOOBe4mmfFZG/h/DqYM/xs8S6kZoeZmb3b+uUtFEfSewlqCpNiIUSQ==
X-Received: by 2002:adf:bb89:: with SMTP id q9mr9584310wrg.337.1639917085644;
        Sun, 19 Dec 2021 04:31:25 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g5sm42533wrd.100.2021.12.19.04.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 04:31:25 -0800 (PST)
Date:   Sun, 19 Dec 2021 12:31:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [hyperv:hyperv-next 5/5] drivers/net/hyperv/netvsc.c:1026:5:
 warning: no previous prototype for 'netvsc_dma_map'
Message-ID: <20211219123123.6bpkyiccjld2ekv2@liuwe-devbox-debian-v2>
References: <202112181204.uRIUsFfa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112181204.uRIUsFfa-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 12:23:30PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next
> head:   19fd7ca00201c0525452dcf5a490e4b01674ef4c
> commit: 19fd7ca00201c0525452dcf5a490e4b01674ef4c [5/5] net: netvsc: Add Isolation VM support for netvsc driver
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211218/202112181204.uRIUsFfa-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?id=19fd7ca00201c0525452dcf5a490e4b01674ef4c
>         git remote add hyperv https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>         git fetch --no-tags hyperv hyperv-next
>         git checkout 19fd7ca00201c0525452dcf5a490e4b01674ef4c
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/hyperv/netvsc.c:1026:5: warning: no previous prototype for 'netvsc_dma_map' [-Wmissing-prototypes]
>     1026 | int netvsc_dma_map(struct hv_device *hv_dev,
>          |     ^~~~~~~~~~~~~~

Adding static should fix this issue.

I've fixed this and the other one in hyperv-next. No need for sending new
patches.

Wei.
