Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9284C581568
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiGZOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbiGZOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:35:19 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973BC1165
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:35:15 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220726143513epoutp0320fe103706b4ca13f1da9c22ec80a42e~FZ8BTIy_40421604216epoutp03H
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:35:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220726143513epoutp0320fe103706b4ca13f1da9c22ec80a42e~FZ8BTIy_40421604216epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658846113;
        bh=SjwqhqqT3ykpN2dxVXEX69dy3YaRenSDnkfZTFyWve0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=goBeYbTADudMVXamJDxrfIFNrKxZadcrX1veE52koyEcdi8AZKebdeT76d4A2PPkt
         VYxSCkS0cyyfgapfT+Dm+AgVxVx0tVaFvmC/MF0Js/Dw0IGU1Ia4qlM4y9AMU35aGU
         clMfRgaa8NBskeEpolSM9Icy2QuoeP5Ku4XM5++g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220726143513epcas1p319c0f0a3d26ea4d87f6af082f199758b~FZ8A-AjEY2179221792epcas1p3i;
        Tue, 26 Jul 2022 14:35:13 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.135]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LsfZm10sKz4x9Pp; Tue, 26 Jul
        2022 14:35:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.E7.10203.0ABFFD26; Tue, 26 Jul 2022 23:35:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220726143511epcas1p473a65a52034025b5c1fa7bfaf4a90917~FZ7-muitc2228622286epcas1p42;
        Tue, 26 Jul 2022 14:35:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220726143511epsmtrp1e7322b3205e38c213ae9ba4675e9bc25~FZ7-je9FX0139401394epsmtrp1b;
        Tue, 26 Jul 2022 14:35:11 +0000 (GMT)
