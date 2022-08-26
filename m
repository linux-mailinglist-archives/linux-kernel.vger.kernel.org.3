Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956A35A29A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbiHZOgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHZOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:36:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DC918B32
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:36:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p18so1732779plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=3s/DZ1HMqv5ArgVIfPof2jbOwBTqzvpHj16AfB2LQj0=;
        b=BZYGbfglNN8fxsFeOWsuC0LXGX2d/8nArqKX7dVH4c/wys6/GG+suHxzkQJlEqTsdT
         +DXnjPa2SLm+Op25EqIHYRgr8iq46eRbWYZ+Gm2dlXPt2essYIP6kjfkqzwZDhzqrxEl
         JewMr4g0Ql6myCi3MuH/ORzD05ASBg5E8BgCvvIiNIOv+qlyQocoOVTQ/NT1ejb9fy/r
         7xtNYXOCmi6vYWx5pIVBeURMa5Wx5DHfP/lZq1/Wkx2N8gK1VcHIqnFeemfX5uYthpbG
         xql1KpDSfo6OvZ8xlR39KvJQnCiC+aNKKIEfXJlJ8RnmIQLGih0hluPjp1LJ5K7I5oZj
         E9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=3s/DZ1HMqv5ArgVIfPof2jbOwBTqzvpHj16AfB2LQj0=;
        b=L0ieiTZwk97WGOub/mnMiDFt2XgZmk3MnsmT9u+83TEBr9AxIwha7FDBKdozEYD0fh
         sQkZFW36/k1ZVcXYgWKQW2qjybiqOK/X6KqW8Bn7VhB7b/LAfbGF3eE24sDl+NZhzeap
         67OpmtovFHmY2r4SyKC5dIA2fOvGwcvkNVE5/LyGSR6oJ0/GpC4Vh+qDtezjfhd39rND
         NvP815bMnu9nyWODtWw9ZEeDDQcP91xofLxCTRGItNULeh2OlPz2dOEFS5PAm1aqrov7
         wGSvoPswk5+EFs6Q2MFhpE1l8DPlWT094dJ9Ohbe/p3NhaCn2gEtg7KxeuaZz2AVrnBj
         mjAQ==
X-Gm-Message-State: ACgBeo3C/W/I6lk0OOeGIS2QMr1rynY88LeUQIG+qklalkAcuvJxkxIv
        Hu7r3cU5r2ZXp/SrqfKW1mZFDw==
X-Google-Smtp-Source: AA6agR4zIgpIZ2CZPqZlSbGx+bqX5pgq2MOr6rh7Ztu0DVlWBE1iN3FOffN/AYPJH7RWDTJRnszOgg==
X-Received: by 2002:a17:90b:4a41:b0:1fb:77e0:3ff2 with SMTP id lb1-20020a17090b4a4100b001fb77e03ff2mr4848871pjb.161.1661524611313;
        Fri, 26 Aug 2022 07:36:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k27-20020a635a5b000000b0042aca53b4cesm268925pgm.70.2022.08.26.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 07:36:50 -0700 (PDT)
Date:   Fri, 26 Aug 2022 07:36:50 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Aug 2022 07:36:36 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: enable CD-ROM file systems in defconfig
In-Reply-To: <20220812200853.311474-1-heinrich.schuchardt@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, heinrich.schuchardt@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heinrich.schuchardt@canonical.com
Message-ID: <mhng-69fe0aa5-65ee-4dc3-b3ba-41e307ebc4e5@palmer-mbp2014>
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

On Fri, 12 Aug 2022 13:08:53 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
> CD-ROM images are still commonly used for installer images and other
> data exchange.
>
> These file systems should be supported on RISC-V by default
> like they are on x86_64.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index aed332a9d4ea..05fd5fcf24f9 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -166,6 +166,9 @@ CONFIG_BTRFS_FS=m
>  CONFIG_BTRFS_FS_POSIX_ACL=y
>  CONFIG_AUTOFS4_FS=y
>  CONFIG_OVERLAY_FS=m
> +CONFIG_ISO9660_FS=y
> +CONFIG_JOLIET=y
> +CONFIG_ZISOFS=y
>  CONFIG_MSDOS_FS=y
>  CONFIG_VFAT_FS=y
>  CONFIG_TMPFS=y

Thanks, this is on for-next.
