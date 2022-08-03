Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD91E588AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiHCKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiHCKvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:51:44 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477151BEBD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:51:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a11so8508832wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UKgtTNEBRcEuJKNYzz9fav0XLRpqgY1r5hhJ/ETR5F4=;
        b=l1j1LNiLEHPl29Pqd5P8h+R7lQ9danPifmXUoG1hTfeY7KvWVeWx4Abd/xixiNrTZ9
         JBlyQVkJyX80pZtlMqZ6Zbq0haNbmZHQinkkW4C8DIpLFF0kl4WJPthEg6PNo2p6eTCp
         attrMx7gN07hxshRXfb9PDygzeU0NjnkZhcnRjJ6DAgsr6WsA9grBWaP5hMz0rPsDIlh
         OhW7WsQJxFhhOVrOT3KtkmQqcemojHqyp6C37wCh3drpgH1D4H6IuVjlNJF8eQYJ6AY8
         SeNbscjbVDScrpQ1WsxQGbjQLluEMJUv13H4KPRayh0XvtQIJxmLIKNRGUukTiwDLMFr
         Oncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UKgtTNEBRcEuJKNYzz9fav0XLRpqgY1r5hhJ/ETR5F4=;
        b=K8KGa6ylfbRyksCbGMRehTBj1xkGLzqviY6sApgHM8k4YSbA9wAvzyhxMzMTLsQbna
         iwevCBho1d34RMU9dn8htoraEY642Dk4jvjxtdxkpYVvy2qDdDL7OeECmd24GqX6AkVP
         Rea2GTPbw45Pr+kAn4k3fe89LXmAqcLLmGdAcDCVFeaZzaudqTxI88/s+I5IkF7ucM/s
         ANGiR4nUIFPnSpvBw2ZgLoVeZbt++qvE8LLWrGHUCNkkcaSFoEApGIzDNDsUrToSOCJu
         fl5+sl7AzJocWPhU1Vvkhvck21b0w4TTPPbZBUxzu1sK+RVnllMbqqNhpT3fXHr4InPn
         uROw==
X-Gm-Message-State: ACgBeo0qxL/bZq87dMm5VvPcTGJu/2XUHnPyyoSWY3daQoES0n/qEPZH
        DS39msS5AZKjjWBbo5Kd0MggiQ==
X-Google-Smtp-Source: AA6agR4ooQgNyvGSBedKzPOVSNxL7PaXRTSiaL3eh/8HzCV27FgkpUxBQmODfbbFRFzAFLhywsacXA==
X-Received: by 2002:a05:600c:3845:b0:3a3:227d:c1c6 with SMTP id s5-20020a05600c384500b003a3227dc1c6mr2467572wmr.9.1659523900775;
        Wed, 03 Aug 2022 03:51:40 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6e48:fbdd:280d:6dac? ([2a05:6e02:1041:c10:6e48:fbdd:280d:6dac])
        by smtp.googlemail.com with ESMTPSA id g11-20020a05600c4ecb00b003a02cbf862esm2331719wmq.13.2022.08.03.03.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 03:51:40 -0700 (PDT)
Message-ID: <57687bbc-580a-ef07-bc50-6bc9f5c14ec9@linaro.org>
Date:   Wed, 3 Aug 2022 12:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/6] thermal: mediatek: Relocate driver to mediatek
 folder
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220726135506.485108-1-bchihi@baylibre.com>
 <20220726135506.485108-2-bchihi@baylibre.com>
 <24250d03-b25f-e521-5abd-f36109885c36@linaro.org>
 <CAGuA+opxZ7DDrWHcnTRhMcm7YveCAypdy9MDSytt58asgekayw@mail.gmail.com>
 <CAGuA+ooOUXaBM+uPvEEohFLtO8sRd4T=DMcc6Fvo9P92gsq4yg@mail.gmail.com>
 <9b224465-e9e5-43d3-50eb-3614decbd8b2@linaro.org>
 <CAGuA+op-mO5ZMz_EvSOYUNiZ_4OOwLFQqFqMrCQBVMcG3mbcPQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAGuA+op-mO5ZMz_EvSOYUNiZ_4OOwLFQqFqMrCQBVMcG3mbcPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Balsam,

On 03/08/2022 10:41, Balsam CHIHI wrote:
> On Fri, Jul 29, 2022 at 5:35 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Hi Balsam,
>>
>> On 29/07/2022 17:21, Balsam CHIHI wrote:
>>
>> [ ... ]
>>
>> You may want to wait next week before sending a new version, I'm still
>> reviewing your series (note you can send it anyway if you prefer)
>>
> 
> Hi Daniel,
> 
> Thank you for the review.
> I have finished implementing the changes requested by the maintainers
> and would like to resubmit the series.
> Do I still have to wait for your feedback to send it again?

At your convenience, I'll review the new version if you send it



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
