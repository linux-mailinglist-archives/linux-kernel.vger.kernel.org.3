Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DCF58A02E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiHDSGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbiHDSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:05:55 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC9BF66;
        Thu,  4 Aug 2022 11:05:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a15so374401qto.10;
        Thu, 04 Aug 2022 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ueZWNCVbjk07SHSEjZ5pMZCyMRunEn5a84H2Prm1c7s=;
        b=ZhzGJ/YPL1nWALnFj7utS28xVrTIMis8RxQmn4PoomFommjaFBkRvndKATuUHuktAe
         Pv3BPgRogMuYO9pOAiszoJiC+I2y7+KhCrvQTAcoOqc5168b1z08SjEKeNKiuneMVCM5
         sA9aVKGTTdX7KhgSDKx0/Plapa+dANimJoYTSrhM7Gaa9M0W2VFKgDu1o8xOhrUk7tSv
         adYAoJ8zcZD+WvpFqFP1Hfc7f6fWG6GeHiCGjVy3qIe+0J9f86u+lPsa0QDb6TpKlxHl
         jCPHahdXtVEU4RuMd6UVbJeDkeQE8vTkT/5PbM1zC4arDh41IuwIIaD+8RWNxatQSNVa
         /7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ueZWNCVbjk07SHSEjZ5pMZCyMRunEn5a84H2Prm1c7s=;
        b=THXOKANSdE+iHVxpp7SDeW2pJKTFQ77VGcpUjYzIAFFtaqUkiaVoOLDfA0ermEt2Zs
         eZzwQq6Z5L3YU6WbsLOXoajdw+SY48X22085OxOjdJpkLMl6Phzkdf0/HIlLnkX1+K0d
         NdUioxYZTvq27C0UQc/HT9vu7hGmNLKhY9JZBRQgdeDE8K7wlcX/OCZP/j/KgPspGNtz
         iVe45Arco960FYxsCoIKsXY8qX8aBJwosBgFzxWYtXfpo8Q5FfscbcPIS6A0enwBXc8Z
         jO3TWpulPSj5VEsDO7xTFkC++F7J+6q1YPUo2v098iy3GbKC7gCvpAGkxQMd2bdNBuFg
         WQvQ==
X-Gm-Message-State: ACgBeo3I8UQlrFoJzFqh2UvwL8Jnxq6Pc68U8ZGje21S+yXlX81/dz7F
        4r823DkLVb0rBSDWFNe9A9E=
X-Google-Smtp-Source: AA6agR68eo/nNfsPH9Glbr4xHb9nMHYY7b3F4Rs/VqehRSEHk7DiIw8lNb/EhOnamW6/opfzW0nLmQ==
X-Received: by 2002:a05:622a:164a:b0:31e:d373:b1e5 with SMTP id y10-20020a05622a164a00b0031ed373b1e5mr2641983qtj.689.1659636353894;
        Thu, 04 Aug 2022 11:05:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y20-20020a05620a44d400b006a6ebde4799sm1185861qkp.90.2022.08.04.11.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:05:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: dts: bcmbca: bcm63178: fix interrupt controller node
Date:   Thu,  4 Aug 2022 11:05:50 -0700
Message-Id: <20220804180550.1339046-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194448.29363-3-william.zhang@broadcom.com>
References: <20220801194448.29363-1-william.zhang@broadcom.com> <20220801194448.29363-3-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 12:44:47 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add the missing gic registers and interrupts property to the gic node.
> 
> Fixes: fc85b7e64acb ("ARM: dts: add dts files for bcmbca soc 63178")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
