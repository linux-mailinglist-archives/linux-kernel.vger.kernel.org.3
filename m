Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6B652A8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351335AbiEQRIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbiEQRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:08:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D44161B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:08:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq30so32472496lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+A/gqNgFRPEMJXVCfWemyO0vB3lRR0Hdpr7+C1w217k=;
        b=KuYH9SfPm08o4zERjiaMVqprd20S354P0BHLOcpenPkSkL9RTHJzEvdAonyWDqEOcY
         K5ojBvTLJlLKWm9NijAzwmd7DPHPsm/tEOssDFMCmBnBK+/aYV1W3Lb8QCC2xF2zxyqY
         +dNzkoaJSy0G8ddWacS4h+4b1gzr7yHU7BPNfSziVFyy6xaeRM+yV/FT7BNBMNSuh4N1
         Jrp7KdZS7w8213reU/sq75o2O169QjfQ4l4Fy6xOclcFW8lvSD+lM5LdOBk81vLTyG3o
         HUVkZEPH83yLnkYC+uJZATVC4QVLEv1TyLOarqlGSt36LU8V3tSbNvhVTIpuztAhTlIL
         wBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+A/gqNgFRPEMJXVCfWemyO0vB3lRR0Hdpr7+C1w217k=;
        b=D9qXPW35xFvflgU/HdkanIOmdia64E7zE6pPM3AUYg+ikSt08YrhZQ1jSLYpl7LRaW
         yG7SKVRMubXq4b3v2aIroRp1eo/BT4zT4mBVH+IUZ24pJzdxWO1/VmyjI9RODepD0/Uv
         JRMR/l3EjXh5HOOEN5fmiPBVtbL846q4rDr77kbC7IxIHSUMwGCYfn7g3hJV4gPt8Z+6
         SgLxDo9sURV8a/0ffhz6p4XLXj/Hg6MRvtT/mEE7CJ3OsMF8IvwJJF40kkGPzCO8epMV
         3To2U1GazUOO3MpyfbPjWe+F1KVPxaYLrGGEhPhLhEDOjy0boLepZ3TyAUdlEXLFr/qm
         sluA==
X-Gm-Message-State: AOAM533nAyDFF3bQhN+eD6WibBTlDN1hDPEd7CuLrBUrPv214A83PJJB
        vYEPlSBhKj8W5M5rYuHrAn9gDA==
X-Google-Smtp-Source: ABdhPJyTAaGcL35nGkVaSYQS4H7pcZ+EyaR+FCeKkh/hhqsUd3BG4KFAUQ5g6KvqZn3Dej0hS0ku2Q==
X-Received: by 2002:a05:6512:258d:b0:477:a2a3:53ba with SMTP id bf13-20020a056512258d00b00477a2a353bamr3132854lfb.468.1652807304185;
        Tue, 17 May 2022 10:08:24 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v2-20020ac258e2000000b0047255d211c0sm8573lfo.239.2022.05.17.10.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 10:08:23 -0700 (PDT)
Message-ID: <5efdd020-3665-810c-f62d-ed3771757ada@linaro.org>
Date:   Tue, 17 May 2022 19:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 00/13] dt-bindings/arm64: dts: qcom: minor cleanups with
 DT schema
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, arm-soc <soc@kernel.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdVc3kShpp8wieX1SSA8-37m8PbxpqKRs5+gxz8Dm6QwsA@mail.gmail.com>
 <3bdb65cd-cdad-6e10-c921-5ec3a9b4c9dd@linaro.org>
 <YoNxoUwjJIxyAi3l@kroah.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YoNxoUwjJIxyAi3l@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 11:57, Greg Kroah-Hartman wrote:
> On Tue, May 17, 2022 at 11:27:39AM +0200, Krzysztof Kozlowski wrote:
>> On 17/05/2022 11:19, Geert Uytterhoeven wrote:
>>> On Wed, May 4, 2022 at 5:13 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>> The patches are independent, so they can be picked up as is (or everything
>>>> through Qualcomm SoC tree).
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>> Krzysztof Kozlowski (13):
>>>>   dt-bindings: soc: qcom: aoss: document qcom,sm8450-aoss-qmp
>>>>   dt-bindings: soc: qcom: qcom,smd-rpm: add power-controller
>>>>   dt-bindings: usb: qcom,dwc3: add IPQ8074, MSM8994, QCS404 and SM6125
>>>>   dt-bindings: usb: qcom,dwc3: fix clock matching
>>>>   arm64: dts: qcom: add missing AOSS QMP compatible fallback
>>>>   arm64: dts: qcom: correct DWC3 node names and unit addresses
>>>>   arm64: dts: qcom: ipq8074: add dedicated qcom,ipq8074-dwc3 compatible
>>>>   arm64: dts: qcom: msm8994: add dedicated qcom,msm8994-dwc3 compatible
>>>>   arm64: dts: qcom: sm6125: add dedicated qcom,sm6125-dwc3 compatible
>>>>   arm64: dts: qcom: qcs404: add dedicated qcom,qcs404-dwc3 compatible
>>>>   arm64: dts: qcom: msm8996: add clock-names to DWC3 USB node
>>>>   arm64: dts: qcom: align DWC3 USB clocks with DT schema
>>>>   arm64: dts: qcom: align DWC3 USB interrupts with DT schema
>>>
>>> Looks like all but the first two were applied to usb-next by Greg,
>>> causing conflicts with the soc/for-next tree.
>>
>> Also this one was not applied:
>> arm64: dts: qcom: add missing AOSS QMP compatible fallback
>>
>> However I did not get any conflict message...
>>
>> The DTS patches should not go via Greg's tree. They are sent together so
>> there will be no warnings from Rob's bot. This is a common practice for
>> dt-binding fixes.
>>
>> Bjorn,
>> Any preference from you? Shall I send missing three patches to you?
>>
>> What about conflicts with Greg's tree?
> 
> If I need to revert anything from my tree, please let me know.  Trying
> to figure out who should, and should not, take patches like this is
> driving me crazy...

Sorry for the confusion Greg. I marked preferred merging strategy in the
cover letter. I am trying to sort it out with Bjorn. The conflict will
hit later Linus and it is auto-solvable with decent mergetool, but for a
human's eye it is a confusing diff.

Some more background:
Patches marked with "dts" prefix should always go via respective arm-soc
maintainer, not only to reduce conflicts, but also to keep hardware
description (Devicetree sources, DTS) separate from implementation.
Otherwise some folks like to combine ABI-breaking changes in drivers
together with DTS patches, so from the kernel perspective it looks like
there is no ABI breakage. But there is, just not directly visible.
Therefore arm-soc folks always insist on having DTS changes in separate
branches, so this split driver-DTS is clear.

Best regards,
Krzysztof
