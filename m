Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA5518CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiECTF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbiECTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:05:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7DF2B269
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:02:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a21so20917238edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GhPVwEXFQlelT1ahoVdVsco/ScoxIkg+GwxOC7eOaEc=;
        b=fDLZyyRvAVx2uEW7lTQEdGpwpsEEMgifXHx1C9/rgxLbrANjCct8AdZwl/Qu6HnS3c
         ST8BJSWUC4PeNzfvHcS4SzTosKYkqRVV1q/PLeQU6ZYP/i0TluoWpLUJ/nAwZpga0VP+
         9I9oRIM1y0bq1B+ykLn4cCL2mgQgsLWbYCjCBe1R5ka08KFb6H/k8fk60AiINMewytvH
         5yFp0efCueZ7dSZ+hlAwfjSB/l3TM0CR9eT6GQXZXsPdUe0cKH47Dt7A50+5JbBCt00h
         VX0JrvhM8HjEG4VrxQVhkuMOVjnLP+JYM6dE1qSgWF473zICXaZud9XySu3acZ+v6yQ+
         k8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GhPVwEXFQlelT1ahoVdVsco/ScoxIkg+GwxOC7eOaEc=;
        b=q8831mHPqjxEw4OFYQCzZE5OKP4kp+mX8iEGgndK71YwNDRLICWdpsgXDlD6bBd/LZ
         GR+FmsF8W/Z8UyXsam0aGaigq6QpC8wexEx+g6ITNeF+SkVDeenD72/ch0t/myIFbRTY
         CnVG4d7TCX3KZmXV+JpUZLj3vggJxehkj3KSzix843bQWJCRNnqQMhK4BjV+pKhz4bMJ
         cO/Dsed7MnZ8jA/UQiSuxOrLAZP2bBE9N0vAFo8Owm2HsjiMFPnYQuhM4y+hWIHyTG3Z
         WzH2qPggFYm7UaiTsixqJQbXbBgLKFpa3RMwkeZmd2KXgxSPGl9cUm3noO0MfrBOcCv7
         /Afw==
X-Gm-Message-State: AOAM530JVK+nxy9UeQsd+UpyYpfLgZ2MK7CchzDchMP/dNA57M8aoUUa
        muMwXOw4UdyCrOIws7bRekJFqw==
X-Google-Smtp-Source: ABdhPJyUSOv9kitRm7ExswRN8j6l5yHt0jx+r/ntr8DNAq2Hp2E0qOX+pl3n3b+8w7WVKhKXNuKfVg==
X-Received: by 2002:a05:6402:2714:b0:427:b9bb:a179 with SMTP id y20-20020a056402271400b00427b9bba179mr14199065edd.102.1651604541458;
        Tue, 03 May 2022 12:02:21 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ig11-20020a1709072e0b00b006f3ef214e2dsm5061552ejc.147.2022.05.03.12.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 12:02:21 -0700 (PDT)
Message-ID: <ee8416a3-64da-bd03-6a88-978fb095cbea@linaro.org>
Date:   Tue, 3 May 2022 21:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
References: <20220503042242.3597561-1-swboyd@chromium.org>
 <20220503042242.3597561-2-swboyd@chromium.org>
 <2280875f-fbd8-0dfd-5a0a-1d7fceb856e4@linaro.org>
 <CAE-0n50oGX8jBzfNjYFj01nZkuYbk6ZPsqDj89-zqxHhib=vaw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAE-0n50oGX8jBzfNjYFj01nZkuYbk6ZPsqDj89-zqxHhib=vaw@mail.gmail.com>
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

On 03/05/2022 21:00, Stephen Boyd wrote:
>> else:
>>   properties:
>>     function-row-phsymap: false
>>     google,needs-ghost-filter: false
>>
>> Because these are not valid for the non-matrix-keyboard case, right?
>>
> 
> Yes, but they also depend on linux,keymap so they're not possible to
> set because the matrix-keymap.yaml schema defines linux,keymap and that
> is only included if google,cros-ec-keyb is present.

Ah, right, I missed that one.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
