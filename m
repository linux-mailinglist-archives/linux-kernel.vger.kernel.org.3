Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B257EC81
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiGWHnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiGWHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:42:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2B74A814;
        Sat, 23 Jul 2022 00:42:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r6so8111620edd.7;
        Sat, 23 Jul 2022 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=8BAx5NlHzPi7RVFRM8jj36U8K3MF3okqWdCMAZKspQQ=;
        b=gM/YgYA0zKxBw8okI+LSFJBAJwV8Rvv0luHituz6sYQ8i6FtVAm47D2P3+rBPdc9uK
         KxwU3g4n5NHpye26E4oVJdYgFklSG0Juq/1qkJUtVMxsa2wOU6hr67CO2PGVCAPevFxl
         cjL18HK4mC6cDXS0IUMhx9Zeub75896udRYEQR23eULYE5PYQCo26SUYLQyploaducfr
         Nw1b/c2TU91U6eNDRn2jFVlJTaYhT62tlw5ss5cE3+JU/gH2fERROyi0I9HbTF1PpQs8
         /SnJ6jPRQavXDll3q3H2UFPZ9PGlyT3qB8mdaEnC/ASA0HMgd4IbwM6tu98iadId6Vb/
         KZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8BAx5NlHzPi7RVFRM8jj36U8K3MF3okqWdCMAZKspQQ=;
        b=vU7WlcszqAICumeJZmJ7oGCDcWPqvQFwntPx0dNsIYwc8lkSSoS0j2ZfL85P+3obm7
         JznHWea6VNpXCi6sR19Bf14Pzu8lf+drd0ZTLb8X7i7wopAAZHradVlaptg4UDcaahbG
         1R2RfRkaCWdJPqc44HYsXuPaENKvbBGYtLViUpDiowHdp24q+AmRYbnYf+wZsY7Gu+g/
         n2z0CLnkoqlqamC40+sN648T4quwrR7gGSgPPwRaEB22eOFZvAtyL/SNtjhGD2jv0IGV
         TOvkKT4g3YbHuNuIrFxPxqKqFEa1B2VhfQ/y2yCCfivDVOidgp7km1XO+i0c/AfjygW0
         C1mg==
X-Gm-Message-State: AJIora8pipQVljEK9xE4j2IyAxg/U02clpmhJe+yUHQgFtIurpt7+b8r
        XQCIaZZIlzDCVuzgGUyNl3JyekcfBXL7Gw==
X-Google-Smtp-Source: AGRyM1s/7qPjShO+14x6L2HQ9zeeH4IyLdxk7IzS9U1uWS/g6WZLiTt4Mmee+MpE5D6Brc8nsWx2Og==
X-Received: by 2002:a05:6402:4247:b0:43a:d5ff:1313 with SMTP id g7-20020a056402424700b0043ad5ff1313mr3383080edb.266.1658562175554;
        Sat, 23 Jul 2022 00:42:55 -0700 (PDT)
Received: from ubuntu.fritz.box ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0072aadbd48c7sm2819204ejc.84.2022.07.23.00.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:42:55 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
To:     kestrelseventyfour@gmail.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add support for WASP SoC on AVM router boards 
Date:   Sat, 23 Jul 2022 09:42:44 +0200
Message-Id: <20220723074247.32523-1-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a popular set of Lantiq xrx200 router boards by AVM in
Germany (AVM Fritzbox 3390, 3490, 5490, 5491 and 7490) which
have the strange implementation of having the wifi cards
connected to a separate memory only ATH79 based SoC. It has no
persistent storage and no access to any resource on the Lantiq
host, but is connect to the Lantiq GSWIP switch on an additional
fixed internal network port.
This kernel module is to support booting the secondary SoC called
Wireless Assistant Support Processor (WASP).
After turning it on, a small network boot firmware is sent to
the SoC by using mdio and when it is started, an initramfs
linux image is sent to the SoC using raw ethernet frames.

The whole procedure takes about 6 seconds, if there is no error.
So far tested on 3490, 5490 and 7490 devices based on OpenWrt, 3390
takes about 20 seconds.

Patch 1/3 adds the vendor name
Patch 2/3 adds the dt-bindings
Patch 3/3 adds the remoteproc driver

To build and run, there is OpenWrt PR 5075.

