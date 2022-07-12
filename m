Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3028C572833
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiGLVDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGLVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:02:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D560530
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:02:51 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bn33so11285722ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wYfMN1U2Pe3jpUIv6aB3aQPgJskkEEj7WPI7YhpZ+iM=;
        b=iZXAjAw4olgV0sdKbWutYFhrJLkIBmMclGHtIompGla2ei8+ABHriBhI3sAyRBwQyj
         Nw2uJ1ShRyvRClLPSTGtOg4VPZ0yWWO/bu2LK5ACyTY3P3Vxd2OqnEglT6D73HK8ZBiL
         y3KWoycp98U2TrSmE6EyY1dsNCf6O7S/5QV3IptfC+BBb/UBl7G0TeSgRUwA7N41wYt0
         6baOu7/yvywfkoVIsP7t18eTdmHY/3OFsh7hxDRf41UBd539R56ut+rL+60/+Ino0JEk
         Zeb4/cZRkx3zlM6qSBHpmHhErgzjbrmO4U0hXW3/GdsV3lsL/V95Cn57P5SYMCn5vCvV
         +uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wYfMN1U2Pe3jpUIv6aB3aQPgJskkEEj7WPI7YhpZ+iM=;
        b=QXyUARbGAyuxPAmAp+mQTHszkkY+8gbjt+euDPaIz4ivrU01YAgwNJA+KM0W6tR3U3
         W6TWSa2yGV+tBfMv36WhzSEukTbMIXeuOFHmTl0c4hDr7x82AuCyh0YaT8eJcorB01VX
         HqcSwVbZKQkBfyl2KYhZw+vzcN3Et0hukHhQrHu202lAiyxzmtA3zRdyJLOBIy6RWXfG
         G9ODZ6G5gz5cqg+DsWDeRNe1hVJe8I6/AJ19MdQW4bHx1wz4gtSby4S8gZT9MOd7IpIF
         AAtpVZ685y3ui1ObYUnjwS3+E5Q9tmDu6fpDWwkN72KyPciJ9OxkoVNchhJXwVkiXw7Y
         /IBA==
X-Gm-Message-State: AJIora+YP+r0i0Zv/LcQlatJlwE78E6RzBgVr9Y29SCXRe58yacxlUMo
        1zyZO33GMLNbi5d5amOSKrl7tw==
X-Google-Smtp-Source: AGRyM1v+9fnhivd68F9zNYLDGadJBtEWyFQcWpvtuIzRBBdhrlhiHwQ4slZrz/esjHrNn6MtFsgZPg==
X-Received: by 2002:a2e:888e:0:b0:25d:8112:dfc7 with SMTP id k14-20020a2e888e000000b0025d8112dfc7mr2100485lji.270.1657659769611;
        Tue, 12 Jul 2022 14:02:49 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id v12-20020ac258ec000000b00489dfb5d622sm1390518lfo.257.2022.07.12.14.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:02:49 -0700 (PDT)
Message-ID: <db31ded1-d240-e5a0-c4ec-03ad7aef6af8@linaro.org>
Date:   Tue, 12 Jul 2022 23:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
Content-Language: en-US
To:     Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Taniya Das <tdas@codeaurora.org>, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
References: <1657181739-32052-1-git-send-email-quic_c_skakit@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1657181739-32052-1-git-send-email-quic_c_skakit@quicinc.com>
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

On 07/07/2022 10:15, Satya Priya wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> The lpass audio supports TX/RX/WSA block resets. Disable the LPASS PIL
> clock by default, boards can enable it if needed.

You made here few different changes at once but I fail to see why. The
most important message in commit msg is "why?". Why are you disabling
LPASS PIL by default?

> 
> Also to keep consistency update lpasscore to lpass_core.

This definitely should not be backported to stable.

> 
> Fixes: 9499240d15f2 ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers")

This does not look right or I did not understand where the bug is.
Please describe what is the error/issue/bug being fixed (which would
explain the need of backporting).

More over, the patch alone brings regression - disables the LPASS PIL
while before it was enabled. For sure it should not be backported.

> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---
> Changes since V1:
>  - Updated the phandle reference in lpass_aon node.
>  - As per Matthias' comment updated the commit text.
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)


Best regards,
Krzysztof
