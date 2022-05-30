Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9F538784
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbiE3Sqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiE3Sqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:46:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2443B7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:46:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jx22so22345050ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MGC9lypGvvQHtcPIof+toR4e3sY1geBCnMDhVOsZ03Y=;
        b=Zm6wSN5O6ZM5I2mWkDIIGD00txWoUAy+wG6ekFTiOX1fC1jnHKiCJF3lMFTxP5hL5j
         ilr67+ERw//4a9ENpnAZs+Vvp/nJAaDNyKUJf9FWWKMBcFkfAvI2ufbSSCavYVdcJb8M
         AlRoX3+weThE784Bym5lc78cdv/p621gUHtxViBLMNv3B/1VYCOhYPLntlWd9zlZm3/v
         cXuF2HUrTkk+CF+OR6sGawQwAh+lJk5+4qG/cqMUbYwaZD3Y3C9NzyBdteJSz8NdKK47
         HmqXR7E2pfy2/K+4pjLKazwqpupIDBPp1eT6utl+E9y9JKucl6k+Srdo1uVz/QzYdl9r
         4x7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MGC9lypGvvQHtcPIof+toR4e3sY1geBCnMDhVOsZ03Y=;
        b=5FgxeKY7v4yAWwks695a4NJ77VerZXIU4YKpcNagyN2BjhJwcG5mV+roko2Qn6W4gI
         +oHd35dUIdI1SP/qQw19nu/Ri+UMzU/ZwiE22qvVPTtQszAG3Rl7jJ8xcqhOZynXHdLs
         dPGLSq1SwZogPqtTkegcjQTOMwyaowWLaOYVnN9bnU7VLWnafK3WO3G72IlOMNcEywdH
         XLOda9X4FrMQ/P+vFJwZ2637HhYNUoUmtPIveaoW3R0fqxwHUpx+Hr6+XZ314TRxf9D5
         Tn0wPF3VpcXygJY4V3jNmrfZNwlj/9AfRME4ehWTe/0GciWmSxUVgWBYkehs3PYAP1uZ
         oSZA==
X-Gm-Message-State: AOAM533sp7ajmWigXNit3iczcMEc+lrFu2iyuTPpNserGKv2ZIUsSs0l
        WX/LB46iEE5Ro4zox/brOeAcRQ==
X-Google-Smtp-Source: ABdhPJzsKH/DAFlFH/rItpdXB1i+zYAEEVeFlixS7t9BYZ8Own/moKO/QscKAVorcDmIUKeAZckiPA==
X-Received: by 2002:a17:906:b294:b0:6fe:fdb9:5fb4 with SMTP id q20-20020a170906b29400b006fefdb95fb4mr30084594ejz.179.1653936393433;
        Mon, 30 May 2022 11:46:33 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906354400b006fe98c7c7a9sm4270868eja.85.2022.05.30.11.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 11:46:33 -0700 (PDT)
Message-ID: <cdc6bd79-3fa6-4e3b-45ef-9e6950c3796d@linaro.org>
Date:   Mon, 30 May 2022 20:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] dt-bindings: net: broadcom-bluetooth: Add property
 for autobaud mode
Content-Language: en-US
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <cover.1653916330.git.hakan.jansson@infineon.com>
 <f395ffd03a6594ee11975b708721a33ccf8a4871.1653916330.git.hakan.jansson@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f395ffd03a6594ee11975b708721a33ccf8a4871.1653916330.git.hakan.jansson@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 17:02, Hakan Jansson wrote:
> Add property, "brcm,requires-autobaud-mode", to enable autobaud mode
> selection.
> 
> Some devices (e.g. CYW5557x) require autobaud mode to enable FW loading.
> Autobaud mode can also be required on some boards where the controller
> device is using a non-standard baud rate when first powered on.
> 
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
