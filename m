Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E45AD0C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiIEKzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiIEKys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:54:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B4420BE0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:54:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq23so12574391lfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3EON71xpMwuE31HszjcxT0gv8fFt5vL8HY5cDtEoyUE=;
        b=U1rmQSpkYInIJ/w1y8qPLW9s27eUufq+xhfDRiiOgutlRZ8eSnIVG0cyxQc6PX7PZq
         V/B/5YEQNA1Xa1SLFx3AbD1wUDkbR11eIGe5mIE2HphZxL5FwvlluUgRoscbGHUiL37I
         90zmwQ0nZFyBBWp+VIkCARI20ma06uBcRk0nVB2kMBjRC1YgN8TXwv/73t0WQSlNKM3V
         6v6SunHROv1+f93O7tIPgkfNKneq6bpx0SHa2I+uA8PpugEhFt2QC451keADaOsUSXDt
         NL2E9ykTKxGL4JyXKMBdGaQqgTvkf2LJ4dVQDTmL982JmKtFoF3qZkQjiCI9aq5M683Y
         UJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3EON71xpMwuE31HszjcxT0gv8fFt5vL8HY5cDtEoyUE=;
        b=yQcN5d0qWz1y1G1cNSk+hcdZpoG4qkhdpX0rKRrr5iE8rvG2FRNVzN15Bqaju+cG9c
         A6tF/KjpmVPXNadOMdH+ICioSKOJHMwvUdamECfiW+ylU639J/QW4UGjknHlHShC61cj
         HwOds8gWBkgaSlT0OkzE95Y8qWi/Z4+Vx/rWKJ5qUmEYB/GwZdPsvcbc9kAtHw8061DX
         bPJKpT3mQWU1TZu1teMHtXNqM3ResCrbC/Bi6Xh+vkC4DBua89IggoxZ1hW/2ac9wksg
         rIGTMfTrTLVp4SfH8AWnZQsYsTKYVwahOce0xLczJsubSSjT4Aw+xUAlaG0YkbVODl9/
         HHaA==
X-Gm-Message-State: ACgBeo2nFi9CHI72XbpeRJyUbxAJoyz3bo7TCjlWSqqyT7Y1bTZn7wt6
        MqTWBPe1qFCX44q+Xy/MAMeK7A==
X-Google-Smtp-Source: AA6agR4HAtf2siphc2MwmgM2lBhxpekezqteaTDXFaXJ9HVvuX+dtGDD8Bie5+TFY2HMGRqAUk6zxw==
X-Received: by 2002:a05:6512:39c6:b0:48b:9d1d:fd9c with SMTP id k6-20020a05651239c600b0048b9d1dfd9cmr17826526lfu.633.1662375281813;
        Mon, 05 Sep 2022 03:54:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c5-20020ac25f65000000b0048a9603399csm1158685lfc.116.2022.09.05.03.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:54:41 -0700 (PDT)
Message-ID: <3933cc0c-a99c-7bda-bbb2-c7b2e9f84cf5@linaro.org>
Date:   Mon, 5 Sep 2022 12:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm6115: Add UFS nodes
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-10-iskren.chernev@gmail.com>
 <a0204dc3-af13-6b0b-d779-0f207d1aff7e@linaro.org>
 <488be3d3-d4c4-6200-be99-b85e6ac72c34@gmail.com>
 <180f706d-3304-3a5a-82b7-f37948e5d100@linaro.org>
 <b6424212-75c1-4f42-da01-ae4ce5dc1b68@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b6424212-75c1-4f42-da01-ae4ce5dc1b68@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 12:45, Iskren Chernev wrote:
> 
>>>
>>> I'll list all remaining issues with description/explanation in v2. The fact
>>> that some bindings break on all DTBs present doesn't help either.
>>
>> We're working on this... It's quite a lot of effort, especially when new
>> warnings are being added. :)
> 
> I understand. Is there an up-for-grabs list, or any schema fixes are welcome?

Any fixes are welcomed, but check if someone did not post it. For
bindings conversion, the easiest is with "dfn:old-schema.txt" on
https://lore.kernel.org/all/.

We have some Linaro internal tracking, but maybe it would be useful to
expose it to avoid duplication of work and to track better what is still
to do/fix.

+Cc Nicolas,
Are we interested in some public tracking not only upstream status but
also actual things to do (like DTS fixes, DT schema conversions)? It
might be quite a lot of effort for us, but if community is engaged, they
would offload us in task tracking system.

Best regards,
Krzysztof
