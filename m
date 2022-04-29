Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18A2514A11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359615AbiD2NAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbiD2NAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:00:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEC93614F;
        Fri, 29 Apr 2022 05:57:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t6so10703334wra.4;
        Fri, 29 Apr 2022 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ePG6wKCbyk/Ae1arQi0XeTIwAd5LTspuTNbaM+4UP34=;
        b=UhDeT+7OtGdUNKYaRyYzF4YBjNiqiG5cYbp0NWSnSrluhsGjG6xPIOa/eMOslCx/VC
         t5MHMquFHD0iip2929xPOiKtfcZ7f7Kqyne/BGIHZtW0+1IXEEnNWPhHLQuKrUfZm56I
         9MWvhTeIbw3HTkCcUtk4saxKmzHFZqX3ZCB+WWrtNtRnHsgon3MF5RqJ9xvGQws7/0mS
         b+KAA0MqsPPuKd+MsdTJD2DsZatnp/1g7cxsoG0dVaw4lhJmg2PfwCrWeXpcHA3xyvHa
         1U/RSSLyuPWacNUUqAFTW/EiOcufG4eM4aUy+7Ho0cBqUS68URBRmHKyevMB67igwyIh
         HVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ePG6wKCbyk/Ae1arQi0XeTIwAd5LTspuTNbaM+4UP34=;
        b=cUxDGHO4/+GDTEfKCUQMnCWb9G8CGudVIPPvyNCXWoSj9DCy71E1Qhy6/oPDtnd8VR
         QFv4Lqcl9OssSSPmJy/+ZsK/H5Wpyi3L3VLg60bSKDfpmr+tpNCUbWgNC0qi4zzBt0ul
         RMYmR3CH9o8mYWQX7vDr6bFhU6FaevVXF/05kgCqldwxXdoOBL2oN/oGgLv86I1VJlCE
         0HPOSzXbL3ji9AtzDBO3E/jCmEz1yVzV0cY0/4wdEDmAdPVPqTOKa+gYeWJP64CV1I2k
         Bu0JqoDk610ohfv8gOJJduSRd25CrXwa6ZePeMPR0PvGQJhx9MSssl1USi1wsSU8Dw/q
         qzSg==
X-Gm-Message-State: AOAM533Ao4mzp0dUJc/ksf9XVKhSxVx6sIhYrE+X9wuq2rfyVPr60jln
        0/ku+6k0emV/Mi7ljQoJISo=
X-Google-Smtp-Source: ABdhPJx9iOmaDdFy/exNMf07wrNEg2EtThd5KGiPKJ773aQXEiQRCBTb7PUS/mCPw+1r7dSeJNOlxg==
X-Received: by 2002:adf:ec92:0:b0:20a:d261:2cf2 with SMTP id z18-20020adfec92000000b0020ad2612cf2mr25223015wrn.296.1651237034054;
        Fri, 29 Apr 2022 05:57:14 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm6986212wmq.47.2022.04.29.05.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 05:57:13 -0700 (PDT)
Message-ID: <cf9b425e-84ff-af12-72a7-4056b8cbf90d@gmail.com>
Date:   Fri, 29 Apr 2022 14:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] dt-bindings: dsp: mediatek: add mt8195 dsp document
Content-Language: en-US
To:     YC Hung <yc.hung@mediatek.com>, Rob Herring <robh@kernel.org>,
        broonie@kernel.org
Cc:     robh+dt@kernel.org, daniel.baluta@nxp.com, trevor.wu@mediatek.com,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, cezary.rojewski@intel.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com
References: <20220106064847.15588-1-yc.hung@mediatek.com>
 <Yd4yNkeGlzdULNlv@robh.at.kernel.org>
 <68895a40-559b-13ce-d433-f9b32c648323@gmail.com>
 <9965188904de2e89bc5390fa6c71d9fb243f9d12.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <9965188904de2e89bc5390fa6c71d9fb243f9d12.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/04/2022 07:59, YC Hung wrote:
> Hi Mattias/Rob,
> 
> Sorry I miss this mail.
> Could you please help to check this patch? Thanks.
> 

Rob gave his reviewed-by. I just saw that the driver maintainer is Mark, so I 
expect him to take the patch through his tree. Didn't realized this beforehand.

Regards,
Matthias

> On Fri, 2022-01-14 at 13:56 +0100, Matthias Brugger wrote:
>>
>> On 12/01/2022 02:43, Rob Herring wrote:
>>> On Thu, 06 Jan 2022 14:48:48 +0800, YC Hung wrote:
>>>> From: "YC Hung" <yc.hung@mediatek.com>
>>>>
>>>> This patch adds mt8195 dsp document. The dsp is used for Sound
>>>> Open
>>>> Firmware driver node. It includes registers,  clocks, memory
>>>> regions,
>>>> and mailbox for dsp.
>>>>
>>>> Signed-off-by: yc.hung <yc.hung@mediatek.com>
>>>> ---
>>>> Changes since v3:
>>>>     Fix patch v3 error : v3 only provide difference between v3 and
>>>> v2.
>>>>
>>>> Changes since v2:
>>>>     Remove useless watchdog interrupt.
>>>>     Add commit message more detail description.
>>>>
>>>> Changes since v1:
>>>>     Rename yaml file name as mediatek,mt8195-dsp.yaml
>>>>     Refine descriptions for mailbox, memory-region and drop unused
>>>> labels
>>>>     in examples.
>>>> ---
>>>>    .../bindings/dsp/mediatek,mt8195-dsp.yaml     | 105
>>>> ++++++++++++++++++
>>>>    1 file changed, 105 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
>>>>
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>
>> Rob, it seems we don't have a maintainer for this bindings. Shall I
>> as MediaTek
>> SoC maintainer take them through my branch?
>>
>> Regards,
>> Matthias
> 
