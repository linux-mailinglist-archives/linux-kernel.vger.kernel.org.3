Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AD75816B6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbiGZPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGZPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:46:19 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586822C10A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:46:16 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220726154610epoutp021bf5a8570f5ab0965e5774fae8b9cd30~Fa5_C3kRE2987029870epoutp02e
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 15:46:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220726154610epoutp021bf5a8570f5ab0965e5774fae8b9cd30~Fa5_C3kRE2987029870epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658850370;
        bh=bsbhIglKKloE7hZ1DdKwGPVei4I/y5lPhFQOdRu63rg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Fk/oa3qMxR9yvggTyn82R1qFh60B/5GLpdNgLARnuYXRduFGXOVOrZuyS5AJL/0zH
         8hW5WltEbZiG36Y1PcE1LjxIt4E1yzIPK2GxngSWTRrbMwzd90g1QPlPgcCQdyqYKx
         c9M7pwIy5K0mFzKAj1DBvyeeLan5z8pJTnB/GwKM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220726154609epcas1p4702cce003fbdbffdc7734c02276f6d0b~Fa59KxES51794117941epcas1p4V;
        Tue, 26 Jul 2022 15:46:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Lsh8c4ztyz4x9Pw; Tue, 26 Jul
        2022 15:46:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.EB.09661.04C00E26; Wed, 27 Jul 2022 00:46:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220726154608epcas1p27b31dc63fe80e6021d9e747be68e4547~Fa57txtoW0714907149epcas1p2D;
        Tue, 26 Jul 2022 15:46:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220726154608epsmtrp1d81d56dd731876dcea351da56032f248~Fa57tF0n91112811128epsmtrp1F;
        Tue, 26 Jul 2022 15:46:08 +0000 (GMT)
