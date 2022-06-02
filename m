Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574DB53B334
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiFBF6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiFBF6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:58:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670765D1F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:58:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so3967703pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wPBDv8Xucc9F0KVOT9xu9iIByq/KGBHHhKQJwLqoVzg=;
        b=7QtUdqwtlxbxKjdEeEOqac39coDUMufeS3DRibw4LOSr5kIRLNnFCJEloUjDmkQEGf
         gQKGkV+trBHjvPm594tJbQM/K1aT2M+Ay1xigvc4ialetNXUgNauPjoxBpJyVu9zSrD/
         akF9IyP8z1fLNWfc5onE9XZLGF8/jRLd92kqvP8uBpsnTf8dtyXxQMiP8os9dcKgDeDg
         F3DKSsd4r+Jx5okQUnsR2D8wxpYnbap+W473Dr5YU1F7e9IZafHS5vNaxGe1gd3Boa6S
         AVhm87U4bBwma9fNSGMuTNJVgmsanr9LOSMcqoblhu+oHCWWjavQoqIQmK7nIqoufjHf
         d/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wPBDv8Xucc9F0KVOT9xu9iIByq/KGBHHhKQJwLqoVzg=;
        b=p40anvctTO9UHjny74rqVCDo0MNd6crVIjDG3zWjEtzIS4XE4bN2z9FdH77UGU0xgZ
         K4roxPS1QQtYXLxIvRkU84ocHrR52Ah4qFqL/BVxoS4Rl/mGblkdC10Uc8he3KVsKFxW
         gPh87Koor/BfsaCRaD3mWPLMRgYG4traPoPc+2UITyusWMu34KmoMeM02EnveY2YiJIB
         Xmhie711L2hsTEwI2wvxKucVbCvmtDq9pWRTUP8HjDmbRhTI3dfdHKe++EBoHGqA0LGC
         e3oUap6xYMeMyhMHWJwMr0TA7gyv1TrGxkgCn8Dsfy/9NlLv6rWjbT5ChtO2IDAJFnnr
         M/CA==
X-Gm-Message-State: AOAM5306WGbnliSrtxRKDTtjm7M0gL6rIcpxLkdp5GOtlZRWahQ6EwEm
        XD4HUXoagg3Pno36UtmP52+HhyFuRURH2A==
X-Google-Smtp-Source: ABdhPJwZewGk6VykwRej+NNAIC7c5baAbdYBoLRnT9XM+o4+CPHY2Sk+7sPmGe8CcP047xSNHfmDvw==
X-Received: by 2002:a17:902:d5cb:b0:161:6a34:37ac with SMTP id g11-20020a170902d5cb00b001616a3437acmr3170973plh.83.1654149488679;
        Wed, 01 Jun 2022 22:58:08 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h69-20020a628348000000b0050dc7628138sm2621272pfe.18.2022.06.01.22.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 22:58:08 -0700 (PDT)
Date:   Wed, 01 Jun 2022 22:58:08 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 22:58:06 PDT (-0700)
Subject:     Re: [PATCH v2  0/3] Miscellaneous fixes for PMU driver
In-Reply-To: <20220513015522.910856-1-atishp@rivosinc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        atishp@atishpatra.org, anup@brainfault.org, jszhang@kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <atishp@rivosinc.com>, Will Deacon <will@kernel.org>,
        mark.rutland@arm.com
Message-ID: <mhng-ba83da39-dadf-4d6e-99be-a1b5fdf9b62c@palmer-ri-x1c9>
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

On Thu, 12 May 2022 18:55:19 PDT (-0700), Atish Patra wrote:
> This series fixes issues PMU driver code.
> PATCH 1 & 3 are fixes for rv32 while PATCH 2 fixes a redundant
> user page update issue during counter start.
>
> Changes from v1->v2:
> 1. Add proper compile time rv32 checks.
>
> Atish Patra (3):
> RISC-V: Fix counter restart during overflow for RV32
> RISC-V: Update user page mapping only once during start
> RISC-V: Fix SBI PMU calls for RV32
>
> drivers/perf/riscv_pmu.c     |  1 -
> drivers/perf/riscv_pmu_sbi.c | 16 ++++++++++++++++
> 2 files changed, 16 insertions(+), 1 deletion(-)

+Will and Mark.

Will recently took some stuff for drivers/perf/riscv_* into his 
for-next/perf tree (which I didn't even know about until then, oops), 
but the previous stuff I took through the RISC-V tree.  Always happy to 
get stuff out of my tree, just LMK what you want me to do here.

I did some minor cleanups to the commit text and put them over at 
palmer/riscv-pmu_fixes, it's all passing my tests.  These generally look 
fine to me and they're all stable backports, so no big rush on the merge 
window (which I still have stuff for).
