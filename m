Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2410A477981
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhLPQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhLPQmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:42:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ED9C061574;
        Thu, 16 Dec 2021 08:42:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b40so50755372lfv.10;
        Thu, 16 Dec 2021 08:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Px7PCFothAOblRFvnJfWYF7NmmmFM8S9W6bLvLigRYg=;
        b=TcVdm0T0058utnCm51/eiho4YTY2aa9FxA366Ntu+1FAFOcOrdyspRiNDM7PccwN2n
         ZgeuYHgW/F1Nkmch1/aEDV6MhlXXt6CRzSTXO55EkmwbPWe+1EdcVorHhmikqDrEzRaX
         BZ7ruscwf/ZsDxXXa0DK56Henrx0aep8LA9BsYj0Uflsvxt0jGVqA/2DmxjTNC9qL/oK
         PR+PPwMbae0B/R/y31X6jGJIna0ReFiGRjpXiDDju3MQtvPatO1FaE5m2v2WH61auS7T
         zr+jSXYFozziKBHkETlVzO1gqgDOuvj6a+mKu4shusgn6m+jntc+WiP0Q9k9nW121Q1T
         QcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Px7PCFothAOblRFvnJfWYF7NmmmFM8S9W6bLvLigRYg=;
        b=k/aHh0WfQAK+gB8H54fsZi0adV1tHYbhrAtPHA83XgLMbh+A+cul3okB3kKCXlfeJE
         fjPMCp5xAOWgsK8bzR5yYY7LxHdNgyR1wXzBIp0KXO675CfiKwtw3NWHZUnVWdCuEzcs
         arjtybVsrflbHYTbuKKUS6vrLMyIgVsD4GHejysh1gsfr1vK+j/4NxLZcsW2DwlD80/Y
         +2WiGADb3noTkDfTSqcf3EzDs1AxXS8TOWACmkdVQCOuhVGBTQlBMg3H1SHzVLy4udkj
         xv9AlX8Kbp2Mngh4OIhZtr2AR4e1xrkc4yj2h8gEiawCQzfL0CphiWrZs14L0D6CiqhU
         5U3w==
X-Gm-Message-State: AOAM532iipImv4xZve6Z1emS3bZbuAKUomkkvtQjwbMrWcxJVJkbMPkq
        PF+2+dfl5ge2PCNexTPU1HtmPEWecQw=
X-Google-Smtp-Source: ABdhPJwQaYM3Od+uryTCmBX8+jPef7Rjl5kmnAIJ4aErjak2Z24Ruvt8b+xgWo0i7x4H1QyykexiuA==
X-Received: by 2002:a19:f10a:: with SMTP id p10mr15240358lfh.487.1639672960919;
        Thu, 16 Dec 2021 08:42:40 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id u21sm1223943ljl.76.2021.12.16.08.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:42:40 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: display: bridge: document Toshiba TC358768
 cells and panel node
To:     Rob Herring <robh+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ~okias/devicetree@lists.sr.ht,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211215152712.72502-1-david@ixit.cz>
 <CAL_JsqLyMr+apgqn31V7QPfqqxhJ1ro258WsDP=CO37zfyxVNw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <63184edb-b758-6a3a-2eb8-9106b0ee0002@gmail.com>
Date:   Thu, 16 Dec 2021 19:42:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLyMr+apgqn31V7QPfqqxhJ1ro258WsDP=CO37zfyxVNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.12.2021 18:13, Rob Herring пишет:
> On Wed, Dec 15, 2021 at 9:38 AM David Heidelberg <david@ixit.cz> wrote:
>>
>> Properties #address-cells and #size-cells are valid.
>> The bridge node can also contains panel node.
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>  .../bindings/display/bridge/toshiba,tc358768.yaml      | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>> index eacfe7165083..3186d9dffd98 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>> @@ -69,6 +69,16 @@ properties:
>>        - port@0
>>        - port@1
>>
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +patternProperties:
>> +  "^panel@[0-3]$":
>> +    $ref: ../panel/panel-common.yaml
> 
> It's possible to attach something that doesn't use panel-common.yaml
> and if it did, it would be applied by that schema.
> 
> What you need is to just reference dsi-controller.yaml at the top level.

It works, thank you.

Then we will also need to rename the "dsi-bridge" node to just "dsi" in
the new ASUS TF700T device-tree since dsi-controller.yaml wants that name.
