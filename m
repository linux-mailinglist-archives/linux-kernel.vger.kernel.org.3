Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908F858589D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 06:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiG3EdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 00:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiG3EdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 00:33:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E119C14
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:33:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ha11so6385986pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TIooHcxORyJe2cY/zgHgodr2wpa9bd+BACMZC4ZSkew=;
        b=BVtOc41O7wQuwfgBOGSueaK0EepGoq+9yLcn43+jgZhQAgs8e4LhPNY+Qn80pIQku2
         CQET0Ykff8yJ3AoEpHGQXIrFrreNwf0s/tk9CPdCa9rtZsCL+YI6Y/Xiutg8f+0gqEu3
         Zv23lE+nopl2gXfUfy3D3tyXNai4yhyWBt42UpAYvQbRt7ulA7jpkAJiABqsFvIjbJP+
         Tg17rEenObUBXf61+FXwz3/IjGb46lxn4WNKIJ14vuIwO+/lIjyefPxCYkokx3E13D6D
         itgBaEb2kPDaWgS0tLipGvFX8rkrttRev6fqVmeIrjWg8l2aA7wJpEswp04818nF2vS5
         Yj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TIooHcxORyJe2cY/zgHgodr2wpa9bd+BACMZC4ZSkew=;
        b=WlyLVTgQgv1Tjc6FDQfOz1UhiEc4xSlzu3YyXdCWK1yJDNpM658S3sDXj464+Q1WWg
         Kbe5JjCF+4nTJcXB6SKCgy5tx/X8TP2nr9k9hT33w6fO0tiyyRNP+6g/MhUYOfhognik
         Etpl2A/ntFzuNIIMFGmMuL3g0g9ICNr0NmKyV8T9qAmK169cu8HH8uQq5V5D7YkEsHGr
         gx4+06A+Q1PBgoCsw62msz2NQ23ZVWGz5Z/578aJdc+EY+M3nJ9RCWZ4NymFUtOdeIs/
         bW5KduZcDBkxGp9iRNL4jGUEsG5N+p0HtVIqsaxGX88bwJwO5QH2/hDnem3x5ZpsPeAH
         JScg==
X-Gm-Message-State: ACgBeo3zaIvksP5IHoT+17D2//KhA+cNdW8SXua4BjlAqtbqHoCkNu9A
        UtcnVCY8U0KusF/CTI4UUi4VSLS2IqBZ6w==
X-Google-Smtp-Source: AA6agR4XORAEEYLSON+6Yr8y42HYNauBvjO2bc6uPpXKLrpnaKmXUWALuU6zxRb/vpsU0tnocuTfTA==
X-Received: by 2002:a17:902:e88c:b0:16d:4364:2c37 with SMTP id w12-20020a170902e88c00b0016d43642c37mr6827188plg.69.1659155580613;
        Fri, 29 Jul 2022 21:33:00 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902e74900b0016be527753bsm4557865plf.264.2022.07.29.21.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 21:33:00 -0700 (PDT)
Date:   Sat, 30 Jul 2022 13:32:58 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [stffrdhrn:or1k-virt-5 2/10] arch/x86/kernel/cpu/cyrix.c:277:17:
 error: 'isa_dma_bridge_buggy' undeclared
Message-ID: <YuS0euQVO1gc1Vnc@antec>
References: <202207301158.ldOcpmVn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207301158.ldOcpmVn-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 11:54:41AM +0800, kernel test robot wrote:
> tree:   https://github.com/stffrdhrn/linux.git or1k-virt-5
> head:   2e5ced6dd3319303f0d6760a46e8b35e985c86b5
> commit: db5cc35daef410a8a51d7c2e66d34195b82dcb50 [2/10] PCI: Move isa_dma_bridge_buggy out of dma.h
> config: i386-randconfig-a014-20210930 (https://download.01.org/0day-ci/archive/20220730/202207301158.ldOcpmVn-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/stffrdhrn/linux/commit/db5cc35daef410a8a51d7c2e66d34195b82dcb50
>         git remote add stffrdhrn https://github.com/stffrdhrn/linux.git
>         git fetch --no-tags stffrdhrn or1k-virt-5
>         git checkout db5cc35daef410a8a51d7c2e66d34195b82dcb50
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/kernel/cpu/cyrix.c: In function 'init_cyrix':
> >> arch/x86/kernel/cpu/cyrix.c:277:17: error: 'isa_dma_bridge_buggy' undeclared (first use in this function)
>      277 |                 isa_dma_bridge_buggy = 2;
>          |                 ^~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/cpu/cyrix.c:277:17: note: each undeclared identifier is reported only once for each function it appears in

I don't have the fix on the branch but this is fixed on the branch
'pci/header-cleanup-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

After the patches went into the PCI branch.

-Stafford
