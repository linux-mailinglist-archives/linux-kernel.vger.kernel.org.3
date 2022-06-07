Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA253FF1E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbiFGMmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiFGMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:42:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75390F594;
        Tue,  7 Jun 2022 05:42:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so23865028ejj.12;
        Tue, 07 Jun 2022 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QWGQ/jFwQVG1lQvfacyHok6y1NHoHQn3XY+5974NmFs=;
        b=WoKL+2b/ZHvv5g/XRuHkEc5DNuSGDQSccTXGcBhxG8C8aSmgB7gfDCN7CK/H7kqxZG
         y0NRBmY/MwqhYZeH4kNPBG3DYIfKWvmWpaK6DaDaPQi4aABaZ6UFvPwIi+W70szvHv1/
         uWdTPf2JYSg0w93u5h8GSj8oD9csDFEPuK60r996gCFiNceUTK2HnivfZFLw2F0u1idU
         W6optP5n0M1QNFu0a1puha4ZK0ZdcQLoU+yKILJX/dh949Nq8jKJ5YarMrBn0W0al73l
         8UnoCxvzC/Va796Umo6Qt0CWdULTTDC96+0d5MZEkbqlcdr7jef3Y6us5dd4x//rU9Dw
         lUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QWGQ/jFwQVG1lQvfacyHok6y1NHoHQn3XY+5974NmFs=;
        b=6qlgKMuTbTjtOaPgQapKPcYNSZq2NNRx/RT0M2LkhudSF2hvvvDfpLP1DqthJRpXXk
         EbOlzPmSgYjph4ekgtxISC2d3+ojvaDlpTnXIixbKBOmEsSqf7KNF/PwIDcg0ZwPe637
         G59qiq3sQSApyRwGlZeBma7LJYZzrT8x08sbAbR8uGo8FKH6seueb/ztU8BttqMIbsRT
         /Ee3n0j8pmEBB0TRHNnUoyOj3SqgxWmJjfcHa0W3Nmwa7S2gAB229VuBc4yLx6s/66pW
         3Wvca0TI17ikZQ9XoWZ+5E7O8boH42REm8/19IhEb2NRciMjjeGnpkm+CYGd+LgjKAIc
         18xg==
X-Gm-Message-State: AOAM533Gj6q7Ha7Bwb2fQWbSQ1nW/Xo1VORp/wLn9TFtQVi2PaOZwBx5
        Fll888xsWs08uj2FGcwr9l4=
X-Google-Smtp-Source: ABdhPJwHCSLPDHEhZvuk8tB5tsfWFvZUKoY+PHHEMWVQWj/CA1NZDebYXA9DTcCIDC1JxQqhj5m8mQ==
X-Received: by 2002:a17:907:94c8:b0:711:d864:fd84 with SMTP id dn8-20020a17090794c800b00711d864fd84mr6889221ejc.18.1654605733831;
        Tue, 07 Jun 2022 05:42:13 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id o5-20020aa7c7c5000000b0042ad421574esm10427934eds.33.2022.06.07.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 05:42:12 -0700 (PDT)
Date:   Tue, 7 Jun 2022 14:42:09 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>, yujie.liu@intel.com,
        linux-sparse@vger.kernel.org
Subject: Re: /bin/bash: line 1: 45878 Segmentation fault sparse -D__linux__
 -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -Wno-return-void
 -Wno-unknown-attribute -fdiagnostic-prefix -D__CHECK_ENDIAN__ -D__NDS32_EL__
 --arch=nds32 -mlittle-endian -m32 -Wp,-MMD,ker...
Message-ID: <20220607124209.ccibpwpjgh6kaqmj@mail>
References: <202111131205.eni58iWQ-lkp@intel.com>
 <CALOAHbBQfK16aXUwT3znCwLBWcpLwgovS=kYBBR=eL4Eb62t3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBQfK16aXUwT3znCwLBWcpLwgovS=kYBBR=eL4Eb62t3g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 10:46:04PM +0800, Yafang Shao wrote:
> On Sat, Nov 13, 2021 at 12:25 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   66f4beaa6c1d28161f534471484b2daa2de1dce0
> > commit: 60f2415e19d3948641149ac6aca137a7be1d1952 sched: Make schedstats helpers independent of fair sched class
> > date:   6 weeks ago
> > config: nds32-randconfig-s031-20211015 (attached as .config)
> > compiler: nds32le-linux-gcc (GCC) 11.2.0

...

> > All errors (new ones prefixed by >>):
> >
> >    include/linux/rtmutex.h:68:58: sparse: sparse: got $

Hi,

Apologies for this late reply.

The error was caused by the line:
	#define tsk $r25
in arch/nds32/include/asm/current.h

I suppose it was only meant for assembly files but was also included in
(most) C files and the '$' character made sparse crash in some weird
circumstances. Patch is on the way.

-- Luc
