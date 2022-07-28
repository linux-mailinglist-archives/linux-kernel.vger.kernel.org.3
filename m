Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC335843CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiG1QKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiG1QKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:10:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8CCD;
        Thu, 28 Jul 2022 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659024606; x=1690560606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X9/vv1OubhiRjvTagiSFmkEub0PKOyPJQmKKSarsRW0=;
  b=OnVB1ttLWNXi/CcYLZ9o9y4qyXBLrvgPzkHNHX5T7g/A1jG2JSTNsvyT
   VPK/gAuGIG9bsjV4K1n/tB174iUS8bBOL8mJMhyAQSUGmIIezxYt0BExe
   jTpphGLRepwdy3vLcegVlYOj0OQAgba9Ntfy1DIsfAPYKgkQF720SG8iq
   M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jul 2022 09:10:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 09:10:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Jul 2022 09:10:05 -0700
Received: from [10.216.19.102] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Jul
 2022 09:09:58 -0700
Message-ID: <a92891b1-1fd0-82fa-3dc4-34282e6c2ef3@quicinc.com>
Date:   Thu, 28 Jul 2022 21:39:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: qcom: SC7280: Add support for external DMIC bias
 supply
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1659016789-9933-1-git-send-email-quic_srivasam@quicinc.com>
 <YuKbpXVOeGn2l2gd@sirena.org.uk>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YuKbpXVOeGn2l2gd@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/28/2022 7:52 PM, Mark Brown wrote:
Thanks for your time Mark!!!
> On Thu, Jul 28, 2022 at 07:29:49PM +0530, Srinivasa Rao Mandadapu wrote:
>> Update SC7280 machine driver for enabling external dmic bias supply,
>> which is required for villager evt boards.
>> +++ b/sound/soc/qcom/sc7280.c
>> @@ -356,6 +356,7 @@ static const struct snd_soc_ops sc7280_ops = {
>>   static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
>>   	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>>   	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>> +	SND_SOC_DAPM_REGULATOR_SUPPLY("DMICVDD", 0, 0),
>>   };
>>   
>>   static int sc7280_snd_platform_probe(struct platform_device *pdev)
> Don't you want to connect this to something?  This won't do anything
> as-is.  I can't see any references to DMICVDD which might be failing to
> resolve in the current sound/soc/qcom.

The connection is being done to "VA DMIC"through audio routing in board 
specific dts file.

Will post the changes once the main dts patches are landed.

Ex:-

&sound {
     DMICVDD-supply = <&pp1800_l2c>;

     audio-routing =
             "IN1_HPHL", "HPHL_OUT",
             "IN2_HPHR", "HPHR_OUT",
             "AMIC1", "MIC BIAS1",
             "AMIC2", "MIC BIAS2",
             "VA DMIC0", "DMICVDD",
             "VA DMIC1", "DMICVDD",
             "VA DMIC2", "DMICVDD",
             "VA DMIC3", "DMICVDD",
             .....

             .....

};


