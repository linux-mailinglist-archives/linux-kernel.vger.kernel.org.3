Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183724F7165
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiDGBaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiDGBUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:20:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B09B3685
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 18:16:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s137so942682pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 18:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XEH2/iJSIuFDfccdM1u0P17EAr+Um5R1hy9qLgtDR4M=;
        b=OA772vpHfAHBIugPh/XQtfpHmDsxqkQi1/UBaoCG494fupS3OiR5177KLxWxK+Anul
         kVBwCein30GC1DSn9oNgOdwt/4xuUnFmA83pb9Oy1XlrpC7mrRwculkEPmkgorr7Nvw3
         FxUpTqtK+QFzZ7EwGcFWcBL+vJ9AZiCQyYyPRqYOXlqVLzp2Xz0w8OJWK2Tnd84fpF4b
         eVYFEZGYjNCZ/TWfirUGtKstsDJ1e8mtg1Y1LInzT9rNq5LxsXEsLlTBXEIykz6I1BMS
         hH8z9FSKXAEWAIwM5IamgQQ3kd3OZhSm6JhdSg6ppXJDixVNwrOInkzAexuVe6NuE0QY
         P4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XEH2/iJSIuFDfccdM1u0P17EAr+Um5R1hy9qLgtDR4M=;
        b=2o/yOul19rh1p4NKP5cTHrTYcvY1SqWSsGoSDE/i0VqdEDrcLTEYueeNGpSBk9ndRp
         aDsa0QxBZ3cf4tqS+8k8JWmMVTRax1rcmTqXf4sxZ3ToYkiMatV8LRazpSX+xgEQTPtd
         ZkaCw5RzPZ+dbyM/PPJ3DG2oDLPnLqNtJpt/hzuCnIj+zUetJbYCVc0MOE1SlxGoWpOX
         rro7MbWaKITdmnPRYuMSJfOh1/xYgS1fpbmy76vCN+Y2a/M6M5ut2as2Zfc1sLKgVAY2
         BPDwtxN6zjJaYrNEZ7dLDBosuoBWuejHOjFbYhnBwdjmA7lwKezq6+pW1fkDtgj1rwyc
         GDlg==
X-Gm-Message-State: AOAM532o/CL9FVqLOE04TowF38BDafnQCSSkhImBVZxkPQ0QbDuiML8z
        Pl0TJIjny3eELc+HyNXV0xQ=
X-Google-Smtp-Source: ABdhPJxeut6cNaSvd6pF6Lvv5nTN8xCifWxFyWzc6LiaKMmh7lwfZfm9eAReqpDY1PNuJQjaIqoOHw==
X-Received: by 2002:a05:6a00:1488:b0:4fa:ac61:8b11 with SMTP id v8-20020a056a00148800b004faac618b11mr12031950pfu.58.1649294199390;
        Wed, 06 Apr 2022 18:16:39 -0700 (PDT)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id i187-20020a62c1c4000000b004faafada2ffsm21107363pfg.204.2022.04.06.18.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 18:16:38 -0700 (PDT)
Message-ID: <033c1ec4-4bee-a689-140c-9694dfee435b@gmail.com>
Date:   Thu, 7 Apr 2022 10:16:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
Content-Language: en-US
To:     Guenter Roeck <groeck@google.com>,
        Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
 <Yk4DGZfpYbK8dofL@chromium.org>
 <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CABXOdTcY3w56hc7kWsDLxKU-c6fCLYt_jigK13tKjjm9OHi2+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/07 6:32, Guenter Roeck wrote:
> On Wed, Apr 6, 2022 at 2:16 PM Prashant Malani <pmalani@chromium.org> wrote:
>>
>> Hi Akihiko,
>>
>> Thanks for the patch.
>>
>> On Apr 04 13:11, Akihiko Odaki wrote:
>>> The EC driver may not be initialized when cros_typec_probe is called,
>>> particulary when CONFIG_CROS_EC_CHARDEV=m.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
>>> ---
>>>   drivers/platform/chrome/cros_ec_typec.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>>> index 4bd2752c0823..7cb2e35c4ded 100644
>>> --- a/drivers/platform/chrome/cros_ec_typec.c
>>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>>> @@ -1084,6 +1084,9 @@ static int cros_typec_probe(struct platform_device *pdev)
>>>        }
>>>
>>>        ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
>>> +     if (!ec_dev)
>>> +             return -EPROBE_DEFER;
>>> +
>>
>> Just a quick check: are you still seeing this issue with 5.18-rc1, which
>> contains a null check for the parent EC device [1] ?

Yes, I'm seeing this problem with the check.

>>
> 
> I may be missing something, but from the context I suspect this may
> make the problem worse. My understanding was that the problem was seen
> specifically if CONFIG_CROS_EC_CHARDEV=m. In that situation, it
> appears that the parent EC device does _not yet_ exist. If the driver
> returns -ENODEV in that situation, it will never be instantiated. The
> big question for me is why the type C device is instantiated in the
> first place if the parent EC device does not [yet] exist. I have not
> been able to identify the code path where this happens. >
> There is a similar problem with other EC child devices which are also
> sometimes instantiated even though the parent EC device does not exist
> (ie dev_get_drvdata(pdev->dev.parent) returns NULL). That can happen
> if the parent EC device instantiation fails because of EC
> communication errors (see https://b.corp.google.com/issues/228118385
> for examples [sorry, internal only, I can't make it public]). I think
> we need to track down why that happens and prevent child devices from
> being instantiated in the first place instead of trying to work around
> the problem in the child drivers.

Well, I think you have two misunderstanding.

1. The parent exists and dev_get_drvdata(pdev->dev.parent) returns 
non-NULL value. However, dev_get_drvdata(&typec->ec->ec->dev) returns 
NULL. (Yes, that is confusing.) I'm wondering 
dev_get_drvdata(pdev->dev.parent) returned NULL in the following crash 
log but it would be a problem distinct from what is handled with my patch:
https://lore.kernel.org/lkml/CABXOdTe9u_DW=NZM1-J120Gu1gibDy8SsgHP3bJwwLsE_iuLAQ@mail.gmail.com/

2. My patch returns -EPROBE_DEFER instead of -ENODEV and I confirmed it 
will eventually be instantiated.

Regards,
Akihiko Odaki

> 
> Guenter
> 
>> Thanks,
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/chrome?id=ffebd90532728086007038986900426544e3df4e

