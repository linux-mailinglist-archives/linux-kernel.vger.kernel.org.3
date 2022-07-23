Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B690557EFCD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiGWOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiGWOrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:47:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595D194;
        Sat, 23 Jul 2022 07:47:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp17so11881947lfb.3;
        Sat, 23 Jul 2022 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HE7GGuksx6MN+gNz4voCRIijIPTMFt+Q99FuH/9Vyns=;
        b=XcOLoipEtzdWz60RxkIBhM1EJsLSqB3tEf8s+pA+I64qcoAIa2ICCKJdhTzkEMoWr8
         PBCEMVHRfHV57xdzbFKs4xOvjLuAOwDjzGfIXboZ9NijRjxqgSken0cQQSnjqMnG4ilG
         zqLmwpK1aAFqLblq6TAlvbEsTT1cC+tfPEsgp8YN0jhXMXXz8Mxyt46KU9hH5VmTrBCx
         z1EJJz3B8AJCdBkWTu9vZYqViE34sPBxziu4fHVCQrfLUtlDufmGQ61EWeupVlJLWKRc
         xUTOTHoteAF9l+5kIrfsoFsvm+FdNFy8eOf9qRBbHjhch2LJ1EqeiPr/E7y3cY+fxqB6
         X9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HE7GGuksx6MN+gNz4voCRIijIPTMFt+Q99FuH/9Vyns=;
        b=apJgGtYdukHmXwX1sgTVUti6l9VYcqnt/SAP/sDl6miUGPbMyaKvk/xdgrMWH4auDJ
         aX3WHIlI+JUcAy4QCYKB6yXrKdyI/F//v268fVYZGJQaursIL+dTNgsp3u5dzcsx5+qR
         ymliBtRE7dH6veWSArH6RCIMKG2m1IG5dSSmpVNNexrl8A2xPpvcvsRswbptbhQDe7VN
         EJudyUu9vApd3B8vxhf6nhnNl/wFmQuLOUl8rA650GCHb4lB0cmWTz5y3bODEZx5MaQL
         zzETroWpV1GXUWcvRXRvD1V3ceMhf9s6BieaOPRIUs8cOMtEKX3BGdaLj8qvU95lZU9Z
         EyVA==
X-Gm-Message-State: AJIora95bSGkfLoXkLRG7crs7oVZVocVWxXYB6abc6f1hNGDTFnuGhCU
        7eg+TYR3ePTxsP8iyjX84MA=
X-Google-Smtp-Source: AGRyM1tce8Isk5AvQUNCun70fbSPdfnl7tkEm/3+aE4U6gYegDlJnINf0OQKeF50/kjrqO/fUlEKdQ==
X-Received: by 2002:a05:6512:1307:b0:47f:baa4:52c5 with SMTP id x7-20020a056512130700b0047fbaa452c5mr1724043lfu.103.1658587627614;
        Sat, 23 Jul 2022 07:47:07 -0700 (PDT)
Received: from [192.168.1.6] ([212.106.161.60])
        by smtp.gmail.com with ESMTPSA id c11-20020ac25f6b000000b0048a7ad94982sm775468lfc.84.2022.07.23.07.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 07:47:07 -0700 (PDT)
Message-ID: <e700eecf-e7e0-c2e7-9e20-b5d20df4b65f@gmail.com>
Date:   Sat, 23 Jul 2022 16:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Add SFC support for Ingenic SoCs.
Content-Language: en-US
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
In-Reply-To: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 22.07.2022 o 18:48, 周琰杰 (Zhou Yanjie) pisze:
> 1.Use the spi-mem poll status APIs in SPI-NOR to reduce CPU load.
> 2.Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC from Ingenic.
> 
> Liu Jinghui and Aidan MacDonald provided a lot of assistance during the development of this driver.
> 
> 周琰杰 (Zhou Yanjie) (3):
>   mtd: spi-nor: Use the spi-mem poll status APIs.
>   dt-bindings: SPI: Add Ingenic SFC bindings.
>   SPI: Ingenic: Add SFC support for Ingenic SoCs.
> 
>  .../devicetree/bindings/spi/ingenic,sfc.yaml       |  64 ++
>  drivers/mtd/spi-nor/core.c                         |  42 +-
>  drivers/spi/Kconfig                                |   9 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-ingenic-sfc.c                      | 662 +++++++++++++++++++++
>  5 files changed, 768 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>  create mode 100755 drivers/spi/spi-ingenic-sfc.c
> 

Even tough it's still early in revision process, I'll add my
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>

The test was performed with Damai DM6291A SoC which is a Ingenic X1000 IP
but with 256 MiB RAM. No bugs yet observed on my side.

-- 
TMN
