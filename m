Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBFB4EE61C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbiDACja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbiDACj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:39:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3394B2597F7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:37:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so1283231pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dSzGnbquoGpvfekF3+JSElEXmIkzDvN1jgGM1Sss5ik=;
        b=73XfenG3pR4e8k8WwYXUCm8KRLeDyor4l/6dcX7PWZNA+ExQFPnSHDIhjhG+y2n654
         a4Z3/UzKFxj34A3uUWV18T1VXixwPAHicLiu1Udgb6OPffWPSebu4S2cOZ8CebJWNOE4
         SOF3AUgAnBQB28yl/J9ephB7PZE8vsR/xUJo0HNkbp+/2VAqu9SaTL1QMmToskhKw/yM
         qY1yOyElMmqwmlZNdRI5bqReAzvO4tx0vXhUSQqoFGospj8PmpmPWpjttCUW429uhaWN
         RvzKaHBA/flY2MggApnpNXhyJoGugk+bdvxQMOkQ6PiSafFQPfKgiap4pkcrEtPGkJP4
         nHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dSzGnbquoGpvfekF3+JSElEXmIkzDvN1jgGM1Sss5ik=;
        b=3Z1akzCqG1hF1l08Jh4TJ3nz70rXmPeLg+88i6qaTXOntIC3Y4a2BicJHil5p8cxiG
         TAywxXFbtdTsDH2Q627Lp7a8nl9w5XuADaQokV7opxHSQbUNuClR+9kXJyEwzV2ykwMM
         AgZi2i+q9jBDJktyq4g+6+nOUPSZYod/fQKCZIL68yl88oO76tgpIkqE/A/2+HTEuDBF
         yUfFaEd1cI/2uC5z0652pLld2pq8a1UJPaq0Rp3fiCylQUW0JtQ+jYWiStW+3k1+Prxk
         UpH2u47TT5p5x3SgYN8z1C3+mKeUbldPe1r43AD4i76BjnamR/+qIdNik915N4531A5a
         P9Fw==
X-Gm-Message-State: AOAM530Xyah9NypBZGmZwGaBW04inVT2ZKL/VFwhbEcEmNh+MqIWvP7w
        oHy1XXrOykyv8FICEfKwGdvbkg==
X-Google-Smtp-Source: ABdhPJxAXkMECDqCbVJu0jvPhm8GCAbKB5MwB4XPjx0E3ipQetCmEarl4Afe2ZOldds0saCiXbn3jQ==
X-Received: by 2002:a17:903:41d0:b0:154:de5:a240 with SMTP id u16-20020a17090341d000b001540de5a240mr8464375ple.32.1648780656632;
        Thu, 31 Mar 2022 19:37:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id il7-20020a17090b164700b001c779d50699sm12130159pjb.55.2022.03.31.19.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 19:37:36 -0700 (PDT)
Date:   Thu, 31 Mar 2022 19:37:36 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 17:49:16 PDT (-0700)
Subject:     Re: [PATCH 1/3] RISC-V: defconfig: Drop redundant SBI HVC and earlycon
In-Reply-To: <20220330234739.1956-1-palmer@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, heinrich.schuchardt@canonical.com,
        atishp@atishpatra.org, mchitale@ventanamicro.com,
        alexandre.ghiti@canonical.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Message-ID: <mhng-6019c9cc-b2f0-405c-91de-981ce90dd9d9@palmer-mbp2014>
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

On Wed, 30 Mar 2022 16:47:37 PDT (-0700), Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> As of 3938d5a2f936 ("riscv: default to CONFIG_RISCV_SBI_V01=n") we no
> longer default to enabling SBI-0.1 support, so these dependent configs
> no longer have any effect.  Remove them to avoid clutter.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/configs/defconfig      | 2 --
>  arch/riscv/configs/rv32_defconfig | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 7cd10ded7bf8..74df9e1dd2d2 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -64,8 +64,6 @@ CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> -CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> -CONFIG_HVC_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index e0e5c7c09ab8..cabfd6a5b47b 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -62,8 +62,6 @@ CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> -CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
> -CONFIG_HVC_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y

This and #3 are on for-next, I'm holding off on #2 pending testing on 
the K210.
