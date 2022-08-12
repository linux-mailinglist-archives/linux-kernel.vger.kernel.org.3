Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40F590A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiHLCcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiHLCcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:32:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481022B26A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:32:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f28so18046892pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=UatbzrMNJ/Gz98jG+p6F/k7W841GMjlaXCRBIlUoqyQ=;
        b=ESLma1JlM4oX2GZndU01sVYkgELUKJlvlE4UE9ycyWB6blhV5OgbPPCgxKHnmrUePV
         zxfW0JnugpHrwyI0Gy0fO2sbP4uKNu9tpluyje5aQOB8XL6jViq2CUqbBt4pRb4OqHgR
         M7yOP45h+SgeolZUS/jvx6L0dmL9Kr2z08Eg/zhyrvE91kcgb4MLeV4+Z8AQEE3YVQUW
         NYFiMWpHWKK+Q/D+WqphSLEaTGKl2VVd5q2FwjeLPa81bkaT5mSwDtcik5tzOTEQhb74
         W34cB1mv8m6brZJUKviT5y7wRFwToi2p41Vrd8o6V6CneUWQZb6f+fKLfRJSx+F0NQFw
         62jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=UatbzrMNJ/Gz98jG+p6F/k7W841GMjlaXCRBIlUoqyQ=;
        b=UVfF7OMdRWPkS5YbqN0w2LCkWhEzo87fSLk7DCLd3mH5M3NEHtoP/H/tjt6sb4EV9r
         5QP6Y2CQspLgxWqYrN5BMlNC9LuSk97iUvQON7a0PIW8qDk5NO/xAqmM+HcOrmn6Y4/w
         jeS3XCun4p6Ovqc37QwUVCMFW/aC6piqyIX+xys31iLg3wq+PbIPfwT1fVUBXqTwUbsb
         gCiW3OXiMHZ048rTraIGVSnyMBQtEI14EXR0NAKrlbypf/r8GarQjEDPKPiNuaxjPwNv
         8BGQIeEwotPvBUJYxCYityjOx44zefVRk6DTP+ph9k3GCUE9RE2B5Z95XNgvdKNATPX6
         TgXg==
X-Gm-Message-State: ACgBeo1lDidIJTfdmWfU+/caPZQfuhHPKe2k2wGSYL/RInsHC9nwjxJx
        Je5fT1/hKog7WZjrsfzjGLTxp9JfN0DsEU1V
X-Google-Smtp-Source: AA6agR7mEMkyDimdP1njZ09P5/Hw+zAuTePW+dr0/LwPPms6DmM5Jt/lZE8emGPN1jSgOPZskfVcfA==
X-Received: by 2002:a05:6a00:15d2:b0:52e:b5fe:8fa9 with SMTP id o18-20020a056a0015d200b0052eb5fe8fa9mr1841581pfu.30.1660271524435;
        Thu, 11 Aug 2022 19:32:04 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id cp17-20020a170902e79100b0016f8e8032c4sm386682plb.129.2022.08.11.19.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 19:32:03 -0700 (PDT)
Date:   Thu, 11 Aug 2022 19:32:03 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 15:06:37 PDT (-0700)
Subject:     Re: [v3  0/5] Miscallenous improvement & fixes for the PMU driver
In-Reply-To: <20220711174632.4186047-1-atishp@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org, atishp@atishpatra.org,
        guoren@kernel.org, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <atishp@rivosinc.com>
Message-ID: <mhng-a68b84d8-d7c4-4048-b64e-0a5c7403fdd9@palmer-ri-x1c9>
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

On Mon, 11 Jul 2022 10:46:27 PDT (-0700), Atish Patra wrote:
> This series fixes issues PMU driver code.
> PATCH 1 & 3 are fixes for rv32 while PATCH 2 fixes a redundant
> user page update issue during counter start.
>
> PATCH 4 & 5 improves the SBI PMU definition.
>
> Changes from v2->v3:
> 1. Added two more patches that fixes few typos and enable support
> for perf support in KVM.
>
> Changes from v1->v2:
> 1. Add proper compile time rv32 checks.
>
> Atish Patra (5):
> RISC-V: Fix counter restart during overflow for RV32
> RISC-V: Update user page mapping only once during start
> RISC-V: Fix SBI PMU calls for RV32
> RISC-V: Move counter info definition to sbi header file
> RISC-V: Improve SBI definitions
>
> arch/riscv/include/asm/sbi.h | 32 ++++++++++++++++++++++++++++++--
> drivers/perf/riscv_pmu.c     |  1 -
> drivers/perf/riscv_pmu_sbi.c | 30 ++++++++++++++++--------------
> 3 files changed, 46 insertions(+), 17 deletions(-)

Sorry, I guess I'd forgotten that Will asked me to merge this one.  
Thanks to Atish for reminding me, this is on for-next.
