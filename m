Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307EC501C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbiDNUDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346007AbiDNUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:03:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03133DCA9D;
        Thu, 14 Apr 2022 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649966467; x=1681502467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6SG+3CsiHlJbOSDbfGJomT4dBWShXsbA04zZqqH4KoU=;
  b=Lls5U6Vf5k/0/Bq8DOUZGsrpgXQKiuDw3YBGoXXbf3qNz7K9zkeSXFSw
   gmBaBfChQaKT1K04x7zNPPkJsE7nlL/lzqa2Q+idPQqnZmKYaWX3iNIoL
   ie+9gl1m5v8/3Ey4lhk2/qZ2S2X/cdbER750gFw92+DcuF0sOfI084cTe
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Apr 2022 13:01:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:01:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 13:01:04 -0700
Received: from [10.111.169.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 13:01:01 -0700
Message-ID: <e3154f3b-aea4-6961-b409-6b20ff8bf18e@quicinc.com>
Date:   Thu, 14 Apr 2022 13:00:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH v7 0/4] Add support for the eDP panel over
 aux_bus
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
CC:     quic_kalyant <quic_kalyant@quicinc.com>,
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        "Steev Klimaszewski" <steev@kali.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Aravind Venkateswaran" <quic_aravindh@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=Ui6BAsnTaJ2_TMh1Tnjtaw7FR92aWoUysS+UT=c0qB3Q@mail.gmail.com>
 <20afcd97-4b8d-f770-151a-268b893b7c5a@linaro.org>
 <CAE-0n51fc-b-8VF7XP29=o8Xi86HQALGB-1u8n3b_3NjVyyJYw@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAE-0n51fc-b-8VF7XP29=o8Xi86HQALGB-1u8n3b_3NjVyyJYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On 4/14/2022 12:43 PM, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2022-04-14 12:20:31)
>> On 14/04/2022 19:40, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Apr 14, 2022 at 5:19 AM Sankeerth Billakanti
>>> <quic_sbillaka@quicinc.com> wrote:
>>>>
>>>> This series adds support for generic eDP panel over aux_bus.
>>>>
>>>> These changes are dependent on the following series:
>>>> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=613654&state=*
>>>
>>> You're basically depending on the last two patches of that series.
>>> What's the plan there? In patchwork they're marked as "Not
>>> Applicable". If they're good to go, maybe we should land them? If not,
>>> maybe you should include them (with Dmitry as the author, of course)
>>> at the beginning of your series?
>>
>> No, please do not resend patches. The patches in question are marked as
>> 'Not applicable' as they are really not applicable to Bjorn's tree.
>> It would be better to point to the correct patchwork:
>>
>> https://patchwork.freedesktop.org/series/98585/
>>
>> Note those patches still lack the R-B tag. I can include them anyway,
>> basing on Sankeerth's Tested-by tag, but the formal R-B would also be good.
>>
> 
> Can you resend those as not RFC?

Yes, please resend these, I can ack them.

Previously I held off my ack, as kuogee ran into some issues testing 
them which was later concluded to be a mismatch in QC internal trees due 
to different versions of the changes.( another reason why we should get 
these landed ).

Now, that Sankeerth has tested these, if you can remove RFC and post 
them, I can ack the.

Thanks

Abhinav
