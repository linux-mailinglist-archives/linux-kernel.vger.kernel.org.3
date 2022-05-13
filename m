Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0D525E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378489AbiEMIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378525AbiEMIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:44:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B032AACE2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:44:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so10488735wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=88qRG/b6ScbLlV2pW3cxdQcZqm/oAWx5aycEMU6sNBo=;
        b=bygupOhsN/ulp5NY7fJLZ7dvKlwZ8+8Qz+kCrYfqVtIXGZihtRSfw7GWX5zRjxC6jk
         fEIgz9IRaxOHHygZEvGTqgAIY+un5PM0Kgucxfbtw6Wd6FUq9ZSc5XJpS4O4gEHVY/AA
         HOGSXr2Kk1J//gTMZ0+3C8ZU6h0LcQsghK6SynOcgTTki7TqCaGKMsYl5xPHIgDYTnjJ
         CMhkyYhvFF/c6XZHbssuhzv9gQ12J1jkpZp1HE+OimeKBgQkgoSUWLaCnseDO3VMvk/b
         qPfnLMV+6KiivR9dYkYK5XhvN2qzW27AeDYguZOjstIiIoq4FYWd1Kkot+UxbqtWo7Fh
         UYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=88qRG/b6ScbLlV2pW3cxdQcZqm/oAWx5aycEMU6sNBo=;
        b=E6RDlSO87+cpws/lmpTuwry+NXCBPsUEVX3qZgafCZzfUYs1iPAkBfr7KOQ0tXaAux
         BYNDsM4Dk3qnhCh2O2Tbcg4yl3R4MtwMGy7LziPTy7KpZ6iThZsVBqbzW1uNtHu0lU1u
         myyCcqun7j8j7xXlk90EzYXaapf71iwcoBX4zNauK9Y4gwyjWA8EM/kGGz7g10xKL5Dg
         bGHYyOvwtmYK+jCwl3Ei8BZn1OrEQGn9l/CbCodb9auQ2Y8A2KAEgj7VfrEmnlkt4ciN
         tjxZpf8nnx61DZdSPWdc0na45uuAjugNsrUi+WpzeOO3OnLL9uEbSkQejFM3/stNhS1G
         DBRQ==
X-Gm-Message-State: AOAM53374o5QTs9FKbaTOoTwJyBTkojSr6/5E0BBL4Zzkh+e5/9Owe4A
        GAoUbQWQfnq15WFWCNCQAJMEtQ==
X-Google-Smtp-Source: ABdhPJwl9DJvDnFUS6xTB9gx+4sZEim88qSnQkpdIxfKKUNO4jqj7W1MY1l+9UmaO95iGbaUyu4cpQ==
X-Received: by 2002:a5d:5309:0:b0:20a:cee3:9e3f with SMTP id e9-20020a5d5309000000b0020acee39e3fmr3003638wrv.570.1652431457445;
        Fri, 13 May 2022 01:44:17 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s28-20020adfa29c000000b0020c5253d911sm1582185wra.93.2022.05.13.01.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:44:16 -0700 (PDT)
Message-ID: <2efc4a74-f4fb-3b91-348f-838412116d6d@linaro.org>
Date:   Fri, 13 May 2022 10:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 08/11] arm64: dts: marvell: rename temp sensor nodes
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220512124905.49979-1-robert.marko@sartura.hr>
 <20220512124905.49979-8-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512124905.49979-8-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:49, Robert Marko wrote:
> Rename the temperature sensor nodes to use "temp-sensor" which matches
> their device class instead of IC specific naming.
> 
> Remove the status = "okay" which is not required as its default anyway.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
