Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5645824AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiG0Kmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0Kmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:42:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A784AE67;
        Wed, 27 Jul 2022 03:42:51 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 12so15361808pga.1;
        Wed, 27 Jul 2022 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jPh7uktVXCUcDi+x9xgNFg5nV00zWemJcuBnfAdCfNY=;
        b=TAMkzfh3IcQnP+ZBfX7bzgfWHwpEqtcSHfiMrla0axfMwDmmBQEdHWmPvMhGEpEPRB
         AVbBhzagwvKh1XaWbt8F+ClMNJ5Nz+wG6MfF+RswTwEjjxtqxBFr4IieFS+16KHcDh6t
         sYjvMAUZ7oM2eX/Dtz137QTR6eWBDLg5dEqqNs9MkXBUqUh8FOSWhCQ1N51wA7Sl2N3q
         aR1e4Xa9VaHvuy+vr+sMgQ/+ZhElcL9K078rVs5Srk33oXezlZjxRCmRqqwSRemMKHMG
         gpD0wvg0tDdawXFm0YHPsSaVqOlZ4TkI2br8eh2e0TavTn5Rf1qI7YG2yGaLEsPxnFz/
         dnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jPh7uktVXCUcDi+x9xgNFg5nV00zWemJcuBnfAdCfNY=;
        b=0nvILFQYiUbCKVRm/qWQggXy+0ErSlygbuCjSaqxMuUI8R/rHEGYklWHVqrF+b/aFF
         bVObQrCsm4HGMZD82qA8ytrgVoebqLlmApCXevbxS6QDRPQSj+u3Hg69SjKtJ+Vb/sdM
         m/TUh8g89zVk3K99OWjob5zZMlgc2Tkj3hY2lgvVY4dYSBSBCETjJ0qjsXlB3Hm0VxXn
         gPW9nCQepixVahztj3c0dRxW45BXWpYp9luhVJDL/iyIOOb4spHrXqLk/TNMKLP7Yts6
         9PDZFD0sQv9kEt9E5V0Nc8AIzXbOw09LJZFNi1dj/GLZz8UEZSeCR7S/wE+bIOAej25J
         nnAg==
X-Gm-Message-State: AJIora8cXcWip3G4iBZtrvgTpm4d2Bjl3DizfDd5pzav9kCLPaLaZtMa
        4edwplKH1TMNRaw+iDprp6E=
X-Google-Smtp-Source: AGRyM1sBf18kiqMrbxu3YudWfR/7hAvf+yJEXx8m+97W7VXq//ragsgY2eKqqdHwmRzQP427xcPz6A==
X-Received: by 2002:a63:6909:0:b0:411:994d:1e3e with SMTP id e9-20020a636909000000b00411994d1e3emr18177086pgc.227.1658918570581;
        Wed, 27 Jul 2022 03:42:50 -0700 (PDT)
Received: from [10.10.4.41] (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id x9-20020a634849000000b0041b3c112b1esm1851741pgk.29.2022.07.27.03.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:42:49 -0700 (PDT)
Message-ID: <a385e266-b24e-7ffb-c083-891edd4b0b14@gmail.com>
Date:   Wed, 27 Jul 2022 18:40:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] iio: humidity: hdc100x: add manufacturer and
 device ID cehck
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220727064415.940690-1-potin.lai.pt@gmail.com>
 <CAHp75VfNmq12Yv7mqVeijqK0vwRdPsSrH5wMzg9qR15+t7ArSQ@mail.gmail.com>
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <CAHp75VfNmq12Yv7mqVeijqK0vwRdPsSrH5wMzg9qR15+t7ArSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/22 18:00, Andy Shevchenko wrote:
> On Wed, Jul 27, 2022 at 8:46 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
>> Add manufacturer and device ID checking during probe, and skip the
>> checking if chip model not supported.
>>
>> Supported:
>> - HDC1000
>> - HDC1010
>> - HDC1050
>> - HDC1080
>>
>> Not supported:
>> - HDC1008
> Thanks for an update, my comments below.
>
> ...
>
>> +       const struct of_device_id *match;
> Don't you have a compiler warning? Always compile your code with `make W=1`
>
> ...

You are correct, I will remove this unused variable.

>> +       data = device_get_match_data(&client->dev);
>> +       if (data) {
> This check is redundant. Too much protective programming. Just oblige
> that matched ID has to always have an associated data.
Is it guaranteed that device_get_match_data will not return NULL? I find some examples in other drivers, all of them have a check on returned data.

Will it be more appropriate if I move device_get_match_data to probe function, and return EINVAL when we get a NULL pointer from device_get_match_data?

>> +               if (!data->support_mfr_check)
>> +                       return true;
>> +       }
> ...
>
>> -       .probe = hdc100x_probe,
>> +       .probe_new = hdc100x_probe,
> Make this a separate patch before the presented one.
>
got it, will move this into a separate patch in next version.

thanks,
Potin

