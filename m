Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDE4E3574
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiCVAKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiCVAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:10:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CAF54684
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:07:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x2so562250plm.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lN2wYlOmw3Dp7VdKLX/Ah0t27d8sLMi66eUav/fZlz4=;
        b=3ylO89xv5QvHxF31gCi0K6M3cMzuJI1gXak8x08U6MdAKZC9klzR2d9gLrjeZ6vyQ0
         A1Pkx38oO2fyf9ZtiaAUs//wXOERoTQZgUBT40UYRTsTvOozaahk2zkVDz6bH4pRbnAA
         nB9gTjFNSzX+jgOsTaoxnrnnkTWHWOZKWRCve2fKK47lC9OYyz0/D2ydxtZEIl+VWVdI
         CVGTmR3jt/tU5mXnOom9tiBeffam+WmVvXdL9zs3Gd8WSR00bvpUEdSPmLuAyYJve2gw
         iGBEvEXhCnDBEHIp4GCEk0ZepQGnQDppzAg8qncCTRu/OidvHgmF47zRYcRz0PlBSQ17
         ZJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lN2wYlOmw3Dp7VdKLX/Ah0t27d8sLMi66eUav/fZlz4=;
        b=oMsAajf8QO+bCtPJDBVLzmQgKZLrZeAa9Jyv/CowMOCPEOnM7qZXRJgomJLOzPE+/U
         AG71j+CAnoN9E9DfqWOXsTnJJO7GwJHCsiLqA9pG0RqptQNQj2Yzj/ZTn6igyYMe5i66
         J7LPmcLnAmOzQoeR9IZbkWHuWYJZA0D90CQewfRUZzVUqhXnpEyfDF4r2BXDCuetN3S2
         icdYBm8sojpvIHMc890qYLK6fTF2E6/wc3eBnSsmN5hIUqsAldsT7Fb6qW89lDs5FMWa
         OFAUu3PaAGx2tEs4u8ODQqwRIHpVsEJNywC/ocABA80j3+c9jlRIf/eicbE/p0qqjKGg
         UWLA==
X-Gm-Message-State: AOAM530Ck8ZV4ND5n4QLhZ7Hoj6UU9PR47Lier1l0mQhW3V6gHZNFR6E
        S/lVA/xVtswT2WMbAsYh7ZEM4g==
X-Google-Smtp-Source: ABdhPJxKHErpIeAj3JtNr9yjff2+0r7m9xM5Ee5pq+5GOlTu6y040CdRI9jaZdt+fyyN7rHAzjJY6g==
X-Received: by 2002:a17:90a:cce:b0:1bf:6387:30d9 with SMTP id 14-20020a17090a0cce00b001bf638730d9mr1778565pjt.196.1647907546056;
        Mon, 21 Mar 2022 17:05:46 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a0024c200b004f6b6817549sm22062826pfv.173.2022.03.21.17.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 17:05:45 -0700 (PDT)
Date:   Mon, 21 Mar 2022 17:05:45 -0700 (PDT)
X-Google-Original-Date: Mon, 21 Mar 2022 17:05:20 PDT (-0700)
Subject:     Re: [PATCH 00/12] Initial support for Nuclei DemoSoC w/ UX600
In-Reply-To: <mhng-624abf1a-c1e9-40aa-97a5-07a5b9676942@palmer-ri-x1c9>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     icenowy@nucleisys.com
Message-ID: <mhng-b11934a9-100f-457b-a35e-46bdcd7f43f4@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 08:56:42 PST (-0800), Palmer Dabbelt wrote:
> On Sat, 19 Feb 2022 06:45:43 PST (-0800), icenowy@nucleisys.com wrote:
>> 在 2022-01-27星期四的 23:16 +0800，Icenowy Zheng写道：
>>> This patchset adds support for Nuclei DemoSoC (which is an evaluation
>>> platform made with Nuclei CPU cores and mainly peripherals in
>>> original
>>> Hummingbird E203 project, running on FPGA) with UX600 CPU cores.
>>>
>>> Most patches are for DT bindings, the remaining ones are adding a
>>> Kconfig option and some DTS/DTSI files. The last one is a workaround
>>> for
>>> a severe bug in currently released versions of UX600, which is found
>>> in 5.17 kernel, in which Sv48 support is added to Linux.
>>>
>>> Two non-technical patches are in this patchset too, for MAINTAINERS
>>> and .mailmap items.
>>
>> Ping, could any RISC-V maintainers review these patches, especially the
>> SATP workaround one?
>
> Sorry, I remember having written this but I guess it got lost.  IIRC my
> main worry here was that, at least as far as I can tell, DemoSOC is an
> FPGA development board.  If this is actually in production somewhere
> then it's a different story, but IIUC the general rule is not to accept
> code for development hardware that can be updated.
>
> Assuming DemoSOC can be updated, I'd also argue that we should have some
> sort of version attached to it in DT entries.  Without some versioning
> we'll end up lost when trying to later determine what we're actually
> running on.
>
> As far as the errata goes: it looks fine to me, but I'd like to see some
> sort of description of what the errata actually is (ie, some
> documentation from the manufacturer).  I know that's not always
> possible, but without some desciption of what the bug is it gets tricky
> to mainain this sort of stuff.  For example: we've got sv57 patches
> now, so how do I know what to do with them on this target?

