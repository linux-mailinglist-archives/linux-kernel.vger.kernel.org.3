Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853A53A5A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352968AbiFANGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbiFANGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:06:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D22DE7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:06:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso3026430wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=y7AFvgnHqwWsOFhTmk4i/DwYzcjtYaWfhp+4Z6qHobU=;
        b=E637gfrRTkd2Xn1qbN2xOc9CfyQozzgeVso68I9JFpeOLf+kFLouA3I8IQET/AsKlb
         Y1dDEG86g6pP4Wv54CJhzD2hSV7CirPJGhTV90LJS7FEzMjER6rlpwuWMrNPK05oY9ti
         g4uXFNvyQlg2NlSWpDajepojAfWFSDMaIvfd3Q/O87hLvFgbOUCzO2VMOX0U4N2i/7OW
         pu/JMTO8zx81A1CQp8ZfTD2kAMXiw3fId03fFm0Y4aOKue7WTXjAtPw/QR6+qrB7PS41
         wfmtWUQa7MimFRBVziVFU7sBmsYRlrglvK4rE5jYWEvme7mUhgZr+yoyAMGn3TwxXPju
         5OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y7AFvgnHqwWsOFhTmk4i/DwYzcjtYaWfhp+4Z6qHobU=;
        b=XGuSfLVX6kBBC1Dwm7XMFYUFMjgSQWtDd+D1TiL0EtPOf2YezsSy5Vlv/I4F+oepPV
         wcxJF/SKgg/cFEX6j9qJkMN2V4cV1IgAshTf7h3A5/mJ+AaAB3SRn1YMWWIxhh7LQaWi
         MTjyLFxQwJeMoWOG5PAz7Ms005XwsdCRZH8uWa7UmWr3G05bLtM3fOohdwpe7BWzckke
         meHzx6lXAFlQcIKl1/GcXCqn0/eSsJtQr/xHMpfLHcVI4jS1b1ylRlPVBdQkpkoHI3mz
         7/HolF25DIZnaN+wd8kO/OKFmzgq8qMdM4si55klUFg7RnEhc+dEXWugcG9kw04KaYUM
         g+6Q==
X-Gm-Message-State: AOAM532GW2ncvWn00Ba94ybw+bUChMY4s1RJ9igoXapp3JsZF7YfeLhw
        Q32OPrVN7kzptigp9VYhEL3vfA==
X-Google-Smtp-Source: ABdhPJz5o9FuHCcYjcaH5dprQ7ehfD3MI+SA5JumBHiFDerZaHO2MPeu/niUrkcqkUu4GjHxBsRY7A==
X-Received: by 2002:a05:600c:1f0e:b0:397:707f:5a60 with SMTP id bd14-20020a05600c1f0e00b00397707f5a60mr27623101wmb.3.1654088806145;
        Wed, 01 Jun 2022 06:06:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id m11-20020a5d624b000000b0020ff3a2a925sm1892597wrv.63.2022.06.01.06.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:06:45 -0700 (PDT)
Message-ID: <1ec64a99-cfcf-c903-935b-d1bb0617c284@linaro.org>
Date:   Wed, 1 Jun 2022 14:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] ASoC: qcom: soundwire: Add support for controlling
 audio CGCR from HLOS
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        alsa-devel@alsa-project.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, tiwai@suse.com, vkoul@kernel.org
References: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53g9rWks+euk5KHBzmJNEB3xLbJzMgCxN52DO5x+9-Wgg@mail.gmail.com>
 <51b8aca1-e038-4907-e973-ebdbebaf9b28@quicinc.com>
 <YpaXZ6KfApGebkBy@google.com>
 <7c74868d-624b-c18e-b377-026e70813fcc@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <7c74868d-624b-c18e-b377-026e70813fcc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2022 13:57, Srinivasa Rao Mandadapu wrote:
> 
> On 6/1/2022 4:02 AM, Matthias Kaehlcke wrote:
> Thanks for Your Time Matthias!!!
>> On Tue, May 24, 2022 at 04:19:47PM +0530, Srinivasa Rao Mandadapu wrote:
>>> On 5/21/2022 8:43 AM, Stephen Boyd wrote:
>>> Thanks for your time Stephen!!!
>>>> Quoting Srinivasa Rao Mandadapu (2022-05-18 05:42:35)
>>>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>>>> index da1ad7e..445e481 100644
>>>>> --- a/drivers/soundwire/qcom.c
>>>>> +++ b/drivers/soundwire/qcom.c
>>>>> @@ -1333,6 +1337,10 @@ static int qcom_swrm_probe(struct 
>>>>> platform_device *pdev)
>>>>>           ctrl->bus.compute_params = &qcom_swrm_compute_params;
>>>>>           ctrl->bus.clk_stop_timeout = 300;
>>>>>
>>>>> +       ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, 
>>>>> "swr_audio_cgcr");
>>>>> +       if (IS_ERR(ctrl->audio_cgcr))
>>>>> +               dev_err(dev, "Failed to get audio_cgcr reset 
>>>>> required for soundwire-v1.6.0\n");
>>>> Why is there no return on error here? Is the reset optional?
>>> Yes it's optional. For older platforms this is not required.
>> If it's optional then either there should be no error message, or the
>> error message should only be logged when the version is >= 1.6.0. There
>> are few things worse than a kernel log riddled with misleading error
>> messages.
> 
> In that case, it can be done like below. Kindly let me know your opinion 
> on this.
> 
> if (ctrl->version >= 0x01060000) {

This is not true 1.7+ variants do not require anything as such.

Why not add a flag in struct qcom_swrm_data and pass it as part of 
of_match data specific to this version?

--srini
>      ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, 
> "swr_audio_cgcr");
>          if (IS_ERR(ctrl->audio_cgcr)) {
>              dev_err(dev, "Failed to get audio_cgcr reset required for 
> soundwire-v1.6.0\n");
>              ret = PTR_ERR(ctrl->audio_cgcr);
>              goto err_clk;
>          }
>      }
> 
