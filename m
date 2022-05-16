Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD2528835
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbiEPPL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245097AbiEPPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:11:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564D2CE37
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:11:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ch13so29236850ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dYishxIf8bd1GMWp6XCA0BG1+T1Eg+eJYk8k1IWXpBI=;
        b=Ut9u8XDPpuCFw95W0NyvgKorAYZlAuFW050yVggI/lY146YLmsTKubJtm6eiZVY8EG
         H7ile/L7eyDCp4aWvTzFESjrVcP8a7p8IqPTX4jqzQr3TrgiiTn9SKY90lfriIAiA2Na
         Dy+im26QCsWcixNWxG5EQl1eoZ7tc8aZE0gNvu5cnZl9GFhzrS931ugxCvE0NlC/TkD5
         3xU793dP3v3vghx4ERqRN9It0YAvxjWZrsLsSxmMGWlZ36VC8O+0WahpIA9IOmF6hjFK
         D/E1gydUdQVRRWhD6skG2FMB5PjyhYD8cGA2QiHiEnZkaZ7d7UBryItfdVLlKLbTjR6l
         lQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dYishxIf8bd1GMWp6XCA0BG1+T1Eg+eJYk8k1IWXpBI=;
        b=7TrcNYLc2ckCS2PYFYSp98V/jKOxXyhdJKfErcQMrkI+kBatdzFG/hdbNiFefGBTAX
         J51rHK0tKQBXw3JZ7rGvV51QDkV+51cCswFPSKTyF8AUGKqEPOtmy7NowJDwWg54K9Vo
         X/X3fJeL+l9tKlOzpakfvwyeesfVUV4ovVTyrenYyw24BSdvrYgDsA4yQbNBdJR1mwB2
         ZbYKXnEW3dUcL1120GbhCTMPu48L+UPV+Uk45rtnMQiXmmGYUyvpvn6NCzFXslToycUI
         yLHqlJRlpsPd3EViyK4riZjoAm8UIWalGPKqZcppqRjietsRfhD0EyuVpChvR7jSAnTy
         AVhQ==
X-Gm-Message-State: AOAM530xpxNuzW37tI0UyblLm2O2VuGejjgMaC09gH32WnlRul5qQ3ij
        6It/tGgZU1tmbqNFvwSfHSnBqlR0ucb+V//x
X-Google-Smtp-Source: ABdhPJz8rL7PhUYNDMzap/vDmRapn2E5WZxAyepGoMi50gSo0lWo4qWxyOsn9m4PMzoe8Lt4ogmF8Q==
X-Received: by 2002:a17:906:2883:b0:6e8:7012:4185 with SMTP id o3-20020a170906288300b006e870124185mr15334518ejd.204.1652713883670;
        Mon, 16 May 2022 08:11:23 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090600d000b006f3ef214de0sm10389eji.70.2022.05.16.08.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:11:22 -0700 (PDT)
Message-ID: <c7d2ac6e-a407-0dbf-d34e-347f505ec4ef@linaro.org>
Date:   Mon, 16 May 2022 17:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/4] dt-bindings: Document how Chromebooks with
 depthcharge boot
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <d5438d2e-f387-170a-cea1-d5936cc8e15a@linaro.org>
 <CAD=FV=VNGS+H8biOOigt=drUCYCWY1VBKN=ZFD74T-3RSeWBxA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VNGS+H8biOOigt=drUCYCWY1VBKN=ZFD74T-3RSeWBxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 17:06, Doug Anderson wrote:
>>
>> This is not a Devicetree (generic) document, so it is not the best place
>> for it. Maybe regular vendor place, e.g . Documentation/arm/google/ ?
> 
> I can put it there. ...but taking your two pieces of advice together,
> you're saying:
> 
> 1. Don't add this under the devicetree directory.
> 
> 2. Don't refer to this by URL but instead by a relative file path.
> 
> I can do both of those two things, but I always had it in my mind that
> the device tree was supposed to be "Linux agnostic". In other words,
> you could refer to Linux as one OS that boots with device tree, but I
> thought that the device tree docs were supposed to stand on their own.
> With the above two suggestions, it seems like an extra piece tieing
> the two together and assuming that both Linux and device tree docs are
> living in the same place.

D'oh, you are right, it should not be referenced via path, if moved into
docs. Then let's discard that part of idea, so just move it to
Documentation/arm/google/ and keep the URL link in your bindings change.


Best regards,
Krzysztof
