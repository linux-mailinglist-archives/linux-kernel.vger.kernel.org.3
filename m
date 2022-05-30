Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837795379DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiE3L1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiE3L1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:27:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1D94D27C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:27:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd25so13107515edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E6z4YAlgEJxy9dgZZXDWgK7C1bAepcnt8dDi/KruTk4=;
        b=ewMbJkTHaxj6KMfZwATaPp2mCXul+xqk6q8YtHxkkF5wqw37LUquBYIUQa8LQt4RSS
         1EUHm9WJjf1AIwd4n7jNVJfZGPo5UyRGC0PE8RlYLvMJeRa9Ko9khtgtZ0zKjKWJZIfR
         3dAnve8CP7SdE50l1njcD3AOYY2STh1lTDnV9JFiWe7/j8Tw0dfH8crrTt+zPjJYTVZZ
         qdUadgqb9rrVXpnTo/YgzkBBshksOZC5kx02IRffZpoAUnmliZFWKAF8Ds6f/63X6895
         kpgHw/7KYb/M887go/Uau/acEKyUypx/HVOuUjQzbftcRIhAESYtepcsmbluE6koTBH6
         +/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E6z4YAlgEJxy9dgZZXDWgK7C1bAepcnt8dDi/KruTk4=;
        b=ghrQdF673ZoCyaCL4w+mrqY608P0jpwCUQ9dq9fqcewom8aPXQCO1rv/1T/XIWg1+W
         VANlYew9ZqdUOyEzBmGjDWyrME0X9Y84c/Ok3R6d9+qYRn6akb9p+1wrvKJG/QdtLApt
         GmKLL9jTwtXDkk8EgF+w3X2jsT1tcMml0O8Ebc8HmXDY1AsVQktwfk27BI5bmn5/5LSo
         6Eh8aq0M7+Q7TAMisaybhBaEMfVzq7kzWNAx88ewzayAUVSme1IWWSMm5ACx9KzrKdoZ
         vg4Ub7pHCxXbxc5G4TvZW01N7lH77UraVe/w/PIc40pAURSP6efxxmF+wi1P/rTMts6k
         6ODA==
X-Gm-Message-State: AOAM532qO0iipQ3yFSe6ah70iqZ3/qVnyaYXCKsPJ8CaTyy0KpcjslAE
        aEqP3vH96++78Z2zPFl/z4RkmA==
X-Google-Smtp-Source: ABdhPJx2LtAW7VoNu8xUutiHAdywZpmhpB+XyQsVgc+F2AkPxL015R1BZlRBCEtAnv0heBZeOlIDPw==
X-Received: by 2002:a05:6402:3514:b0:42d:d4ec:4a35 with SMTP id b20-20020a056402351400b0042dd4ec4a35mr2848302edd.62.1653910040266;
        Mon, 30 May 2022 04:27:20 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i15-20020a1709061ccf00b006fec5cef701sm3895631ejh.197.2022.05.30.04.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:27:19 -0700 (PDT)
Message-ID: <d88afea3-de4b-aab5-b90b-e21b8bf003e5@linaro.org>
Date:   Mon, 30 May 2022 13:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add
 clock property
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, robh+dt@kernel.org, nm@ti.com,
        vigneshr@ti.com, kishon@ti.com, krzysztof.kozlowski+dt@linaro.org
Cc:     lee.jones@linaro.org, rogerq@kernel.org,
        devicetree@vger.kernel.org, kristo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com
References: <20220530101031.11357-1-r-ravikumar@ti.com>
 <20220530101031.11357-2-r-ravikumar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220530101031.11357-2-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2022 12:10, Rahul T R wrote:
> Add a pattern property for clock-controller, also update the example
> with a clock-controller node
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  .../bindings/mfd/ti,j721e-system-controller.yaml     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
