Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBEE53267E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiEXJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiEXJeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:34:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E97759B86
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:34:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p22so29820404lfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J8Wg4rnRcBfNxHEuva0O6GDms5evD/i9eDv1xukubFk=;
        b=rxzG+dFiBLvoKmcUWdb7dxTvDcICEglqVsiIHjpUK83BUn9EJjkL5Z1/9wPxm1gGm1
         dlsdDl5/mqRZE5c4lh2jNb3fYVHYNy53XZGJqBF9yC/M1jcNCczQwGSsbi+CWQ9hHFcW
         jyIfJSqA9aBJY7etZJrU2Miy1YhYVgMnfxsEwk6NbbLMIQACADEP63GiazUxh8+NPS8w
         hkh0/pjRLEeTLVP8SLS2qbSLBVQl/7QCUiYdccvTGZSEhh5yHqMh/K1USnzbWlUb6jI/
         r+S0Al0hRLVfDcL9Gek3sH82wgRbzMTQ+FPoxFM98eoGGFeaheAA1JF23grHsVxDXIwx
         rkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J8Wg4rnRcBfNxHEuva0O6GDms5evD/i9eDv1xukubFk=;
        b=kuwcSCXKluFuJ38c4LTU8ZrIWLj/6hEPUKgnviCaaJQOThisGfm7cyqp5/T0d7BQjK
         g+Ac/nmeBCftoU69jv9F+Vce0klSN57wVphoBG/cL0AVvb4JwoUQk89twDkzy40rTtCI
         I1VwviyvnjJWXK8Bt3lHN8CXXu+f9K4/VjYdoLF8E8qQLGsy0WFVPRM0vNXD3dBOhVTK
         L0aCRTzilALunLIWXKEr5WQ4LE79rs0qlR9ySH5rMRbRpg678xprhfeQVt6I8Zz6kDk2
         yRGlnYZNGAcEzUuzB0eZ4urKQ0UJkPpkc9sseP981hFFAQJC+39Y/NYnFU2LujKELLy9
         k0CA==
X-Gm-Message-State: AOAM5319TJfqbO9DoL3zvk0y3UqZwk6v92sHwmWW5dq/BGUpib03D++u
        WmYabY3DyqYFn0xbis6EYDeElw==
X-Google-Smtp-Source: ABdhPJxpO3BqCzHCSX9TRWFGv26Cj3szdVSsayzjTgUpXjfXplPk6yAIZ83hMTOiUTnv0uEaaB64DQ==
X-Received: by 2002:a05:6512:3ea:b0:478:5d10:7134 with SMTP id n10-20020a05651203ea00b004785d107134mr11181438lfq.44.1653384883374;
        Tue, 24 May 2022 02:34:43 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id r8-20020a056512102800b0047255d21139sm2440367lfr.104.2022.05.24.02.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:34:42 -0700 (PDT)
Message-ID: <ef83d1b7-ac05-754a-1d57-2ae467e075ec@linaro.org>
Date:   Tue, 24 May 2022 11:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/5] dt-bindings: arm: qcom: Add sc7180 Chromebook
 board bindings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220520143502.v4.3.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
 <7c1598a9-476d-0115-ab13-11dfa0d89436@linaro.org>
 <CAD=FV=UC+eFZaUiPQNKBMmLmjx21YpH4Yeg3Yz9NiDLXnh+nDg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UC+eFZaUiPQNKBMmLmjx21YpH4Yeg3Yz9NiDLXnh+nDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 18:16, Doug Anderson wrote:
