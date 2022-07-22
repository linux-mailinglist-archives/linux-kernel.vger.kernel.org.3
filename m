Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A373857E687
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiGVS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbiGVS3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:29:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC3A9E28C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:29:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so1395859lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a+V6t6liAQ5emBUANrnh80Z6VbYR0k4klruhMYsrA7I=;
        b=JiiZH2iqIatkRp2eK11dZ0LLREG5T2jv3GgYvrd1INug58PhSjfIAaorRyTtnjC0CJ
         8uwUUyJRIGPBLVci7wRHpkncBMpSR/l6+j0Dym6EO1fld6Up1DwYV6oAxwBTFHgBO3Gm
         /sKUZTrVF6snylId2ha0VFjjgCDmdoebpyLaEJHgokYNdi8rhemRb1+XxTTFi3mEk/Di
         vrp5suHGp02+lQoteXjGtoWKa/SiDBFmDFha8MxbfdcqEoxAxkUKecvyW4RIxPfMS9xW
         pzQ0VxX3GXYAsu6b76b1hsyS3a9SCMYVNZE47plYp7CRFDXT//9/HTFN2IZux4i1PouL
         VFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a+V6t6liAQ5emBUANrnh80Z6VbYR0k4klruhMYsrA7I=;
        b=Riw9+3e5tKlHCqI8T+45HySHrMRoZQnHjhV0bnQFCE/V3OpWHlLQLEbWYQdsSo0Nao
         RXfZhggcK3AvxB/8986ExUBsdio0AiCak9Dmx/lnO0ccSI9dWnUBoydXAjA4ApVH8Dz4
         9Ry73onU+69fDOmZlM3hfWYgZeO3bYyw0Sr59CrgLqT20ZkIWug4GCkVlvu7UaoaW+Nb
         MfxZRf+Kk4jlEbAl3Caaec/o1MoexUZ3DLRqK2Oy0QQX17Q4uXG3qOef2oRfcODwM2xI
         anu904jlavWi/jHR5G6C2pnEDtDrISupqa3Ti6LLmf320YfWza2LT3YH5pU0tbyLyMbx
         OEKA==
X-Gm-Message-State: AJIora8kOHPd72ClWdwjn7sbxOOOdCkQOY+GLPglSX/k5gQPuIO9n/VY
        +a2fKkCJgOBrMWErktZW1d105L6VimP1r3hU
X-Google-Smtp-Source: AGRyM1voO1vgZpH1qYd6sqkYqE0Eb8kTQ9qlepsLVPvsi1CD+x72nBMp5xxzPbE63atzPddojn3Xlg==
X-Received: by 2002:a05:6512:3a8b:b0:48a:7b80:1d9c with SMTP id q11-20020a0565123a8b00b0048a7b801d9cmr455028lfu.655.1658514573178;
        Fri, 22 Jul 2022 11:29:33 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id u4-20020a2e9b04000000b0025de8d95352sm1056688lji.1.2022.07.22.11.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:29:32 -0700 (PDT)
Message-ID: <b100b4d4-5ee2-2b76-285f-a9d4f4bb9306@linaro.org>
Date:   Fri, 22 Jul 2022 20:29:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: at91: add lan966 pcb8309 board
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com
References: <20220722131836.2377720-1-horatiu.vultur@microchip.com>
 <20220722131836.2377720-2-horatiu.vultur@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722131836.2377720-2-horatiu.vultur@microchip.com>
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

On 22/07/2022 15:18, Horatiu Vultur wrote:
> Add documentation for Microchip LAN9662 PCB8309.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