X-AuditID: b6c32a37-2b9ff700000025bd-c0-62e00c40d45c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.74.08905.F3C00E26; Wed, 27 Jul 2022 00:46:07 +0900 (KST)
Received: from jihochu04 (unknown [10.113.112.236]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220726154607epsmtip12a39630c2ae87083490008e871e74bae~Fa57iB2i32652526525epsmtip1A;
        Tue, 26 Jul 2022 15:46:07 +0000 (GMT)
From:   "Jiho Chu" <jiho.chu@samsung.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <yelini.jeong@samsung.com>, <myungjoo.ham@samsung.com>
Subject: RE: RE: [PATCH 0/9] Samsung Trinity NPU device driver
Date:   Wed, 27 Jul 2022 00:46:07 +0900
Message-ID: <001801d8a106$d26e2860$774a7920$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdihBUm9mEN6PLeoTiiwkHAUdjbCkw==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTV9eB50GSQd9NRYu/k46xWzQvXs9m
        cXnXHDaL240r2CyeT7vO4sDq8fvXJEaP/XPXsHv0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaVbR/YCn4qVqx5v5up
        gXGmdBcjJ4eEgInEp/a97F2MXBxCAjsYJWZt/8EC4XxilFhzZSKU841RYuWsicwwLXumrGWE
        SOxllDi5qIUdJCEk8IJRYvXfeBCbTUBd4sz6r2wgtoiAgsTVn7/BbGaBXIm3N/cygtjCAnYS
        018tAhvKIqAqMfH0ObAaXgFLib/PIWbyCghKnJz5hAWiV15i+9s5UEcoSPx8uoy1i5EDaL6e
        xOObERAlIhKzO9uYQW6TEHjJLrG0aTMTSI2EgIvEj0euEK3CEq+Ob2GHsKUkXva3QdnZElM6
        FrFA2AUS555vZYZoNZa4uCIFxGQW0JRYv0sfokJRYufvuYwQW/kk3n3tYYWo5pXoaBOCKFGS
        WPLnMNRwCYmpM74xQdgeEvc2rmaawKg4C8mLs5C8OAvJL7MQFi9gZFnFKJZaUJybnlpsWGAM
        j+nk/NxNjOD0qGW+g3Ha2w96hxiZOBgPMUpwMCuJ8CZE308S4k1JrKxKLcqPLyrNSS0+xGgK
        DPSJzFKiyfnABJ1XEm9oYmlgYmZkbGJhaGaoJM67atrpRCGB9MSS1OzU1ILUIpg+Jg5OqQam
        nREyq9+dzp50Olvk1+TFYv/uL1naPn9+BP+hpZO/+S+rmLeC9f39K5fi1tguiHVzkesN1dcy
        WKIZtDavK+rIwV9q58qEl7avX5tfO+Vac93RztQpVzR37RfJeCY777XwRwfm2zLPDjK65CWI
        rJA2P5PS3XLh+wOFYJ/ylw36/Dl32p4fNtGV0C1xPH7YMnT+/4P68jp2s8Xv7oz/tiBF90ZF
        O9u/80Zfuee/XKh+O1TdiWHFyRvripiUb/z5+nVv48LQZRyPb+12tTFo8c8r89R9kB+3lMH5
        7hY2brP6xhkJ+/SulW70U+BP+2zpXda3YP7vf+LfeNrv7J+VVmDqz1SvGqCTsiCIS091wk8R
        JZbijERDLeai4kQAsNeQNRgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSnK4Dz4Mkg38hFn8nHWO3aF68ns3i
        8q45bBa3G1ewWTyfdp3FgdXj969JjB77565h9+jbsorR4/MmuQCWKC6blNSczLLUIn27BK6M
        K9s+sBX8VKxY8343UwPjTOkuRk4OCQETiT1T1jJ2MXJxCAnsZpR49+IBC0RCQmLTveXMXYwc
        QLawxOHDxRA1zxglXr45ywpSwyagLnFm/Vc2EFtEQEHi6s/fbCD1zAKFErNeZYCEhQXsJKa/
        WsQMYrMIqEpMPH0OrJxXwFLi7/MWdghbUOLkzCdga5kFtCWe3nwKZctLbH87hxniHAWJn0+X
        sYKMFxHQk3h8MwKiRERidmcb8wRGwVlIJs1CMmkWkkmzkLQsYGRZxSiZWlCcm55bbFhgmJda
        rlecmFtcmpeul5yfu4kRHPhamjsYt6/6oHeIkYmD8RCjBAezkghvQvT9JCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY8gu2WR5//FNoxg/bosMxW6ss
        T8mdmjHl5alvOcWCK6Jdyx4E/nqrtt7IuPLs308qzZd+ipx4kxR5YJbu36fbVxdZ1Kt3r9pu
        GL+1ztAt/WjyjqtKIe5F6qXG3/1PHkxQKlPX4BO4w3xtbxGT7fLjibUqm27bCX20u/4m9fmR
        voRPP1cXZZxzCk/ya1Ldu7cq65DGuh6Bhl/3Dlukn1VgzbVXus99oC0jIlhFcW7vz5SL9xmW
        JR7IjkngOtFzetcaCbUrnz5qbVvPuGe+/yyGIr97jiWHVZcdPCHiYj/p8Nt/p9Q2Xe02+7Kh
        qC5xycnT71piPFNVHL6ynXrzcOWvBe4+Z8wuNTpUX8lVdtULUGIpzkg01GIuKk4EAP5thdHr
        AgAA
X-CMS-MailID: 20220726154608epcas1p27b31dc63fe80e6021d9e747be68e4547
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220726154608epcas1p27b31dc63fe80e6021d9e747be68e4547
References: <CGME20220726154608epcas1p27b31dc63fe80e6021d9e747be68e4547@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --------- Original Message ---------
> Sender : Greg KH <gregkh@linuxfoundation.org> Date : 2022-07-25 18:02
> (GMT+9) Title : Re: [PATCH 0/9] Samsung Trinity NPU device driver
> 
> On Mon, Jul 25, 2022 at 03:52:59PM +0900, Jiho Chu wrote:
> > Hello,
> >
> > My name is Jiho Chu, and working for device driver and system daemon
> >for
> > several years at Samsung Electronics.
> >
> > Trinity Neural Processing Unit (NPU) series are hardware accelerators
> > for neural network processing in embedded systems, which are
> >integrated
> > into application processors or SoCs. Trinity NPU is compatible with
> >AMBA
> > bus architecture and first launched in 2018 with its first version for
> > vision processing, Trinity Version1 (TRIV1). Its second version,
> >TRIV2,
> > is released in Dec, 2021. Another Trinity NPU for audio processing is
> > referred as TRIA.
> >
> > TRIV2 is shipped for many models of 2022 Samsung TVs, providing
> > acceleration for various AI-based applications, which include image
> > recognition and picture quality improvements for streaming video,
> >which
> > can be accessed via GStreamer and its neural network plugins,
> > NNStreamer.
> >
> > In this patch set, it includes Trinity Vision 2 kernel device driver.
> > Trinity Vision 2 supports accelerating image inference process for
> > Convolution Neural Network (CNN). The CNN workload is executed by Deep
> > Learning Accelerator (DLA), and general Neural Network Layers are
> > executed by Digital Signal Processor (DSP). And there is a Control
> > Processor (CP) which can control DLA and DSP. These three IPs (DLA,
> >DSP,
> > CP) are composing Trinity Vision 2 NPU, and the device driver mainly
> > supervise the CP to manage entire NPU.
> >
> > Controlling DLA and DSP operations is performed with internal command
> > instructions. and the instructions for the Trinity is similar with
> > general processor's ISA, but it is specialized for Neural Processing
> > operations. The virtual ISA (vISA) is designed for calculating
> >multiple
> > data with single operation, like modern SIMD processor. The device
> > driver loads a program to CP at start up, and the program can decode a
> > binary which is built with the vISA. We calls this decoding program as
> >a
> > Instruction Decoding Unit (IDU) program. While running the NPU, the CP
> > executes IDU program to fetch and decode instructions which made up of
> > vISA, by the scheduling policy of the device driver.
> >
> > These DLA, DSP and CP are loosely coupled using ARM's AMBA, so the
> > Trinity can easily communicate with most ARM processors. Each IPs
> > designed to have memory-mapped registers which can be used to control
> > the IP, and the CP provides Wait-For-Event (WFE) operation to
> >subscribe
> > interrupt signals from the DLA and DSP. Also, embedded Direct Memory
> > Access Controller (DMAC) manages data communications between internal
> > SRAM and outer main memory, IOMMU module supports unified memory space.
> >
> > A user can control the Trinity NPU with IOCTLs provided by driver.
> >These
> > controls includes memory management operations to transfer model data
> > (HWMEM_ALLOC/HWMEM_DEALLOC), NPU workload control operations to submit
> > workload (RUN/STOP), and statistics operations to check current NPU
> > status. (STAT)
> >
> > The device driver also implemented features for developers. It
> >provides
> > sysfs control attributes like stop, suspend, sched_test, and profile.
> > Also, it provides status attributes like app status, a number of total
> > requests, a number of active requests and memory usages. For the
> >tracing
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
> 
> 

Hi, Greg
Thanks for your review.
A documentation for ABI/ is added for user interfaces.
And, most of unnecessary 'dev_info' removed except initialize information.

Thanks,

Jiho Chu

