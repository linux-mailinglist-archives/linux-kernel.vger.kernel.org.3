Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5A58F708
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiHKEu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiHKEux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:50:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1077F647E2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:50:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z6so16606380lfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=evbV2QSTh0jjb46dPJrBnRBIm6kqkgOSimjCzn6KZ6w=;
        b=B4WZkBZwZpVAxOKJXSp9lcyLT5gyyb2X3AWF8Xnmy2GIoylCEaK6I1czwsX/PHlU4V
         hmxMBUvSpMXmaRpjiAe/nOCHrZCu2D+F8fU+l6ZvgncszfBuJPF4DtXTwkdJI9l89hgo
         jLgih0AbwHLwRfbIvFg4uanGq1M5NCZlgV2mCHGvHZm6S/DQbljK5gRec8bL+XQJR4mh
         aWA1qBwk4/XXKGnKBR3ioFY/XZ6T8OcV75eVyhpdp6Fnra9K/eRZFmZzh12dFEPyEO9Y
         KP4o30+OiWtpoOfMJc/D4E4PMSnRWfMO2MeGCYMPKKa8zFvR5AHe5ByjELVCeTaFXdmH
         Qayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=evbV2QSTh0jjb46dPJrBnRBIm6kqkgOSimjCzn6KZ6w=;
        b=x6F/i1WIPvzszEXhROUxJ4YYztJQ2MTenYEBUkQFhvdEytmEIIYyNs+FGgRHZ2yO2M
         0UlX+zPn4HExvoZAKJpsdHB0KJs/4/4MV/9y9qFkjWk3OpliEDc8sKtvJFRFZfDZMdv6
         PZQvqos97LWw7IphXrcAY4/W/euY36ohq5LC4uumImL30RBzPl1XNKFWO61C4qI/qVNU
         JqLahmHH0O25oanB7KH7UUNoCXuGjewxiLRLhoePSeCvMWKoKGFv6c590H33otp0bvbV
         ZXpNAnEoTxxfwdqSfestPkqvpUWbxz7SGHbbRjAKkfbbME8IzLVkGW6gF8FxRNmg61Sg
         yEwQ==
X-Gm-Message-State: ACgBeo0P8eBEuREAt4m1M82A3kdXN9zxzJ1JWQMEJHc1NUjU7HMzpkRS
        7VJCdW/0b69JzsnTWLGKcfx5e7WpTg8=
X-Google-Smtp-Source: AA6agR6ZnnADrcuc6bkXwME7gPBgMJo5C2/QlR5eeXIuMbjUeQRtfjWOsd7GvXy7ChKPskMYMTaCRQ==
X-Received: by 2002:a05:6512:4016:b0:48b:1e96:af0f with SMTP id br22-20020a056512401600b0048b1e96af0fmr11716360lfb.359.1660193450253;
        Wed, 10 Aug 2022 21:50:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16ee:fa00::9? (dc73szyyyyyyyyyyyyyft-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::9])
        by smtp.gmail.com with ESMTPSA id f19-20020a056512361300b0048a8f119e7esm563636lfs.233.2022.08.10.21.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 21:50:49 -0700 (PDT)
Message-ID: <b17dccb5-79f1-a70b-37f6-129e20f27cfc@gmail.com>
Date:   Thu, 11 Aug 2022 07:50:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1660127865.git.mazziesaccount@gmail.com>
 <b6058e052b842a19c8bb639798d8692cd0e7589f.1660127865.git.mazziesaccount@gmail.com>
 <YvOdBv0edrE3wKsO@sirena.org.uk>
 <e8900490-1eec-83d8-b190-6d6983d81c4a@gmail.com>
 <YvPLx5hizWMEBjVK@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 2/7] regulator: Add devm helpers for get and enable
In-Reply-To: <YvPLx5hizWMEBjVK@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/10/22 18:16, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 03:19:05PM +0300, Matti Vaittinen wrote:
> 
>> In order to tackle the issue the suggested API does not return handle to the
>> regulators - it really just provides the "get'n enable, then forget"
>> solution. The consumers who use the suggested API to "devm get'n enable"
>> will have had time manually controlling the regulator afterwards as they
>> will not get the handle. I would almost claim that the pattern we nowadays
>> see (devm_get, enable, add_action_or_reset(disable())) is more error prone
>> as users seem to in many case be storing the regulator handle w/o any
>> comment about the automated disable at detach.
> 
> Hrm, right - that does help with that case.  However we do need a bulk
> version since that's an obvious problem case.
I'll take a look at the bulk APIs and add them if they're not too 
complex. I'm a bit short on time as I was told I should be doing 
something we can show to a customer ;)

As a result of this discussion - not returning the handle to struct 
regulator * sounds like a safest option here. I'll drop the RFC when I 
respin this (hopefully with the bulk-APIs and a few more converted drivers)

Thanks for the input!

Best Regards
	Matti Vaittinen

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
