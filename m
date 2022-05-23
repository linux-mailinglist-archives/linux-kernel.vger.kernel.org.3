Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65A3530C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiEWJCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiEWJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:02:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1141AD93
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:02:32 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e4so15846284ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ljrd9sPBtTP1ZdWylTJaxJQwiOMaV0RsKrtAyaEmj6o=;
        b=Ufac/zzCH/P/QeskduOb3+8+mNnnrWiXQj/J0i5e/iKzzWXFcA/6bBNOr+FR1fVI4Z
         BCGaF65u3k7jqeSLd8BLX6uz0+HDNsh1yLh+AvjYj5rA42s6nb2uKrp6dKLMNaCLX/Xb
         N9A+ZX2U07Ftw5p1Vx0LT3suxVk9PVmPb3yM6taB53ffx0C8IH1GJgnyF67/Bq2I2n1f
         q+bMDPOvC5fkycgdlsg6KMRIfddk5qIRcVRo2PhzyxRuR6TaUAYE7QDPIbAOGzg/DNfh
         Ve+w7OMnushQgIM8vrvhjR+kNumnBMNIJ2jFamt0dU/8RTRTgg3zv/8brgAuTu/aSxSC
         +e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ljrd9sPBtTP1ZdWylTJaxJQwiOMaV0RsKrtAyaEmj6o=;
        b=OmfWBm2PSgIpeRXKpIDZB/YCjwFFZ+7BZ+6HaeQ/MlPE6Ab6VPM2WxEz0COputhVd4
         VkN6P6JCL63adgZtTH01hNPtLYXR0FA0hzFDz3jDe3Z1qZhvmPgPXbiNFyzLM+4aYYFY
         8iWbsrrnR73oC69GKdTJK+v80erhWgQIe8cJnXPqsIj2WK6b8S9w0nEO7ifq7GaovLFK
         k97MjSRVlChT6bofgsw5Q9XU94ghZSj35WR/lMPYCdf0wTIvnf0Rq2uaqyXOMybUiQgj
         RWBqjc940xb/awXwSapUTU9Ai7ZawK1uDGgFdXVi2rzg8udT6jnoceTGpszZ5f0XC7gf
         uWrQ==
X-Gm-Message-State: AOAM530pfqSTN6C9DM9HcMi5qJinfBpKNEZBODH5tKq2JFVJ1acgqE6T
        yw5lvoHPDIdwIysQl5V78q4xSQ==
X-Google-Smtp-Source: ABdhPJypNw8ZqJ8C7Db1xwPEHrcAFbfCarFFD/xaG/JNVZP1XnFEmL+ADmOIzXWaBvyW+bXEriRUnA==
X-Received: by 2002:a2e:a26d:0:b0:253:d7b4:1d9a with SMTP id k13-20020a2ea26d000000b00253d7b41d9amr11109878ljm.203.1653296551485;
        Mon, 23 May 2022 02:02:31 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c6-20020ac24146000000b00477b0cfc990sm1864559lfi.30.2022.05.23.02.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:02:31 -0700 (PDT)
Message-ID: <3338df85-485d-25ac-e912-411e600ed851@linaro.org>
Date:   Mon, 23 May 2022 11:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 15/19] dt-bindings: arm: npcm: Add nuvoton,npcm845 GCR
 compatible string
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
 <20220522155046.260146-16-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220522155046.260146-16-tmaimon77@gmail.com>
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
> Add a compatible string for Nuvoton BMC NPCM845
> global control registers (GCR).
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
