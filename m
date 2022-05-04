Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4E519D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348415AbiEDKzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348365AbiEDKzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:55:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76A42655B;
        Wed,  4 May 2022 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651661537; x=1683197537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yaE0UXo00bqoLBw5jvLJF+P3poG7RKFAaSkpydqWat8=;
  b=ENL2NA3aEIRwxWpXG0jx2NqAqE18PxYxzgQ6WNX2GfG6pk/8iVosJ73l
   C0EuTzn9skdErqERjEwi4v5eZ36/Rh8QKZLaEjei32jR61A4bVDhovz23
   6vXIICefbcDRMyDivHmLriy3MJS1yb0x7LK5DSx5vkFTIYHe3r8bmMixq
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2022 03:52:16 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 03:52:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 03:52:15 -0700
Received: from [10.50.60.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 4 May 2022
 03:52:12 -0700
Message-ID: <e9f5cbd0-fef4-ae82-b543-536eccdeed5f@quicinc.com>
Date:   Wed, 4 May 2022 16:22:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] soc: qcom: socinfo: Add another ID for sc7180
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <matvore@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
 <13819b2d-26f0-14f4-9cb9-affb6b18f13d@quicinc.com>
 <CAD=FV=VBqbhB03uPtnzYdRHhU-4TnX6RgDpHK27RUXY84esebw@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAD=FV=VBqbhB03uPtnzYdRHhU-4TnX6RgDpHK27RUXY84esebw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/4/2022 9:00 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, May 3, 2022 at 7:14 PM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> Hi,
>>
>> On 5/3/2022 6:03 AM, Douglas Anderson wrote:
>>> It appears the some sc7180 devices, like the one in my
>>> sc7180-trogdor-homestar, report an ID of 407 instead of 425. Add
>>> another ID into the list.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>>    drivers/soc/qcom/socinfo.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
>>> index cee579a267a6..2ef1dc2a1dd3 100644
>>> --- a/drivers/soc/qcom/socinfo.c
>>> +++ b/drivers/soc/qcom/socinfo.c
>>> @@ -318,6 +318,7 @@ static const struct soc_id soc_id[] = {
>>>        { 396, "IPQ8071A" },
>>>        { 402, "IPQ6018" },
>>>        { 403, "IPQ6028" },
>>> +     { 407, "SC7180" },
>>>        { 421, "IPQ6000" },
>>>        { 422, "IPQ6010" },
>>>        { 425, "SC7180" },
>> Hmm, this ID maps to SM6250 which is a mobile variant. Not sure we should
>> use it for SC7180 which already has 425 ID assigned, perks of marketing :)
> That's super weird. Any idea why my strongbad reports 407 then? Is it
> a firmware bug, or someone misprogrammed something? What can we do to
> make the CPU recognized in strongbad?

Let me check with coretech folks as to why the ID is reused.

> ...and just for extra info, I believe strongbad actually has the
> slightly faster version of sc7180. It has a higher GPU/CPU speed. In
> some places I've heard it called sc7185, but in other places I've
> heard it called just sc7180 with a faster clock speed...

The only other variant of SC7180 I see in the document is SC7180P
which has 495 soc_id and is an APQ variant.

Thanks,
Sai
