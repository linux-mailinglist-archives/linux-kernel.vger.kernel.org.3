Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766CA4FA832
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbiDINYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241854AbiDINYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:24:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA1E98F51
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:22:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so22332437ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P6um4RkZU+3YK1ClK/l8evJQFx9Q56DgMAMk+g3BYMo=;
        b=OGgu5KZXQS2d0rYOkLEhFI1xIXcHBtZhLcjG4a4EnL54togwh5ElZW9Xvzm1H9cszr
         6nQhFjfyysNcmwVgnR0I63238xdS83deIgu0TqwAURV3OFF6brWNbJhoZfmRlA+gvRKC
         +CWbYjnceqndMmyC6JZsdjfaC+EHZxHRjFtCj9plIh1qlQxEqJN4g5aho2gy8TNJt8XZ
         d7RKo9ts52GdKFX+eyKIkFBYmrMoBqCHxxpjFEDregB1lpnkwvKIqpWn7r3LnJzWadSs
         6SdadbEM4KBwz9LBl/qbmbsO5U5tiL3lhmVyhWb//jKBEpNKg8oeqw28yhmqDrlQDTua
         SVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P6um4RkZU+3YK1ClK/l8evJQFx9Q56DgMAMk+g3BYMo=;
        b=RrkDbl6Kv0BJ9WFPD+6SnqvFm/7MukrnPntaUU76zo+pdVr86XLJfaLORW8NxzinL8
         ii2sjeqjEj0egCRemZvy1acDEyO7vjjfChvEIwXraAhCsiluxyk8RJhZXYWaRPBjgXx3
         gydB6guDy4FcUUMeMcmeo5NXMl8sw7rVfkQ2HoG14DceG+pvrgqRjbCRhfZ1/Z5Mi3SF
         uMKMmnB8+pprNpQFR3FJMOxegZpAZ4EoWZSDoVh1o81UdCikxSFpPs/AeXeQXyM5unjT
         TxBNUnT1Kg5rsNakWNh3DscmVDrIgtaL0/I9oKYRbRxvccUbRAfXOwo/qrPt3Qfn+F0s
         hBDA==
X-Gm-Message-State: AOAM5308M1Hnl7MSEs2nUhM6jJv/POgeNz0cu4mKRb44071Emm/AhB8z
        0cPT03DvyAFgjDFVfVLPIA+/iA==
X-Google-Smtp-Source: ABdhPJz28Jp1rgzh1wNFzMt+TUSzLUlO8hYZl1h7iOxZAQ577C3+gK+6Nr8PgjyGdkwCZcPkGN7QoA==
X-Received: by 2002:a17:907:7da8:b0:6e0:5b94:5ed8 with SMTP id oz40-20020a1709077da800b006e05b945ed8mr21641512ejc.312.1649510524958;
        Sat, 09 Apr 2022 06:22:04 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id wn20-20020a170907069400b006e7f3d0c90esm6360589ejb.137.2022.04.09.06.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:22:04 -0700 (PDT)
Message-ID: <2729b85b-1c54-d446-baf4-2c41bb04b3b2@linaro.org>
Date:   Sat, 9 Apr 2022 15:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
 <e5ea96d8-f8c9-b925-04ee-81e80e30a5d0@linaro.org>
 <A023438A-B8A8-4F91-BA25-7BE9A76C6730@goldelico.com>
 <ef1674e5-2347-fbb4-52c8-5170faa84690@linaro.org>
 <9BE666F8-123E-4062-88F8-D266CCCAC43B@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9BE666F8-123E-4062-88F8-D266CCCAC43B@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:18, H. Nikolaus Schaller wrote:
> 
> Well, again, my assumption is that bindings and .yaml files formally describe the actual
> hardware components. And they have been reviewed.

The bindings try to describe it. They are pretty often incomplete or
might have mistakes. The true reason of doing a change is not that some
tool tells you "do like this". The true reason is because the change
properly describes hardware.

> 
> So they have a higher level of authority than any current driver or .dts implementation.
> Unless there is evidence that the bindings are wrong.

This is just a tool, not an authority.

> I.e. if the bindings feel right why is there a need to argue for that?

Because doing things "just because bindings told me" hides the true
explanation and makes the code review, code management more difficult.
Later person will look at this and wonder why this was done like this.
If you write "because some tool me" this is not a good help. But if you
write "because hardware is like this exactly" this is proper comment.

> 
> It is like test-driven development model. There you have to write code that passes
> the tests. Not argue against the tests.

Again, don't focus on the tool... Tool is just a tool...

Best regards,
Krzysztof
