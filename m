Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAAA46BA20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 12:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhLGLgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 06:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhLGLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 06:36:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECCAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 03:33:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i5so28864251wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 03:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W+jl/ZL6Ni2iJkvnbGpHwSuKGjkdbemchwt4upixgmM=;
        b=oFABvotOOBZR4NlvwPo/m+RR0AOH8nY+YolX4mtFCDkCZs0/oq92ZvkuJwPfm3hbUR
         jwzjo8Cpch8bBsxLIoAr1J6gcqPAy7lY9ECZ7rFK3FebmVtjYy6xRtDCnH86AeQAG/N3
         8aMH5FEVFP0b4/r4sLis56jXp2xcf30+tjZpxKSdXg2f7jTlg5caMN0uOT2KhR+UHFtN
         BonfxLRAfDWkOWPJv93cpKg/a5wvEfw/KnyLt/x/BI5pJu06mHn2OG6DWetkchIfJnIY
         MlvdkLaizGz4Af0eH3sATsBEOJ/OB4ZAtaDYv0V0zO9mPSxon+dDULRveFM6DiVNyAUn
         MVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+jl/ZL6Ni2iJkvnbGpHwSuKGjkdbemchwt4upixgmM=;
        b=fsmonLk10YfeTraCzR0WVsY5vR0m8Fj+tlKmEQ7Y743ht3QIrUHanHZoG9S8+6Eguu
         zflsohXF+ULrhUiylEWm3IGAUKXUfZ9K2F4zlOHH/HiGSW0s45p2BIbD4qvj3NDenmBT
         X9sNR3KPfJT/+SCTfGKgSkj4LOYN/kZcHS2vX+l0FfcFOE3mJUv3ltOaOZK2DP1g6+mU
         pPC8WmYAp42I35ArRiQsvSkkW42ip3jzhfqo7x23fBXYc++hUN2E/s/kmjaZ9goLQLzc
         /wQ/ct9RdLl5XADWwkxYS0dskpiTqnuDo7ENBJUlZPAWlykuE0fJe12GxwGd03NfAGoY
         ZKGQ==
X-Gm-Message-State: AOAM53227HqNt3eoTucRtzsmWOEi+SSDGllP4cMFTUx5iBXTVhwTn3kl
        VTTMHnlzjVnLgzDTML6d69pUerAQ3qo=
X-Google-Smtp-Source: ABdhPJxKdI0IOTeMzmfX2JPCpnXJdv/oNQKpU3aOxfgjSYVh+B4N5+cSb56zy/ibu8no6F+ePINcnA==
X-Received: by 2002:adf:c10e:: with SMTP id r14mr49049778wre.558.1638876779441;
        Tue, 07 Dec 2021 03:32:59 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id p13sm2343765wmi.0.2021.12.07.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 03:32:59 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: rockchip_i2s_tdm.c:undefined reference to `clk_set_parent'
Date:   Tue, 07 Dec 2021 12:32:52 +0100
Message-ID: <13326272.At7iLaMNiz@archbook>
In-Reply-To: <202112070621.TnLPiADU-lkp@intel.com>
References: <202112070621.TnLPiADU-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 6. Dezember 2021 23:46:38 CET kernel test robot wrote:
> [...]
> 
> All errors (new ones prefixed by >>):
> 
>    mips-linux-ld: sound/soc/jz4740/jz4740-i2s.o: in function `jz4740_i2s_set_sysclk':
>    jz4740-i2s.c:(.text+0x3ec): undefined reference to `clk_set_parent'
>    mips-linux-ld: jz4740-i2s.c:(.text+0x44c): undefined reference to `clk_set_parent'
>    mips-linux-ld: sound/soc/rockchip/rockchip_i2s_tdm.o: in function `rockchip_i2s_tdm_calibrate_mclk.isra.0':
> >> rockchip_i2s_tdm.c:(.text+0x10d4): undefined reference to `clk_set_parent'
> >> mips-linux-ld: rockchip_i2s_tdm.c:(.text+0x1180): undefined reference to `clk_set_parent'
> 

According to some previous conversations I've stumbled upon[1],
this appears to be due to certain MIPS configurations not
implementing the clock API properly, so they don't provide a
clk_set_parent despite advertising that they have support for
clocks.

So my question is: do I need to care about this? This hardware
will never be used on MIPS, and a lot of other drivers (as seen in
the errors snippet from the test robot) have the same issue, and
the problem is most likely not in my driver but in that specific
configuration's clock API implementation.


[1]: https://lore.kernel.org/lkml/8a41b718-a6f6-6b7f-1699-18ab619884c3@infradead.org/


