Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8476F4D1372
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbiCHJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbiCHJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:32:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA231527
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:31:01 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso1064454wmr.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 01:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=CetJNzTKyVG8qZ2bQ1eNFE/fMs/QHyLqehu50WJq6EI=;
        b=nFIiZVjRWne0eKi8ijKlgttx9nFNNk0yvmrCEoM8f2E/Wo0XGmjQTr2z+HL3pzhqXd
         /alRd6H2COvxpRKhCX2bJqsmMXRv2SYaYn3JadIMqwUDCgK1gJ76wGF2+8BQmmSA4hAK
         BCzCXu3coxU89/jZzHWuB0vL8a1q0783Teqkac//+e0b1XlirzjBIU7EEiwruMxew2Dm
         SnoArvzmGI4qDMYZ6XLqwK93Ut+oF1ScmxA548ZHb5DxI2RW0PRDADC7NR3ksCRK6b7q
         6GW/0kz40kmUjeIB+WoSK5c/3tJF0CXC4+52Rv83pJHCthV2y5vpjuqnuvlkyPoBMBGV
         TgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=CetJNzTKyVG8qZ2bQ1eNFE/fMs/QHyLqehu50WJq6EI=;
        b=uoKFS9MjbAF/w+KQ2Fzs2ImZ/rBytgSW4I6EdmoIDNvUGjO6bFxwDM82I8TWnLVPps
         B22DfHW9LhBYPrNTELJq8bTabIzEUvGQ9qNot61s9wJnAdU0cQ089ww4mhPu3LLWhgg7
         oh5UVxSD/zy3AFLeBwm3Rl4ivKQH+xKYXUsatZ3el3YvN1hSsr6oUi6ACkmf1BQoW51S
         jrUBUoxk4P/WHUPRnjN8KFqV1og4Eod9ICYbhGA7MK8GNuvDnnXEr0C5XCPSd5lmRPaF
         ua+GXnFeDJhKF3GtjZV7RqNdk34ZUA8MuvJRp572lTJBXKfA10ygVNM3Y3ARlUvFtDbM
         3l4g==
X-Gm-Message-State: AOAM5331+x0Da7ta5sK8Tmqx9poBfiK/HBiWoe9K2Sw+fw60nMifsKsK
        pTLctZ2zIv7OYQ49Y5FpRqWreiYuUP1ZVWLp
X-Google-Smtp-Source: ABdhPJx0nc5bJfY7hYmCPLXx0B2JDr41e2w8sVXywNW9kErbCVrNB3oaw01HJ2rNuFLo0zuhqzYbjw==
X-Received: by 2002:a7b:c250:0:b0:389:7fe5:d34c with SMTP id b16-20020a7bc250000000b003897fe5d34cmr2679862wmj.83.1646731860131;
        Tue, 08 Mar 2022 01:31:00 -0800 (PST)
Received: from [192.168.1.99] (std93-h01-31-34-241-225.dsl.sta.abo.bbox.fr. [31.34.241.225])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b0038377fb18f8sm2312355wma.5.2022.03.08.01.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:30:59 -0800 (PST)
Message-ID: <bacb5387-2992-97e4-0c48-1ed925905bee@gmail.com>
Date:   Tue, 8 Mar 2022 10:30:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     andreyknvl@google.com, vincenzo.frascino@arm.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        paul.semel@datadoghq.com, semelpaul@gmail.com
From:   Paul Semel <semelpaul@gmail.com>
Subject: [PATCH] arm64: kasan: fix include error in MTE functions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix `error: expected string literal in 'asm'`.
This happens when compiling an ebpf object file that includes
`net/net_namespace.h` from linux kernel headers.

Include trace:
     include/net/net_namespace.h:10
     include/linux/workqueue.h:9
     include/linux/timer.h:8
     include/linux/debugobjects.h:6
     include/linux/spinlock.h:90
     include/linux/workqueue.h:9
     arch/arm64/include/asm/spinlock.h:9
     arch/arm64/include/generated/asm/qrwlock.h:1
     include/asm-generic/qrwlock.h:14
     arch/arm64/include/asm/processor.h:33
     arch/arm64/include/asm/kasan.h:9
     arch/arm64/include/asm/mte-kasan.h:45
     arch/arm64/include/asm/mte-def.h:14

Signed-off-by: Paul Semel <paul.semel@datadoghq.com>
---
  arch/arm64/include/asm/mte-kasan.h | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/mte-kasan.h 
b/arch/arm64/include/asm/mte-kasan.h
index e4704a403237..a857bcacf0fe 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -5,6 +5,7 @@
  #ifndef __ASM_MTE_KASAN_H
  #define __ASM_MTE_KASAN_H

+#include <asm/compiler.h>
  #include <asm/mte-def.h>

  #ifndef __ASSEMBLY__
-- 
2.35.1
