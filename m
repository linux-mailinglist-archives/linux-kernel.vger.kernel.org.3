Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0244BCA55
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbiBSS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:57:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiBSS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:57:13 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439C488BE;
        Sat, 19 Feb 2022 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645297013; x=1676833013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OEri4uDqfVq3Sq55bw1JpjblsjiHhv7blHvy92mJyQM=;
  b=kWTI+FBMYB1yp11DnYtcBWgtIFFCEOYbhKYsMKgOPBzz5pWJ8sRbS9Xb
   uSx7qW640h5vwXw7ZibsDTLmZyyaIFmvJabVOsq3sIg+dQcKVJsdZiw9Z
   Svsu4IOYmlYldLI6bjnTE8+cYv3GrQ0KiaozT/SSqGVlL0hRa3qkCPPsX
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Feb 2022 10:56:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 10:56:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 19 Feb 2022 10:56:52 -0800
Received: from [10.216.20.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 19 Feb
 2022 10:56:45 -0800
Message-ID: <e279b9ec-92af-1b86-9ea0-09c9c36e1404@quicinc.com>
Date:   Sun, 20 Feb 2022 00:26:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RESEND v13 08/10] ASoC: qcom: Add lpass CPU driver for codec dma
 control
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
 <1644850708-11099-9-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52jD_BvQm4CeTkiR723-3uKC9G4fFeynFbs5Ukg_S762g@mail.gmail.com>
 <d70291a6-7e3f-0406-2826-3a30f2d5650b@quicinc.com>
 <CAE-0n51zr2qZ4qSzsC4=3d_jCYGvSxh8_3znrEQFaNrGfRU2Gw@mail.gmail.com>
From:   "Srinivasa Rao Mandadapu (Temp)" <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n51zr2qZ4qSzsC4=3d_jCYGvSxh8_3znrEQFaNrGfRU2Gw@mail.gmail.com>
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


On 2/18/2022 1:23 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-16 01:42:42)
>> On 2/15/2022 7:03 AM, Stephen Boyd wrote:
>> Thanks for your time Stephen!!!
>>> Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:26)
>>>> +       struct snd_soc_pcm_runtime *soc_runtime = asoc_substream_to_rtd(substream);
>>>> +       struct lpaif_dmactl *dmactl;
>>>> +       int ret = 0, id;
>>>> +
>>>> +       switch (cmd) {
>>>> +       case SNDRV_PCM_TRIGGER_START:
>>>> +       case SNDRV_PCM_TRIGGER_RESUME:
>>>> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>>> +               __lpass_platform_codec_intf_init(dai, substream);
>>>> +               break;
>>>> +       case SNDRV_PCM_TRIGGER_STOP:
>>>> +       case SNDRV_PCM_TRIGGER_SUSPEND:
>>>> +       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>>> +               __lpass_get_dmactl_handle(substream, dai, &dmactl, &id);
>>>> +               if (!dmactl) {
>>>> +                       dev_err(soc_runtime->dev, "failed to get dmactl handle\n");
>>> This same message is in many places. I really hope it never gets printed
>>> because finding out which line it got printed at is going to be
>>> impossible.
>> Okay. Will add function name in each print.
> Are they useful prints at all? They seem like development prints that
> won't trigger after the driver is developed. Why can't we just remove
> them?
Okay. Will remove prints.
