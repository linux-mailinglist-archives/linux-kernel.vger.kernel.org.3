Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDEC548950
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357814AbiFMMAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357841AbiFMLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:55:33 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E332F67A;
        Mon, 13 Jun 2022 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655117761; x=1686653761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vbuPPm2ZNkUse/X0oH12l21pmvWvlzFHAvFZQz0hTnA=;
  b=mJ4H9cbcCxO+Uu9n74cyqMWQoGiDQ1+IMUtnAGj52zfZavn1sQnbr1DZ
   oydIm9mRfuGDQvwld//R2pk6AgJqJI5IZ0BR1fAOrdyQcgofyRy6EyrD0
   CCt0EV0SbVYFk+SatrX7DALZPtpoNoDPedi+S/iW2UX4EJqYYx0gF90V7
   4=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jun 2022 03:56:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:56:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 03:56:00 -0700
Received: from [10.216.14.138] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 03:55:54 -0700
Message-ID: <23bb9f5d-85fe-d7a7-d178-1185981f1b89@quicinc.com>
Date:   Mon, 13 Jun 2022 16:25:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: lpass-cpu: Update external mclck0
 name
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <quic_plai@quicinc.com>,
        <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1654169206-12255-1-git-send-email-quic_srivasam@quicinc.com>
 <1654169206-12255-2-git-send-email-quic_srivasam@quicinc.com>
 <20220602143245.GA2256965-robh@kernel.org> <YpjL3X73LyefYjI7@sirena.org.uk>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YpjL3X73LyefYjI7@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/2/2022 8:10 PM, Mark Brown wrote:
Thanks for your time Mark Brown and Rob Herring!!!
> On Thu, Jun 02, 2022 at 09:32:45AM -0500, Rob Herring wrote:
>> On Thu, Jun 02, 2022 at 04:56:45PM +0530, Srinivasa Rao Mandadapu wrote:
>>> Update "audio_cc_ext_mclk0" name to "core_cc_ext_mclk0",
>>> as MI2S mclk is being used is from lpass core cc.
>> This is safe to change breaking the ABI because ...
> The driver was only just merged so didn't make it into a full
> release.
yes. DTS changes are still in review state.
>
>> Names are supposed to be local to the module, not based on their source.
> Indeed.

Okay. Will take care next time. As external MCLK is supported from both 
modules, audio cc and core cc,

for now it's mandatory to change the name to avoid confusion.

