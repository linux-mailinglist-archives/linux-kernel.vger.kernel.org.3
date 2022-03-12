Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2C84D6F44
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiCLNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCLNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:47:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C24F476;
        Sat, 12 Mar 2022 05:46:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id e6so13068594lfc.1;
        Sat, 12 Mar 2022 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YhT9hr883XEA4HVpbnlXz1RtCYAWAHmAITaWaM00IqQ=;
        b=BUEZbTI4dUbp/fqGnLyBe/d8iC9iH2iOo3vURg8uqKUqZIye7/BiROG9+KqA/sBt/S
         rGl2b5saJMnYHhAjICvm+TdNwkeqxVUly9yfZBdWMqZqVqqG+majtIEtGZYvliK7RISP
         GGoRHPw/Qka96+3ilrUtCgACvVCnWl3nZ7tO4WIw0wLmL5RvHDYsKb9fu+O2zDo7R1jH
         axSM/BSKStLoO9XPmftjkWM3evpfH9ls9m1WQnLECm+EvNku6KLgak9U1PBXNO/pBPvC
         NL2Iw3bw6pYb68J8VtTq/d6Psja7ZoaMzeShpqgX35XZiY+9EaxmoIY57f2fKKF/HUeU
         0COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YhT9hr883XEA4HVpbnlXz1RtCYAWAHmAITaWaM00IqQ=;
        b=PxBFWSOpGStTVE21V1G8f55aEdktA9Bx5QCBNz3NMIoajJFMOGMWSmKt8WzDP+MI+2
         F7Ro1cjuT1fd4vpDLeABEMtGqpAEcYBMALw/ibp5jwSot28TyM2BXi2Bg62J5tPoUA2V
         nAJ2fTZpdynex/+eYWQpb2jpTUtYHGXBwIxgt7gkfViSZdNyPe1P/gwbYcKgoogYL4vT
         KnDoaLQo/slmfpEdUvliufqryx9YxZVRGA2QMYS+iBTMuyzcFLDXCATWbZWIVUqCX2YQ
         aP675GzTzuUqiw9ARZ17exgLKxJFFdQyszHdK1r8q+pvIYL1os+02umlnzpiWXSyFF0F
         HL+Q==
X-Gm-Message-State: AOAM531km/D1p/4iaEuDz0DPPAeNZjVVgna+6PivlDfm1qCfcQw+6oP3
        siKr4Mj6dShnMdv9tOhiJ+s=
X-Google-Smtp-Source: ABdhPJy9p1jDB866V18WNktXttY5ah85fSiIpQ/ZJfPWDanT6KTGfuJygSUXZHUaQOYIP8FPen4Q/A==
X-Received: by 2002:ac2:5598:0:b0:448:1c0f:b7db with SMTP id v24-20020ac25598000000b004481c0fb7dbmr8490016lfg.585.1647092807922;
        Sat, 12 Mar 2022 05:46:47 -0800 (PST)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id z10-20020a19504a000000b004483c8359f9sm2189035lfj.131.2022.03.12.05.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 05:46:47 -0800 (PST)
Message-ID: <4968263c-b4c5-0e54-22f1-81cc43d93b83@gmail.com>
Date:   Sat, 12 Mar 2022 16:46:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 30/38] media: platform: vde: move config to its own
 file
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <cover.1647006877.git.mchehab@kernel.org>
 <ffd86389feee80c36309aab89c30990e4fd80f4b.1647006877.git.mchehab@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <ffd86389feee80c36309aab89c30990e4fd80f4b.1647006877.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.03.2022 17:07, Mauro Carvalho Chehab пишет:
> In order to better organize the platform/Kconfig, place
> vde-specific config stuff on a separate Kconfig file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/
> 
>  drivers/media/platform/Kconfig           | 19 +------------------
>  drivers/media/platform/tegra/vde/Kconfig | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/media/platform/tegra/vde/Kconfig

Acked-by: Dmitry Osipenko <digetx@gmail.com>
