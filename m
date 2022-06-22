Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD3554ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353684AbiFVNUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiFVNUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:20:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A22F02A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:20:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a14so6470399pgh.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OSbRySHuWSrgsTpq6XAtnwt3bZpv/W9+tRxkj/bYpYs=;
        b=Qwhp+OrdMAdNWOeOaJaEnz1qGNlP1dw9UtJoiaJQQD5M8tHpEVYjnMv5PIOaEENNVn
         WIMSFX8UUPoIpa9ZoCurbMcI/uvZyYybXN1qTPAMowSR0iMvYbE6SS64TjlAUHLhaCQY
         UA9jFy6GLmf7ExWpUViVxvicpba/Q3gahmfzUM6va7UJyzmH7Fg//bZbhnsZGQ5EOIZc
         V3jB6BvBDVFZsQ0ci4KIOfSQkI/5CjY6TB543Z1sQBw5Z0Kel3k8MkV8CRpUszOpjbM4
         vFhEshNEl/PCBoAxg6afEsOuHCXYn+8STPYm4ZYbmMfffIp0RJZC0CuMZNAaEZmfEn4G
         GoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OSbRySHuWSrgsTpq6XAtnwt3bZpv/W9+tRxkj/bYpYs=;
        b=dnJ+8VFvJVA+fVtcmkbRXQqrQrCC/vJNec1tk0Qx8utCe1mtnj7JKapw80qzXJtl16
         8v0zB8zklz7VWJPmdL1iulYNe5uMlDiewUHDxNlvTEItSNnH+Af3PjPkbVoG7516v5Iq
         m7bMjhduy8cyYD6yHgH84dQqHjqBM1SYkS/14MxokqEFNmXqf69zFvotaXhY3mh9XHJM
         7lxhPNXP9VbocaRPWVNH/fv5ztYDhz5JP955HecDdH0z+ROGsVqJa8lvhfC3ngXd4Jxd
         DY+wkT5dzTe3YrGUJtiMBbulTnhNTWHrEnRD1wXc+5F89yZdISpUNtv8G3Qp3VtFt4c3
         hBcg==
X-Gm-Message-State: AJIora8BDJ1ko7bvQ4JsIPY0Fa/zK1cCaJdTytUo5xUNX3OBPM5BRW/Q
        JvK20yq3qTxwfpSmVs1ZML5QDXQmYgg=
X-Google-Smtp-Source: AGRyM1u3CuDYhKlMipHDVRcmY+JMnUFve2UiQB+/X+R5r7Xlr6SQoFTJgAy5rSwllcicH2sJtMdkCQ==
X-Received: by 2002:aa7:8091:0:b0:525:27cb:19ef with SMTP id v17-20020aa78091000000b0052527cb19efmr13944086pff.37.1655904009021;
        Wed, 22 Jun 2022 06:20:09 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-83.three.co.id. [180.214.232.83])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709027e8600b0016a3b5a46efsm3400089pla.113.2022.06.22.06.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 06:20:07 -0700 (PDT)
Message-ID: <1b34e0e5-23aa-96cd-c37f-1434884ff061@gmail.com>
Date:   Wed, 22 Jun 2022 20:20:03 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
 <YrLTCXLrr3HB39lv@debian.me>
 <4cef89c9-3b27-11e8-2971-66b93b847ede@synopsys.com>
 <alpine.DEB.2.22.394.2206220513590.2646@hadrien>
 <46e4b588-d35b-ec50-ad1a-8502c2903677@synopsys.com>
 <alpine.DEB.2.22.394.2206220535300.2646@hadrien>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2206220535300.2646@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/22 16:38, Julia Lawall wrote:
>>> So code that is fine will have typos forever?  Fixing typos in comments
>>> doesn't break git blame for the following code.  And typos in comments
>>> give a bad impression about the state of the code in general.
>>
>> Of course not! Documentation is as important as the code, if not even more.
>> However, fixing typos to increase your commit counts to a reputable project
>> is not fine either. For instance, many of these proposed fixes are targeting
>> one single typo at a time. Couldn't they just be sent altogether!?!
> 
> I have the impression that the person is just trying to figure out the
> patch submission process.  For example, the subject lines are not
> formatter in the standard way (I sent the person a private email about
> that).  Perhaps just let him know about how you would rather have received
> the patches.

In recent times I had seen many typofix patches sent to LKML. You can see most
of them by querying `s:"fix typo"` on lore.kernel.org. Some of these patches
have been merged, though.

What I say as starter thread is "ideal" scenario as described in
Documentation/process/2.Process.rst; that is we prefer to see these minor
fixes as part of real patches work (say refactoring), rather than just being
trivial patches.

But what most reviewers here missed is how these typos are found? I guess
these can be from codespell or some other tools, or even manual review,
then send the fixes en mass.

Take a look at "fix typo in a comment" aka "delete redundant word" patches
at [1], [2], [3]. and [4].

[1]: https://lore.kernel.org/lkml/20220618132659.17100-1-wangxiang@cdjrlc.com/
[2]: https://lore.kernel.org/lkml/20220618130349.11507-1-wangxiang@cdjrlc.com/
[3]: https://lore.kernel.org/lkml/20220616163830.11366-1-wangxiang@cdjrlc.com/
[4]: https://lore.kernel.org/lkml/20220606123419.29109-1-wangxiang@cdjrlc.com/

IMHO, these patches should have been in a single, consolidated patch, since
these strip duplicate (hence redundant) word (single logical change).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
