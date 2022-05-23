Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19EA530A19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiEWHcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiEWHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:32:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D255AD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:31:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v8so22110927lfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KyV9lT9+ytqJp/YOSL0Uwp6DljeF8AaxfinieX67j3o=;
        b=lYKCMl/RGy09NhRM6yiabyzHYXnCsb6xykBD2OmT7C4UGXL/tS5cDHEr01DiJT8wXk
         GDf9X9/aRLHK1aymH4u5opnx2hngCfPwvCdog5UoF6q/sWbvrzunVSLIQmEhmPnLAFAi
         VkrnAqF0VCikJaynFl5OSGuVIeoLsaCeMiLJuorcsw08+U7Lmi9vU+0A0pLIzwN6ScZn
         y2TLWJEJ+umDzjeFsXXL9+fYVXTyfd2nsJS7sZCg1RQY4LOavXbz94DUAJQUCzyY34RA
         8CFQAdnNMsY/ImY0bdfrrWurLzTAAB7MumIRewwvAImYXo0/Tel3qr5Cu0dKYX4hsIPB
         Gr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KyV9lT9+ytqJp/YOSL0Uwp6DljeF8AaxfinieX67j3o=;
        b=PNEB4G9/fTjGSny520F51hAniyt5D1Ywoo7jGT5pMwgFVqh0dHgNSDO+JDEs+TdK3k
         FDHOKzNQBQjJO7ihhWA3sQh6aw8qQATAwg3sbcnOFsmUw7KYlfp0OmmQTGeDjuxZ3xYC
         SfuoSdYFdIrgGJh5YmThN5CfpI8mlX2++wqzoHJaegqf9F2Rm0oA0MOl+vGrGY4sZ3tz
         PZjQlAQL6FJd8feShzjYOHVPwKnLaGsvWsk0Fv9rJ/G1VKCGtW47hH6kNwn9kx2Mu8oz
         3xGOTNdRnmD7PRVW2o4UxMftO0mnWwzggUFS7gWNd5BGZf771PADQ+CSR9SX95gzYYtv
         BLLQ==
X-Gm-Message-State: AOAM530vYqVvR7lRFwXjXZ5I2ARrwUtb62tUp9pQqragXL8HVTyblMrf
        GWr7aVrE9de6I8XOUKqYkTGo8w==
X-Google-Smtp-Source: ABdhPJyGZyOu9VIxr33EGSOKBZFSxGoiwpEjxX4VFoXSuoPjjAbUXKOBkNH955vm37QLR3a4tkoUxQ==
X-Received: by 2002:a05:6512:927:b0:473:ebb9:ec7d with SMTP id f7-20020a056512092700b00473ebb9ec7dmr14833260lft.637.1653291097068;
        Mon, 23 May 2022 00:31:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 10-20020a05651c00ca00b00253e88591f1sm817885ljr.23.2022.05.23.00.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 00:31:36 -0700 (PDT)
Message-ID: <bff38fba-86c7-36b6-c616-cd96d2a22111@linaro.org>
Date:   Mon, 23 May 2022 09:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 01/19] dt-bindings: timer: npcm: Add npcm845 compatible
 string
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220522155046.260146-1-tmaimon77@gmail.com>
 <20220522155046.260146-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2022 17:50, Tomer Maimon wrote:
> Add a compatible string for Nuvoton BMC NPCM845 timer.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
