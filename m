Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E00565EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiGDVOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:14:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACFC626D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:14:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id cl1so14946621wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SQNaogcvrfpgtg7UQ9S2wlJiM9wxHzq7S9766wbvx3o=;
        b=idWwdlKr/Jg63bwItDlgtWaz85etsChjYVlARgFoAdboxl7Ku5k4GD4bkLf9ioeACE
         BpDt9lQU/bNZ4RCIEg23oUttSqFm/LNn1Sp7GSaYxYQHQhqaC8i/zOhRGpVUueQoEZHz
         y1mydagupxaiqJyrKkqHRWEteedLM888WJNOwmGytqe1cLe4spQZmUuCuzAPacRIH35b
         cx2ayqXuvvhvES85ElcKb80rAU4h64LUZ5bNB1fjJt/jjK+yQWfbkD30OLCS8Uy6P+2z
         G5zn1dYGAPgA9OIdYs4Gfxx+2lbsww51UTMoEfNbJhn0yHXAt+tgQI3wadHLfPBIph21
         bSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SQNaogcvrfpgtg7UQ9S2wlJiM9wxHzq7S9766wbvx3o=;
        b=MjMkoUviQC5eLyD87H9kvXygnPLnvyxXzZ1o5ufO0lvoeipjnnJsTjQyQhsShIw7mV
         wjP/kKyHlpgqHpUoym9Pks6CsA7n8rtTGzXlgPLD3X2k0IGs5jLZki+gbIEVrvQolbdp
         aTOv0foaR9t1HYiCz0HW7HKmAJuKDYakyBteulSp/ly9id3Et2yDenMBf/QRwY7QYc2h
         lRBO3HwvMFgUGi1HOYP+hs4JocJk6NVlu5z9I3A6vUcwiVT1OLwlMltbsh2KTiEfN13L
         4OGMHX4cDTXTzFBqCh6+vemJXlD6UDVOplCpKJOtOqKygvOjf88GjqABS0o5SzsG3rCk
         fqDA==
X-Gm-Message-State: AJIora9NJ8EfaMblvIn9o22GVniQLy4c/t7b3JPP8fNCAvTvoONKxeky
        KiYqHtR7BhhGYExLaea9WRfuHQ==
X-Google-Smtp-Source: AGRyM1vX5Oj5Ayx0OoJOY7mYDM2kf9xO+rHv+GaB0ejii7Qw0OtV9yhRWQfvqX4a9L8hkTJtRSw6uQ==
X-Received: by 2002:a5d:468a:0:b0:21d:6dc8:9e60 with SMTP id u10-20020a5d468a000000b0021d6dc89e60mr4105543wrq.595.1656969257078;
        Mon, 04 Jul 2022 14:14:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b002167efdd549sm2885381wrw.38.2022.07.04.14.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 14:14:16 -0700 (PDT)
Message-ID: <e2d81210-a969-fe9d-a4fb-1826c991fbce@linexp.org>
Date:   Mon, 4 Jul 2022 23:14:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Todd Kjos <tkjos@google.com>,
        Wei Wang <wvw@google.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-6-daniel.lezcano@linexp.org>
 <ad8dd950-9260-16b3-2134-72984e2ba261@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <ad8dd950-9260-16b3-2134-72984e2ba261@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 09:35, Lukasz Luba wrote:
> Hi Daniel,
> 
> (+Todd and Wei on CC)
> 
> 
> On 7/3/22 19:30, Daniel Lezcano wrote:

[ ... ]

>>   }
>> -EXPORT_SYMBOL(get_tz_trend);

[ ... ]

>>   }
>> -EXPORT_SYMBOL(thermal_cdev_update);
> 
> I wouldn't remove that export. I can see in my Pixel6 modules dir, that
> it's called in 7 places.
> 
> I assume that in Android world this is common use.

It is not possible to do changes taking into consideration out of tree 
code. Moreover there is logically no good reason to use the 
thermal_cdev_update() function from outside of the thermal core code.

