Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452D65AC480
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiIDNZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIDNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:24:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091491EAD0;
        Sun,  4 Sep 2022 06:24:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so12338278ejy.5;
        Sun, 04 Sep 2022 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Bdqzu+VtsZVtfIj9GP+yvbSAyPZKsekyvy5yCrlp8+U=;
        b=U9RMKb/Fw6uaL+z7jtElY0l2S8XPbsE7/XkTZ3b65gk0+RUU+Eq5n5yqjGA2zWtiMj
         nd7dg/DVR4y2nDw675cQe83H9t2EEFzRPA7NCHIDJ7g+QzpKDQ8cSfDU9kHxLsnTm8Qa
         B0fPuhRmAUOoDcgqvt8WJhscddTBlQYyAi4bQQ9Yf8OaA5VupT+qCVjb8bPFjSyvfr6N
         q+tgrtrojWh2NTWnJX4SXCNHzp/1oG9jyEBWOWmhEXxtyQWP0lffhT7D6lit4nZQDnI6
         uiZPy6Tvxo+ANa0+xlyt7G0OkIZcLIwo/hHjm7zq/iQsaKftMV6zJ6o4uf62+KQVSVOs
         grwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Bdqzu+VtsZVtfIj9GP+yvbSAyPZKsekyvy5yCrlp8+U=;
        b=Ht1gOnW2lMl+8lKk3DhiCJjM7x0PgRuxCRulVuT9f1oZ9pAubH/FIdVCgUKL5yVGNG
         rXk+5A5soM+IO8C+knRlCWCXnbQdupcUw5NN0VmnFqng/4GfXsFRiucPTmJ5XS3dD0VL
         NTQc3xLjDj4Suqt3y9SupNS0j99arBHdItBgTsBxl31ouIKm9bBXImewM3tjlnDd0HEW
         KChw7rW6qFjfnS0fUXzG60pd8qMw4IFxsA9S6kb0fBqFktuGiKNUxvaPRPQ46WX0xnBc
         G5tmtqp/YJF56Z/ls5ieolPDlw6WCH0FQR8NbLhY+4Zvcm03E7oN8rV+3S/jwzgLI+LW
         UwIQ==
X-Gm-Message-State: ACgBeo3Tlpn0RaI0GgZ1zdvzmRYDNHpzbpBJRaaKOYyiiabLjVL6gpQB
        +pqHo5WGYGAxO+2vLzPLH3s=
X-Google-Smtp-Source: AA6agR4l36T2EoiYPzEMRPEhBLvst64id+VOIhhytjDwER1pFe1mnJg+K8eP0XrOE0ZLkjqzvfKj2g==
X-Received: by 2002:a17:907:271b:b0:730:aa8e:74eb with SMTP id w27-20020a170907271b00b00730aa8e74ebmr33280729ejk.478.1662297895494;
        Sun, 04 Sep 2022 06:24:55 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id cm20-20020a0564020c9400b0044e74c9dfedsm860413edb.86.2022.09.04.06.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 06:24:54 -0700 (PDT)
Message-ID: <eac61be4-7d66-f07c-55ce-2ffb2caabbca@gmail.com>
Date:   Sun, 4 Sep 2022 16:24:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 7/9] arm64: dts: qcom: sm6115: Add basic soc dtsi
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-8-iskren.chernev@gmail.com>
 <0583bec6-3bcd-b4b5-910e-bb82ec72028e@somainline.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <0583bec6-3bcd-b4b5-910e-bb82ec72028e@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/3/22 22:46, Konrad Dybcio wrote:
>> +		user_contig_mem: memory@fbc00000 {
>> +			reg = <0x0 0xfbc00000 0x0 0x1000000>;
> Pretty sure this and linux_cma_mem don't need to be reserved at a precise
> location.. I might be wrong, though..

In downstream pretty much no reserved memory location have precise location.
How do you figure out which one is which?

>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 1 0xf08>,
>> +			     <GIC_PPI 2 0xf08>,
>> +			     <GIC_PPI 3 0xf08>,
>> +			     <GIC_PPI 0 0xf08>;
>> +		clock-frequency = <19200000>;
> Remove clock-frequency if the platform boots without it.

And if not stick it in DTS?
