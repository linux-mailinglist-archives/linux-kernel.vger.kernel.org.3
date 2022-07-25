Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95C057FC12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiGYJKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiGYJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CEF13F2A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCA961248
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857FCC341CF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658740234;
        bh=iVYubWVhr7m8SgQOz5yFmdeGtJpAvYw1/iYnb5v6064=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZuV+DvPvE0YP4XjtVPCjfLxvuDAI7EMRFUM0Mgmca3prTznHH+fVUBqR6K13WgkXe
         kraZ/Mvc15xsGErqNPtohXSC5mQ5nGVRrnF5M3THAORcyruGx8VIHkQyUsDbH/yV8D
         ICy2P+NHQVjgsMFODSoUYXzrz0wkoK4RKA10f9hBuPL6xeoGmwHW+IZ4cm1TLXMhcJ
         u1kzFuSJF5JAguzScuFsa8Y5zg20HPdmHEo1w4nU1Lq4fwPkae3r242YG/y2T1lliW
         WtAQzOzeAer+oVcxar0JaPd3ZtQ0Zd5yZVrKhnrbc6vde6VxBE5/QM9zP88yZdFNSq
         GiC8gv2M8slvQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31e7c4b593fso102096177b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:10:34 -0700 (PDT)
X-Gm-Message-State: AJIora8IYUxSAF6UNp3kXtJ1ZI6mKtHqAxRaX+t+9auaog8jcucEg++i
        A/yjjOvazl2qjKhCamx/2adyYlQ1MB4A7c2YIM4=
X-Google-Smtp-Source: AGRyM1vq4bmce3d+fC8j36lyWWo0InmMKmRxezrTSEkgvh0iucP+Dq2oUKytenc6fkQ6+Fcc1crpFodVipdA7tTdZKg=
X-Received: by 2002:a81:4909:0:b0:31e:961f:a334 with SMTP id
 w9-20020a814909000000b0031e961fa334mr9119377ywa.424.1658740233581; Mon, 25
 Jul 2022 02:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcas1p2.samsung.com>
 <20220725065308.2457024-1-jiho.chu@samsung.com> <Yt5cFBgiTLwGXv17@kroah.com>
In-Reply-To: <Yt5cFBgiTLwGXv17@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 25 Jul 2022 12:10:07 +0300
X-Gmail-Original-Message-ID: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
Message-ID: <CAFCwf13JA+5vuAKqvBSs3MkcF-gbE_8vd9nSvStQga55vW80VA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Samsung Trinity NPU device driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 12:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 25, 2022 at 03:52:59PM +0900, Jiho Chu wrote:
> > Hello,
> >
> > My name is Jiho Chu, and working for device driver and system daemon for
> > several years at Samsung Electronics.
> >
> > Trinity Neural Processing Unit (NPU) series are hardware accelerators
> > for neural network processing in embedded systems, which are integrated
> > into application processors or SoCs. Trinity NPU is compatible with AMBA
> > bus architecture and first launched in 2018 with its first version for
> > vision processing, Trinity Version1 (TRIV1). Its second version, TRIV2,
> > is released in Dec, 2021. Another Trinity NPU for audio processing is
> > referred as TRIA.
> >
> > TRIV2 is shipped for many models of 2022 Samsung TVs, providing
> > acceleration for various AI-based applications, which include image
> > recognition and picture quality improvements for streaming video, which
> > can be accessed via GStreamer and its neural network plugins,
> > NNStreamer.
> >
> > In this patch set, it includes Trinity Vision 2 kernel device driver.
> > Trinity Vision 2 supports accelerating image inference process for
> > Convolution Neural Network (CNN). The CNN workload is executed by Deep
> > Learning Accelerator (DLA), and general Neural Network Layers are
> > executed by Digital Signal Processor (DSP). And there is a Control
> > Processor (CP) which can control DLA and DSP. These three IPs (DLA, DSP,
> > CP) are composing Trinity Vision 2 NPU, and the device driver mainly
> > supervise the CP to manage entire NPU.
> >
> > Controlling DLA and DSP operations is performed with internal command
> > instructions. and the instructions for the Trinity is similar with
> > general processor's ISA, but it is specialized for Neural Processing
> > operations. The virtual ISA (vISA) is designed for calculating multiple
> > data with single operation, like modern SIMD processor. The device
> > driver loads a program to CP at start up, and the program can decode a
> > binary which is built with the vISA. We calls this decoding program as a
> > Instruction Decoding Unit (IDU) program. While running the NPU, the CP
> > executes IDU program to fetch and decode instructions which made up of
> > vISA, by the scheduling policy of the device driver.
> >
> > These DLA, DSP and CP are loosely coupled using ARM's AMBA, so the
> > Trinity can easily communicate with most ARM processors. Each IPs
> > designed to have memory-mapped registers which can be used to control
> > the IP, and the CP provides Wait-For-Event (WFE) operation to subscribe
> > interrupt signals from the DLA and DSP. Also, embedded Direct Memory
> > Access Controller (DMAC) manages data communications between internal
> > SRAM and outer main memory, IOMMU module supports unified memory space.
> >
> > A user can control the Trinity NPU with IOCTLs provided by driver. These
> > controls includes memory management operations to transfer model data
> > (HWMEM_ALLOC/HWMEM_DEALLOC), NPU workload control operations to submit
> > workload (RUN/STOP), and statistics operations to check current NPU
> > status. (STAT)
> >
> > The device driver also implemented features for developers. It provides
> > sysfs control attributes like stop, suspend, sched_test, and profile.
> > Also, it provides status attributes like app status, a number of total
> > requests, a number of active requests and memory usages. For the tracing
> > operations, several ftrace events are defined and embedded for several
> > important points.
>
> If you have created sysfs files, you need to document them in
> Documentation/ABI/ which I do not see in your diffstat.  Perhaps add
> that for your next respin?
>
> Also, please remove the "tracing" logic you have in the code, use
> ftrace, don't abuse dev_info() everywhere, that's not needed at all.
>
> thanks,
>
> greg k-h

Hi,
Why isn't this submitted to soc/ subsystem ?
Don't you think that would be more appropriate, given that this IP is
integrated into application processors ?

Thanks,
Oded
