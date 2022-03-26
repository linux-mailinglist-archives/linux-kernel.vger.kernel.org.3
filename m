Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B34E7FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiCZIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiCZIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:15:12 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9FA1A94A1;
        Sat, 26 Mar 2022 01:13:35 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id j15so19335322eje.9;
        Sat, 26 Mar 2022 01:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gKCD/CUfN7H8HGfSIt3k90i5F+gqdbhnFAqoLqeWkPw=;
        b=l1HsqHB3l7h2Hv9OJU0uJ3RBUO3ydg3vgMdd+FcuA9CB2mibIy/jMZfhw+gDRC6a+S
         yl7J8HMVoFhf3GhO8r42pX8J0Grde7Eb357PkzBT11q1bBkrUIU6lHdyQs8Us1BVoMT9
         thB64Ba2PGa9xY/aURRpjkxJZ5MhatZbW/3eKZZNt93zAI0CWCEMA8jZi9e1CURbB2/F
         CcNabeS97IYrboPW+QfKmWSXoTILdmdrNwf4Qg99zlZSTLJESA0j6wjagHUtQkMddvPa
         I+GbCqZuE+GUnLLsPCkSjckstHdwRXFS3lKL7+7geg/nKB6nP/weKUeT+qKZFmZ7s8lN
         8Iiw==
X-Gm-Message-State: AOAM531eu0W98NjbodtyzqKrNPI8rRsd0gZFb5365FgwRi4gFUYUES4w
        tdeknH1phU3NuhGIiWmSpm5jsp5B1pYKPw==
X-Google-Smtp-Source: ABdhPJwv53DeufbWroyCxLEwt0hZ4F/T2bC1RdmzUiOR6vilXTvu9MMTpJa/giGHGN3MRfYZEchfqQ==
X-Received: by 2002:a17:907:94ca:b0:6da:b785:f067 with SMTP id dn10-20020a17090794ca00b006dab785f067mr16449301ejc.654.1648282413717;
        Sat, 26 Mar 2022 01:13:33 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id nb38-20020a1709071ca600b006e02fed87ebsm3402478ejc.17.2022.03.26.01.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 01:13:33 -0700 (PDT)
Message-ID: <de9ff5a7-ebcf-d08f-486b-5334be8fb703@kernel.org>
Date:   Sat, 26 Mar 2022 09:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
 <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
 <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
 <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org>
 <Yj3oXuijuZY1gG9X@sirena.org.uk>
 <d2f220ae-c62c-a7f7-23cc-c33956c2eeaf@kernel.org>
 <CADiBU3-3QLi5PVUymk_VCbF+-uVSqjoP9jLGL+R=PQ-S=Y=_AA@mail.gmail.com>
 <Yj5nYUeizlmlbX4O@sirena.org.uk>
 <CADiBU38O6zdp5KYt90KgrZKJwAzBqPoaYQYehAJ=wS42NyVcjQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CADiBU38O6zdp5KYt90KgrZKJwAzBqPoaYQYehAJ=wS42NyVcjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 08:55, ChiYuan Huang wrote:
> Mark Brown <broonie@kernel.org> 於 2022年3月26日 週六 上午9:07寫道：
>>
>> On Sat, Mar 26, 2022 at 08:58:47AM +0800, ChiYuan Huang wrote:
>>
>>> I tried to remove only __maybe_unused and build with x86 config  that
>>> CONFIG_OF=n.
>>> There's no warning or error message when compiling the rt5759 source code.
>>
>>> If so, I will remove only '__maybe_unused'.
>>> May I ask whether 'of_match_ptr'  need to be added or not?
>>
>> If you add of_match_ptr() (which is a little better, though it's
>> a tiny different either way) then you shouldn't remove
>> __maybe_unused - the thing here is that the __maybe_unused is
>> needed because of_match_ptr() is used.
> 
> Sorry, I'm confused.
> Originally, Krzysztof's opinion is to tell me why 'of_device_id' is
> declared as '__maybe_unused'.
> That's why I mentioned that the return value  about of_device_get_match_data'

Your answer is not related to my question. of_device_get_match_data()
has nothing to do with __maybe_unused...

> And now we're talking about to add 'of_match_ptr' in struct driver
> of_match_table.

Because this is one of the solutions.

> 
> Back to the original topic, two ways can solve this.
> 1) only remove '__maybe_unused' in of_device_id
> 2) keep '__maybe_unused' in of_device_id, and add of_match_ptr for
> of_match_table.
> But option 2 seems conflict with Krzysztof's gueestion.
> 
> May I ask which option you suggested?

Option two does not conflict my suggestion. I pointed out that having
ONLY maybe_unused is incorrect. I pointed the mistake. Nothing more... I
said that there are two ways to solve it later, just choose one. I don't
know why do we talk about such basic issue for so long. This should be
one email from my side and one confirmation from you...

Obviously maybe_unused it has to be removed if you do not add
of_match_ptr. But if you intend to add of_match_ptr, then things change...

Just for the record of choosing between options (which I also mentioned
that there are two solutions) - having no of_match_ptr allows to match
with ACPI PRP0001 (AFAIU also when !OF).


Best regards,
Krzysztof
