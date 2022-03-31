Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F24ED19D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352511AbiCaCSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiCaCSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:18:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73601673EE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:16:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso2175467pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/Wq8pDzbR7CUsnr4sdt91dwx6hh1W9+nP/weoDPwRHk=;
        b=ALRpTGH8SD7ag77B6dbqoLafs6OdKxiQbdVsqhuEw9qFf/oYaqv3HxQQRWhAIx1Dt9
         ftKdvsgia6lDm13mxCIeU9dTjRm3SWTgcyGq78N9SFHvf6VtE6sJHDSzKI8oE1G8D0TG
         9g7k7owgDo/5TxT1mHfelbks5a1bJ+UosjTKY09AGVjljM3XcosaDvjGqUayor2RdN/u
         c/4YsRMc/lRyOq2JlbWey6W/SXDQ8SDh3+sX9OBgMBghK2Gw0+yiC9LGeg8vST5xbaYe
         dUytlP3/TKOsU3bkow7XUT318kNwCmMeW7gPyXg1SPwBQr4KX+15TB+yUC9pCeOMibTi
         taYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/Wq8pDzbR7CUsnr4sdt91dwx6hh1W9+nP/weoDPwRHk=;
        b=gBz3qq+tC/bbL3MVNyPYuyI/jdmG7aeHtp2gjMpVzw7J6eFBKlksbcK06J0MRmkAkE
         qRGZm0lMEB2d+tZV0Z8MaAivB4a4UqwkyaDE31FqFL1lRcbzmN1KCd3txIEtyZm+o/Gw
         iiVPb9UVTR/mQjW+H8oU8H1DgACtxU8/UhenLdYdqFMMFR9TKDUmJr/f/ArZJ0h5KajA
         9xJWf8xSTP35a7MaiWsrRqTCnUmZgDq7SwvvJfMf4bRKh1Z8gAzjDbDCPp8AHBQUvnRD
         O3xMGsduv5MTxhOVMZPdvJilLfCnDnUvS0lIS9Ua3zBnsiwK12haDPL/3SRVEtTZuYTS
         bclA==
X-Gm-Message-State: AOAM530PoNsRA799IIBCRa2g/Zrb38+VV2GgDUR6wSw/Y5anNLhVDp0d
        ZHuL29SrEIhMHhNV/bIp13Jr0GDGaCKM0Q==
X-Google-Smtp-Source: ABdhPJwoWJyLQ6QPp5H5+Zi0bn4XlidZVPYpOFyufA+MeJTtbd6qNo/vK9YqdyQGm6YZAjsao2QpsA==
X-Received: by 2002:a17:903:2c5:b0:14f:4a29:1f64 with SMTP id s5-20020a17090302c500b0014f4a291f64mr3022071plk.90.1648692982901;
        Wed, 30 Mar 2022 19:16:22 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id d24-20020a637358000000b003823aefde04sm20680836pgn.86.2022.03.30.19.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:16:22 -0700 (PDT)
Date:   Wed, 30 Mar 2022 19:16:22 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 19:16:20 PDT (-0700)
Subject:     Re: [PATCH 2/3] RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n
In-Reply-To: <d8a35bea-f4a0-b54d-9d2a-d1cc9b3d3e53@opensource.wdc.com>
CC:     linux-riscv@lists.infradead.org, Niklas.Cassel@wdc.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        heinrich.schuchardt@canonical.com, atishp@atishpatra.org,
        mchitale@ventanamicro.com, alexandre.ghiti@canonical.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     damien.lemoal@opensource.wdc.com
Message-ID: <mhng-5bb87384-f841-4793-8f1a-fabd5c13a181@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 17:26:45 PDT (-0700), damien.lemoal@opensource.wdc.com wrote:
> On 3/31/22 08:47, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> As of 93917ad50972 ("RISC-V: Add support for restartable sequence") we
>> have support for restartable sequences, which default to enabled.  These
>> select MEMBARRIER, so disabling it is now redundant.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> ---
>>
>> I'm not actually sure this is the right way to go: presumably the K210
>> defconfigs had MEMBARRIER=n for a reason (maybe just size?), so we might
>> actually want to move to RSEQ=n instead?  As usual: I don't test on the
>> K210, so I'm not exactly sure what the constraints are.
>
> Not sure either. It is like this now because I think this was the default
> at the time the config was created.
>
> Niklas,
>
> Can you test this please ?

Thanks.  I'm OK either way, I guess I'd learn towards turning on the 
features if they work/fit.  I'll hold off on merging this one for a bit, 
I don't see any rush (it's just a defconfig) and if what was there is 
broken then we can take it as a fix.  Otherwise it'll just get rolled up 
into the next round of these, which I'll hopefully remember to do 
earlier next time.

>
>> ---
>>  arch/riscv/configs/nommu_k210_defconfig        | 1 -
>>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
>>  arch/riscv/configs/nommu_virt_defconfig        | 1 -
>>  3 files changed, 3 deletions(-)
>>
>> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
>> index 3f42ed87dde8..2438fa39f8ae 100644
>> --- a/arch/riscv/configs/nommu_k210_defconfig
>> +++ b/arch/riscv/configs/nommu_k210_defconfig
>> @@ -21,7 +21,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>>  # CONFIG_AIO is not set
>>  # CONFIG_IO_URING is not set
>>  # CONFIG_ADVISE_SYSCALLS is not set
>> -# CONFIG_MEMBARRIER is not set
>>  # CONFIG_KALLSYMS is not set
>>  CONFIG_EMBEDDED=y
>>  # CONFIG_VM_EVENT_COUNTERS is not set
>> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
>> index af64b95e88cc..9a133e63ae5b 100644
>> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
>> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
>> @@ -13,7 +13,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>>  # CONFIG_AIO is not set
>>  # CONFIG_IO_URING is not set
>>  # CONFIG_ADVISE_SYSCALLS is not set
>> -# CONFIG_MEMBARRIER is not set
>>  # CONFIG_KALLSYMS is not set
>>  CONFIG_EMBEDDED=y
>>  # CONFIG_VM_EVENT_COUNTERS is not set
>> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
>> index e1c9864b6237..5269fbb6b4fc 100644
>> --- a/arch/riscv/configs/nommu_virt_defconfig
>> +++ b/arch/riscv/configs/nommu_virt_defconfig
>> @@ -19,7 +19,6 @@ CONFIG_EXPERT=y
>>  # CONFIG_AIO is not set
>>  # CONFIG_IO_URING is not set
>>  # CONFIG_ADVISE_SYSCALLS is not set
>> -# CONFIG_MEMBARRIER is not set
>>  # CONFIG_KALLSYMS is not set
>>  # CONFIG_VM_EVENT_COUNTERS is not set
>>  # CONFIG_COMPAT_BRK is not set
