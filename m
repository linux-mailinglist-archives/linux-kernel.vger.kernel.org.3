Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4950F57976D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiGSKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiGSKQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:16:51 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB911A3A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:16:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e28so23906661lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LW9NCKO2QYnmA54Na2mGEFFYmsEB487StfUpSsbPyvQ=;
        b=WIL+Zq4W91rUT+WDhQbGYjI0iyNQfcNCaHTNDAUuYos8t117vwGE/jMCG2TUWhvuUH
         Mx3JzolW1dINYBDQpo0MFZFMT7P9mgXkj4rBQXd/oOXQ1OwnS358LCrYaFm/q9jeg+W/
         pcJYPflB4QGSJxXB1to3h0wjtiExYoAh1MWvAhcbsfTX3AxPYv9JX/LvkUQTt1wdfYMl
         nKhznAz2B846RBF/2B4OX3+OFNyrU/i12jSrDUSx4EqJHC6rcFiu81jjx3YwkjwrpE+H
         3U6YYRaVajnhlac7H6M7Uwz3oBOBbHmXm5vR+b3SpAp3sqbDtaJkAuw2IAT0d2HHNJfp
         8pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LW9NCKO2QYnmA54Na2mGEFFYmsEB487StfUpSsbPyvQ=;
        b=3CZMzQ9AHSYduxq8UUwuwpNlxu0gG7/U66eiDcMBvBynm9TwybWR25clZvwILSuI9s
         oIt0+MXcYpr47jH9hhxCjqQJu5zWlf6giCuFbcKSZmBa7XYquIi4XLL1PgiPMmXgv7jp
         LvlKb4cVoqQ8jp8gimr0CJJwry0B3u9PvFYZ4wyxrOT5z6CB8119n4x/SzwGde5/A4NE
         SHzVxtduaikdR+DLIbSZNhfeRAjk/T4xDJ9w/d/yDeVL9FSu8l2D1RctrKTf1VAyg8O/
         sRS4wo2poq6QvpwydKSshWm3m3tB1iT4wJZ7Vv6RInrImmJHq5Om+9/JdN9b5hP9s6nK
         hYIQ==
X-Gm-Message-State: AJIora+RdR+MCgPsNbchYVj64yDHK9Xpag6aq/wwEI0cvEsp1UEhAXC8
        uHBjG4/Nk77EYKpBWmBrYENScg==
X-Google-Smtp-Source: AGRyM1vU9LJ6G8ivP4wDHbLuhVisV/7UBTFM9nIXb3Gso6xsV6QpqbYZ767YcfmCZ7wRhMl4muJP7g==
X-Received: by 2002:a05:6512:3d92:b0:487:5cea:a68b with SMTP id k18-20020a0565123d9200b004875ceaa68bmr16183559lfv.21.1658225807944;
        Tue, 19 Jul 2022 03:16:47 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id z5-20020a19f705000000b0048646c0af5csm3104545lfe.263.2022.07.19.03.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 03:16:47 -0700 (PDT)
Message-ID: <78230095-6b45-4536-f41d-12bb23308d34@linaro.org>
Date:   Tue, 19 Jul 2022 12:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
 <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
 <CAA8EJppCxrcQOtCDZvUX-CThGV7aZXYv__gz3KRBf28TCRTBEg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJppCxrcQOtCDZvUX-CThGV7aZXYv__gz3KRBf28TCRTBEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 11:59, Dmitry Baryshkov wrote:
> On Tue, 19 Jul 2022 at 12:56, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 18/07/2022 17:38, Christian Marangi wrote:
>>> Reorganize node order and sort them by address.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>
>>> This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
>>
>> If this is picked by qcom branch, no need to resend it.
>>
>> I don't see value in such reshuffle. Reviewing is not possible and you
>> did not mention tests (results should be equal).
> 
> The value is usual for all the cleanups: make it follow the
> established practice.

Are you sure this is established practice? New DTSI files (see SC8280XP,
sm8450 although sc7280 looked ordered) do not always follow it, so why
imposing it for existing code? Such reshuffle can cause conflicts thus
stops parallel development. Review is close to impossible...

Best regards,
Krzysztof
