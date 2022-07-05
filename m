Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4535667CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiGEKXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiGEKXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:23:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41714D32
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:23:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y16so19726427lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D5siEQlI9XeniTKofv/2Ej6WMzqEAvwWpsCPDQ5Kx7k=;
        b=RGrEAp7zvLo7CTBtpOOl5wiObpP8CTfkfXlUAXMlhsoqFhctrsSeGyQvtum9CIMClQ
         T2ionu2utuPpEtPp8pEJ1SrdUwt2orU2kEVDrs+3cuzWyq/aWS8d8HJ1BODLE3gLG/HQ
         RBUoCV972pvReTzlL93EsOl9qCj7Q0tfHPFaOGFNAc11JkQgLqlPVzTqZU0rPwrcPWPM
         zqah7tRBSuz0NI3lQ0TFfXPoX1D5qN8bfxwKApd5EefSfCQaNvTQxv8fRbZDoiTJmfhX
         MqhY2392OhqhTie0d3Dt2sfN2AmOf8QjBFhWFMU/jXuVt2SwDcxGluCbmyzT1H/m4MVZ
         aNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D5siEQlI9XeniTKofv/2Ej6WMzqEAvwWpsCPDQ5Kx7k=;
        b=rJlhWbcOMU7noU0jfqwRo3ZjWRYbYDurlpkjdRjMzohZVfr+f0aSZhy3nCAVzq5nhJ
         xZDj5Y/63JegcEe86cgqgHNEaoe9majlPGF4XI0sA1RvUuBhltRUlwxXz83NU0Wphd6J
         WEWTbUIMIxNfRXIxmkbS+9VG35KxxRNhjsF+Mx2bA5tbctsJrH0M9UU5LJrcc4lRcF1I
         qDHCRjXR4PJB1TiyLMef966G7jgfWaglG3UMZKelh7qnAYrE9XwF8DbTueTCvGp27Ez+
         7ghN1ixhTyljXY1DZuyPGDirXSoD7wXjwRajvCgB/+pGkEXzb1c2LD/zQPC6sMkxhAv9
         Yaiw==
X-Gm-Message-State: AJIora8HJLjjBJnpiXxODxDSPFwEsVTBVLNQkptc0llYVChLmUJ/LR+m
        l5S3r1onOJZZYlxQSpD0ALP5YQ==
X-Google-Smtp-Source: AGRyM1u/5ekv4E6MjvZ4URSOmp1X5JoJIqCjqdBiA5tEuuxuPaVwWaOw4MHCavNj71iNDl2hB3U8ng==
X-Received: by 2002:a05:6512:260e:b0:47d:ae43:62b3 with SMTP id bt14-20020a056512260e00b0047dae4362b3mr23834973lfb.77.1657016613842;
        Tue, 05 Jul 2022 03:23:33 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b0047b0f2d7650sm5622474lfr.271.2022.07.05.03.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:23:33 -0700 (PDT)
Message-ID: <b1a14a8d-489c-6871-332d-230811baace3@linaro.org>
Date:   Tue, 5 Jul 2022 12:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/43] dt-bindings: phy: qcom,msm8996-qmp-pcie: clean up
 constraints
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-8-johan+linaro@kernel.org>
 <4b1a9ded-24b1-faf1-e105-f18afef57682@linaro.org>
 <YsQQnT5ixHtSo+vk@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsQQnT5ixHtSo+vk@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 12:21, Johan Hovold wrote:
> On Tue, Jul 05, 2022 at 12:09:19PM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 11:42, Johan Hovold wrote:
>>> Drop the compatible conditional and tighten the property constraints.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>
>> Squash it with previous patch. Does not make sense to add new file and a
>> patch later change it.
> 
> I beg to differ, for the reasons I just spelled out in my previous
> reply.

So let's keep the discussion there.

Best regards,
Krzysztof
