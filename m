Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BAE52D058
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbiESKTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiESKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:19:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EBA5ABA
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:19:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p26so6413596eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQZDF0ST+m3bjXxhfgKrKul8Pa3ypLxrdFU2KUJN6Wo=;
        b=yulejd8gCAcfcCJ6Hbz4UE8pg5QLnb0fCWsWWDGcCpZEpalnvHluHjDTMZwcUqEvBS
         TI1P7Eeo1L0VCdNbVplivDDT9YvH3KKapVz0QSM1jyBdfiESxEjiQstdwStrjVgcJZJ6
         J8DQD+pHP+InweqD5x6O7wh4QBqZN1xSGdDl9Ga1NsZPoSHHIB/6hb2Mzu2ddIDy/sgd
         wKmI25hsNlrcSz+C43HCmX0vIbFJqymCTcCdfA9j0SBuBc6a2Qj1QntZeO9u+M/9yx+I
         ATGXd4ebtIyF8nektWoOXEDUzVs0I+Z4eYU0SRVjZJs4A9g5dcczKHkbezctiENN1R+8
         IYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQZDF0ST+m3bjXxhfgKrKul8Pa3ypLxrdFU2KUJN6Wo=;
        b=YEmv9+h5ny+c8DLAE8FZbX+Koary3iqOGjG8nMiiHMvYW1ZRobO8jWFF2qBFC9UF96
         UKxncb/4GcgIZbu+Fg7Zmi9xOAJRPsDPuGfBmSxfvFfqBEprjIFOAJOaovADsNLU3oML
         iN2Q3EtCwSfINggc5ZEQ9cqf8mSVo+4Zwl5JJimhDrES706s5lpyr8iAaN4TZH531QMp
         AvzoKZlPHmZ/TP7apSNHyZAQzm6eefYVpjuYsQLW7x/CQFCHn7vJ4CvY4cn49rnmCB1s
         WFylAy5WezWXdsW5xV2Dt3lJWiQz29Dgf+HGRr7inSK0tAS/85YvZHdEOmke6WmYVJuy
         y94A==
X-Gm-Message-State: AOAM531zM3jVCpdgS1OLjzy9liB+ogbFAy2F6c61KoUy5217INDm4On5
        vfUqJYnk7P/V5s25lXj0PAZYBLbMQepaEqm9yB6NbA==
X-Google-Smtp-Source: ABdhPJxJRotEBuFNPsVGhczRDFHSLngF16rHucpJb9tpSyucqiOctuqwe+PayGCiBANvsl1m3CDpzIzQ37sdH0gPy2I=
X-Received: by 2002:aa7:cb1a:0:b0:41c:dd9c:2eaa with SMTP id
 s26-20020aa7cb1a000000b0041cdd9c2eaamr4404541edt.119.1652955554524; Thu, 19
 May 2022 03:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
In-Reply-To: <20220518194426.3784095-1-tanmay.shah@xilinx.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 19 May 2022 11:19:03 +0100
Message-ID: <CANLsYkw9HuLso9bGL4fM7C9qH+basgKA9yKFwms4WB4OUHqymQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add Xilinx RPU subsystem support
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        michal.simek@xilinx.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

I have replaced the previous version of this set with this one in my
queue.  That way you don't go back to the bottom.

Thanks,
Mathieu.

