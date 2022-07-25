Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343C157F9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiGYGxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGYGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:53:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF11055A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:53:15 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220725065310epoutp013ec37c2b9ae1fe8922fb021eb29f6f9c~E--UFrK3E1626416264epoutp01U
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220725065310epoutp013ec37c2b9ae1fe8922fb021eb29f6f9c~E--UFrK3E1626416264epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658731990;
        bh=DhYr56B85XFzsIL3AYizbwn4zjKgwllQvNEZoqjOXHE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oJ2EBa+EvsGOPYz85mV6ED7qxVXHi9lUQ9KZJSBZRKOIc0FbK0nubuLlQ6VZTPIJy
         wMnt6eFCyIt3pkz1HHNkE52zBQqE28rchY2nTE9KrxefWT+R5gMwUL5IPHwJC3AsQu
         uV6GpKiE30Yb7p9Slr1We1xNHmY3podmFcdd7T3w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220725065310epcas1p30edd5358c0ed3cb0806c4b9ffd46983b~E--Tz2yXI2790327903epcas1p3e;
        Mon, 25 Jul 2022 06:53:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.145]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LrrN52JJXz4x9Q1; Mon, 25 Jul
        2022 06:53:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.F3.10203.5DD3ED26; Mon, 25 Jul 2022 15:53:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065308epcas1p2f6de3d74792854bb312cca4b310badac~E--SkG3i53004830048epcas1p22;
        Mon, 25 Jul 2022 06:53:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220725065308epsmtrp278673849ae7a3675939f858aafb551fb~E--SjWGmF0777907779epsmtrp2N;
        Mon, 25 Jul 2022 06:53:08 +0000 (GMT)
X-AuditID: b6c32a38-dbbc7a80000027db-d6-62de3dd5baf0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.B6.08802.4DD3ED26; Mon, 25 Jul 2022 15:53:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220725065308epsmtip289dc8afa1d05e15feafde8b5c5e1ae60~E--SXxH9-2537425374epsmtip2T;
        Mon, 25 Jul 2022 06:53:08 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     yelini.jeong@samsung.com, myungjoo.ham@samsung.com,
        Jiho Chu <jiho.chu@samsung.com>
Subject: [PATCH 0/9] Samsung Trinity NPU device driver
Date:   Mon, 25 Jul 2022 15:52:59 +0900
Message-Id: <20220725065308.2457024-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmnu5V23tJBge2Clj8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fLSy2xMjQwMDIFKkzIzli95RhbwR3j
        iqWHl7A3MB7Q7GLk5JAQMJE4vmEzaxcjF4eQwA5GidV9HawgCSGBT4wSjz5kQNifGSWenJCB
        abja2ccGEd8F1HBTEaIZqGb1nUVgzWwCqhIzZ6xhB7FFBLwl5rd2MXUxcnAwC0RKXFtRBRIW
        FjCTuPJiB9gcFqDypY8mgbXyClhL7DvxgRnCFpQ4OfMJC4jNLCAv0bx1NjPILgmBbewSmzf+
        Y4M4yEWid/F8dghbWOLV8S1QtpTE53d7oWqyJaZ0LGKBsAskzj3fygxyj4SAscTFFSkQp2lK
        rN+lD1GhKLHz91xGiLV8Eu++9rBCVPNKdLQJQZQoSSz5cxhqkYTE1BnfmCBsD4kZa68ygpQL
        CcRKvPxeP4FRbhaSX2Yh+WUWwt4FjMyrGMVSC4pz01OLDQtM4HGYnJ+7iRGc3LQsdjDOfftB
        7xAjEwfjIUYJDmYlEd6utNtJQrwpiZVVqUX58UWlOanFhxhNgSE6kVlKNDkfmF7zSuINTSwN
        TMyMjE0sDM0MlcR5e6eeThQSSE8sSc1OTS1ILYLpY+LglGpgyk9zMbJssBfiYjw0y+6A7owJ
        xdx7/CWP+MwXXHW5nms5d/XGaIuL3G/fZqx5lqZg+Pf67+ncpn2BN88sKRV9/PoG+/RTN+7L
        Gccuqnaol5C0N6hyWvfPRJj9GYPpgtiOf7wPi2Z/ET7gKdzaVGf3W/jbIUaZ31LbV8zxM7nE
        9+/Yxse+b7beWigsMdWxM/Pp16691X83Tv6ntfrlwwN3Y39xZd7kXH2cS21dk9pqtd9OjGud
        DuRcXuV5c0OPu+yGV2kvMz8d4rpxI1Hl5+4apTmLumSuR8uFz3/DLOwzYZfcFIvCBfOnK16X
        kvIwj2WXXCvBrrd2xfPUfPv6iV9bXNT9r8x1LfhQ/yFmUUFWsRJLcUaioRZzUXEiADgGd9f3
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvO4V23tJBs8mmFv8nXSM3aJ58Xo2
        i/fdu5ktLu+aw2Zxu3EFm8XzaddZHNg8fv+axOixf+4ado++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKWL3lGFvBHeOKpYeXsDcwHtDsYuTkkBAwkbja2cfWxcjFISSwg1Hi4MyjTBAJCYlN
        95YzdzFyANnCEocPF0PUfGSUuLr2MzNIDZuAqsTMGWvYQWwRAX+Jv5+OsYLYzALREqu33WcB
        sYUFzCSuvNjBBmKzANUvfTQJrIZXwFpi34kPzBC2oMTJmU9YIHrlJZq3zmaewMg7C0lqFpLU
        AkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwYGnpbWDcc+qD3qHGJk4GA8xSnAw
        K4nwdqXdThLiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qB
        qd1MW1hoveZOTYUGhX2H55YcYG5omHxFkdn6gAjPhBnWzJO/9WTElG5JVxaptUxT+tH+VLHN
        ed8rhX8z5AMn3EyzWcd5YfFxxlW1h67ImYZmCgedub/E4eCrnMpTHJZs/V9W/mI4MsknzSLQ
        wCxXPT1x/6vV16r4pfemLvFPMU1fe2QyywLGjLfTHQ6cybER0C7dcvvB7R/JxxmWfswLnZc4
        9fykSI/sBRXXUl0Wdht67ph9Zy0nh5ILn0dQe6UVw8Gty7l+B2zV97ev/fdDoqq9WT4jccNi
        iZbP4fGtD+c9Fj77Z3stq5F7dlHu2bgZTgq+2alRN58f6/s6tSZ1k5VXeFL2osiYBQGz0m4p
        sRRnJBpqMRcVJwIAOzQJiqsCAAA=
