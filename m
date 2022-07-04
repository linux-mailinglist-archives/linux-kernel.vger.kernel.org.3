Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2B564E8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGDHVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiGDHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:21:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82562EF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:21:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f39so14284431lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vln6HYgiS3ToTvJf9Q6ri+cW27TKxOvsHNd6WycR420=;
        b=eoA4egyRuz1FU+dmRUIeJh0HTBAZQs5Unex7A+9NMQ7tbPwSXDKUYSW9bCUMYEwP6N
         VzVQ+DmicZJglQFaE6rpnuAH+038u4AFz1O6cX+auJnidMYHnvkWW4l35ZdAA6MIZEXh
         lFugyazM5acdQIO78FISQtbZDjGQ46b8rfiCRL13dBp9I+qDvTNNeX1q2OeCVP4wbYk+
         Rhq7G4nQct7sjAumoq8FYP3QfuPEJhvXCHmQ72kxC8x2SjH+Y/9GQ8D4IYPsEvGcGosM
         IgUJGUGgz+8809WVZnv97am9NezaggPdWd4XJ/sGaKUWbLhEJRUKVnXy5/ZJy6K5fjgo
         Hk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vln6HYgiS3ToTvJf9Q6ri+cW27TKxOvsHNd6WycR420=;
        b=LaOhQ3YZd+rWTT676VoWQCbUimYPHz4rS8gxs0i3l9UTRUUKi+WMF/kxK9ysDQR4Fv
         +DE/6LoQtMy6plFhvKHKcPV5xe2jZtxGXu4VWK9Ra8oLbNRMD4i3r2/Ohpjh+Ws2SbMh
         OTRXok4yB35MkfoWNeqSR3inLDqepCI89V942LNMn+bODy6KThaegAPobK39N1asStYd
         5BKD4WvzgSBbC/UrClYbzbv3DsBEIA8V6lDnWyJJi/xusypz5tl4uqZ9FBbNdSgDQ+Yc
         kv/QtLbNvDMxXH7lJVQQJlRW5Dl9uhxyzO7sUW3/puxgF2g9IeVxwMQeCs0nMzLfV30x
         DKHg==
X-Gm-Message-State: AJIora+r5dCQGBtc887B33zWZDNRtGHYtsl9fPUoCAZIq6UwNcSwThBL
        bn29/jNxlkWWOsYiE++rwOf4TA==
X-Google-Smtp-Source: AGRyM1vwulbGf0wEriyCwvzBATzx/6SXMvjbcrsCvVa6M/FuBcUc/A1FI7JhSiDe2KlM+1Tgtc4Obg==
X-Received: by 2002:a05:6512:3b06:b0:481:507e:e3a0 with SMTP id f6-20020a0565123b0600b00481507ee3a0mr15079502lfv.616.1656919296028;
        Mon, 04 Jul 2022 00:21:36 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bi16-20020a05651c231000b0025a66b3fc45sm4853780ljb.97.2022.07.04.00.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 00:21:35 -0700 (PDT)
Message-ID: <2b6427ba-9afc-b1b4-0862-6857bb346878@linaro.org>
Date:   Mon, 4 Jul 2022 09:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/2] dt-bindings: hwinfo: group devices and add
 s5pv210-chipid
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
References: <20220703183449.12917-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdUnH0oRQg3i1VorZOmNSKKXRP91BiQEgBaV5W5ig+YH2A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdUnH0oRQg3i1VorZOmNSKKXRP91BiQEgBaV5W5ig+YH2A@mail.gmail.com>
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

On 04/07/2022 09:18, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Sun, Jul 3, 2022 at 8:35 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> As suggested by Rob [1], I organized a bit bindings for SoC devices having
>> similar purpose - chip identification.
>>
>> These sometimes are put under nvmem directory, although in that case the
>> purpose is usually broader than just chipid.
> 
> Thanks for your series!
> 
>>   dt-bindings: hwinfo: group Chip ID-like devices
>>   dt-bindings: hwinfo: samsung,s5pv210-chipid: add S5PV210 ChipID
> 
> So why not call it "chipid"?
> "hwinfo" sounds too generic to me; aren't all DT bindings hardware
> information?

If it is too specific, some other similar drivers won't perfectly match
thus they will be placed again under dt-bindings/soc.

I was thinking about name "socinfo", but on the other hand why limiting
to SoC? I think there are many more devices which provide some kind of
read-only hardware information (type, revision, product ID, model etc),
therefore - hwinfo.

Thanks for the feedback.

Best regards,
Krzysztof
