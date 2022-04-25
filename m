Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0B50E270
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiDYN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiDYN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:56:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8FB68FB9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:53:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so29749011ejd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O5c0UqGvLtPw8emC5AWVjXB8dvbnto1ATcZ65iturcA=;
        b=Z8w7LYxWc4ApdukoH2e50ejIEdNwvoqXyHEC6plt0/Vw1+VK1Mu4bpnd7ccZ1yYdJt
         lgsSAvgeMia2TvsUXKLwIs8nlmUnCh5FwTApqoT46ktNVx6l7AVfb2ETLtVcO+vTYXUG
         YF7c7ULN1TOH8gq8v+1j72Vqkx24qcsM0DWCrBAGhYMMIs+FEdk/4VSZ90PiZFPey1E4
         XajUfAaalq6B5SXqMD3WbCkh3fbfbV/t16ApcRuYGvdoN2zFbi5cpgTRMeJ2So8jr8pQ
         nY8EWVmJhkUhK0uTBdjMtuFBa7zWn9oIAVi/YR1/N6tc7trjxJaDSBpbbGMJdu9K9bdG
         BVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O5c0UqGvLtPw8emC5AWVjXB8dvbnto1ATcZ65iturcA=;
        b=NQo++inMH3K4MLdfDsoMG9fM3LKgCDUPUp3mAAfjuVyIp1mTzl2gJ86aO0Vj7ij2Ek
         XMqKvR1gMfhR0UioTCGJ6xmHRwmbOkKjA+ynznM+ZieA+FIOgCfmBl5pRN4dR42W2Rip
         bhvK5q42wkWV8qomt8bJ7Z2+I+o4Not1tdJBMoG58KSO8rz2v1iUVyW5Eoc3Zc2BVZwS
         tyGZYMQ24DFcKvaLI5ArAczO0ccharAL/EVBuhSsPqhmTrwr5zvqtglUWOGqCofh+p0k
         ccT6/s+fZjMpRgFHonhcHw7M89ACmnDG8easuFmtZ1GeqRWTG0JfS9jipsNT8sUnascb
         0AaQ==
X-Gm-Message-State: AOAM531EOv2QX4e/cPM7NHAqQGDcZ8M7U7MIuei/WWSYOmMGFK1tdQR0
        rJfqGOI89RV7dOHyRwpdQ6C8Ew==
X-Google-Smtp-Source: ABdhPJyJh6DWB2kVePBbEOthMsffKZenL6MCE3nNClBAPQGqQUSfgCEotwo6UYTEk0UqYpTDGEozNQ==
X-Received: by 2002:a17:907:60cf:b0:6f3:60ab:d1ed with SMTP id hv15-20020a17090760cf00b006f360abd1edmr13605037ejc.22.1650894821957;
        Mon, 25 Apr 2022 06:53:41 -0700 (PDT)
Received: from [192.168.0.243] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mb22-20020a170906eb1600b006f38dcf211bsm1529661ejb.138.2022.04.25.06.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 06:53:41 -0700 (PDT)
Message-ID: <35648611-cfa9-1df4-7130-7cd1bcf1a69e@linaro.org>
Date:   Mon, 25 Apr 2022 15:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: stm32: Add compatible strings
 for Protonic T1L boards
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20220425132844.866743-1-o.rempel@pengutronix.de>
 <20220425132844.866743-2-o.rempel@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425132844.866743-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 15:28, Oleksij Rempel wrote:
> This boards are based on STM32MP151AAD3 and use 10BaseT1L for
> communication.
> 
> - PRTT1C - 10BaseT1L switch
> - PRTT1S - 10BaseT1L CO2 sensor board
> - PRTT1A - 10BaseT1L multi functional controller
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
