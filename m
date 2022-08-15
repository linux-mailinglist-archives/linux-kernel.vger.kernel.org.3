Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47995592C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiHOKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiHOKDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:03:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE481055D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:03:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kb8so12731645ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NJX8jO1pYzzhVEPoTBTkL7Gt5+R43W0llgP4O+NknEE=;
        b=4CsAeheZqpI88jrVCMl2Ai+HIPg1QRU2T31EcirAw8ECrKiz+vC+xtLbqswoQ0fOB0
         8noIF8f7rSWmO43r3ua8N1XNq9wi67SqgVtQwjW0t1V0KNfR2uKcuew3vUilbZ5RonY4
         kkIBtBqo/juDP+45QnPwpgeQqMXJwW25ciwd3F6kMhtr9p98qdPdtg9+FDegeaEewrPN
         JAG4DOtpz+fl5YZl3xCUwuw0QAxEs4lq7LqeT2co9rwdHpclvIyKbjLw6KpEAFMmX5V7
         vZr4qyplJqFHV+M6vmeUJ03UBhrqXY67cs4BOFqLx3AqJSBAtlEc3nQKKB73fHOJPhWP
         TYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NJX8jO1pYzzhVEPoTBTkL7Gt5+R43W0llgP4O+NknEE=;
        b=S96P4bzYU5IIrvkP4Px3rYT6xAup4aOj/KPgRG3osKf8ty2cJ9ZkJvkkIWmN4UK2Eo
         Lcmqsi6MaS/Xl0XVRbJ39UezihZWiTCnpkcIflyq5dMbADbzGDo5NCOjiBtjk0XpIxXb
         EBP774JissNKNsoU3SqLaP+6ssAIjcbDR6UOF6iZZ9oD0VCBVd1B72oA45UaK2YznFCR
         suDFTQsrppSjPiQpclIvicMiX3aFKqg2K9QJQMDBdavwkqXKTeFJbh4YfEwiWytZi287
         Shb8RGf7OOS1ol23pcz64cmk8cpyXdr3gaGFgz6YZkxwjUS/x+OWrEhIfQ4+IcjRzk/j
         GfKA==
X-Gm-Message-State: ACgBeo3BzknXxDtPrwn931+OWY6T68je9Qp4PP2ERJDKR28ebN/j39hD
        vJrq4edMWczzLD6lJtSsrZhyKMlDk3lh0B8SCG6+Og==
X-Google-Smtp-Source: AA6agR5hGQYDC8LGpVf58AajIYUmJAZOmVsl7JaDj51K6a6u15Jz5PUBvnJPwL0XuxQ4THkDa5RL10/XBiP2v+NWaSo=
X-Received: by 2002:a17:907:7254:b0:731:61c6:ecf9 with SMTP id
 ds20-20020a170907725400b0073161c6ecf9mr10022260ejc.101.1660557796390; Mon, 15
 Aug 2022 03:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220810124109.34157-1-srinivas.neeli@xilinx.com>
In-Reply-To: <20220810124109.34157-1-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 15 Aug 2022 12:03:05 +0200
Message-ID: <CAMRc=Me_xqOG64yfQHygS=eBbYaqwqGKt6DK1D1DWr+xkM-N3A@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi
 gpio binding to YAML
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        srinivas.neeli@amd.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com, git@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 2:41 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:
>
> Convert Xilinx axi gpio binding documentation to YAML.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---

Applied, thanks!

Bart
