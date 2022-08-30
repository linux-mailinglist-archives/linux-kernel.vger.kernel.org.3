Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF825A5C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiH3HFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH3HFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:05:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401AD4A838
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:05:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bt10so14270137lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JVbQO8NaIJX9r2XXsX5JS1XPjDhaNVf/tZE3BTjyue8=;
        b=aUvfBo7ge5wrT9PVdRa7n4WKc+KjoguCB0VGM5ArOYeVSOAtCGAZEIhVT1HktOBuXs
         xVuo8JAqwWgOvbrNiXwuPoqNnTLm8bwbpdzBVdW1XBIGIvvAobm/5fUU1DaMZxhXYMt5
         q9PRCAd0ycNSdCJ0SF3wM/sC/4Jv2wRlE5fJwmrsyHasgMrFm8hXCsm1aD90A+iBSqdp
         JGIlgxplMRXcg90us2nijNq9XvpwRKJHtXnnWe7UD0HWPdTTVSw6af7IiSvj3TkZZcSl
         I+qsTHUM5mofnppLxCg0Ch2lFK2+Sdu+1LslDLVXb/wyNEtQEALA7Ff4s3cbJgr4Eyrt
         eXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JVbQO8NaIJX9r2XXsX5JS1XPjDhaNVf/tZE3BTjyue8=;
        b=3BbBSQfmfCTfJnqScFiSv6FBQ0oW6O8LKNxYYP+BTW0VKismDN9TpzNWFs5be2/mcQ
         bdU0gaLxAdvLiObbBXlCv9HpZM1yBpf4IoGBvTVOxFmqaOjTw7313Xas8LFmxcnq6zGh
         pmYoG4CifupleMmUlKCJZDN9RKgqEyiTvt1Xw7YZW0wlm9+AgihA1YwqaM5OwWViw0O4
         f/LsYFC61VDJPwynFtaPIw+t0mLLj0cprD/nJdPzbIdbQYuy1PyXY3ejeA8KxDjGBptq
         MGF5JVqrYSRlHOLUy1Phm2i5+1Y56gja+k/kvl3PtEwb/XcP287+JBW37G6ZKjmLpDH6
         g/LQ==
X-Gm-Message-State: ACgBeo0G/hmekQBopAh+nJoWqUhLpnF1PbQSIDEfG9/ZOYQ+D7BycWRW
        tWnGt1Kj2o3V4CeuaQunQpM=
X-Google-Smtp-Source: AA6agR5cFuxjTSbp2ILQnRmRzNd5Pjxhu1SWu2c7J9+e7QO7+oxCtHIczngbO2Ls5GyWNgJnT/iQrA==
X-Received: by 2002:ac2:58d5:0:b0:48b:3a88:641 with SMTP id u21-20020ac258d5000000b0048b3a880641mr6784864lfo.421.1661843106574;
        Tue, 30 Aug 2022 00:05:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id m20-20020a056512359400b00492d1eb41dfsm1506038lfr.240.2022.08.30.00.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:05:05 -0700 (PDT)
Message-ID: <b5116f19-4b00-1717-a7ff-eac988bde4a4@gmail.com>
Date:   Tue, 30 Aug 2022 10:04:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 03/14] gpu: drm: simplify drivers using
 devm_regulator_*get_enable*()
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3aacca7d9a0240d95dc3cf103d114b5c85392e71.1660934107.git.mazziesaccount@gmail.com>
 <CAG3jFyvQc4ZxEt8yRtiP6VAnurvfBdWzD7640DRXun+F7vDHog@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAG3jFyvQc4ZxEt8yRtiP6VAnurvfBdWzD7640DRXun+F7vDHog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 17:25, Robert Foss wrote:

Thanks for the review Robert.

> Hi Matti,
> 
> On Fri, 19 Aug 2022 at 21:18, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> Simplify drivers using managed "regulator get and enable".
>>
>> meson:
>> Use the devm_regulator_get_enable_optional(). Also drop the seemingly
>> unused struct member 'hdmi_supply'.
>>
>> sii902x:
>> Simplify using devm_regulator_bulk_get_enable()
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> v2 => v3:
>> No changes
>>
>> RFCv1 => v2:
>> - Change also sii902x to use devm_regulator_bulk_get_enable()
>>
>> Please note - this is only compile-tested due to the lack of HW. Careful
>> review and testing is _highly_ appreciated.
>> ---
>>   drivers/gpu/drm/bridge/sii902x.c      | 22 +++-------------------
>>   drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
>>   2 files changed, 6 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
>> index 7ab38d734ad6..162f9c87eeb2 100644
>> --- a/drivers/gpu/drm/bridge/sii902x.c
>> +++ b/drivers/gpu/drm/bridge/sii902x.c
>> @@ -171,7 +171,6 @@ struct sii902x {
>>          struct drm_connector connector;
>>          struct gpio_desc *reset_gpio;
>>          struct i2c_mux_core *i2cmux;
>> -       struct regulator_bulk_data supplies[2];
>>          bool sink_is_hdmi;
>>          /*
>>           * Mutex protects audio and video functions from interfering
>> @@ -1072,6 +1071,7 @@ static int sii902x_probe(struct i2c_client *client,
>>          struct device *dev = &client->dev;
>>          struct device_node *endpoint;
>>          struct sii902x *sii902x;
>> +       static const char * const supplies[] = {"iovcc", "cvcc12"};
>>          int ret;
>>
>>          ret = i2c_check_functionality(client->adapter,
>> @@ -1122,27 +1122,13 @@ static int sii902x_probe(struct i2c_client *client,
>>
>>          mutex_init(&sii902x->mutex);
>>
>> -       sii902x->supplies[0].supply = "iovcc";
>> -       sii902x->supplies[1].supply = "cvcc12";
>> -       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
>> -                                     sii902x->supplies);
>> -       if (ret < 0)
>> -               return ret;
>> -
>> -       ret = regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
>> -                                   sii902x->supplies);
>> +       ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies), supplies);
>>          if (ret < 0) {
>>                  dev_err_probe(dev, ret, "Failed to enable supplies");
>>                  return ret;
>>          }
>>
>> -       ret = sii902x_init(sii902x);
>> -       if (ret < 0) {
>> -               regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
>> -                                      sii902x->supplies);
>> -       }
>> -
>> -       return ret;
>> +       return sii902x_init(sii902x);
>>   }
>>
>>   static int sii902x_remove(struct i2c_client *client)
>> @@ -1152,8 +1138,6 @@ static int sii902x_remove(struct i2c_client *client)
>>
>>          i2c_mux_del_adapters(sii902x->i2cmux);
>>          drm_bridge_remove(&sii902x->bridge);
>> -       regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
>> -                              sii902x->supplies);
>>
>>          return 0;
>>   }
> 
> Ideally this patch would be split into two parts here, due to
> maintainership boundaries.

Ok. I will in any case respin this series when the dependency patches 
from Mark's tree have been merged to the -rc1. I can split this to 
patch/driver if it is preferred. I just though I'll decrease amount of 
mails by squashing these almost trivial changes.

> 
> For the sii902x part, please add my r-b.
> 
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
Thanks.

Best Regards
  -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
