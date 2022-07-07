Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8256A1F0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiGGM2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiGGM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:28:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23610B3;
        Thu,  7 Jul 2022 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657196907; x=1688732907;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q87SZE8+NdzcCfnZaIbxgUmnbzqOub15OviL30vFxQQ=;
  b=Rk1lLfNircUIguFNbDea9c3RpQ/Dowmz+ngyqvQHdKmbThvi+te4Kn3v
   NImsAFtDvROgnRDx1qB98TzPe+pDi3pM22qdTcfO6an5HG3fNJNUhzjtQ
   Y6FVt37NV6RZals/YYz75WvAmLCD59mpSR9QId2p5I+AXkhHfC+uPpm8k
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Jul 2022 05:28:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 05:28:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 05:28:26 -0700
Received: from [10.216.56.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Jul 2022
 05:28:22 -0700
Message-ID: <e8811c9b-f826-2810-ee9e-df86250fd4cc@quicinc.com>
Date:   Thu, 7 Jul 2022 17:58:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Move wcd specific pin conf to
 common file
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <1657102611-20067-1-git-send-email-quic_srivasam@quicinc.com>
 <CAD=FV=UaUnZfWsXGQx6PoVQ5qqtsq10Dnui1v0Xn0S5Y-YgwRw@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAD=FV=UaUnZfWsXGQx6PoVQ5qqtsq10Dnui1v0Xn0S5Y-YgwRw@mail.gmail.com>
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


On 7/7/2022 2:13 AM, Doug Anderson wrote:
Thanks for your time Doug!!!
> Hi,
>
> On Wed, Jul 6, 2022 at 3:17 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>> +/* PINCTRL - BOARD-SPECIFIC */
> It's not really "board specific" since this is actually a file that's
> included by multiple boards.
Okay. Will update accordingly.
>
> Maybe just use the header "PINCTRL" for now. Everything here is just
> adding pull/drive strength/slew-rate info to existing pinctrl
> settings. If we ever have more than that and want to separate into
> different sections we can always adjust later.
>
>
>> +/*
>> + * Methodology for gpio-line-names:
>> + * - If a pin goes to CRD board and is named it gets that name.
>> + * - If a pin goes to CRD board and is not named, it gets no name.
>> + * - If a pin is totally internal to Qcard then it gets Qcard name.
>> + * - If a pin is not hooked up on Qcard, it gets no name.
>> + */
> This file doesn't include "gpio-line-names" so you don't need to
> include documentation about it.
Okay. Will remove it.
>
> -Doug
