Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F815B15B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIHHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIHHdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:33:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B3A1D48;
        Thu,  8 Sep 2022 00:33:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x1so12634776plv.5;
        Thu, 08 Sep 2022 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=B8tgrxk79xHPz1l1wMBtMK+SqLA6DxQq1jBnPGwyQdw=;
        b=Q2Re0VL533BkmGPXbTegt5bw9YtJZsBIbhzfnqYTFbsj4seIovNfeXuOrNs7q+A9iB
         6fiTzLzck4t6kmADNojQ3nbPqs0VFhL/HL0dgw9w15700bauQggqdIsh6GipozpiY1H1
         ARM2G7LvrSLkI5AVdmbFVfJymyvXUEAs9cnJzcqWxo/hACBSFjNYnz/cPBbLz7USbaph
         n+4b4vXjh7HqxVdzYXSzaOQCkMZYwlPgidJv6YapBrO2UPJq0xH1M4NBledbQGThG+4t
         pS6l4pW05Voe3j6JNrZaQeqo5R1Ll5EV8aIMrLsVnmoF9r6d3fmlDpEiGipiee6yPlAy
         IJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B8tgrxk79xHPz1l1wMBtMK+SqLA6DxQq1jBnPGwyQdw=;
        b=p6nJTeb5ownuoCs44odHoIfnTuQBZxtvpMuGz4PIQdFF9UkVWV9A6KWMnM9KeLWvKb
         +Ipzdtti0XbR5ZROkyypL7OP1K2DLm4eGjvKjaSPHv5GrYfPfd1quI3cqgY1/hTYzQJs
         ch1jpp4HXYNIPkg4xKAyf+IrZHk24ZmibzHUbHMmFgVZKeINudLP/b32fQQGtN4RpUpP
         0l3JW2aBpIxNxZqM4qFkIZWTTrPFjhoeFVIIM0+V0o1The75cpHcWjLmIgZvdc3Ecq8N
         qGt/O9RffNZrsNlnqAY6T9ZUxvr3hwixAy30z65O95OMSJ4mCkMSWly7OeO3nUwZk24f
         nnJw==
X-Gm-Message-State: ACgBeo0dZF3Ro2d+qqKIYQ2eZbGNc3sWBfe/Lm/ZBX7lqReNp+gEiJEH
        yW8+vzqkTm7Ve9sRxTOempM=
X-Google-Smtp-Source: AA6agR4PSHVFRGYzYiymC5ZQ8p/qRragiKAoPQMeOY/ALRkyDJHEi4S1+kNMKsc4IBElgaOBqHSctg==
X-Received: by 2002:a17:90a:ab0a:b0:200:9339:3935 with SMTP id m10-20020a17090aab0a00b0020093393935mr2672902pjq.141.1662622382049;
        Thu, 08 Sep 2022 00:33:02 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id z6-20020a623306000000b005321340753fsm5620781pfz.103.2022.09.08.00.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 00:33:01 -0700 (PDT)
Message-ID: <dda8346f-2cfb-4d85-607c-553625cc98d4@gmail.com>
Date:   Thu, 8 Sep 2022 14:32:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [v7 00/14] Add support for Bosch BNO055 IMU
Content-Language: en-US
To:     andrea.merello@gmail.com
Cc:     andrea.merello@iit.it, jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org
References: <20220907132205.28021-1-andrea.merello@iit.it>
 <1b30d814-3570-1cb7-573b-9bca90d5d3fd@gmail.com>
 <CAN8YU5P1qjKtmSskA_+vLMnC6wHFmhk4ZvP+a-9KLr0OsY0FdA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAN8YU5P1qjKtmSskA_+vLMnC6wHFmhk4ZvP+a-9KLr0OsY0FdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 13:51, Andrea Merello wrote:
>> Rebased on what tree (and what commit)? I can't cleanly apply patch
>> [05/14].
> 
> Sorry, it looks like I've raced against recent updates on iio-togreg
> branch (i.e. I've rebased, then I've got preemped by something else,
> then I've tested and sent the series some days later - I should have
> rebased again).
> 
> BTW patches can be applied on the top of this
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=2bc9cd66eb25d0fefbb081421d6586495e25840e
> 
> I'll prepare a v8 anyway.
> 

OK.

Don't forget to pass --base to git-format-patch(1) when preparing v8.

-- 
An old man doll... just what I always wanted! - Clara