X-CMS-MailID: 20220725065308epcas1p2f6de3d74792854bb312cca4b310badac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220725065308epcas1p2f6de3d74792854bb312cca4b310badac
References: <CGME20220725065308epcas1p2f6de3d74792854bb312cca4b310badac@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My name is Jiho Chu, and working for device driver and system daemon for
several years at Samsung Electronics. 

Trinity Neural Processing Unit (NPU) series are hardware accelerators
for neural network processing in embedded systems, which are integrated
into application processors or SoCs. Trinity NPU is compatible with AMBA
bus architecture and first launched in 2018 with its first version for
vision processing, Trinity Version1 (TRIV1). Its second version, TRIV2,
is released in Dec, 2021. Another Trinity NPU for audio processing is
referred as TRIA.

TRIV2 is shipped for many models of 2022 Samsung TVs, providing
acceleration for various AI-based applications, which include image
recognition and picture quality improvements for streaming video, which
can be accessed via GStreamer and its neural network plugins,
NNStreamer.

In this patch set, it includes Trinity Vision 2 kernel device driver.
Trinity Vision 2 supports accelerating image inference process for
Convolution Neural Network (CNN). The CNN workload is executed by Deep
Learning Accelerator (DLA), and general Neural Network Layers are
executed by Digital Signal Processor (DSP). And there is a Control
Processor (CP) which can control DLA and DSP. These three IPs (DLA, DSP,
CP) are composing Trinity Vision 2 NPU, and the device driver mainly
supervise the CP to manage entire NPU.

Controlling DLA and DSP operations is performed with internal command
instructions. and the instructions for the Trinity is similar with
general processor's ISA, but it is specialized for Neural Processing
operations. The virtual ISA (vISA) is designed for calculating multiple
data with single operation, like modern SIMD processor. The device
driver loads a program to CP at start up, and the program can decode a
binary which is built with the vISA. We calls this decoding program as a
Instruction Decoding Unit (IDU) program. While running the NPU, the CP
executes IDU program to fetch and decode instructions which made up of
vISA, by the scheduling policy of the device driver.

These DLA, DSP and CP are loosely coupled using ARM's AMBA, so the
Trinity can easily communicate with most ARM processors. Each IPs
designed to have memory-mapped registers which can be used to control
the IP, and the CP provides Wait-For-Event (WFE) operation to subscribe
interrupt signals from the DLA and DSP. Also, embedded Direct Memory
Access Controller (DMAC) manages data communications between internal
SRAM and outer main memory, IOMMU module supports unified memory space.

