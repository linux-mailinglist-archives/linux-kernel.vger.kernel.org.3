Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3B598223
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbiHRLRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHRLRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:17:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E2AE23A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:17:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j8so2598586ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=E1NipNzUWLZ2palbEix1QtbCTNgOpAKdVPPFyst0N7o=;
        b=YCwY2+ZOwZePVXHIed870W0AMBgz2YE11uL8soFdD2/JiKrKB7+vx5++xVceVEdfv4
         f+3HWdO1z9ehFa6qO4t68/0/LzqpthaY/C6NCXUI1zp4UheqE64y4qTyK2KQzD2tnFiO
         jIAkKAGKTeTAnV0OdfZwZoG5dGzccmnChgDjGByCmSXCxjOJFDalhFBdk4jGtDTd4TKT
         VOiT1pJizr8p3mr9rGhr8Cc9eWbUZVB+oclTSvJGwHNQ+rXa16IgiG7190sjPR99Xski
         vSwf/zjuFbcqVkEyDGyc7mHpL89dRdJkK4PhO4CY3g0nCTgARc+BXL5F18pAu+RVAyMu
         1+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=E1NipNzUWLZ2palbEix1QtbCTNgOpAKdVPPFyst0N7o=;
        b=1GMJHVlURc+B8IgMhlUDFowpuQyn7C+klyOwQOYvSYiNVExoCVun99pA9UxKr+FJ4G
         uaEAXnESQRnDoR8qdFzHWiv/QrhoRT53AUrV/j6/r4w0CBw2nTOsgC1LcofJNoBO5t8r
         /JEMsuasp5INibiWv5/sxFsXnFHeC4Bl5Ex1XvG/YtK3ZqluuZ2w6+JWVIzbAw+3sAu1
         MKQMtGBvBQVp6VHWa/0qZ6hi/teogyK59iwqlF3a0mwsqwLKpoK8XhtOwty2fhfnOObn
         fyKV5YGLutFCwrAKYL5vd7uAT441+4afzVlreOVsbS9Jnc3qhOIHnkTnwDlaSu3vBfXv
         wbjQ==
X-Gm-Message-State: ACgBeo3ECDc0Jbkcchxf7EDOt47GgnUp7FLh3BAzft3K2jbFdh4kMSt5
        +BuZA44LSneNGr6V6TD9IrZBwu0EtqF3msYK9MmLag==
X-Google-Smtp-Source: AA6agR5b8bP+fivEf8sWhn4cjq7X6RpjZuI0sL1iRR2iThKSe11tnOp6MF2tDz+lsllpLbtZOzvSG3NbTnoaTALTQtY=
X-Received: by 2002:a17:907:6d98:b0:731:2bb3:8e17 with SMTP id
 sb24-20020a1709076d9800b007312bb38e17mr1597869ejc.203.1660821465138; Thu, 18
 Aug 2022 04:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <202208180333.1pfLpmaj-lkp@intel.com>
In-Reply-To: <202208180333.1pfLpmaj-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 18 Aug 2022 13:17:34 +0200
Message-ID: <CACRpkdYkRL0Yavgrg378Kte3mpeCTXoPu-Wnr0T7deNDyt2zoA@mail.gmail.com>
Subject: Re: [broonie-regmap:for-next 4/4] include/asm-generic/io.h:187:18:
 error: redefinition of 'readb'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 9:53 PM kernel test robot <lkp@intel.com> wrote:

>    In file included from arch/hexagon/include/asm/io.h:311:
> >> include/asm-generic/io.h:187:18: error: redefinition of 'readb'
>    static inline u8 readb(const volatile void __iomem *addr)
>                     ^

Aha. I'll hunt down a hexagon cross compiler and provide a fix on top
of the regmap tree for-next.

Yours,
Linus Walleij