Just following up on this one.  Not sure if I missed it, but I can't 
find a reply.

>
>>
>>>
>>> Icenowy Zheng (12):
>>>   dt-bindings: vendor-prefixes: add Nuclei
>>>   RISC-V: add Nuclei SoC Kconfig option
>>>   dt-bindings: riscv: add compatible strings for Nuclei UX600 series
>>>   dt-bindings: timer: add compatible for Nuclei UX600 CLINT-compat
>>> timer
>>>   dt-bindings: interrupt-controller: add compatible string for UX600
>>>     PLIC
>>>   dt-bindings: serial: add compatible string for Nuclei DemoSoC UART
>>>   dt-bindings: spi: add compatible string for Nuclei DemoSoC SPI
>>>   dt-bindings: riscv: add binding for Nuclei platform boards
>>>   riscv: dts: add device tree for Nuclei DemoSoC w/ UX600 on DDR200T
>>>   RISC-V: workaround Nuclei UX600 cores with broken SATP CSR
>>>   MAINTAINERS: add myself as Nuclei SoCs/CPUs supporter
>>>   mailmap: add Icenowy Zheng's Nuclei mail addresses
>>>
>>>  .mailmap                                      |  1 +
>>>  .../sifive,plic-1.0.0.yaml                    |  1 +
>>>  .../devicetree/bindings/riscv/cpus.yaml       |  7 ++
>>>  .../devicetree/bindings/riscv/nuclei.yaml     | 27 ++++++++
>>>  .../bindings/serial/sifive-serial.yaml        |  1 +
>>>  .../devicetree/bindings/spi/spi-sifive.yaml   |  1 +
>>>  .../bindings/timer/sifive,clint.yaml          |  1 +
>>>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>>  MAINTAINERS                                   |  7 ++
>>>  arch/riscv/Kconfig.socs                       |  6 ++
>>>  arch/riscv/boot/dts/Makefile                  |  1 +
>>>  arch/riscv/boot/dts/nuclei/Makefile           |  2 +
>>>  .../dts/nuclei/nuclei-demosoc-ddr200t.dtsi    | 41 ++++++++++++
>>>  .../nuclei/nuclei-demosoc-ux600-ddr200t.dts   | 13 ++++
>>>  .../boot/dts/nuclei/nuclei-demosoc-ux600.dtsi | 49 ++++++++++++++
>>>  .../riscv/boot/dts/nuclei/nuclei-demosoc.dtsi | 67
>>> +++++++++++++++++++
>>>  arch/riscv/include/asm/vendorid_list.h        |  1 +
>>>  arch/riscv/mm/init.c                          | 17 +++++
>>>  18 files changed, 245 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/riscv/nuclei.yaml
>>>  create mode 100644 arch/riscv/boot/dts/nuclei/Makefile
>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
>>> ddr200t.dtsi
>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-
>>> ddr200t.dts
>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
>>> ux600.dtsi
>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi
>>>
