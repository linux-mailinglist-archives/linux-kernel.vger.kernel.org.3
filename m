Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA84F493932
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353981AbiASLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:05:38 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:28692 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346901AbiASLFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642590336; x=1674126336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1RxvszT2LIQhUMoamuH7jeB/HW54e0Ijr5Mvuivp4N0=;
  b=tofEA4/AU3DIRSIdVs/VmNV3K/uUy42Lm52KMbbtjEql8W+bKRJuQb/a
   qaa6IeD8oPIr0j10lglS2icT5sm3lh1LhUCQavNg50WrdsifeQ8WtHIHh
   ntDT3elku1lu3KUl6VSusaypVu5cph0xnuSQzfrxpvKsfqdk/iwyGq8gV
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Jan 2022 03:05:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 03:05:34 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 19 Jan 2022 03:05:34 -0800
Received: from [10.216.49.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 19 Jan
 2022 03:05:28 -0800
Message-ID: <7514ff7f-9979-e308-486e-def51ca8e943@quicinc.com>
Date:   Wed, 19 Jan 2022 16:31:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: qcom,dwc3: Add multi-pd bindings
 for dwc3 qcom
Content-Language: en-US
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>
References: <1635152851-23660-1-git-send-email-quic_c_sanm@quicinc.com>
 <1635152851-23660-2-git-send-email-quic_c_sanm@quicinc.com>
 <YXcBK7zqny0s4gd4@ripper>
 <CAE-0n51k8TycXjEkH7rHYo0j7cYbKJOnOn1keVhx2yyTcBNnvg@mail.gmail.com>
 <YXck+xCJQBRGqTCw@ripper>
 <CAE-0n530M3eft-o0qB+yEzGjZgCLMgY==ZgdvwiVCwqqCAVxxA@mail.gmail.com>
 <YXdsYlLWnjopyMn/@ripper>
 <CAE-0n51C4dm6bhds=ZZyje-Pcejxjm4MMa3m-VHjFgq7GZGrLw@mail.gmail.com>
 <YXjbs3Bv6Y3d87EC@yoga>
 <CAPDyKFrWQdvZX4ukHZoGz73JPfQSgqVrG_4ShMp_GrxL0NKLvg@mail.gmail.com>
 <da877712-dac9-e9d0-0bfc-25bef450eb65@codeaurora.org>
 <0153c297-f648-25d1-7f0f-2114f07ef12b@quicinc.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <0153c297-f648-25d1-7f0f-2114f07ef12b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2022 11:33 AM, Sandeep Maheswaram wrote:
> Hi Rajendra,
> 
> On 10/28/2021 9:26 AM, Rajendra Nayak wrote:
>>
>>
>> On 10/27/2021 7:54 PM, Ulf Hansson wrote:
>>> On Wed, 27 Oct 2021 at 06:55, Bjorn Andersson
>>> <bjorn.andersson@linaro.org> wrote:
>>>>
>>>> On Tue 26 Oct 19:48 CDT 2021, Stephen Boyd wrote:
>>>>
>>>>> +Rajendra
>>>>>
>>>>> Quoting Bjorn Andersson (2021-10-25 19:48:02)
>>>>>> On Mon 25 Oct 15:41 PDT 2021, Stephen Boyd wrote:
>>>>>>
>>>>>>>
>>>>>>> When the binding was introduced I recall we punted on the parent child
>>>>>>> conversion stuff. One problem at a time. There's also the possibility
>>>>>>> for a power domain to be parented by multiple power domains so
>>>>>>> translation tables need to account for that.
>>>>>>>
>>>>>>
>>>>>> But for this case - and below display case - the subdomain (the device's
>>>>>> power-domain) is just a dumb gate. So there is no translation, the given
>>>>>> performance_state applies to the parent. Or perhaps such implicitness
>>>>>> will come back and bite us?
>>>>>
>>>>> In the gate case I don't see how the implicitness will ever be a
>>>>> problem.
>>>>>
>>>>>>
>>>>>> I don't think we allow a power-domain to be a subdomain of two
>>>>>> power-domains - and again it's not applicable to USB or display afaict.
>>>>>
>>>>> Ah maybe. I always confuse power domains and genpd.
>>>>>
>>>>>>
>>>>>>>>
>>>>>>>>> Or we may need to make another part of the OPP binding to indicate the
>>>>>>>>> relationship between the power domain and the OPP and the parent of
>>>>>>>>> the power domain.
>>>>>>>>
>>>>>>>> I suspect this would be useful if a power-domain provider needs to
>>>>>>>> translate a performance_state into a different supply-performance_state.
>>>>>>>> Not sure if we have such case currently; these examples are all an
>>>>>>>> adjustable power-domain with "gating" subdomains.
>>>>>>>
>>>>>>> Even for this case, we should be able to have the GDSC map the on state
>>>>>>> to some performance state in the parent domain. Maybe we need to add
>>>>>>> some code to the gdsc.c file to set a performance state on the parent
>>>>>>> domain when it is turned on. I'm not sure where the value for that perf
>>>>>>> state comes from. I guess we can hardcode it in the driver for now and
>>>>>>> if it needs to be multiple values based on the clk frequency we can push
>>>>>>> it out to an OPP table or something like that.
>>>>>>>
>>>>>>
>>>>>> For the GDSC I believe we only have 1:1 mapping, so implementing
>>>>>> set_performance_state to just pass that on to the parent might do the
>>>>>> trick (although I haven't thought this through).
>>>>>>
>>>>>> Conceptually I guess this would be like calling clk_set_rate() on a
>>>>>> clock gate, relying on it being propagated upwards. The problem here is
>>>>>> that the performance_state is just a "random" integer without a well
>>>>>> defined unit.
>>>>>>
>>>>>
>>>>> Right. Ideally it would be in the core code somehow so that if there
>>>>> isn't a set_performance_state function we go to the parent or some
>>>>> special return value from the function says "call it on my parent". The
>>>>> translation scheme could come later so we can translate the "random"
>>>>> integer between parent-child domains.
>>>>
>>>> As a proof of concept it should be sufficient to just add an
>>>> implementation of sc->pd.set_performance_state in gdsc.c. But I agree
>>>> that it would be nice to push this into some framework code, perhaps
>>>> made opt-in by some GENPD_FLAG_xyz.
>>>>
>>>>> At the end of the day the device
>>>>> driver wants to set a frequency or runtime pm get the device and let the
>>>>> OPP table or power domain code figure out what the level is supposed to
>>>>> be.
>>>>>
>>>>
>>>> Yes and this is already working for the non-nested case - where the
>>>> single power-domain jumps between performance states as the opp code
>>>> switches from one opp to another.
>>>>
>>>> So if we can list only the child power-domain (i.e. the GDSC) and have
>>>> the performance_stat requests propagate up to the parent rpmhpd resource
>>>> I think we're good.
>>>>
>>>>
>>>> Let's give this a spin and confirm that this is the case...
>>>>
>>>>>>
>>>>>>
>>>>>> The one case where I believe we talked about having different mapping
>>>>>> between the performance_state levels was in the relationship between CX
>>>>>> and MX. But I don't think we ever did anything about that...
>>>>>
>>>>> Hmm alright. I think there's a constraint but otherwise nobody really
>>>>> wants to change both at the same time.
>>>>>
>>>>>>>
>>>>>>> Yes, a GDSC is really a gate on a parent power domain like CX or MMCX,
>>>>>>> etc. Is the display subsystem an example of different clk frequencies
>>>>>>> wanting to change the perf state of CX? If so it's a good place to work
>>>>>>> out the translation scheme for devices that aren't listing the CX power
>>>>>>> domain in DT.
>>>>>>
>>>>>> Yes, the various display components sits in MDSS_GDSC but the opp-tables
>>>>>> needs to change the performance_state of MDSS_GDSC->parent (i.e. CX or
>>>>>> MMCX, depending on platform).
>>>>>>
>>>>>> As I said, today we hack this by trusting that the base drm/msm driver
>>>>>> will keep MDSS_GDSC on and listing MMCX (or CX) as power-domain for each
>>>>>> of these components.
>>>>>>
>>>>>>
>>>>>> So if we solve this, then that seems to directly map to the static case
>>>>>> for USB as well.
>>>>>>
>>>>>
>>>>> Got it. So in this case we could have the various display components
>>>>> that are in the mdss gdsc domain set their frequency via OPP and then
>>>>> have that translate to a level in CX or MMCX. How do we parent the power
>>>>> domains outside of DT? I'm thinking that we'll need to do that if MMCX
>>>>> is parented by CX or something like that and the drivers for those two
>>>>> power domains are different. Is it basic string matching?
>>>>
>>>> In one way or another we need to invoke pm_genpd_add_subdomain() to link
>>>> the two power-domains (actually genpds) together, like what was done in
>>>> 3652265514f5 ("clk: qcom: gdsc: enable optional power domain support").
>>>>
>>>> In the case of MMCX and CX, my impression of the documentation is that
>>>> they are independent - but if we need to express that CX is parent of
>>>> MMCX, they are both provided by rpmhpd which already supports this by
>>>> just specifying .parent on mmcx to point to cx.
>>>
>>> I was trying to follow the discussion, but it turned out to be a bit
>>> complicated to catch up and answer all things. In any case, let me
>>> just add a few overall comments, perhaps that can help to move things
>>> forward.
>>>
>>> First, one domain can have two parent domains. Both from DT and from
>>> genpd point of view, just to make this clear.
>>>
>>> Although, it certainly looks questionable to me, to hook up the USB
>>> device to two separate power domains, one to control power and one to
>>> control performance. Especially, if it's really the same piece of HW
>>> that is managing both things. 
>> []..
>>> Additionally, if it's correct to model
>>> the USB GDSC power domain as a child to the CX power domain from HW
>>> point of view, we should likely do that.
>>
>> I think this would still require a few things in genpd, since
>> CX and USB GDSC are power domains from different providers.
>> Perhaps a pm_genpd_add_subdomain_by_name()?
>>
> Tried with the changes provided by you  where USB GDSC power domains added as a child to the CX power domain
> 
> But cx shutdown is not happening  during sytem suspend as we need to keep USB GDSC active in host mode .

In the USB driver suspend when you check for this condition, in order to keep the GDSC active, you would
perhaps have to drop the performance state vote and re-vote in resume.
I don;t think the genpd core can handle this in any way.

> 
> Regards
> 
> Sandeep
> 
> 
> 
