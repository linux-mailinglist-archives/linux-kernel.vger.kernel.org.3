Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457FF486956
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiAFSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbiAFSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:01:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18CFC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:01:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso3983407pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 10:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4zcOQ9tOzM//Yk7TQGq7eHYDGBLmCAFxO9dcr6dZd90=;
        b=DIZgxcXzw8eHu0c1FCLZmjbgNvWxxUXm9ereYtae3do2ZAGBOv2V7qCYgdcDo8kmlV
         Pe4ZKLQbFBbBqzBiiIKQE+w844eEmWE89Mj4juZdQh059BCUnn3l7hDr8eRSAYJwlxXT
         ALtjbBUhflR46FuhAqzZfY6rSmwb4JVKMNKOtXvaMFiVor8tfr/z0RZHE1xKEz2R74Yj
         x70Gsb8XVjzPSu9Dv2X2pkAJDxs8RT9ZEU9ZUbJFOaVlEcKR+OcuxEIjtmu55cyz/wQW
         mlPD2alf4zDT6WWYmZM9E2NXWhFGl9UwlKn11e8IK70k0zQ98WBJPMf5Y4gDr8ysTB/k
         SVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4zcOQ9tOzM//Yk7TQGq7eHYDGBLmCAFxO9dcr6dZd90=;
        b=cVag7oZevTI99wt4myWCIA55Rp9zKbSWGyUkjPVOfgTIbeZH9kSqD0WHACzHi6jYEK
         K/ThbsnUCjIJsIVXSVT7TeVg7worYmdCpOEeCDkPRcuil9drWH4M3TkbdHrzSx3nRViO
         sh7P0IVt3BG/t/Zt6AndT+6knCfkZ6gFo+T5JTVqdG/7z2QxIQtZJBTYgbcouXEP3RcO
         0nf5bLc5huCHQSj2lL3WDjef1w/TkYiT3lDWJt392iC9mDS3dsUC5YIP6k8tIL5Nz12p
         GgsQOiwgpCCTuBHjTC6yIZqst6wyHpfXISzThwmdJAha6+f8Y1IKaN9XgJPXVyqG9Gkf
         SeGQ==
X-Gm-Message-State: AOAM531i8jqOxPFdPiEklKb/dNLabe5uvYXOHF2h24+yphw4Ubkxat1R
        mDXfYpA6shTIL0npRKrozPSAAA==
X-Google-Smtp-Source: ABdhPJwxRgBsmYz4yEwedUABJs7D0bB9QxHddTM6iDuTsAaHUHBx9dOLYOQX/OiNZqx1wfnABsvJVw==
X-Received: by 2002:a17:902:7442:b0:149:7a3f:3899 with SMTP id e2-20020a170902744200b001497a3f3899mr49389317plt.90.1641492116369;
        Thu, 06 Jan 2022 10:01:56 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gm9sm3034133pjb.25.2022.01.06.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:01:55 -0800 (PST)
Date:   Thu, 06 Jan 2022 10:01:55 -0800 (PST)
X-Google-Original-Date: Thu, 06 Jan 2022 10:01:24 PST (-0800)
Subject:     Re: [PATCH 12/12] RISC-V: defconfigs: Remove redundant K210 DT source
In-Reply-To: <DM6PR04MB70816CBD9FFA383FEE8DDC67E79E9@DM6PR04MB7081.namprd04.prod.outlook.com>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        heinrich.schuchardt@canonical.com,
        Atish Patra <atishp@rivosinc.com>, bin.meng@windriver.com,
        sagar.kadam@sifive.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Damien.LeMoal@wdc.com
Message-ID: <mhng-40969d90-76cb-4b9b-9c39-32dbd0f9a7ea@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 15:41:18 PST (-0800), Damien.LeMoal@wdc.com wrote:
>> On 2021/11/20 1:45, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>> 
>> The "k210_generic" DT has been the default in Kconfig since 7d96729a9e7
>> ("riscv: Update Canaan Kendryte K210 device tree"), so drop it from the
>> defconfigs to avoid diff with savedefconfig.
>> 
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>>  arch/riscv/configs/nommu_k210_defconfig        | 1 -
>>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
>>  2 files changed, 2 deletions(-)
>> 
>> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
>> index 89ab76349ea8..e8ceab678e8b 100644
>> --- a/arch/riscv/configs/nommu_k210_defconfig
>> +++ b/arch/riscv/configs/nommu_k210_defconfig
>> @@ -29,7 +29,6 @@ CONFIG_EMBEDDED=y
>>  CONFIG_SLOB=y
>>  # CONFIG_MMU is not set
>>  CONFIG_SOC_CANAAN=y
>> -CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
>>  CONFIG_MAXPHYSMEM_2GB=y
>>  CONFIG_SMP=y
>>  CONFIG_NR_CPUS=2
>> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
>> index 84b87f8bfc8f..46aa3879f19c 100644
>> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
>> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
>> @@ -21,7 +21,6 @@ CONFIG_EMBEDDED=y
>>  CONFIG_SLOB=y
>>  # CONFIG_MMU is not set
>>  CONFIG_SOC_CANAAN=y
>> -CONFIG_SOC_CANAAN_K210_DTB_SOURCE="k210_generic"
>>  CONFIG_MAXPHYSMEM_2GB=y
>>  CONFIG_SMP=y
>>  CONFIG_NR_CPUS=2
>> 
>
> Then maybe also delete the arch/riscv/boot/dts/canaan/k210_generic.dts file too
> ? It is redundant now that it is not being referenced...

IIUC that's the opposite of what's going on here.  Looks like I somehow 
managed to get the commit wrong, which I've fixed, it's 67d96729a9e7 
("riscv: Update Canaan Kendryte K210 device tree")  That contains

    diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
    index 6402746c68f3..7efcece8896c 100644
    --- a/arch/riscv/Kconfig.socs
    +++ b/arch/riscv/Kconfig.socs
    @@ -51,7 +51,7 @@ config SOC_CANAAN_K210_DTB_SOURCE
            string "Source file for the Canaan Kendryte K210 builtin DTB"
            depends on SOC_CANAAN
            depends on SOC_CANAAN_K210_DTB_BUILTIN
    -       default "k210"
    +       default "k210_generic"
            help
              Base name (without suffix, relative to arch/riscv/boot/dts/canaan)
              for the DTS file that will be used to produce the DTB linked into the

which makes the defconfig entry redundant but still references the DT 
file.