A user can control the Trinity NPU with IOCTLs provided by driver. These
controls includes memory management operations to transfer model data
(HWMEM_ALLOC/HWMEM_DEALLOC), NPU workload control operations to submit
workload (RUN/STOP), and statistics operations to check current NPU
status. (STAT)

The device driver also implemented features for developers. It provides
sysfs control attributes like stop, suspend, sched_test, and profile.
Also, it provides status attributes like app status, a number of total
requests, a number of active requests and memory usages. For the tracing
operations, several ftrace events are defined and embedded for several
important points.

I would highly appreciate your feedback.
Review, question or anythings.


Thanks.
Jiho Chu

Jiho Chu (9):
  trinity: Add base driver
  tirnity: Add dma memory module
  trinity: Add load/unload IDU files
  trinity: Add schduler module
  trinity: Add sysfs debugfs module
  trinity: Add pm and ioctl feature
  trinity: Add profile module
  trinity: Add trace module
  MAINTAINERS: add TRINITY driver

 MAINTAINERS                                   |    7 +
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/trinity/Kconfig                  |   27 +
 drivers/misc/trinity/Makefile                 |   12 +
 drivers/misc/trinity/sched/core.c             |  170 ++
 drivers/misc/trinity/sched/priority.c         |  335 +++
 drivers/misc/trinity/sched/priority.h         |   18 +
 drivers/misc/trinity/sched/sched.h            |   52 +
 drivers/misc/trinity/trinity.c                | 1282 +++++++++++
 drivers/misc/trinity/trinity_common.h         |  434 ++++
 drivers/misc/trinity/trinity_debug.c          |  358 ++++
 drivers/misc/trinity/trinity_hwmem.c          |  438 ++++
 drivers/misc/trinity/trinity_hwmem.h          |   45 +
 drivers/misc/trinity/trinity_pm.c             |   76 +
 drivers/misc/trinity/trinity_resv_mem.c       |  264 +++
 drivers/misc/trinity/trinity_resv_mem.h       |   41 +
 drivers/misc/trinity/trinity_stat.c           |  893 ++++++++
 drivers/misc/trinity/trinity_stat.h           |   56 +
 drivers/misc/trinity/trinity_sysfs.c          |  864 ++++++++
 drivers/misc/trinity/trinity_trace.c          |   15 +
 drivers/misc/trinity/trinity_trace.h          |  406 ++++
 drivers/misc/trinity/trinity_vision2_drv.c    | 1893 +++++++++++++++++
 .../misc/trinity/trinity_vision2_profile.h    |  324 +++
 drivers/misc/trinity/trinity_vision2_regs.h   |  210 ++
 include/uapi/misc/trinity.h                   |  458 ++++
 26 files changed, 8680 insertions(+)
 create mode 100644 drivers/misc/trinity/Kconfig
 create mode 100644 drivers/misc/trinity/Makefile
 create mode 100644 drivers/misc/trinity/sched/core.c
 create mode 100644 drivers/misc/trinity/sched/priority.c
 create mode 100644 drivers/misc/trinity/sched/priority.h
 create mode 100644 drivers/misc/trinity/sched/sched.h
 create mode 100644 drivers/misc/trinity/trinity.c
 create mode 100644 drivers/misc/trinity/trinity_common.h
 create mode 100644 drivers/misc/trinity/trinity_debug.c
 create mode 100644 drivers/misc/trinity/trinity_hwmem.c
 create mode 100644 drivers/misc/trinity/trinity_hwmem.h
 create mode 100644 drivers/misc/trinity/trinity_pm.c
 create mode 100644 drivers/misc/trinity/trinity_resv_mem.c
 create mode 100644 drivers/misc/trinity/trinity_resv_mem.h
 create mode 100644 drivers/misc/trinity/trinity_stat.c
 create mode 100644 drivers/misc/trinity/trinity_stat.h
 create mode 100644 drivers/misc/trinity/trinity_sysfs.c
 create mode 100644 drivers/misc/trinity/trinity_trace.c
 create mode 100644 drivers/misc/trinity/trinity_trace.h
 create mode 100644 drivers/misc/trinity/trinity_vision2_drv.c
 create mode 100644 drivers/misc/trinity/trinity_vision2_profile.h
 create mode 100644 drivers/misc/trinity/trinity_vision2_regs.h
 create mode 100644 include/uapi/misc/trinity.h

-- 
2.25.1

