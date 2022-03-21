Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB134E2E87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351427AbiCUQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbiCUQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C02174B93
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:51:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 96E583200973;
        Mon, 21 Mar 2022 12:51:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 21 Mar 2022 12:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=aD8/Y4hPqAyTKU5rh74GM8ppHJsw64m0Pybq+d
        SZ3sU=; b=Unl77xM818Hg40rm3neqXsUYPf84ogGUOSO9s/WU+dBjTycleHCTNS
        VGIS4QE4J0Zm0wjTnH9plpUqax9jY2bzccpbqaz6/rV3B0OKM3Uy7U2FD50hu7u/
        6KYNqbz5uF1CRyYl5ajO2fk1/LGFFgh06S+W1z9WVUTaregdRs/yPhAtoUOZp/7W
        w+V7UEux9f+ZIZDc2JkdQAxuQyUFvkCg69mJnq/68nBtQzQvAI24etGon5JElXUL
        0GcoSVLGsr7310zwLoLu4dtvpluaB3EpqxjiXi45TDjY/n5004ZtQhxPdQUkfkNj
        nJRPlOi5h+DobH+Pg9SEg52pYgijrSwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=aD8/Y4hPqAyTKU5rh74GM8ppHJsw6
        4m0Pybq+dSZ3sU=; b=ZXwI48PmFtFZXoQoICSrxzYjsMp+HimXuhfYuBH0kqyS3
        H936lNBr25GHeNkMNkePjiYGCROktVxhFyZ6Dn4PsujIEv3L8YKSXY0NK74qqKUn
        ksRc/NKDPOEPk/vBRmwVof/XwqQ73ts4b7KuwrM/r02uGgMUVV8V+VQmyfqijOLs
        UtFMNyBDJgX186nhMWLV4kjmF1+PR8OJulHQWNbIgAwbtmHfjrdn2ID6iCdVa1QI
        QAAuPx+gRjQ00+1BqbPT4w1Hhq2JN3kZ7kDXeNG6mD+UCPdNR6GCD6kYSNS/gN3E
        VeCpAAPeviBlqQdktNhgTpn//Yvu1NthMwgPZe+zA==
X-ME-Sender: <xms:Jq04YiFQg_MIx0FglpHhZf77RssM9UutuDnZXqFSb_MdtNN8k24pxw>
    <xme:Jq04YjXgSG3kVkzqD-8j9f0b6E29HaAVndSZYuUOzWhrsxDHN27V1zgOJ-wUc-t73
    RVHSgSFrAb27LTlm6w>
X-ME-Received: <xmr:Jq04YsJss5_C3PdUGVCsuTOGOaI3EPcznSK9Vz07DV1poQlomWxuwYtOycXz6jMHWQkxs-7qxYjKskelNHx6izpUgi4YXJ6T_4DE3tJWSS04aLMbO4fQg87jdXk9iBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegoteeftdduqddtudculdduhedm
    necujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurf
    gvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghr
    nhepfeehudeftddvhfehvdduhedtjeejheeuudfftdfgvdekvdelleeuveelgfeflefgne
    cuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Jq04YsEG1_bhSXIhM9DTrk0xP3MN8H1n5HO74vBYkZXt1iTwsv8uhw>
    <xmx:Jq04YoUKzx2otZq5QLrdbgh5_KrbF-l1lw8nyWmOflmsCCatafPGug>
    <xmx:Jq04YvOUHT5camEHD40iiOJIEvD0pz3YGzOm9UOeEqjFMWP8M2agog>
    <xmx:J604YpsIDrCEkKaTDgSnOU0WyMols2DVv6Oxj9gb5LBfhy7zXrrIjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:51:48 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 0/9] Apple M1 (Pro/Max) NVMe driver
Date:   Mon, 21 Mar 2022 17:50:40 +0100
Message-Id: <20220321165049.35985-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series includes everything[*] required to get NVMe up and running on
Apple's M1, M1 Pro and M1 Max SoCs.

The NVMe controller on these machines is not attached to a PCI bus and
this driver originally started out when Arnd added platform support to
pci.c and I added the required Apple quirks. Christoph Hellwig stumbled
upon an early version and suggested to instead rewrite it as a
stand-alone driver since some of these quirks are rather awkward to
implement and would affect the hot path otherwise [1].

