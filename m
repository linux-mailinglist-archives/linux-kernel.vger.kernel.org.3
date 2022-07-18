Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B857840E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiGRNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiGRNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:44:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7E6374
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:44:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w2so13635836ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QGPckwIqmYC0GGeLNsoZO9ZfM0x0N4ESwTfdOVnfbdo=;
        b=f3ntLRVwskz3ZYyc2FJn8KOqs8b6ND5mDfh/7JZFWOq5l7KWLXKWX9A9rKeTa5Ij4k
         7JGNN4tCQOemtel+6gbrSKA5gp4HIM2qxMMw+tS0YV/5naByFOtIryM0FC9tuNFVTvbr
         Jrdds9O/F2AzeJevAMT6zuZXRuHiK+SpaTUkfIndiTuqomSVPxeatvzTOEZ6jO/E85kH
         TBDEEb5ZqoeeM8vt0G2FyfX2kYWk6aetO28bczKUfx/RZ61pMkGe8W0OA4X7xbilIUhA
         xNuI8calWwk6BChdv3oBhEsOCtCz5qqbICQC/cNoPm+zTJT1HvDsiK8N1OEWdA+5O5YT
         mUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QGPckwIqmYC0GGeLNsoZO9ZfM0x0N4ESwTfdOVnfbdo=;
        b=UZyzY4e1CNzLvlkcMcLxR5FVyKY+5t1Nv8hIBkbjHulO8NdrWzOdeiHt1D7M7HBAfx
         DUdQbi0OS4ReVLek5F3wV/txH0Mc7nKRGPiS7soOIN1YMd3EGtnQsITr6DO7EXWRCSaX
         wVg/D1NDbK3BciiWVJo5R0c8xC2jmg+QLBuJUnpL8sLaDxuUSb0A1wDbRdk/yEdFiD2R
         /642lR5LZU7Nay5Z574cTRySGXreZ+hx1ZbQXVTpr3LTOR2ATWdGouZEiu1+HDWFJJ0y
         JGYQ8qW3zIwUcwy+E7GMKGAC4juY98rzeNArilPg7sOgng8VrZB+jT7QV86eaGXEMCS7
         FftQ==
X-Gm-Message-State: AJIora/p2QLqqiY+gV4Bi1tiGLtaE9vWLTNn/+VFkihZ+AFfyfGz8nLP
        b683Eyv+JroxPrYfd3y3VRsNYQ==
X-Google-Smtp-Source: AGRyM1tzhjki38V3oaMBPTSxXFp3nFxykyZ41PEs8Iaz+PAeQSFVS2lALcibNLEz/hiYCRucx9zy4w==
X-Received: by 2002:a05:651c:1986:b0:25d:a125:eee2 with SMTP id bx6-20020a05651c198600b0025da125eee2mr8375312ljb.488.1658151841639;
        Mon, 18 Jul 2022 06:44:01 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id e13-20020ac25cad000000b00489cc0dd59esm2606599lfq.90.2022.07.18.06.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:44:01 -0700 (PDT)
Message-ID: <27939c76-161d-1bd4-0a2e-ec21681e0548@linaro.org>
Date:   Mon, 18 Jul 2022 15:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] dt-bindings: ipmi: Add npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
        minyard@acm.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220717121124.154734-1-tmaimon77@gmail.com>
 <20220717121124.154734-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220717121124.154734-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2022 14:11, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 KCS and modify NPCM KCS
> description to support all NPCM BMC SoC.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
