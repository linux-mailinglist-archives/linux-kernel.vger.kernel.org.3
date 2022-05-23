Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4EB53175E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbiEWQll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiEWQli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:41:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C5248FA;
        Mon, 23 May 2022 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653324096; x=1684860096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+Eqlq+Lez3z65syX1lv+ITX8fTEVdJaf1yC4Vp1bDE=;
  b=kpOJAVEcK2HV/2FyzDht75hIR0TtvcVB2ZFdFngzD2UQhQW/MGmfUy++
   TOPdo6keEp6t249jzGUDKDpFEMvxU8oiHLGxsDQUuYh8fQ+I/8M4oYAfC
   0v3fOpPLdLm7nQKBmAYw8NY0bqIllwGrLftOYkR9Xac5OkHdGhaz+If7c
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 09:41:35 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 09:41:35 -0700
Received: from [10.110.74.125] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 09:41:34 -0700
Message-ID: <196459ad-704d-020c-c485-842f613ae618@quicinc.com>
Date:   Mon, 23 May 2022 09:41:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Removal of qcom,board-id and qcom,msm-id
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <agross@kernel.org>, <arnd@arndb.de>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <olof@lixom.net>,
        <robh@kernel.org>, <sboyd@kernel.org>
References: <a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org>
 <20220522195138.35943-1-konrad.dybcio@somainline.org>
 <53d5999b-88ee-24db-fd08-ff9406e2b7b7@linaro.org>
 <02ab0276-b078-fe66-8596-fcec4378722b@somainline.org>
 <49a52870-9aab-c4bd-2077-66732f42bbba@linaro.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <49a52870-9aab-c4bd-2077-66732f42bbba@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On 5/23/2022 5:14 AM, Krzysztof Kozlowski wrote:
> On 23/05/2022 14:02, Konrad Dybcio wrote:
>>
>> On 23/05/2022 09:21, Krzysztof Kozlowski wrote:
>>> On 22/05/2022 21:51, Konrad Dybcio wrote:
>>>> Hi,
>>>>
>>>> removing these properties will not bring almost any benefit (other than making
>>>> some checks happy any saving some <200 LoC) and will make the lives of almost
>>>> all people doing independent development for linux-on-msm harder. There are
>>>> almost unironically like 3 people outside Linaro and QUIC who have
>>>> non-vendor-fused development boards AND the sources to rebuild the
>>>> bootloader on their own. Making it harder to boot is only going to
>>>> discourage people from developing on these devices, which is already not
>>>> that pleasant, especially with newer platforms where you have to fight with
>>>> the oh-so-bright ideas of Android boot chain..
>>>>
>>>> This only concerns devices released before sm8350, as the new ones will not
>>>> even boot with these properties present (or at least SONY Sagami, but I
>>>> doubt it's an isolated case), so other than completing support for older
>>>> devices, it won't be an issue going forward, anyway. But there are give
>>>> or take 50 locked down devices in mainline right now, and many more waiting
>>>> to be upstreamed in various downstream close-to-mainline trees that should
>>>> not be disregarded just because Qualcomm is far from the best at making
>>>> their BSP software stack clean.
>>> I actually wonder why do you need these properties for community work on
>>> such boards? You ship kernel with one concatenated DTB and the
>>> bootloader does not need the board-id/msm-id fields, doesn't it?
>>
>> If that were the case, I would have never complained about this! It's
>> the bootloader itself that needs it, you can see it in a "Best match
>> [blah blah] 258/0x1000/...." log line, where it walks through the
>> appended (or otherwise compiled into the boot.img) DTBs and looks for
>> matches for the burnt-in msm-, board- and (on newer-older platforms)
>> pmic-id. If it cannot find these, it refuses to boot with an Android
>> Verified Boot red state and you get a not-so-nice "Your device has been
>> unlocked and the boot image is not working" or something like this on
>> your screen.
>>
>>
>>>
>>> Not mentioning that in the past bootloader was actually not using these
>>> properties at all, because it was the dtbTool who was parsing them.
>>
>> Not sure when that was the case, maybe with very old arm32 bootloaders
>> in the times before I did development on Qualcomm devices.
>>
>>
>>>    So
>>> in any case either your device works fine without these properties or
>>> you have to use dtbTool, right?
>>
>> To the best of my idea, wrong :( Unless the vendor modified the LK/XBL
>> code on their own, it looks for a "best match" (but if it's not a
>> precise match, it won't even bother trying to boot, just fyi..), meaning
>> it tries to go through a list of SoC ID and revision pairs (msm-id),
>> board IDs (board-id) and PMIC id+rev pairs (pmic-id) and if no match is
>> found, it doesn't even exit the bootloader and says something like "no
>> dtbs found".
> 
> This would mean that dtbTool as described in the actual patch [1] is not
> used and bootloader ignores the table. If that's the case, the commit
> and requirement of such complex board-foundry-pmic-compatibles should be
> dropped. So I am getting now to what Dmitry said...
> 
> [1]
> https://lore.kernel.org/all/1448062280-15406-2-git-send-email-sboyd@codeaurora.org/


The link above is from 2015. Lot has changed downstream. Most of what 
was mentioned by Konrad is right. Application bootloader acts on picking 
on platform DTBO based on the platform ID plus some combinations like 
PMIC etc; These platform DTBOs gets overlay on top of SOC DTB by the 
Application bootloader.

We have moved to DTBO for all the latest targets, but I can understand 
that some old targets at upstream could be using the very old approaches.

Downstream all of the platforms including the DTBO files will need 
board-id and msm-id since we also do the compile time stitching of dtb + 
dtbo and dtbo + dtbo to generate the proper SOC DTB and PLATFORM DTBOs 
which gets flashed in the DTBO partition and follows the Android boot 
requirements. Application bootloader then picks the right Platform DTBO 
as mentioned above w/ the right SOC DTB. It gets more complicated w/ GKI 
new requirements every year (better for GKI, may not be better for 
upstream kernel + downstream bootloader combination).

---Trilok Soni


