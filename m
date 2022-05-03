Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1803951892C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbiECP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiECP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C63BFA2;
        Tue,  3 May 2022 08:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8BB1616A9;
        Tue,  3 May 2022 15:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640C0C385A9;
        Tue,  3 May 2022 15:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651593278;
        bh=ttsYKdHya8NFXXbpmd6fMc2IdK8j16P+tIaA6ZRYEJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YKZhP6/cj6nXuDCQplf5MJzZX47V3EfzWI1JWpqVcz/TlzZRqtuSzHI3PZLDTRGkR
         bjYJNLzIDHlznEONfhTSsbs+toXqgkD0IbOB4HzqM4pd1bmbPYT8CG9bslmNC/Y0Gu
         v+HbfvzzZanrlzM/OXZcf8bNhySw6gmKvqDG4+VRcftXJLwufqtMPW0j6KQFdnL16/
         grfIs+NTsBa5HQX/6eIyBd/Em4snBZq+KXnN0H8xobMuIl4+o6cAyePSyVkf1+nhGA
         17xrEUG5Xx68FDlvB9K+x7F+SbSjUSc8SFcIO+yDpJPZrLdEtYhMEkzAGKUDX1Tr9r
         yTLbuHSTg0iWw==
Message-ID: <cd1da207-1f15-f3f1-7190-56b983e75024@kernel.org>
Date:   Tue, 3 May 2022 17:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
References: <20220503042242.3597561-1-swboyd@chromium.org>
 <20220503042242.3597561-2-swboyd@chromium.org>
 <2280875f-fbd8-0dfd-5a0a-1d7fceb856e4@linaro.org>
 <CAD=FV=UEBi9dctmhaAi1z+c+Sj5gtcRrc3FRW294T55dTiAidQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAD=FV=UEBi9dctmhaAi1z+c+Sj5gtcRrc3FRW294T55dTiAidQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2022 17:46, Doug Anderson wrote:
> Hi,
> 
> On Tue, May 3, 2022 at 8:42 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 03/05/2022 06:22, Stephen Boyd wrote:
>>> If the ChromeOS board is a detachable, this cros-ec-keyb device won't
>>> have a matrix keyboard but it may have some button switches, e.g. volume
>>> buttons and power buttons. The driver still registers a keyboard though
>>> and that leads to userspace confusion around where the keyboard is.
>>
>> (...)
>>
>>>
>>> +if:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: google,cros-ec-keyb
>>> +then:
>>> +  allOf:
>>> +    - $ref: "/schemas/input/matrix-keymap.yaml#"
>>> +  required:
>>> +    - keypad,num-rows
>>> +    - keypad,num-columns
>>> +    - linux,keymap
>>
>> else:
>>   properties:
>>     function-row-phsymap: false
>>     google,needs-ghost-filter: false
>>
>> Because these are not valid for the non-matrix-keyboard case, right?
> 
> Isn't that implicit because this file has `unevaluatedProperties: false` ?

But they are evaluated here, aren't they?


Best regards,
Krzysztof
