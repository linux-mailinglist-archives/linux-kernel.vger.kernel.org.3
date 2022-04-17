Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C705048D3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiDQSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiDQSQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:16:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E797BE03
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:13:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t11so23527722eju.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M7aa+7gyYP8947L46J/ZWUZfiM4rbv0O0VQspQujSMw=;
        b=QXd8AGwBUTtxyFhsmi070SidFQ5Ti4mSoo+8oCuboc9u4FpolrvHnG7jyimT7RujXG
         D6NW6DLoEjAozBAPxSLyzW6oUS3sulV/Xb4Bc56LtnMTc4SXYEU5kplT+ACdgavjjCJh
         4J6OvevJf6JFO7i/qdRNJn+qqQpj0g+ALM7HRdd89lmBYTerPqPWj4pjuRTnU64WJrEz
         KKhW6B3jI9AVO5wMtW7mgZZXXVogLbnxMhLXEGix2Cj6wTjIfT0+ePAVi/+ok76blfx8
         9KkGU34mJHgxkSCr9y9CjGhY7D8Jc684/Lc1Y5bseRUbLBgXxVnTLksNAvxBZ511QYOK
         J9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M7aa+7gyYP8947L46J/ZWUZfiM4rbv0O0VQspQujSMw=;
        b=iXXq+QJhudxs9oEo8nmhGimL6UxH1HLKhKYh4dR5eacsK83cwE7btM2vkQ+oYr5JbC
         u03NqMh9Vsdfs7m9IDQhlaRyeBXUmpaByGHclCzgf/HgDnMvVFn73U9BfrXJUDWL4qP/
         oLwOnLIwYmPIkmPROE9YflaTjN6/1x5gFDfCf4mi/t+e+FTNTvvN5I+jMxxZGo6pMZR3
         P+LvuBg6iSNuRQO2tdxeQksrabKDgNDHeoaFTFzVXREg+XncT4pRC20oJXnONjVrmwCZ
         WJG97nXzGsrtfEWsT09eTEBwh8kx9FwsC3X5HEyn3ONwjK59OqaDSfPkLcozOBKW3sqf
         fiXQ==
X-Gm-Message-State: AOAM532gBMPMEuQ8UXm2TWAGDGnkaXw2mUzbvYcapx89BXfMIXd5ZkYQ
        y/a4GNloPolDNCU9xNyvj6N02g==
X-Google-Smtp-Source: ABdhPJzH7D2xB7lJ6AFTeSdQUbRx0/XqqVG0/qSBzmNnmuu5+RrB3niuG/AQcJHbW9nUQIhWK+fXTg==
X-Received: by 2002:a17:906:3ec1:b0:6e8:aae3:90de with SMTP id d1-20020a1709063ec100b006e8aae390demr2109039ejj.127.1650219226016;
        Sun, 17 Apr 2022 11:13:46 -0700 (PDT)
Received: from [192.168.0.216] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ga5-20020a1709070c0500b006de43e9605asm3709673ejc.181.2022.04.17.11.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 11:13:45 -0700 (PDT)
Message-ID: <63aad869-ec0c-58cf-55a9-6739f6e3e3e5@linaro.org>
Date:   Sun, 17 Apr 2022 20:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: add bcmbca device tree binding
 document
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220413192645.7067-1-william.zhang@broadcom.com>
 <20220413192645.7067-2-william.zhang@broadcom.com>
 <0de21e5a-f169-2830-2a8b-e92c2d309260@linaro.org>
 <cd628e0f-0724-caf3-1b18-481609c14457@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cd628e0f-0724-caf3-1b18-481609c14457@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 19:38, William Zhang wrote:
> Hi Krzysztof,
> 
> Yeah I saw your ack.  I guess I should put an ack-by in this v2 set? 
> Still new to the upstream process and thanks for your help!

Yes, please add all tags before your Signed-off-by part.
https://elixir.bootlin.com/linux/v5.18-rc2/source/Documentation/process/submitting-patches.rst#L541


Best regards,
Krzysztof
