Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48F458A611
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiHEGqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiHEGqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:46:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0C140D4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:46:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e15so2223433lfs.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=elKcXDfUxPr5UWB5Ig8rgcGqrF7Nd89MhfB2Oxmopfk=;
        b=V32+S7YUV/1rfANMUeraQkvs58A9sCUKhnleazkhDf2cidrJm6vb96ts6qDSCw05Kc
         V9CqHvp+Q9ntGdAboe41XOq12L8axSuUoSYofJ6X92D9MwzVEHjJMpsnuXcBk4s2uUb4
         jden0La+rvdxwlcdfn1ZZDPi0NZHXxIn5Qap88of0Mj4xBYt0oP+Bqo1SZ5E6e3N1Ip3
         mj1RfJxCGFsHUrQJwIbho//GG7e7B2cHfuxt2tF+mU64Z4rUttZT0zgHhuUqro5p934c
         gx6JfOifTojzkd/vrmmi5k12KEYjpn3YMZ2Tny1xaNbY1unGDxJNjO+giV7kb5YnxbC8
         8xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=elKcXDfUxPr5UWB5Ig8rgcGqrF7Nd89MhfB2Oxmopfk=;
        b=fQ23moQRjGDa7mfrDa0Hnc/tFDmwyNaly6qGj/HoOHu7PlSiyhQJ7coZ0PGwEjqj4Z
         5qwtXqwbAvSgeye+UgFXssHgP7+7otSsg8y2EmgKuHUs9EWxk3Jtw2shmkilAK4IMRcO
         ekHUYdhOoGzR6Id9nQ3J9SuMoPE5/uXpMqWAQdqXtsWo56m4DZEEtMMjC+9FopeNbT4+
         JMCzNPprqa2RSzCFhn/ePBkyqb8Sz4Z6Slj0xr+9Fo247EkV1aDFl+oWpqc58qVGewAj
         S1J7x2nJBENkSycF/bdTbCrrSzv4JOE1oWP29ekS6FwuRuocyU1eGJ+ul4spPgziSlmm
         kMfQ==
X-Gm-Message-State: ACgBeo0/dzkOX1Nwv5HEMMOCRfyZtugVah7/uUEifVjrEF5j1Jzg8hO8
        GmDxowX/2YYHOagimbjM9k5dng==
X-Google-Smtp-Source: AA6agR7L9ksA8IWx0gxOVnH6K4HcwGa/7uD0x3KwylcNpI/FkJHrjksOnqu6DQW3NEJoMGkK4Sk9Mw==
X-Received: by 2002:a05:6512:31c9:b0:48b:27af:ad36 with SMTP id j9-20020a05651231c900b0048b27afad36mr2100250lfe.394.1659682000569;
        Thu, 04 Aug 2022 23:46:40 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id t18-20020a056512069200b0048b08e25979sm360374lfe.199.2022.08.04.23.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:46:39 -0700 (PDT)
Message-ID: <e84277b2-55ab-6b6d-c2bf-34736b0622be@linaro.org>
Date:   Fri, 5 Aug 2022 08:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/4] spi: dt-binding: document microchip coreQSPI
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-2-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805053019.996484-2-nagasuresh.relli@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 07:30, Naga Sureshkumar Relli wrote:
> Add microchip coreQSPI compatible string and update the title/description
> to reflect this addition.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
