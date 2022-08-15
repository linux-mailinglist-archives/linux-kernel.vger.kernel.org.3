Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3995933F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiHORRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiHORRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:17:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8027CF6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:17:43 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n133so9256809oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=iTqSFcKdBFWRcG51JwvSqUqajl7nbOchSE6cjtY60jg=;
        b=VPokcfO/Zn58P+uPyP+d80HrKyQ7jUIFzXVlgLDYNHAOD4WqTbEoWTM7oNaHLHqrNL
         bLm3dEEy1peXTF6kAfI6V3KmWLM9V4DvpaE2OkRW9sHzeoLypopzAPfNKgNKX8uLTnnk
         uZ/1fsZDVNaeiD/OTShmrfLX5AX/OZXgcY4Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=iTqSFcKdBFWRcG51JwvSqUqajl7nbOchSE6cjtY60jg=;
        b=AuR+cC1oR+xFRCxYo7Ft5q48l11jhMmx4CkWsA5jnKRtafjg64UqVBgFHzeOZSPlCx
         p+8ZxGUWJWyKecK0WTAVj7cvjpTqNiiku8BzQ76Cws2fB1L1HsB1DEvh+56VB6kb9I90
         b68ZKr4g1b/DORXjGzu9UwRTBfwydS/PJ7Vll1UjM5FVS2Y4MmLuNk3Ge8j7WTSFP8qp
         zfBTzLX4SA4Bu9ETAijibSSXiFGZuxx9ZWoIMSXyfrJqV+eCGl+D7GQYR2xqYhZhIU1V
         OOh7e8nu8IDYgxIihaKBVpyLYXqk99bqAzceNbFx0H/9Q2RYch3RCcsycRIjl677Pnty
         ULsA==
X-Gm-Message-State: ACgBeo1VhQCKLsvKWJ29kCQc3D3x2iyh6V4bAMzCWSBN83L1wXomf1y6
        +Y66Z4CxLRZ4UhmtE3rSKnoMsw==
X-Google-Smtp-Source: AA6agR5/eLFCnzSFObcfd6XyGoNsQ1b8dU8kb/ubZnHu5G5/wVMPb72Jx+yfPnA5mf5nhKDFxj2gJA==
X-Received: by 2002:a05:6808:1ab4:b0:33a:1081:2498 with SMTP id bm52-20020a0568081ab400b0033a10812498mr10170733oib.103.1660583863188;
        Mon, 15 Aug 2022 10:17:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d63-20020aca3642000000b00339c8aab320sm1914684oia.3.2022.08.15.10.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 10:17:42 -0700 (PDT)
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <f1fc4e6e-e2a6-3ec7-2d3b-215111a4b9ae@digikod.net>
 <76a2ac43-6e3d-0b62-7c8c-eec5f247f8f8@collabora.com>
 <3de9a64e-6f27-8f76-9626-6ee082d382ea@digikod.net>
 <c0c65ade-1d2a-5466-2c12-8e016904817f@digikod.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <32f7befd-19be-19aa-6db6-7b1fd670166e@linuxfoundation.org>
Date:   Mon, 15 Aug 2022 11:17:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c0c65ade-1d2a-5466-2c12-8e016904817f@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 9:29 AM, Mickaël Salaün wrote:
> Shuah, do you plan to send a pull request before merge window closes?
> 

I was hoping to do so and missed the window. Looks like more discussion
happening on this change. I will get this in for the next rc

thanks,
-- Shuah