> Hi,
> 
> On Sun, May 22, 2022 at 12:57 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/05/2022 23:38, Douglas Anderson wrote:
>>> This copy-pastes compatibles from sc7180-based boards from the device
>>> trees to the yaml file so that `make dtbs_check` will be happy.
>>>
>>> NOTES:
>>> - I make no attempt to try to share an "item" for all sc7180 based
>>>   Chromebooks. Because of the revision matching scheme used by the
>>>   Chromebook bootloader, at times we need a different number of
>>>   revisions listed.
>>> - Some of the odd entries in here (like google,homestar-rev23 or the
>>>   fact that "Google Lazor Limozeen without Touchscreen" changed from
>>>   sku5 to sku6) are not typos but simply reflect reality.
>>> - Many revisions of boards here never actually went to consumers, but
>>>   they are still in use within various companies that were involved in
>>>   Chromebook development. Since Chromebooks are developed with an
>>>   "upstream first" methodology, having these revisions supported with
>>>   upstream Linux is important. Making it easy for Chromebooks to be
>>>   developed with an "upstream first" methodology is valuable to the
>>>   upstream community because it improves the quality of upstream and
>>>   gets Chromebooks supported with vanilla upstream faster.
>>>
>>> One other note here is that, though the bootloader effectively treats
>>> the list of compatibles in a given device tree as unordered, some
>>> people would prefer future boards to list higher-numbered revisions
>>> first in the list. Chromebooks here are not changing and typically
>>> list lower revisions first just to avoid churn.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>
>>> (no changes since v3)
>>>
>>> Changes in v3:
>>> - Split link to Chromebook boot doc into a separate patch.
>>> - Added a note to desc about revision ordering within a device tree.
>>>
>>> Changes in v2:
>>> - Add link to doc about how Chromebook devicetrees work.
>>> - Use a "description" instead of a comment for each item.
>>> - Use the marketing name instead of the code name where possible.
>>>
>>>  .../devicetree/bindings/arm/qcom.yaml         | 182 +++++++++++++++++-
>>>  1 file changed, 181 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index 5ac28e11ea7b..01e40ea40724 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -219,11 +219,191 @@ properties:
>>>                - qcom,ipq8074-hk10-c2
>>>            - const: qcom,ipq8074
>>>
>>> -      - items:
>>> +      - description: Qualcomm Technologies, Inc. SC7180 IDP
>>> +        items:
>>>            - enum:
>>>                - qcom,sc7180-idp
>>>            - const: qcom,sc7180
>>>
>>> +      - description: HP Chromebook x2 11c (rev1 - 2)
>>> +        items:
>>> +          - const: google,coachz-rev1
>>> +          - const: google,coachz-rev2
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: HP Chromebook x2 11c (newest rev)
>>> +        items:
>>> +          - const: google,coachz
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: HP Chromebook x2 11c with LTE (rev1 - 2)
>>> +        items:
>>> +          - const: google,coachz-rev1-sku0
>>> +          - const: google,coachz-rev2-sku0
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: HP Chromebook x2 11c with LTE (newest rev)
>>> +        items:
>>> +          - const: google,coachz-sku0
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Lenovo Chromebook Duet 5 13 (rev2)
>>> +        items:
>>> +          - const: google,homestar-rev2
>>> +          - const: google,homestar-rev23
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Lenovo Chromebook Duet 5 13 (rev3)
>>> +        items:
>>> +          - const: google,homestar-rev3
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Lenovo Chromebook Duet 5 13 (newest rev)
>>> +        items:
>>> +          - const: google,homestar
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 (rev0)
>>> +        items:
>>> +          - const: google,lazor-rev0
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 (rev1 - 2)
>>> +        items:
>>> +          - const: google,lazor-rev1
>>> +          - const: google,lazor-rev2
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 (rev3 - 8)
>>> +        items:
>>> +          - const: google,lazor-rev3
>>> +          - const: google,lazor-rev4
>>> +          - const: google,lazor-rev5
>>> +          - const: google,lazor-rev6
>>> +          - const: google,lazor-rev7
>>> +          - const: google,lazor-rev8
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 (newest rev)
>>> +        items:
>>> +          - const: google,lazor
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 with KB Backlight (rev1 - 2)
>>> +        items:
>>> +          - const: google,lazor-rev1-sku2
>>> +          - const: google,lazor-rev2-sku2
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 with KB Backlight (rev3 - 8)
>>> +        items:
>>> +          - const: google,lazor-rev3-sku2
>>> +          - const: google,lazor-rev4-sku2
>>> +          - const: google,lazor-rev5-sku2
>>> +          - const: google,lazor-rev6-sku2
>>> +          - const: google,lazor-rev7-sku2
>>> +          - const: google,lazor-rev8-sku2
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
>>> +        items:
>>> +          - const: google,lazor-sku2
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 with LTE (rev1 - 2)
>>> +        items:
>>> +          - const: google,lazor-rev1-sku0
>>> +          - const: google,lazor-rev2-sku0
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 with LTE (rev3 - 8)
>>> +        items:
>>> +          - const: google,lazor-rev3-sku0
>>> +          - const: google,lazor-rev4-sku0
>>> +          - const: google,lazor-rev5-sku0
>>> +          - const: google,lazor-rev6-sku0
>>> +          - const: google,lazor-rev7-sku0
>>> +          - const: google,lazor-rev8-sku0
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook Spin 513 with LTE (newest rev)
>>> +        items:
>>> +          - const: google,lazor-sku0
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 (rev4 - rev8)
>>> +        items:
>>> +          - const: google,lazor-rev4-sku4
>>> +          - const: google,lazor-rev5-sku4
>>> +          - const: google,lazor-rev6-sku4
>>> +          - const: google,lazor-rev7-sku4
>>> +          - const: google,lazor-rev8-sku4
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 (newest rev)
>>> +        items:
>>> +          - const: google,lazor-sku4
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 without Touchscreen (rev4)
>>> +        items:
>>> +          - const: google,lazor-rev4-sku5
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 without Touchscreen (rev5 - rev8)
>>> +        items:
>>> +          - const: google,lazor-rev5-sku5
>>> +          - const: google,lazor-rev5-sku6
>>> +          - const: google,lazor-rev6-sku6
>>> +          - const: google,lazor-rev7-sku6
>>> +          - const: google,lazor-rev8-sku6
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Acer Chromebook 511 without Touchscreen (newest rev)
>>> +        items:
>>> +          - const: google,lazor-sku6
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Sharp Dynabook Chromebook C1 (rev1)
>>> +        items:
>>> +          - const: google,pompom-rev1
>>> +          - const: qcom,sc7180
>>> +
>>> +      - description: Sharp Dynabook Chromebook C1 (rev2)
>>> +        items:
>>> +          - const: google,pompom-rev2
>>
>> I understand why you do not share "item" (your first notes) for some of
>> boards, but I don't get why "google,pompom-rev1" cannot be combined with
>> "google,pompom-rev2". Do you see any chances to alter the bindings for
>> these two boards?
>>
>> The same for other such cases (not newest revision).
> 
> Yeah, I thought about it when I was writing the file and decided
> against it. I guess it's just a style decision. If we combine these
> two then I guess it raises the question: do we only combine entries
> that list a single revision if they're the same board, or do we have
> one uber entry at the end of the list that combines all
> single-revision sc7180 Chromebooks? ...and in either case, what should
> the description be?
> 
> Personally, though it takes up more lines of code, I prefer the
> simplicity of having each entry here correspond to a single dts file.
> 
> Unless you feel really strongly about it, I'd tend to leave the
> decision here to Bjorn.

Sure. I would prefer to combine such obvious entries, so not everything
into one, but the same boards with revision/SKU difference.

For both cases:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



Best regards,
Krzysztof
