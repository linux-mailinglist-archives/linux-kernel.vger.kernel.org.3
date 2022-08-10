Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4858EBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiHJMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHJMTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:19:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96C6B667
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:19:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a9so20943180lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=myQMBe3dwrevdO2JGxUDk/fF0+55fhk32rX1+0alrrs=;
        b=VVGXe9dhG2oS2Ld1u+R2bj7nrCU1tsjv6N4+obpAqjU3mds7QeC1iQZnSxWYbYlnoM
         TjVNQR2Q5LI842Qwym/VDLdm4A+RcnCUV6kTAHYui1h4lMTRsSVWUrsyyjtc9GX/GCq+
         /rjkl4IRhXP7hqKesPHSxvpN6gv2d9OVYWG2y4uEj1a/utULFbC9ubyEv6jHGj8g/erR
         EvB0YbHX611uw3KNDn+otvq+2KpHfKGkkBrTD+qzLYvwGJOvyOHXJ1FYlArfN0zGmHfa
         gFIMc3ny0fzqxCxsfG/gzOU1FE25pzDxpsCI+0hWbstgyZZ6pd4qblkbwKjcumsgR3b0
         p54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=myQMBe3dwrevdO2JGxUDk/fF0+55fhk32rX1+0alrrs=;
        b=NM6tIF0RjQYw8k7WtF0mjLXFesDTEj/svJopCdlOEbWWDFBLFWW3pQJfhO3hJqpWo5
         vromiUGsx4uKnEmfNWYu+IcWpTdzrq0g1wasre3SGrmwC2H3+RS6l9y2U7+pLFtIqJ0S
         YyKVy/dlyewQN2SRA3rnC9wodYsvqqSVDViC8pC1UiEcf+5W+gQe/JmvWVSbAXI7ENYs
         aRulfhzfHjSHFHFhc6Os0UUotfhzDmua13DnzDFFnwLSwh0qmiS06EOijkyeX2IwCuVk
         EqoIws/eaqMdZTxgyuRoM92y6D3O4vVNL8PmMZDwNC3QQKyud/9Jf9NSNVXNoq1qdxZi
         1FxQ==
X-Gm-Message-State: ACgBeo2VZG6pis0Qm89gkvGonAcZ8vJi4g6mCKV1GUxDzpXfBURXxha5
        pIRHtfBI3jdoNAaVAThvojE=
X-Google-Smtp-Source: AA6agR4Xy64LCeVIFkDvp1HbK+NyHL7dUF0JKCNTOYARj+osIUHH9ShHMQH/XAdUYP+bBrPSzn1qhQ==
X-Received: by 2002:a05:6512:1191:b0:48c:dfc9:9e9c with SMTP id g17-20020a056512119100b0048cdfc99e9cmr5737994lfr.3.1660133946767;
        Wed, 10 Aug 2022 05:19:06 -0700 (PDT)
Received: from [172.16.191.151] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l10-20020a19c20a000000b0048b03ec561fsm322736lfc.150.2022.08.10.05.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 05:19:06 -0700 (PDT)
Message-ID: <e8900490-1eec-83d8-b190-6d6983d81c4a@gmail.com>
Date:   Wed, 10 Aug 2022 15:19:05 +0300
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
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH 2/7] regulator: Add devm helpers for get and enable
In-Reply-To: <YvOdBv0edrE3wKsO@sirena.org.uk>
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

Hi deee Ho Mark,

Long time no chat. Glad that you had the time to check this series :)

On 8/10/22 14:56, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 02:29:55PM +0300, Matti Vaittinen wrote:
>> A few regulator consumer drivers seem to be just getting a regulator,
>> enabling it and registering a devm-action to disable the regulator at
>> the driver detach and then forget about it.
>>
>> We can simplify this a bit by adding a devm-helper for this pattern.
>> Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()
> 
> I'm really not keen on the idea of a devm managed enable, it's too prone
> to bugs when someone gets round to implementing runtime PM.

I see. And I agree the devm-based regulator disable can cause problems 
when combined with manual disable/enable.

In order to tackle the issue the suggested API does not return handle to 
the regulators - it really just provides the "get'n enable, then forget" 
solution. The consumers who use the suggested API to "devm get'n enable" 
will have had time manually controlling the regulator afterwards as they 
will not get the handle. I would almost claim that the pattern we 
nowadays see (devm_get, enable, add_action_or_reset(disable())) is more 
error prone as users seem to in many case be storing the regulator 
handle w/o any comment about the automated disable at detach.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
