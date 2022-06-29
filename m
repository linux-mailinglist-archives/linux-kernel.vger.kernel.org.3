Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D855FD48
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiF2KbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiF2Ka7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:30:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465C3DDD8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:30:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fi2so31610222ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AKUBDZoE/jvXM2oq8qe7PZHH+/UTyEsmP4FXnOhfAlU=;
        b=ZRXo/mzIwR4NbglFfMzMKqwfK/xTZxfEsZO10kcCW22biN5F930DKToHUO+2ckttkj
         9EMLOKq/8ELduHQr+tDpCKoLJgh3w6vXB85mhD3/CX4vCxMCI4qTXw4eNHg9kHrpfX0x
         NXWCDcGBrhkQ5ZzTLUruHvztzjzHQqGN9fldjzF+r3ZdZbnoiWBNxqaJ3eL7UjlqQEWr
         /XWWd2W2xv4T7JVs0wzrXT9XMK+adcZ0HC/aGqVt7AtRqZpBMT0GH4QtcdHw5FIk6y/k
         q0dz6pSLFCTBlyxSQ+uua7/Fl4zonstATCEhOpcAmX6f8/sFBNuwZFUiwwXLghAkk2md
         X22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AKUBDZoE/jvXM2oq8qe7PZHH+/UTyEsmP4FXnOhfAlU=;
        b=z8qHC2ORLPXorEO8NP5qZ76votfNdsRcufTSQ47yVCExZgrOcko+4X+58CARpqtRhv
         eLff29WU5+pgMALaxGyn1Va3jvT345CjeKVZcvAibhArRI86fy3Q4BPO4NJFvk7BvAQv
         Y4ZV2SLDyW1TyO35Bh4RK1oFH9NT3gcyGq8pNWhRv7thFzS6JcG9A9fO2tuUxmkeKfUL
         lEonYl2//PV0G/2wU9IAVu0MBjJqK25CVDY/498pYrGPqC4mShFueb7zT7pcPeX9XOwg
         asLc0yVn1Eg5k9hlSuVWxET7bJXbZ5PVTho2VXlvwAuGQWIno6rYqz/SeCiKUjbsaYD9
         zgFw==
X-Gm-Message-State: AJIora95glaXlCu/uObSxFSdJYY29iuLSjQZjoWcQLIUPx0Bv0YdE03E
        I6jG4GarwFCWu4xia5XqasaMQA==
X-Google-Smtp-Source: AGRyM1vR9Bfc4Cn78gAiU5c5r+g5latY1NcXNJRE71q/O+RjUbLzca9egV2jhf6YZ4IqQ90HkFrG1Q==
X-Received: by 2002:a17:907:1b06:b0:6fe:b48d:801f with SMTP id mp6-20020a1709071b0600b006feb48d801fmr2572523ejc.322.1656498656240;
        Wed, 29 Jun 2022 03:30:56 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090613c500b00722fb3c99bcsm7550249ejc.203.2022.06.29.03.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:30:55 -0700 (PDT)
Message-ID: <de5a9756-50d6-2a09-d357-6e419b57dd5e@linaro.org>
Date:   Wed, 29 Jun 2022 12:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] ASoC: dt-bindings: fsl,micfil: Convert format to
 json-schema
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
References: <1656386005-29376-1-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1656386005-29376-1-git-send-email-shengjiu.wang@nxp.com>
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

On 28/06/2022 05:13, Shengjiu Wang wrote:
> Convert the NXP MICFIL binding to DT schema format using json-schema.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
