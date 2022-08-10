Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112AB58F0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiHJQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiHJQtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:49:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E027D27140
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:49:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so22071949lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9OvaNNBpYBwgLNPnv7oZmElWAX/FthLtpvHqRRqBtkU=;
        b=CFqmbTlVjqivEoe67/oqyI+2x+udBtDwihaeRDF2Cppaa1zBJPtTVpGj370B8XwYWH
         fJiclMc72Ced+0tnOKQtmt4lisZ4xOasPgXe8LPaMcVi39LywC1vJ0VWKc0Ie+W+FDlZ
         0z6zbvmKajLZB+nCfxrXiMGIHv1axn3xqNK+VGPaARJ7o3C4JjPxkQNqJyyfqNPx0mfJ
         i1218/dzKTT+HTeoPFpSvv/9taQv2HgZeQ8Ao3aZT8vpxgaQtpb2cxfyf1wgJjGAG/IN
         Q0WMlJMfZ+n3vu0MeWtajmQQJRMMzVHIkQiczjriI0ijoJ4ZTkG5ROhbdmx5nvUfwNcI
         7Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9OvaNNBpYBwgLNPnv7oZmElWAX/FthLtpvHqRRqBtkU=;
        b=d7jFgU0bM+Mm6w2qN5BwPHXoHUWr8q1y+6s7WkZkE7ySGcbNQz/ObxNJwP9L2IQ3Kr
         cvRZ7z9SCbxtb5yjI828wIrsTeyk5xxjMSKGTLRtps7eHQ0/w8qrUjZ14I2wJd/tnp8A
         0z+Gj2ZcdY0NvSA3RCLktjTdeOY0gN1TuCVE81k+F1XuLeBHlWbfYX27Gor63lxxnFQv
         FY1rJzhF4b1DRM758hiYQFywxKbuqygtqn08ZUZGTuJlD8dxaV3bjvP9SzqKjiJwofhy
         GGwpdaUaZ5mZGmAxP4aoQDE0yUwS7eSxHxH1QasrfLrMCMJ5ENbazfvgYLu9BRTRz6NJ
         1Y/Q==
X-Gm-Message-State: ACgBeo3RgCgBIXhf3/g8v369noln5i6/8oroy/hgllNgKQvU1lZrcfal
        uC0Qf/5N0FYAPwUhCLEBifRzeA==
X-Google-Smtp-Source: AA6agR4qPivxoDIsQnpqC+kG7cTrUaCsJ130eoJUjZyWkGIVYS+6ixZZ4ohyh/pZ4zaN2svHMlgsJA==
X-Received: by 2002:a05:6512:c0c:b0:48d:1e9d:aa14 with SMTP id z12-20020a0565120c0c00b0048d1e9daa14mr1780455lfu.322.1660150154276;
        Wed, 10 Aug 2022 09:49:14 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id l14-20020a19494e000000b0047f647414efsm395286lfj.190.2022.08.10.09.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 09:49:13 -0700 (PDT)
Message-ID: <5a6545cc-97a2-7aa8-7b67-6488154e9db3@linaro.org>
Date:   Wed, 10 Aug 2022 19:49:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/4] dt-bindings: mediatek: watchdog: Fix compatible
 fallbacks and example
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220721014845.19044-1-allen-kh.cheng@mediatek.com>
 <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721014845.19044-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 04:48, Allen-KH Cheng wrote:
> The watchdog timer of mt8186. mt8195 and mt7986 have their DT data.
> We should not use 'mediatek,mt6589-wdt' as fallback.
> 
> For mediatek,wdt example of mt8183, We remove mediatek,mt6589-wdt fallback.
> 
> Fixes:a45b408a020b("dt-bindings: watchdog: Add compatible for MediaTek MT8186")
> Fixes:b326f2c85f3d("dt-bindings: watchdog: Add compatible for Mediatek MT8195")
> Fixes:41e73feb1024("dt-bindings: watchdog: Add compatible for Mediatek MT7986")
> Fixes:f43f97a0fc0e("dt-bindings: mediatek: mt8183: Add #reset-cells")

Missing spaces around SHA.

Best regards,
Krzysztof
