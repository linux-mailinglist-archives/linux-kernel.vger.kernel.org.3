Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D59156177C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiF3KRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiF3KRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:17:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376FD4505C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:16:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so2060538wrc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MwZMnBqf0hbC0whu2ti6oHdCcDv559Hi2/mZm7bxOWg=;
        b=PvJy9RTnspasQk3I2ol+lrtL8yS90/rApYTM2YTvi2PjMQZC/C/qEfg5gLnuITSLaV
         xk1DdHco85cpw5Sp8al+/nf2hThmcke9pdK/od1dQOWKXxJWM58B6rJBhA2evRxnEbOi
         gJeLn4bA2nkaYSu+pZpCH8gem10cH0OYKVok42gnykV9rPq8jj+ss43lQ6U5w5How6zR
         niGyy3uFpqD6wHVCqKGOMBwGpmoAQwMdgH3D2IHCvN/9l0kACGdEguMOmqx4Do3ytikO
         Van8xCcqhjXHk2fWz5B0QZvIqSrA3/f5taKD6wSS84Tr8U4Q8ULaV+Lp5dSc8CHUyIY6
         99Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MwZMnBqf0hbC0whu2ti6oHdCcDv559Hi2/mZm7bxOWg=;
        b=LegxNv41fEKZaq4bIymgMEL4CUwoH5Jga5zp/3XcOKrV3IkWfzdqh5W64/h4jhoVhh
         Cyka7s3/ETP3dCWKMRel79240NUtCoUPLu58OW+/0LmmEz+OMyTkDGAWvosMTz1RoL4r
         eAx9pZfx2zgwg5fnM3Jhj1b5qMN3kqd+PLv2XcWLV/aer9yyXNPSlwS5YfJBuPk7C3eQ
         UvKFmO5k4gYANNoxwwAXorFnrwgtS//v4iVVXG8QK5iCl7Tfjtpx6CYuiqEUqpeTg4l3
         1kkzz4jzmbrbP/lrTc0aNJ8f36xOB0hraIgACqChYLeSUhnEagkmssDkxupiZABkD38o
         P5YQ==
X-Gm-Message-State: AJIora8me1VE/z+Lh3iN4tblmZuyXijWv9MNUn3hm/uoV+Uj/XfsLjm3
        YlNDgdPerfi/dbWoJipbLIIUFg==
X-Google-Smtp-Source: AGRyM1uAwI5mNxKF9BMm72byEfXELRTRz/pGjlN6Szhb4liMu0GkPSNKd9qt+17JL3fenP/t2NnGpg==
X-Received: by 2002:a5d:6481:0:b0:21d:231e:83b4 with SMTP id o1-20020a5d6481000000b0021d231e83b4mr7364538wri.689.1656584213540;
        Thu, 30 Jun 2022 03:16:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l5-20020a05600c47c500b0039c693a54ecsm6899099wmo.23.2022.06.30.03.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:16:53 -0700 (PDT)
Message-ID: <0a6c992d-ea88-c3fe-1837-8be4e912d266@linaro.org>
Date:   Thu, 30 Jun 2022 12:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] thermal/drivers/u8500: Remove the get_trend function
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-3-daniel.lezcano@linaro.org>
 <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
 <CACRpkdZBUVGP6whu-ojW9KKapeuYKQbXWn1MEpJ33KFav+8zqQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CACRpkdZBUVGP6whu-ojW9KKapeuYKQbXWn1MEpJ33KFav+8zqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 14:50, Linus Walleij wrote:
> On Tue, Jun 28, 2022 at 10:40 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
>> Adding Linus who is missing in the recipient list.
>>
>>
>> On 16/06/2022 22:25, Daniel Lezcano wrote:
>>> The get_trend function relies on the interrupt to set the raising or
>>> dropping trend. However the interpolated temperature is already giving
>>> the temperature information to the thermal framework which is able to
>>> deduce the trend.
>>>
>>> Remove the trend code.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> I certainly trust you with this :)
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> The code was originally written by Hongbo Zhang, but co-developed
> and tested by Vincent Guittot I think, so paging
> him as well.

Ok, thanks

If Vincent has no concern with this change, I'll queue up the series



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
