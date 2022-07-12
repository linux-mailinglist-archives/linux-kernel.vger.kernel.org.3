Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FD05712D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiGLHLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGLHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:11:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FB62AE2D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:11:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bx13so8854507ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QEUyx0E9n8vFcgYZZ5+oGz1HVwAvbqPb8QwcUhO4wh8=;
        b=pblwCANp624g23t3MmHXm13+zksran9Vfismaduy4g67uAj8xvi/xaROG1iXc2qy9+
         SJqD8n1mg0jTfBRdlTzlVe9/0ezZbtVDWWdjYZV74TMB9at7CyoSIxh5FBwdIeWypfy9
         9nq/rWlA2/EmBgB0DKUdSB4J4MJBmuFYXpKHzNqDs0Dai6ThkkJIr4Jpg+5SxuP2MaiC
         RN7gZRV0Pb1QP5EKvz9H0WMwdNiCMz6S+0rWji1VaqUvgn0zu36oMrPZMpDDTWbNHcrT
         U/kn4UY9ZgQhjL8w7kZemkaXCpcqOvE9L4hspvcYI4Qh7iu220I9SIyg7d9D+StczKwG
         gIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QEUyx0E9n8vFcgYZZ5+oGz1HVwAvbqPb8QwcUhO4wh8=;
        b=wttkt/w5dnPxvhPZDWfZF+CU/w9SBS1IOh9/1h6c3asyO63kpt8AbglktOIhbhHnR2
         A5n9dUTJREXjXqMhzL/rMRdaIHlMZacJL4VKpNLtZIK9mdWu5bqau+AJ0oLnJSG4RrSQ
         GXAmfsORE71K0b7MEKV4AHF6mAyvsP79h8FaNnvEhb3w5Uyo6BYGxMgtYip3b9mgb5H/
         27cG4uSuAKvjnRiGEqIZBktCxjApZZQM2m4F5cD2LB5rDmqnoGm/xqq21pn3WUa/Nnn6
         v+WPHWHgS0TsdSFB0QeEksMhIxeto918mBBJ60ZFuXo1l5qCoVCTEiSnW5U89TrWxsb6
         ZCtA==
X-Gm-Message-State: AJIora9muoIX2XW187kHA+k5s6LXltWweuApoXEWzc09sKWOSuf/eCZb
        UZSUfJns1lvRGoZnsfXsbCpdtA==
X-Google-Smtp-Source: AGRyM1sZ2tKhjXGOykefiUQc+wQu3O3VZEElIodcEfttcGfucNFdJm4CvcLdTZAlaGm46CP46fxOJQ==
X-Received: by 2002:a2e:96c1:0:b0:258:e8ec:3889 with SMTP id d1-20020a2e96c1000000b00258e8ec3889mr12162830ljj.6.1657609862335;
        Tue, 12 Jul 2022 00:11:02 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b0047f8cb94004sm2024781lfk.35.2022.07.12.00.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:11:01 -0700 (PDT)
Message-ID: <09c11a48-fb3f-8fde-c530-dc13f5cf4bf6@linaro.org>
Date:   Tue, 12 Jul 2022 09:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v3 0/3] dt-bindings: input: gpio-keys: apply via DT
 tree
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Input <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220705120356.94876-1-krzysztof.kozlowski@linaro.org>
 <CAL_Jsq+LepF_67SJUqQ5mUO-TZAd-46LB+aYE5rZmnmmwMg=bw@mail.gmail.com>
 <352f27e7-0da1-4a4a-83a4-ded370dfbd7f@linaro.org>
 <YsiVH41gCLeIMyd6@google.com> <20220708220507.GA1557227-robh@kernel.org>
 <YsiuRbaFMa683H1Z@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsiuRbaFMa683H1Z@google.com>
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

On 09/07/2022 00:23, Dmitry Torokhov wrote:
>>> I am sorry but what series/branch this series is based on? I tried
>>> applying but there are conflicts. The latest I have that is touching
>>> gpio-keys.yaml is:
>>>
>>> 4fda8a2df83a dt-bindings: input: use generic node names
>>
>> This one from me:
>>
>> https://lore.kernel.org/all/20220608211207.2058487-1-robh@kernel.org/
> 
> Ah, I see, thank you. Applied the lot.

Great! Thank you.

Best regards,
Krzysztof
