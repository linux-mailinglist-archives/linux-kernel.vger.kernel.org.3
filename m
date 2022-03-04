Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C74CD0DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiCDJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbiCDJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:10:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F549150426;
        Fri,  4 Mar 2022 01:09:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3718C1F463BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646384996;
        bh=CcMBV0l5kr7q1bweV1wcu+vTnCpRH0j1xl0S1wsETtg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GP3Rqx4BysrGeC3OgIgoS8mmJ79Jx/get+EPxdvRz+sxXIL3zKMYdXtNhs/IyKBfa
         IEoUGqwEOuTeX1zhvs0c9R6Ts4h16EBjlAG5IN22qIqkSk8PqBZobCEvSS4C//gd+n
         XQzfL5K8fYBFeAyYdm4jcX9VmFpvFBn9pZN8rqhi21zsMn4r8T49kJszP9ITmaktSR
         RG82DC9HeRK/6cFuUEDMsTzkiDxTCTHGDvwboB0XYQudrqo5rwdY9AK0QHbzmbB8yp
         2n/uzvuSf3H9G8ZOCGw+LQLAspdBPE29YY9sjGtqzf64idsd5P6E1pjz1tDyVvTbKg
         hcb2yUiPR/bLw==
Message-ID: <2bdbe214-7add-f529-db8f-d0e998a540e5@collabora.com>
Date:   Fri, 4 Mar 2022 10:09:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 00/12] Add Mediatek Soc DRM (vdosys0) support for
 mt8195
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        singo.chang@mediatek.com, Fabien Parent <fparent@baylibre.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "roy-cw.yeh" <roy-cw.yeh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        devicetree@vger.kernel.org, Moudy Ho <moudy.ho@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, nancy.lin@mediatek.com,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com>
 <CAL_Jsq+6k5EqouAO2Xm=GpBz3Pi-wfB-ixGwfyC+Y+qOrjUFTg@mail.gmail.com>
 <c103927d7dbc3217431c83dc22a44c656c561228.camel@mediatek.com>
 <28098efc-1de1-b540-b1a3-bf7a92af9511@collabora.com>
 <c19b14ab9a8879fc50d8bcc87745da48491be373.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c19b14ab9a8879fc50d8bcc87745da48491be373.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/03/22 06:26, Jason-JH Lin ha scritto:
> Hi Angelo,
> 
> Because linux-next has applied these patches:
> 
> [v15,04/12] dt-bindings: display: mediatek: dsc: add yaml for mt8195
> SoC binding
> [v15,05/12] dt-bindings: display: mediatek: merge: add additional prop
> for mt8195
> [v15,06/12] dt-bindings: display: mediatek: add mt8195 SoC binding for
> vdosys0
> [v15,03/12] dt-bindings: display: mediatek: disp: split each block to
> individual yaml
> 
> 
> I'll rebase on the latest linux-next, and then send 1 path + 1 series:
> [1] a fix up patch for all dt-schema error in each display dt-bindings
> (If Rob wants me to split this patch into separate patches for each
> file, then I'll resend it.)
> [2] a series of remaining patches of this series
> 
> 
> I would appreciate it if you would take the time to send [1] for me.
> If you can help me to send [1], please let me know.
> Thank you very much ;-)
> 
> 

I will send fixes for [1] later today.

Cheers,
Angelo

> Regards,
> Jason-JH.Lin
> 
> On Thu, 2022-03-03 at 10:31 +0100, AngeloGioacchino Del Regno wrote:
>> Il 03/03/22 05:25, Jason-JH Lin ha scritto:
>>> Hi Rob,
>>>
>>> Thanks for the reviews.
>>>
>>> On Wed, 2022-03-02 at 17:50 -0600, Rob Herring wrote:
>>>> On Wed, Jan 26, 2022 at 1:19 AM jason-jh.lin <
>>>> jason-jh.lin@mediatek.com> wrote:
>>>>>
>>>
>>> [snip]
>>>
>>
>> Hello Rob, Jason-JH,
>>
>> I have just crafted a patch that fixes everything mentioned here,
>> if it's easier like this, I can either send it for the maintainer(s)
>> to apply on top, or squash in Jason-JH's original patch.
>>
>> If you'd like to get my patch, though, I have one question:
>> this is touching literally all of the YAML files that Jason-JH is
>> introducing, so, should I send this as one patch per file (which
>> would be
>> something around 16 patches) or is just one fixing them all fine?
>>
>> Cheers,
>> Angelo
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>>
> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!3tXE3T-t6I2GMILAOHpkTXhrLHwFAQtmhGqTBtKSY2SLWM2qBBMULlM17TtG6VwNR5yn$
>>   



