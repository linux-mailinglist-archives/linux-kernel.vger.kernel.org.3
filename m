Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E559AE74
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347277AbiHTNU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345255AbiHTNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:20:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD405FAE9;
        Sat, 20 Aug 2022 06:20:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id be9so1507884lfb.12;
        Sat, 20 Aug 2022 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Lke/73Rmp7niK35XJWyQl9ZIar7NTQjMK2P4iameEwY=;
        b=E4jklSQ5qHbB8qMlEKLH+rUzmbn/jD1XuQr6SAGAMb6YF2waNdNYo5QlKYvXqDd4Ew
         KxAYkKSohiNzqz887rp3yWgD3ncAREknVlVTKQMDj3rt5V9R05lU4Jm6aLbvqSYCBYTX
         FbNykDB4bEDwunK/fYVDjI7DnzEf+Q7KaMMJsS/SkZX1AnyTlwRtqDUn1vu2rNBL2VUg
         onchQJbdvfwXtSxhwixbELZj5WaEovSasZxk94N3zevUROM/6juja5TctlPktOskqSul
         oKV872QGQEGVJyYIpecNYI0T5Wynxe2sgJ/dGJu6fC7NT9ihO7hKxm/2anPhNGTaUtE7
         OxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Lke/73Rmp7niK35XJWyQl9ZIar7NTQjMK2P4iameEwY=;
        b=IHtYgOtxKiDGgrq3+mwHxW3ApqqQJUrvuWf1OSr03FkS1EzeW0crA4/szUbA2NfYOY
         liGk3fJHfo1DI++jTOvwKWKWAJjPt91pdc0gHrTzDRJjbxgmVAJYrJv95aV+mMtGhLih
         f7EFnYlbdQIm221zv+/QNA/1HelBwBOHMECIjU6SAuSa/I//zz+0Sy66frTDfm9R7M7+
         VDx+MYp21g4Y2P16p/PN79isZOJu61q9ckbiPc3SQegpZ5OyS2hrLfmMOebGeNKCQ6y1
         cqPPaHksZWji8Vqu2TN7kSV6n90hAendzK8pEVJdKm1P368g3k/RAoLi5uJvOiRlyjj/
         ZArg==
X-Gm-Message-State: ACgBeo0pqIEH77hSJK3fV0sx17f/W0Y0Ftfc6YR95VJkM6FcSLM5gr0C
        eQdGqPS1CxgbE2ABSOTTcDc=
X-Google-Smtp-Source: AA6agR4iz98u2SmAALSSfpkdr55/2vxSWyxpTa98t8EU+8OPSU/bYEVcE9KuYxU4CYDpvEFF1e2T4g==
X-Received: by 2002:a05:6512:3fa2:b0:48a:16df:266f with SMTP id x34-20020a0565123fa200b0048a16df266fmr3930967lfa.414.1661001648243;
        Sat, 20 Aug 2022 06:20:48 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w17-20020ac25991000000b00477c0365b20sm1065753lfn.188.2022.08.20.06.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:20:47 -0700 (PDT)
Message-ID: <f0776904-7eff-8bbb-0ea9-f99379c8a200@gmail.com>
Date:   Sat, 20 Aug 2022 16:20:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
 <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com>
 <20220820123707.7f075381@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220820123707.7f075381@jic23-huawei>
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

On 8/20/22 14:38, Jonathan Cameron wrote:
> On Sat, 20 Aug 2022 06:19:00 +0000
> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> 
>> Thanks for the review Andy
>>
>> On 8/20/22 02:30, Andy Shevchenko wrote:
>>> On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
>>> <mazziesaccount@gmail.com> wrote:
>> >>I
>> don't expect this to be merged before the dependency is in rc1 - so I
>> guess I will anyways need to respin this for next cycle. I can do the
>> styling then.
> I was a bit surprised Mark didn't do an immutable branch for this, but
> indeed looks like it's going to be a multiple cycle thing - so we'll
> probably have a bunch of new cases introduced in the meantime that
> we need to tidy up.  Ah well.
>

I guess we can ask Mark what he thinks of the immutable branch ;) I 
admit I am not too keen on rebasing this - especially if I find the time 
to go through more drivers.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
