Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49543578A62
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiGRTNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiGRTNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:13:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90022F3B9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:13:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n7so10072587ioo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ECMSU0iwvYt8tVE81ImJIsGyJ1Mwn7+kBGoJQPQ6k5Y=;
        b=opvdSOTUsRFayUBtCxOuT6SJdk+fiFsUHVMpWnb0m9fsLIPgPE8yDMBJQ6CSG4+3nW
         ZHiJCTiTiHh9Cz5MS5yHigL3IEYSQtiwQaWzUtS/XzTQz442BYbiJXAQVc/ebhMvARui
         C93ROS/awBZA6UHZLa2Jytl+vfTar7B53KhgAmiVZeS2fLLMuKDSNp1/0OJYph9Blj9h
         QO095eWeJl34ls78Tfwjed5yRFkgTyQxRv9OX/0GWnkNEYg78mx/NRiYWqub27jTGsOl
         4CfwP7RwrgKkXHsp/8+/28CwTx1nBC5ib0pgktTgdnh941ZjSHE8eKKU9mZlttSIKbFv
         lEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ECMSU0iwvYt8tVE81ImJIsGyJ1Mwn7+kBGoJQPQ6k5Y=;
        b=e7bA/AM8dhYWVvsH6uzAo0uvyLdKKiCiJDpdRCG+A2AfC611PnGQBUP5gSS+pkag26
         qWuRbGBlbDf1F3rMPwYKXPZJKkeVjWezBaJpNVecKdvNpBWy/nULTdfs76hmtOK4L0nN
         8LH4HsCmPQgFS+/tVI/TkL1eaFns+DsMxdeadLy/r5jIjroZNhB9ASmQR9kBLqmylzAv
         YavglLa9sjaRMMfThD1RvZChyf9yIx3u5l/UDGHewC5TM/iihC4rc1O/NYu6Dm/p0N1b
         smyWD0/vjdIzmy23YOQD99cfJ+WJ9d0hLWQ8/hpKbXS96SgqisC6l2nI87IbAg0oGKrw
         9oXA==
X-Gm-Message-State: AJIora/qIAp6mPWecGwY+mnOfqC4pL0WhCBi8RrkPY2KpnGVD3LZ8Y0V
        LTz+krSr5Yso25kJmdpjHBmZlGngTzo2mg==
X-Google-Smtp-Source: AGRyM1voLiUtdmFcV+uW8VNvoJYBIZcDuv7NzaRkCOJeqZzvTU28lGAtoCPVNCAbBTnqyfNSH90uNA==
X-Received: by 2002:a05:6638:1654:b0:341:59e0:9958 with SMTP id a20-20020a056638165400b0034159e09958mr6672340jat.224.1658171585178;
        Mon, 18 Jul 2022 12:13:05 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c10-20020a02a60a000000b0033ebf04f624sm5876625jam.152.2022.07.18.12.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:13:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yang.lee@linux.alibaba.com
Cc:     abaci@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20220718015431.40185-1-yang.lee@linux.alibaba.com>
References: <20220718015431.40185-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ublk_drv: remove unneeded semicolon
Message-Id: <165817158455.144161.2812725798881211807.b4-ty@kernel.dk>
Date:   Mon, 18 Jul 2022 13:13:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 09:54:31 +0800, Yang Li wrote:
> Eliminate the following coccicheck warnings:
> ./drivers/block/ublk_drv.c:1467:2-3: Unneeded semicolon
> ./drivers/block/ublk_drv.c:1528:2-3: Unneeded semicolon
> 
> 

Applied, thanks!

[1/1] ublk_drv: remove unneeded semicolon
      commit: 6b1439d203a3c3d7adcf31ba70734eb95f8fa02d

Best regards,
-- 
Jens Axboe


