Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211655713FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiGLIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiGLIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:09:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4716467
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:09:04 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t1so9101105lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7hymDGoXZOvT4wo4b8VCjcpQ+XRX3pT8aXtW5HqYY0g=;
        b=OPdG2eSd1GwsQvVoZ0jTUrpcOgCQXXF6v27JsagiYHeJ6mvzzR+Vl2f5DWGBjL0oor
         BzmxvVaVbkSaFHK7xobBT1bo0BsaPnUpw5Qgn0tPbnXqtVtmsvOgknBB1MpPys+RS4Bn
         rfEtTi4GTZNaV/RnyYY+aaIRpyNRrYFu1veoiDQrMvRBmHvqwHy4ilNMbxKtX4JPW9Xk
         A9skPZvL0WP/Ki5yau8/+5P9EUCltbpgLBVm3keFVQxCZ59e121jQM2wCideCjMCucWZ
         spTAHTc6jEIGjfZ1HBwMvzH0MSplaC8m0ZRUeFXmQ7DEecAWRrQRPh7oxT3T1L2dE4mU
         LF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7hymDGoXZOvT4wo4b8VCjcpQ+XRX3pT8aXtW5HqYY0g=;
        b=g9wy0fvKU1DO43ADOeFKH/PSE/u2x9vN6BWynf7my5Pq4BOBWxk6gO92JfvRf043M5
         JK2fxJPr3Yc+jRrWBY9PiPCkSeln4S614/2h+9vQE95X/b5iKJfek0Tfbf7WaMlw7O3y
         JRtCbTwKAQPVFr+uohsfq/SreiXsGTVkZsdwJNtb9GiwRnOyE212QqV6T/iWQ0SArPEE
         lR/zJmh5sMftoHtrniY+6XJiXc7eSK0p7pmazEmvW0CoH7h8iMcyeQEa4eW/5etvskmx
         B35TFQgC9oxWsyPVcCMGrK6MXD0F/soUFdjuaoWfFznG096x1vcaFgwxTdrBrESxYZBC
         wrAQ==
X-Gm-Message-State: AJIora9D+evD8jb5S44i4mQocvjtRYmqSKoRx9WklroVyZ58L1ndCeTV
        qrJAROy78B/PnOcvp40js0KIjA==
X-Google-Smtp-Source: AGRyM1usYq9Y2eMuGje+OHvls6QftNfcJPk9nwgSJbif9bEWrfHigs4mRwSaVpCHRiznM4HZVPSYkg==
X-Received: by 2002:a05:6512:34cd:b0:488:aa53:c104 with SMTP id w13-20020a05651234cd00b00488aa53c104mr15231306lfr.517.1657613343057;
        Tue, 12 Jul 2022 01:09:03 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id a12-20020a19ca0c000000b00488e50527e0sm2026877lfg.112.2022.07.12.01.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:09:02 -0700 (PDT)
Message-ID: <b2934014-8048-6c17-e655-bd1be09794bc@linaro.org>
Date:   Tue, 12 Jul 2022 10:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] dt-bindings: sound: Convert to json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711183010.39123-1-Ryan.Wanner@microchip.com>
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

On 11/07/2022 20:30, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch series converts atmel-classd and atmel-pdmic device tree
> bindings to json-schema.
> 
> v1 -> v2:
> - Fix commit formatting.
> - Fix titles in yaml file
> - Removed trivial descriptions
> - Correct formatting errors 
> 
> Ryan Wanner (2):
>   dt-bindings: sound: atmel,classd: Convert to json-schema
>   dt-binding: sound: atmel,pdmic: Convert to json-schema

Use consistent and proper prefix. I think you got such comment before,
right?


Best regards,
Krzysztof
