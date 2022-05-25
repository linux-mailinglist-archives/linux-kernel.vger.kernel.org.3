Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5115337FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbiEYIHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiEYIHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:07:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B405381489
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:07:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h11so24858037eda.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=K0TSn2fqvwK9SDiwJiRffb/eDZSZxCAGCJGbT9SkTtc=;
        b=CPH4puU00SpN4r0xq5dXYT/9N8r3QYL8RRabLLQKg1tmtWnmC9EoFiVIGQNrxhfVeY
         V3g/XsGz9jrl5z3TuSIDKAynEJ6x3W1KqDPAcg4noVeOLzZWCWYeWxh6Q8WBh1TlEyE1
         vR7XRtPoKqCSc+EDNGF0rCZQtO4bIq/vafTTflUwzDL89V8JGPdS+nBVBSlJOEF1bTMf
         JZEceNXOlF/Eyjq+gDZvCD5Yw+tdloey87nLY6T9HdFnlfxQNWjekE2D1HdS0AXGqbLv
         yX/nCKyOoiGm/xMIopFljwGVDU6F7aJGmwOlsJX+QF03hJOqINjrLILBSqkl83bgvbqd
         M4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=K0TSn2fqvwK9SDiwJiRffb/eDZSZxCAGCJGbT9SkTtc=;
        b=ZZ6nSCWSJiKV7KpkivNKRgzrGaxeHCS/iHsgFRPpgreGSP8KIPCnmiuOB5T6L3xFvp
         oMnLobOUS0YG5z789oU4bERRurN+81Cx0I/KBjLkA2tG0Zg84IEz4qO7p9pgxc/TfyvN
         0F+zdajrURtHyKTKGAyYnEhXU0BkWqKtUx9wpOYK/05Yt/Cmt6Yk852kuNQqNvZk+aTH
         PJpa085osDYbenQzGFAl4E3zqnuRM/iS8QgfQXU3YVUA9bwVesx/6F5vEW/mI61/F3Mm
         3mXchhS25IclX/T7mqMbqKAXbUN7+jRhGTKV29rSjNmMVFXkKxPNxDMOR+XeR6Ycio85
         wc4A==
X-Gm-Message-State: AOAM531ferFLZtJHEOyO7rBR74HiHnxPU1O16CsnEyNanXnfMgw8jZU0
        31txex0qY5Nn90lloDfl6Efu4g==
X-Google-Smtp-Source: ABdhPJxu0J/w/m+jAc1o4NHhbkNTu7E6Qn+2GZlYcRX8vJJeJnGbs2EzXlc/+SXbjKrJIwqyRkBRtw==
X-Received: by 2002:a05:6402:3047:b0:42a:fbe9:4509 with SMTP id bs7-20020a056402304700b0042afbe94509mr32502177edb.159.1653466025277;
        Wed, 25 May 2022 01:07:05 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ot22-20020a170906ccd600b006f4cb79d9a8sm2783035ejb.75.2022.05.25.01.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:07:04 -0700 (PDT)
Message-ID: <b36280be-9993-9a78-0960-4094efeed1aa@linaro.org>
Date:   Wed, 25 May 2022 10:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Getting rid of infradead.org - corrupted subjects
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The address list is semi-random as I don't know whom to approach.

Problem: infradead.org corrupts email subjects by changing:
s/,/, /

Examples:
1. Previous discussion with Uwe about linux-arm-kernel:
https://lore.kernel.org/all/20220215125856.es2euyoqo6mp4y2t@pengutronix.de/

2. My last email for MTD
Modified email:
https://lore.kernel.org/linux-mtd/20220408063720.12826-1-krzysztof.kozlowski@linaro.org/
Proper email:
https://lore.kernel.org/all/3e550deb-7c27-894b-a0b5-62609a60f17f@microchip.com/

When people use Patchwork or b4, the email from the list is being used,
thus the one with a changed subject. Example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9547c4e74f6b4b56c2f9e4e7a286ce126fd333fa
The subject should be "dt-bindings: mtd: jedec,spi-nor: remove unneeded
properties" (no space after coma)

This leads to real commits with a bit odd subject. At least not the
original subject.

Can we do something about infradead? Get rid of it and move the mailing
lists to vger.kernel.org? Or fix it?

Best regards,
Krzysztof
