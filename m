Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E908C58C347
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiHHG1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbiHHG1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:27:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAD411823
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:27:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x25so8775340ljm.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QQLSXoa6vBzyULzMl4Lyj9nCjqEGkXsRm+hwsn6zEQU=;
        b=zIfr/bkoY3gBzFbNcrWpqiMwyNkPCdKNe/MrbGWontsY0HYT4ssA/dAdUdAabizg5N
         Uq6lRdGpZkVFal9dSokwde86NFzLO36qaFgkAcsGa2pp2AewIMfEoLXQu3hwV5vAuG8G
         C39vpKfHrnW8cOYiiw7CBCJZZC9q5aHcEarv2mzTjuimEMXv1nUY0jtqJjjScfaKJNwV
         mK3ZNzHXGD7a5IwATuzg00KVDZTPOGyV+jsJ/uGzqWgmUoM72zYGndAChyFcW4+wfVH9
         +HmN2rEZhRXBzI8fXgw7tCqm3vx1pJXdI5frgGv4weNWXJu4ZCD6p0sxEE2rFDjtaXTu
         Xa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QQLSXoa6vBzyULzMl4Lyj9nCjqEGkXsRm+hwsn6zEQU=;
        b=yNAEb68AgtMocI9AWuQBvFuDsT6T2qMy7TOJl7JDZtjq/ew2qbsDjdBBdTWEP5DkEC
         HWaT0pbhYMrpVzHDok65wFfNVZtVIOqInusOiHdNbl8mbb+xpkZHN9ndzHFNf79EX5ly
         DxME+kUKEtzcllGdMQtMVRU02kNY0sRJpGPPJ0pIQ9H5bqJj/+3XtWUEXvtNDcIEucRz
         eRKyOfAU1h8CUrf69PPw6pvTyjFUvUN7pF+Kp14T0jZ4U9TUyvGyjn7WgPUroFFKhweW
         Lbv+BfeUpaRkfk9+Iewea8BpLeVVAKzU0BhL/AX6y8Y0vxrb0ArUeB6TKzikWUV0JN6y
         OqOQ==
X-Gm-Message-State: ACgBeo1uoXnYv+3dFkk71Yzm8ou2gl1XTKXb7YfKGBhMcXzhABChbfdN
        9fck8hfBbWzemkoWiNVLEtDQbg==
X-Google-Smtp-Source: AA6agR7xDstvO762NOZfSosYL1/7JmPhrOKTSApy4+c172IbCSOvbAnHnC+5kibn/XzAXiv9QgI0GA==
X-Received: by 2002:a2e:918d:0:b0:25e:c884:6a96 with SMTP id f13-20020a2e918d000000b0025ec8846a96mr2674578ljg.157.1659940019211;
        Sun, 07 Aug 2022 23:26:59 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u11-20020ac258cb000000b0048b08124139sm1313796lfo.177.2022.08.07.23.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:26:58 -0700 (PDT)
Message-ID: <83bbcb33-1f6e-47cc-54bc-e0a5444c3609@linaro.org>
Date:   Mon, 8 Aug 2022 09:26:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>, minyard@acm.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220804181800.235368-1-tmaimon77@gmail.com>
 <10e93907-49ef-a3e6-e0b4-0b3e5f236f44@linaro.org>
 <CAP6Zq1ju4=PSiCuDaCi2NQTniaXBwmv5Qn6LoLayGmiayDCvYg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1ju4=PSiCuDaCi2NQTniaXBwmv5Qn6LoLayGmiayDCvYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2022 09:51, Tomer Maimon wrote:
> Hi Krzysztof,
> 
> Thanks for your review.
> 
> On Fri, 5 Aug 2022 at 09:36, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 04/08/2022 20:18, Tomer Maimon wrote:
>>> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
>>> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
>>>
>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>
>> Your previous commit adding that compatible was simply wrong and not
>> matching the driver and it is not the first time. I think all Nuvoton
>> patches need much more careful review :(
> Will do and sorry about all the mess...
>>
>> You forgot the fixes tag:
>>
>> Fixes: 84261749e58a ("dt-bindings: ipmi: Add npcm845 compatible")
> Will add the tag next version.

You received a bit different review from Corey, so to be clear:
1. Your approach is correct, assuming the devices are really compatible.
2. Add a fixes tag and send a v3, to get my ack.

Best regards,
Krzysztof
