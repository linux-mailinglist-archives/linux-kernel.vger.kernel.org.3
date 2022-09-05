Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD55ACB1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiIEGjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbiIEGit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:38:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A61015FD8;
        Sun,  4 Sep 2022 23:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E69B80DB1;
        Mon,  5 Sep 2022 06:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666E6C433C1;
        Mon,  5 Sep 2022 06:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662359925;
        bh=NqZwIj46vXr4s//mDVV/ciUn69Yvh/KE5CISeCFM5ks=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ihr1u16qRVH5F+j2hB+CMzxB2yvZ0U86q9bkzFykb5/sdO9B1sYqzxi3y7TXivmRS
         LB102+prlM8QakJTQiUg4jcl47736cVFz/QyWzL0usI0xhRxToGscoTbasRxg5YDOP
         m2GeuhK8CYm7un6bnYQ8eh++RSRtG6rrwOYtR6jcb0qyP8u6e1mCintSke6J1umrfc
         6Uz2O6JEU93hGOOpiON2EM7TeVxNnoXPtxolrA6PgjMMJSSWvNJgGFBp8/hQtQf/Rn
         F8VlkKt9p9a8uKmTjkmrlFzuV1GleK6t/Mq93+eumxjC/kBTh25LT8aeEd2JuvSIIt
         Mq001ooFQMMyQ==
Message-ID: <6b845257-e8e5-92e4-8cf1-f3e394cbc59e@kernel.org>
Date:   Mon, 5 Sep 2022 09:38:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: Remove reg entry for
 pmc8280c_lpg node
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20220903084440.1509562-1-bhupesh.sharma@linaro.org>
 <42790a40-458a-55ff-7e4b-796e72f474ac@kernel.org>
 <66eaf16e-cb7c-a0b4-9ce5-02611308b0e6@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <66eaf16e-cb7c-a0b4-9ce5-02611308b0e6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 08:47, Bhupesh Sharma wrote:
> Hi Krzysztof,
> 
> On 9/5/22 12:52 AM, Krzysztof Kozlowski wrote:
>> On 03/09/2022 11:44, Bhupesh Sharma wrote:
>>> Commit eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
>>> dropped PWM reg declaration for pm8350c pwm(s), but there is a leftover
>>> 'reg' entry inside the lpg/pwm node in sc8280xp dts file. Remove the same.
>>>
>>> While at it, also remove the unused unit address in the node
>>> label.
>>>
>>> Fixes: eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>> index ae90b97aecb8..2e5cf55afdd5 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
>>> @@ -60,9 +60,8 @@ pmc8280c_gpios: gpio@8800 {
>>>   			#interrupt-cells = <2>;
>>>   		};
>>>   
>>> -		pmc8280c_lpg: lpg@e800 {
>>> +		pmc8280c_lpg: lpg {
>>
>> I wonder why I did not see the errors when testing all DTSes for
>> https://lore.kernel.org/all/20220828084341.112146-9-krzysztof.kozlowski@linaro.org/
> 
> I did not see the error while running the 'make dtbs_check' locally, so 
> may be something to improve in 'make dtbs_check' infrastructure there.
> 
>> Anyway, it cannot be lpg - binding requires "pwm".
> 
> I think that should be a separate patch. It does not seem related to 
> this change anyways - which fixes eeca7d46217c . I will send a v2 soon.

You would be changing same line twice and eeca7d46217c is not going to
be backported, so I am no sure if there is benefit to make two patches.


Best regards,
Krzysztof