Here's the first version that creates apple.c to handle these weird NVMe
controllers. The following parts are included:

  - Device tree bindings: Since this is the first and probably only
    SoC that has NVMe outside of a PCIe bus I've put them into
    soc/apple. The same bindings are also used by u-boot and OpenBSD
    already.

  - SART address filter: Some of the buffers required by the NVMe
    controller sit behind a simple DMA address filter Apple calls
    SART. It allows to specify up to 16 physical address ranges
    that are allowed and will reject access to anything else.
    Unlike a real IOMMU there's no way to setup pagetables and
    also not all buffers are subject to this filtering. Most
    buffers used by the NVMe commands themselves use an integrated
    IOMMU instead.

  - RTKit IPC protocol: The NVMe controller is running a proprietary
    RTOS Apple calls RTKit and we need to communicate with it in order
    to bring up and use the NVMe controller. This communication happens
    over a mailbox interface that is already upstream. This protocol
    is also used for various other drivers present on these SoCs
    (SMC, display controller, Thunderbolt/USB4).

  - And finally the NVMe driver itself: The driver registers a platform
    device and is mainly based on pci.c with a few special Apple quirks.
    The biggest difference to normal NVMe (except for the missing PCI
    bus) is that command submission works differently: The SQ is
    replaced with a simple array and a command is triggered by writing
    its tag to a MMIO register. Additionally, the command must also be
    setup in the proprietary NVMMU before it can be submitted.
    There is some code duplication with pci.c for the setup of the PRPs.
    Depending on what you prefer this could be moved to a common file
    shared between pci.c and apple.c.

The hardware here is the same hardware that's already used in T2 Macs.
The only difference is that the T2 chip itself initializes the
controller, disable some quirks (the NVMMU and the weird submission
array) and then exposes it over a PCIe interface.

The driver itself has been successfully used by multiple people as
their daily driver for weeks at this point and no major issues have
been reported.
A smaller issue is that flushes on the devices take *much* longer than
expected. Jens Axboe has a workaround where the flushes are delayed but
that one isn't ready for submission yet.

Best,

Sven

[1] https://lore.kernel.org/linux-nvme/YRE7vCyn9d1ClhRm@infradead.org/
[*] The only missing part in this series are the device tree updates
    but since these will go through arm-soc anyway I haven't included
    them here but will instead submit them once this series is in a shape
    where it can be merged.

Hector Martin (2):
  nvme-apple: Add support for multiple power domains
  nvme-apple: Add support for suspend/resume

Jens Axboe (1):
  nvme-apple: Serialize command issue

Sven Peter (6):
  dt-bindings: soc: apple: Add Apple SART
  dt-bindings: soc: apple: Add ANS NVMe
  soc: apple: Always include Makefile
  soc: apple: Add SART driver
  soc: apple: Add RTKit IPC library
  nvme-apple: Add initial Apple SoC NVMe driver

 .../bindings/soc/apple/apple,nvme-ans.yaml    |   75 +
 .../bindings/soc/apple/apple,sart.yaml        |   52 +
 MAINTAINERS                                   |    3 +
 drivers/nvme/host/Kconfig                     |   12 +
 drivers/nvme/host/Makefile                    |    3 +
 drivers/nvme/host/apple.c                     | 1568 +++++++++++++++++
 drivers/soc/Makefile                          |    2 +-
 drivers/soc/apple/Kconfig                     |   24 +
 drivers/soc/apple/Makefile                    |    6 +
 drivers/soc/apple/rtkit-crashlog.c            |  147 ++
 drivers/soc/apple/rtkit-internal.h            |   76 +
 drivers/soc/apple/rtkit.c                     |  842 +++++++++
 drivers/soc/apple/sart.c                      |  318 ++++
 include/linux/soc/apple/rtkit.h               |  203 +++
 include/linux/soc/apple/sart.h                |   77 +
 15 files changed, 3407 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,nvme-ans.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/apple/apple,sart.yaml
 create mode 100644 drivers/nvme/host/apple.c
 create mode 100644 drivers/soc/apple/rtkit-crashlog.c
 create mode 100644 drivers/soc/apple/rtkit-internal.h
 create mode 100644 drivers/soc/apple/rtkit.c
 create mode 100644 drivers/soc/apple/sart.c
 create mode 100644 include/linux/soc/apple/rtkit.h
 create mode 100644 include/linux/soc/apple/sart.h

-- 
2.25.1