X-AuditID: b6c32a38-5adff700000027db-f5-62dffb9ffdc4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.A2.08905.F9BFFD26; Tue, 26 Jul 2022 23:35:11 +0900 (KST)
Received: from jihochu04 (unknown [10.113.112.236]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220726143511epsmtip20864010de344b8ab3d82690930259396~FZ7-VH7Mu1992019920epsmtip2c;
        Tue, 26 Jul 2022 14:35:11 +0000 (GMT)
From:   =?utf-8?B?7LaU7KeA7Zi4L1JvYm90IEludGVsbGlnZW5jZe2MgChTUikvU3RhZg==?=
         =?utf-8?B?ZiBFbmdpbmVlci/sgrzshLHsoITsnpA=?= 
        <jiho.chu@samsung.com>
To:     <gregkh@linuxfoundation.org>
Cc:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <yelini.jeong@samsung.com>, <myungjoo.ham@samsung.com>
In-Reply-To: <20220726050305epcms1p5ef19a54322263c768ea71d59da7e2616@epcms1p5>
Subject: RE: [PATCH 0/9] Samsung Trinity NPU device driver
Date:   Tue, 26 Jul 2022 23:35:11 +0900
Message-ID: <000001d8a0fc$e9569d00$bc03d700$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEPrTqOGflLLHU6JPh/pV9MqdRbhAINC2WsANjRdhoCtZ+wYK71lW6A
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTV3fB7/tJBl8eMlv8nXSM3aJ58Xo2
        i8u75rBZ3G5cwWbxfNp1FgdWj9+/JjF67J+7ht2jb8sqRo/Pm+QCWKKybTJSE1NSixRS85Lz
        UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjM6fq1gLfiuWLHl2FOm
        BsYZ0l2MHBwSAiYS7ZN5uhi5OIQEdjBKPHx5jA3C+cQocbTnAQuE841RYvqK4+xdjJxgHbvm
        T2aESOxllLh4dAFUywtGiQNLP4I5bAITGCVevJjNCtIiIqAgcfXnbzYQm1kgV+Ltzb2MIDan
        gJ9Ew/8zYDXCAlYSn/ecYwaxWQRUJb4tP88OciCvgKXEmZP6IGFeAUGJkzOfsECMkZfY/nYO
        M8RFChI/ny5jBSkXEXCTOHvPHKJERGJ2ZxszyDkSAp0cEi8PHGCBqHeR+HD6MlSvsMSr41ug
        PpOSeNnfBmVnS0zpWARVXyBx7vlWZkh4GUtcXJECYjILaEqs36UPUaEosfP3XEaItXwS7772
        sEJU80p0tAlBlChJLPlzGGq4hMTUGd+YJjAqzULy1ywkf81C8sAshGULGFlWMYqlFhTnpqcW
        GxaYwKM6OT93EyM4QWpZ7GCc+/aD3iFGJg7GQ4wSHMxKIrwJ0feThHhTEiurUovy44tKc1KL
        DzGaAgN6IrOUaHI+MEXnlcQbmlgamJgZGZtYGJoZKonz9k49nSgkkJ5YkpqdmlqQWgTTx8TB
        KdXAJJ2xqMXYWZ3hmUiV8Ku2q8+vra63zHte3uTD08msanDxOsdCs/f6TVJmhp96z56/2dR0
        7dGbfHfvnOw1m7w0xfdtMjVafLd6h8Pno2Xnk0qM2ZTP9b44aB7NuSrljOK1vFinu0y31U/f
        /WsQ8FtY4bj84tkd2ScXXX/w6FjrXu+I1bcczqn69s3L0vnUsLfxz8XlJc1aJzoE7v286b3q
        hItRGlv9BJ7a/NhV8XW/Tb5EzJTXq4rfd1tFbiOXi5T1l8aJezPYSvcpdif/f1h4J7bsvNyF
        N8sb+kz37hVR5mT9HjR1eciWowsKbDYu27TB+Pzqy4uuWYWb/Jmv93LJq1Dl4xF/o7ZV1M/y
        WMtup8RSnJFoqMVcVJwIABCwz4UZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvO783/eTDPpfylr8nXSM3aJ58Xo2
        i8u75rBZ3G5cwWbxfNp1FgdWj9+/JjF67J+7ht2jb8sqRo/Pm+QCWKK4bFJSczLLUov07RK4
        Mjp+rWAt+K5YseXYU6YGxhnSXYycHBICJhK75k9m7GLk4hAS2M0ocfHoLiaIhITEpnvLmbsY
        OYBsYYnDh4shap4xSsw6f5sdxGETmMAo8eLFbFaQBhEBBYmrP3+zgTQwCxRKzHqVAdHwgFHi
        4Y25bCA1nAJ+Eg3/z4DVCwtYSXzec44ZxGYRUJX4tvw8O0gvr4ClxJmT+iBhXgFBiZMzn7CA
        2MwC2hJPbz6FsuUltr+dwwxxp4LEz6fLWEFaRQTcJM7eM4coEZGY3dnGPIFReBaSSbOQTJqF
        ZNIsJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER4uW5g7G7as+6B1iZOJg
        PMQowcGsJMKbEH0/SYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZ
        Jg5OqQamI7OZt+3adV3o0uvp5jrb2ILez69YKijj2x27SXd5Yv6Ps0120Yu8Z7j/5indkvB9
        69o3ykb/Syaxmma58n9qKFonX2JUqfOyZdtXjn1uR46kiYekiITyTvyWWmq+zX6vWsA+leqX
        At9nze3ezqSY9E9IO3H9KWnm8o7TRwVmz5jdvvve0X+SwX5256dEzfkuMb/h4dRFpbekm26I
        RyupuwS3KqotF9gozOVg+9JfZE2S0R772bMNy+RubK5J4Zphb3Rtu35R6DJ1P5cJ06v8nrg4
        cu+2PljxSME+Q0xd5UD751/yRzf1r9ip8FvoDHf0jZ/zEpIf9MeW8UcbJ6h/nGPEfC+aJbNy
        qoxe3RUlluKMREMt5qLiRAD4/qT+BQMAAA==
X-CMS-MailID: 20220726143511epcas1p473a65a52034025b5c1fa7bfaf4a90917
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065308epcas1p2f6de3d74792854bb312cca4b310badac
References: <Yt5cFBgiTLwGXv17@kroah.com>
        <20220725065308.2457024-1-jiho.chu@samsung.com>
        <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcms1p5>
        <20220726050305epcms1p5ef19a54322263c768ea71d59da7e2616@epcms1p5>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Hi, Greg
Thanks for your review.
A documentation for ABI/ is added for user interfaces.
And, most of unnecessary 'dev_info' removed except initialize information.

Thanks,

Jiho Chu


