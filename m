Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87F4E37DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiCVER7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiCVERx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:17:53 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C327CE0;
        Mon, 21 Mar 2022 21:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647922587; x=1679458587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kO25VhGwe8ryd6btk/aw5kwTyNNr5HaJdMK800Ut7Vk=;
  b=emzJqon/rnjomDGxfkoA13pMwAyiX8dSsOGkCFAI1IS9QWmBAgTZD3Kp
   YNAQ6aqsaHzeyXGyMh9wFuYp0AU27Zd0fgGK8UxNwlGSe+hs0m+G0bXBh
   qkD8sbrqhk+wrcfn8tBC7cTEYokFjenWB05p/oE5M0VxNmbAbhaLFJ7If
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 21:16:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 21:16:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 21:16:26 -0700
Received: from [10.216.35.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 21 Mar
 2022 21:16:22 -0700
Message-ID: <5977f8f4-f05c-3608-93e3-0a8aeaaad4bf@quicinc.com>
Date:   Tue, 22 Mar 2022 09:46:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: sc7280: Add 'piglin' to the
 crd-r3 compatible strings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
 <c808dc08-09c8-bb08-6656-18dd649af036@quicinc.com>
 <YjiWXA40Nh0jBPO9@google.com>
 <CAD=FV=WQFbsFQdnUsroCdgKaHfZEyDTdRmvuEaY_ymuBrDt76w@mail.gmail.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <CAD=FV=WQFbsFQdnUsroCdgKaHfZEyDTdRmvuEaY_ymuBrDt76w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/2022 11:30 PM, Doug Anderson wrote:
> "Hi,
> 
> On Mon, Mar 21, 2022 at 8:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>>
>> On Mon, Mar 21, 2022 at 11:14:56AM +0530, Rajendra Nayak wrote:
>>>
>>> On 3/17/2022 5:58 AM, Matthias Kaehlcke wrote:
>>>> With newer bootloader versions the crd-r3 (aka CRD 1.0 and 2.0) is
>>>> identified as a 'piglin' board (like the IDP2 board), instead of 'hoglin'
>>>> Add the compatible strings 'google,piglin-rev{3,4}'. The hoglin entries
>>>> are kept to make sure the board keeps booting with older bootloader
>>>> versions.
>>>
>>> The older bootloaders really look for the google,hoglin-rev3/google,hoglin-rev4
>>> compatibles or just google,hoglin? If its just google,hoglin, won;t it pick the
>>> crd-rev5+ dtb now?
>>
>> They look for the -revN compatible, I confirmed that on my CRD 2.0.
> 
> Thanks for confirming Matthias! I'll also note that, in general, these
> "google,board-revX" type compatible strings are all programmatically
> generated. You can see at:
> 
> https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/main/src/boot/fit.c#70
> 
> ...and whenever it's using this normal logic then it has a standard
> fallback mechanism in place. On a random board in front of me
> depthcharge prints out:
> 
> Compat preference: google,lazor-rev3-sku0 google,lazor-rev3
> google,lazor-sku0 google,lazor
> 
> So it'll first try the very specific verison with rev and sku. Then
> just by rev. Then just by sku. ...and if none of those match it'll
> pick a device tree that has neither. The "newest" device tree always
> has no revision number specified and that way if software doesn't
> change but the revision bumps then we have no problem. We only add the
> revision info for old boards.

Thanks Matthias/Doug for the clarification,

Reviewed-by: Rajendra Nayak <quic_rjendra@quicinc.com>

> 
> There are a few cases where we add special compatible strings and
> these don't match on board/rev. This is fairly uncommon, though. You
> might be aware of the special case of adding "qcom,sc7180-idp"
> (without rev/sku matching) for "bubs". See:
> 
> https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/main/src/board/trogdor/board.c#136
> 
> 
> -Doug
