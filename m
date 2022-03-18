Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2004DD375
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiCRDL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiCRDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:11:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDAAC558D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:10:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so4866486pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0gHHt1JqAwoF17n7ibUdigU8aOOB90AJhCP1mUVeFZ0=;
        b=FDuPFlnro/v7DXousZSsjlciLEaFw16Qy6oNf8MBtRjYOOpDeua9725z8H1lpk3eSe
         ZnbC0/XzxQLo0uxR4r23aZhletg3h0JOs8lmCtbgCbZtKxqqQhthNERb1n0eU8ZkK/lW
         l51Lu9hzIHva346QmSvSHI6i/wDKFlvLk5fvjD3mxkcZH7LKeJbkPdDWSclNsa1dEYjh
         iiR5qtSD4c9RqfKUbprJUclvtg/rycXbrPG3uclSvZNqjgOzinWsyfvDuby/W6peo6Ny
         yhaLTEHNN1yjAtSPZI/xL5lFHB+ycsarYpFwFGc0pHjl699pWuV1GKTMh/lKKVsGHEGm
         m0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0gHHt1JqAwoF17n7ibUdigU8aOOB90AJhCP1mUVeFZ0=;
        b=3kBNTCbcgwWNXTLRWmeEQLa4/DLwQUmI/vZJwOSM3meNn9TO27H7v4UY0OEuaYSMMo
         UhbRX0iGrc3d0Cjkl9xB9lVSlGRZTYSuwQMYd4Yeghmm9oEiXMuYu9ME9vl+4bdUJBkA
         2Lrwl3SlOS14O/IagQ1MWdGRwLjDEDc//JKkXdSv42KpLR9s5Ma7NmOg2CR02YF0P/Pz
         Z2L9ZhFhyeoBYnZ1S+08rWHuXd+eP880MH8A16yjVjw3nB7X0e+AmullFFaeS6QVz39x
         sxMbVKtwn78K3B6wSlyKNKq99vbHy7ir/Dy+Dyk4S4dkqdPSohO8IPXqEMgQ15k6mPcl
         o9Xw==
X-Gm-Message-State: AOAM533hYwzm941b+l3aSR3y/aPaOQrUA9FYsTa8CgXX+TgOgEuvNq6a
        HWIGT8NI6MC+IGz/Z+sYtc5FbPVs23tdKQ==
X-Google-Smtp-Source: ABdhPJyVOUAUDfkDhGgRehhK3QSKTVmspbipFfnEk7FylPiNOrWPrYGssWn5GpLCRkFMjS29CjXERA==
X-Received: by 2002:a17:90b:3807:b0:1bf:6c8e:f9b7 with SMTP id mq7-20020a17090b380700b001bf6c8ef9b7mr8995968pjb.16.1647573006636;
        Thu, 17 Mar 2022 20:10:06 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g28-20020a63111c000000b00374646abc42sm6271571pgl.36.2022.03.17.20.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 20:10:05 -0700 (PDT)
Date:   Thu, 17 Mar 2022 20:10:05 -0700 (PDT)
X-Google-Original-Date: Thu, 17 Mar 2022 20:10:03 PDT (-0700)
Subject:     Re: [PATCH v6 0/6] Provide a fraemework for RISC-V ISA extensions 
In-Reply-To: <20220314203845.832648-1-atishp@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, anup@brainfault.org,
        damien.lemoal@wdc.com, devicetree@vger.kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-596cc82d-51af-448c-bd04-51b517fe79c7@palmer-ri-x1c9>
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

On Mon, 14 Mar 2022 13:38:39 PDT (-0700), Atish Patra wrote:
> This series implements a generic framework to parse multi-letter ISA
> extensions. This series is based on Tsukasa's v3 isa extension improvement
> series[1]. I have fixed few bugs and improved comments from that series
> (PATCH1-3). I have not used PATCH 4 from that series as we are not using
> ISA extension versioning as of now. We can add that later if required.
>
> PATCH 4 allows the probing of multi-letter extensions via a macro.
> It continues to use the common isa extensions between all the harts.
> Thus hetergenous hart systems will only see the common ISA extensions.
>
> PATCH 6 improves the /proc/cpuinfo interface for the available ISA extensions
> via /proc/cpuinfo.
>
> Here is the example output of /proc/cpuinfo:
> (with debug patches in Qemu and Linux kernel)
>
> / # cat /proc/cpuinfo
> processor	: 0
> hart		: 0
> isa		: rv64imafdch_svpbmt_svnapot_svinval
> mmu		: sv48
>
> processor	: 1
> hart		: 1
> isa		: rv64imafdch_svpbmt_svnapot_svinval
> mmu		: sv48
>
> processor	: 2
> hart		: 2
> isa		: rv64imafdch_svpbmt_svnapot_svinval
> mmu		: sv48
>
> processor	: 3
> hart		: 3
> isa		: rv64imafdch_svpbmt_svnapot_svinval
> mmu		: sv48
>
> Anybody adding support for any new multi-letter extensions should add an
> entry to the riscv_isa_ext_id and the isa extension array.
> E.g. The patch[2] adds the support for various ISA extensions.
>
> [1] https://lore.kernel.org/all/0f568515-a05e-8204-aae3-035975af3ee8@irq.a4lg.com/T/
> [2] https://github.com/atishp04/linux/commit/e9e240c9a854dceb434ceb53bdbe82a657bee5f2
>
> Changes from v5->v6:
> 1. Changed the isa extension format from separate row to single row that follows
>    RISC-V spec naming standards.
>
> 2. Removed the redundant extension detection log.
>
> Changes from v4->v5:
> 1. Improved the /proc/cpuinfo to include only valid & enabled extensions
> 2. Improved the multi-letter parsing by skipping the 'su' modes generated in
>    Qemu as suggested by Tsukasa.
>
> Changes from v3->v4:
> 1. Changed temporary variable for current hart isa to a bitmap
> 2. Added reviewed-by tags.
> 3. Improved comments
>
> Changes from v2->v3:
> 1. Updated comments to mark clearly a fix required for Qemu only.
> 2. Fixed a bug where the 1st multi-letter extension can be present without _
> 3. Added Tested by tags.
>
> Changes from v1->v2:
> 1. Instead of adding a separate DT property use the riscv,isa property.
> 2. Based on Tsukasa's v3 isa extension improvement series.
>
> Atish Patra (3):
> RISC-V: Implement multi-letter ISA extension probing framework
> RISC-V: Do no continue isa string parsing without correct XLEN
> RISC-V: Improve /proc/cpuinfo output for ISA extensions
>
> Tsukasa OI (3):
> RISC-V: Correctly print supported extensions
> RISC-V: Minimal parser for "riscv, isa" strings
> RISC-V: Extract multi-letter extension names from "riscv, isa"
>
> arch/riscv/include/asm/hwcap.h |  25 +++++++
> arch/riscv/kernel/cpu.c        |  65 ++++++++++++++++-
> arch/riscv/kernel/cpufeature.c | 128 +++++++++++++++++++++++++++------
> 3 files changed, 195 insertions(+), 23 deletions(-)

Thanks, this is on for-next.