On Wed, 18 May 2022 at 20:46, Tanmay Shah <tanmay.shah@xilinx.com> wrote:
>
> This patch series adds bindings document for RPU subsystem found on Xilinx
> ZynqMP platforms. It also adds device nodes and driver to enable RPU
> subsystem in split mode and lockstep mode.
>
> Xilinx ZynqMP platform contains Remote Processing Unit(RPU). RPU subsystem
> contains two arm cortex r5f cores. RPU subsystem can be configured in
> split mode, lockstep mode and single-cpu mode.
>
> RPU subsystem also contains 4 Tightly Coupled Memory(TCM) banks.
> In lockstep mode, all 4 banks are combined and total of 256KB memory is
> made available to r5 core0. In split mode, both cores can access two
> TCM banks i.e. 128 KB.
>
> RPU can also fetch data and execute instructions from DDR memory along with
> TCM memory.
> ---
>
> Changes in v5:
>   - Add constraints of the possible values of xlnx,cluster-mode property
>   - fix description of power-domains property for r5 core
>   - Remove reg, address-cells and size-cells properties as it is not required
>   - Fix description of mboxes property
>   - Add description of each memory-region and remove old .txt binding link
>     reference in the description
>   - Remove optional reg property from r5fss node
>   - Move r5fss node out of axi node
>
> Changes in v4:
>   - Add memory-region, mboxes and mbox-names properties in dt-bindings example
>   - Add reserved memory region node and use it in Xilinx dt RPU subsystem node
>   - Remove redundant header files
>   - use dev_err_probe() to report errors during probe
>   - Fix missing check on error code returned by zynqmp_r5_add_rproc_core()
>   - Fix memory leaks all over the driver when resource allocation fails for any core
>   - make cluster mode check only at one place
>   - remove redundant initialization of variable
>   - remove redundant use of of_node_put()
>   - Fix Comment format problem
>   - Assign offset of zynqmp_tcm_banks instead of duplicating it
>   - Add tcm and memory regions rproc carveouts during prepare instead of parse_fw
>   - Remove rproc_mem_entry object from r5_core
>   - Use put_device() and rproc_del() APIs to fix memory leaks
>   - Replace pr_* with dev_*. This was missed in v3, fix now.
>   - Use "GPL" instead of "GPL v2" in MODULE_LICENSE macro. This was reported by checkpatch script.
>
> Changes in v3:
>   - Fix checkpatch script indentation warning
>   - Remove unused variable from xilinx remoteproc driver
>   - use C style comments, i.e /*...*/
>   - Remove redundant debug information which can be derived using /proc/device-tree
>   - Fix multiline comment format
>   - s/"final fot TCM"/"final for TCM"
>   - Function devm_kzalloc() does not return an code on error, just NULL.
>     Remove redundant error check for this function throughout the driver.
>   - Fix RPU mode configuration and add documentation accordingly
>   - Get rid of the indentations to match function documentation style with rest of the driver
>   - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
>   - Use 'i' for the outer loop and 'j' for the inner one as per convention
>   - Remove redundant error and NULL checks throughout the driver
>   - Use devm_kcalloc() when more than one element is required
>   - Add memory-regions carveouts during driver probe instead of parse_fw call
>     This removes redundant copy of reserved_mem object in r5_core structure.
>   - Fix memory leak by using of_node_put()
>   - Fix indentation of tcm_mem_map function args
>   - Remove redundant init of variables
>   - Initialize tcm bank size variable for lockstep mode
>   - Replace u32 with phys_addr_t for variable stroing memory bank address
>   - Add documentation of TCM behavior in lockstep mode
>   - Use dev_get_drvdata instead of platform driver API
>   - Remove info level messages
>   - Fix checkpatch.pl warnings
>   - Add documentation for the Xilinx r5f platform to understand driver design
>
> Changes in v2:
>   - Remove proprietary copyright footer from cover letter
>
>
> Ben Levinsky (3):
>   firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU
>     configuration.
>   firmware: xilinx: Add shutdown/wakeup APIs
>   firmware: xilinx: Add RPU configuration APIs
>
> Tanmay Shah (3):
>   dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
>   arm64: dts: xilinx: zynqmp: Add RPU subsystem device node
>   drivers: remoteproc: Add Xilinx r5 remoteproc driver
>
>  .../bindings/remoteproc/xlnx,r5f-rproc.yaml   |  128 ++
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |   33 +
>  drivers/firmware/xilinx/zynqmp.c              |   97 ++
>  drivers/remoteproc/Kconfig                    |   12 +
>  drivers/remoteproc/Makefile                   |    1 +
>  drivers/remoteproc/xlnx_r5_remoteproc.c       | 1045 +++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |    6 +
>  include/linux/firmware/xlnx-zynqmp.h          |   60 +
>  8 files changed, 1382 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
>  create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
>
>
> base-commit: 01a1a0c8d456b11f2f6b9b822414481beaa44d6f
> --
> 2.25.1
>