Please review.

Changes in v4:
  - Fix compiler warnings with W=2 option

Changes in v3:
  - Replace generic avm,fritzboxx490-wasp with actual device names for
    device tree documentation and change the driver to accept them
  - Add maxItems to device tree documentation
  - Change example in the device tree documentation
  - Fix wait time to make the Wasp upload work for 3390 more reliable
  - Enable the SOC on driver load, use reset instead of disable/enable
    while driver is loaded and disable on unloading the driver
  - Change some messages printed to adhere to standards (e.g. remove !)

Changes in v2:
  - Remove firmware names from dt-binding and add as kmod parameters
  - Rename other bindings with vender prefix and fix gpios suffix
  - Change descriptions in dt-binding
  - Replace/Remove asynch load of firmware with request_firmware_direct
  - Fix comments to use the errno define instead of the number
  - Implement wait loops with read_poll_timeout() macro
  - Wrap read_poll_timeout() macro in function saving 6k module size
  - Return -ETIMEDOUT for all errors returned by read_poll_timeout
  - Replace mdio writes/reads with mdiobus_write and mdiobus_read and add
    return codes and their handling
  - Remove mutex for mdiobus_lock and add return code checking for mdio ops
  - Replaced the mdio register array with directly specifying registers
  - As a result of the previous 3 changes remove the functions for mdio
  - Consolidate error messages for mdio writes into a single one saved 1k
    for module size
  - Replaced mdelay with usleep_range saved 0,7k module size
  - Remove unneeded include <linux/interrupt.h> and <linux/error.h>
  - Wrap all blocks with {} and fix some indentation errors
  - Change const len in to size_t in avm_wasp_netboot_write_chunk
  - Make all methods static to fix kernel bot warning
  - Change read variable name in avm_wasp_load_initramfs_image
  - Change ssize_t variables to size_t in avm_wasp_load_initramfs_image
  - avm_wasp_netboot_write_chunk change for loop for 2 byte divisibility
  - Change uint32_t to u32
  - Change int count = -1 to u32 with U32_MAX initialisation
  - Add check for firmware len divisable by 4
  - Replace big endian bit shift operations with be32_to_cpu
  - Change loop to write 14 byte firmware chuncks like suggested
  - Change WASP_CHUNK_SIZE to ARRAY_SIZE(mac_data) for readability
  - Change int done to boolean
  - Change unsigned ints to u32
  - Change int to size_t for send_len
  - Use int for numbytes because kernel_recvmsg returns error or number
  - Two sockets are not needed, so reduce to one socket usage
  - Remove struct timeval definition, replace with __kernel_old_timeval
  - __kernel_old_timeval is depracated, but arch mips is 32bit platform
  - Replace &avmwasp->pdev->dev with local dev
  - Check if wasp network interface is up and fail if not in start method
  - Remove setsockopt for SO_REUSEADDR and SO_BINDTODEVICE
  - Remove packet_counter
  - Move firmware and firmware_end out of RESP_DISCOVER to make sure that
    they are initialized if RESP_DISCOVER is not happening first
  - indend break;
  - Move second half of the send/receive paket while loop to RESP_OK and
    let RESP_DISCOVER fall through
  - Remove bringing up the wasp network interface
  - Check if wasp network interface is up in probe and defer if not
  - Remove the check for the root device and replace it with match data
    for WASP device identification
  - Move of_read and find of mdio bus to rproc_start but delete reference
    after using it in the rproc_start method
  - Replace dev_set_drvdata with platform_set_drvdata
  - Remove avm_wasp_rproc_boot_addr because its not needed and move
    setting the fw struct pointer to avm_wasp_rproc_load
  - Move avm_wasp.h definitions to kernel module

Reported-by: kernel test robot <lkp@intel.com>

Daniel Kestrel (3):
  dt-bindings: vendor-prefixes: Add AVM
  dt-bindings: remoteproc: Add AVM WASP
  remoteproc: Add AVM WASP driver

 .../bindings/remoteproc/avm,wasp-rproc.yaml   |   61 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/remoteproc/Kconfig                    |   10 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/avm_wasp.c                 | 1053 +++++++++++++++++
 5 files changed, 1127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
 create mode 100644 drivers/remoteproc/avm_wasp.c

-- 
2.17.1

