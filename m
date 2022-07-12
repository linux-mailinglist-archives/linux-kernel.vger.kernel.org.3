Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39B571351
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiGLHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiGLHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:43:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D8AD137
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:43:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t1so9006291lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fykMBHjyV7LPXsdsR/MQifRdgrsDh/BFR1VZ9OfGQ4o=;
        b=vc5mabH2GM3TX3F2Q0YU5t4wiikLaQ82BU5bfXStOZdQ2iNqfUc6XKszUswvqrBT40
         O7L15l0WN7szG25GL6Ex0bwlGX4IbsJMwHQfm93B8QQue5hl+vkEso0BLxhXHd2PwGaU
         8AaJCLvpdJQNaHzDKn56B6RKzZ2qS8/kL6hf5MARqR6E7h3FnfZglJjlcpjBzSF5rgu+
         dKdUpFp/MPAe3ODMykJ05iAcL27ZlbGHaQRLPnzDl6kbL86VTK0+kIRdgmohwCRorsxr
         fku7paqLlq2pZaKUgV41WjTkDG5QYnloWZjrEEUaCVJtBhLQ8sg7I7QT47ybWfN9VtlD
         4iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fykMBHjyV7LPXsdsR/MQifRdgrsDh/BFR1VZ9OfGQ4o=;
        b=fs1C0yLN/n+OzniAzgVT7ghqLW2IXYhfWqD0VNi84U5NmGzPvxWbe6bML3bGUJgad8
         aIocPOzVTz5ILQ4dR+/NDf7RO2WH+p0E0FKhzhFPI8+KqR+vVIk7bhYrGqgSNItc1qMm
         18PY1xknuHfCxs/sDz6UhnVYrIacPxJIQYUE3r8yFRAwaNeHk4HIFG9HOTUYjveOkvfJ
         4hX9m7R2BkcUSN/6DxSLkknYETisUEVAtyONLIMlagagTzmJz/ZpjaPJsKShw+hWIuyc
         6HP2ns8TATig372/najYXGLR1/Kbz6hcmkzZxgUVFJ8/dxYg8RGcLWNkNHf5SEc3Ur9w
         GdeQ==
X-Gm-Message-State: AJIora8LL9v93/Qili61EQqEpvc2cBMZl5gfx45m0bXOOFtJk4XFXp/D
        SCssp3mAkzXG3m5aNN31A6KI2g==
X-Google-Smtp-Source: AGRyM1tUTdl562QjFjmmC2O2M710ZXbgXFnEfKy7677dxZbiK3u5QWolbRfwZBRgRcA2E/thrQ5Ilw==
X-Received: by 2002:a05:6512:39cc:b0:481:1b6b:4a7c with SMTP id k12-20020a05651239cc00b004811b6b4a7cmr15235404lfu.597.1657611828014;
        Tue, 12 Jul 2022 00:43:48 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id e13-20020ac25cad000000b0047fac0f34absm2027558lfq.196.2022.07.12.00.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:43:47 -0700 (PDT)
Message-ID: <2f593af5-442e-67cc-9b7c-303d4c24e389@linaro.org>
Date:   Tue, 12 Jul 2022 09:43:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time
 Clock
Content-Language: en-US
To:     Mia Lin <mimi05633@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ctcchien@nuvoton.com,
        medadyoung@gmail.com, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        KFTING@nuvoton.com, JJLIU0@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220712030509.23904-1-mimi05633@gmail.com>
 <20220712030509.23904-2-mimi05633@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712030509.23904-2-mimi05633@gmail.com>
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

On 12/07/2022 05:05, Mia Lin wrote:
> Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.
> 
> Signed-off-by: Mia Lin <mimi05633@gmail.com>

Where is the review tag?

Best regards,
Krzysztof
