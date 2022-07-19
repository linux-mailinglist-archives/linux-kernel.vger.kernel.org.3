Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F557981C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiGSLEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiGSLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:03:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2582A248
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:03:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t1so24094144lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F+YPwJ3OalhF2uEWkjDZQjPsGGtm1z0ZYbOsdNSmeBk=;
        b=F5hG1ciIO8BTpnanp2tu67fMURJ1JoFRQAsbWNKS+Qy3/N5k6mavM+zpyEWnGsIdWo
         RuWXixPtQoYxXTpoEJEe4UmuQsWuNyrbXP3aDttJRQ1sVDbH3Wz/oxyWpwpMCmb/r4PZ
         nd3hgz4cjIwihxH3xKIxaZ8hN2H0Be8q6COFpq8YhvYFXfSx7X+d5xBilNwzVM0bOyAL
         CxyPr+gXDfqFvXtkwLPNFm2YVc14Z3kTlgbq7/iPHhyaGoGYZAGEreuNGxOzPLvttrrT
         vLL/krA71tiQdyfBRhDgwlSWNAj42JQDyJtqEOPpM+nIdA7QU8DMmGC8MWhzrlzlyFue
         YXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F+YPwJ3OalhF2uEWkjDZQjPsGGtm1z0ZYbOsdNSmeBk=;
        b=GxZM8nkAJVLwr4RaWEZLgnx1YU5dZCVCiSNDbDe788BPbUyg+uS734BjY+g21FiYb/
         2pV8sjbqdXB1GAYNWiqYBlf80LzxXXzgmB8KMSwJqokBamv5l9K2UytA8FAjZMkDOka/
         KrXvDuVg44+IWCuHI8R2GirzrIwTc3jihBsfYenF9rmRPHQe3GwgfIcFXHiFSP+/lFCb
         YPoT5Ll5OoVqJlY0Et088OjhnZdC6rK3JpeaXz1Bfwa+obE/7N16/EwTB6ljcif7j3GY
         cdK8gIyVoaKAq0en+ALVGB804LvMqH2mNwpIYlCA0JSSDSNohgAwNxqitGgEfTaDXPkO
         pTYA==
X-Gm-Message-State: AJIora9vW7vj+32MMw8XYqoGHCgBKfgYTIhnKuNyzkgVRkQJmEhYB2SC
        8RSgb3rkeJEcx6iIYkTYK6+l2g==
X-Google-Smtp-Source: AGRyM1ttFWfCdMSUUs3sHQIw2bbRarjjsjCbfQfhB4v3yEDUBVXvq/IImwKAuowuawz9yl8kOULpcg==
X-Received: by 2002:a05:6512:3b9f:b0:489:e009:ae0c with SMTP id g31-20020a0565123b9f00b00489e009ae0cmr18648844lfv.213.1658228637111;
        Tue, 19 Jul 2022 04:03:57 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b0047862287498sm3153889lfq.208.2022.07.19.04.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 04:03:56 -0700 (PDT)
Message-ID: <ba62b5a9-cf95-8ad2-3bd1-e2f2de5ab6d1@linaro.org>
Date:   Tue, 19 Jul 2022 13:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: atmel-classd: Convert to
 json-schema
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220715162922.660859-1-Ryan.Wanner@microchip.com>
 <20220715162922.660859-2-Ryan.Wanner@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220715162922.660859-2-Ryan.Wanner@microchip.com>
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

On 15/07/2022 18:29, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert atmel CLASSD devicetree binding to json-schema.
> Change file name to match json-scheme naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
