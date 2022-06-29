Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0CF560CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiF2XKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiF2XKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:10:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C313F5A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:09:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id m13so17591196ioj.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SWgl17o+w/mrOPXhHZ1xRSvhkLOEQYiPi02/oz189qA=;
        b=XWRXVp257nVA9r/5gKwlVJux7mJWJ1G2YC/vZKt2WSpslVqEp9tyaW1Ki31JLShwsT
         jtBCZIf8RBxod7sUoRpiiOsucY2qXAYhHmFrjBdd00CqlYcvHPwoP5Ad8wnvy4jWerTx
         FIyKQr64kAyCQyTlJFVmetwYyBSBu9JBcAOHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SWgl17o+w/mrOPXhHZ1xRSvhkLOEQYiPi02/oz189qA=;
        b=N7IHtm4Wt1mmJwmq+zZcfQAbAQK3T+Ii/A1TUqIyHHz0kZing+9SSpNOZXFPwQekHA
         UYr6J4iFbDvxciXEwCrPrzms/KNsL68aVdvwqtXA8F0PyKcy98OP+r1Dm8NAg0LjZfIp
         HP32mSFB8GnFZSsVSt1JnxDFcRGQ1ZbQ6Oz2NYnPwOMTi32olhKOHIzXsCJcFNuYPjQC
         YZ+JL/Wn9/ShDMITP3EPp8q9qby+jKgiwcB3F1J0suG7sGIzwHXacV4yzB6M4zsgHc8W
         iLC2i8A2Xqs4KpKe4td3uRLrJ9hj95gHxDoZsHpTNN/YJio2sFKEuCCyX9S+fKbGXxE9
         gSBA==
X-Gm-Message-State: AJIora+i/FHptmz/XehM157y7t/clsDXDElzL4DX3r4BupbGJOtCVM+F
        tHGaondk5nI6s3WP/+q+LPNWxz1THgdcdw==
X-Google-Smtp-Source: AGRyM1sNwqGuTQEorVOC9Ap3w+WQZBnxz42e7fjFHW1xMYOfXNlFBHt8eiSviPzl/UVEcC29jxFezQ==
X-Received: by 2002:a02:b689:0:b0:339:ce5d:1de4 with SMTP id i9-20020a02b689000000b00339ce5d1de4mr3595144jam.105.1656544198481;
        Wed, 29 Jun 2022 16:09:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v17-20020a92c6d1000000b002d52f2f5a97sm7471805ilm.35.2022.06.29.16.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 16:09:58 -0700 (PDT)
Subject: Re: [PATCH] tools: Strong conversion of void type pointer could be
 removed
To:     Li kunyu <kunyu@nfschina.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <9b587975-db5b-c7bf-eb8f-bd6e5c3d9f54@linuxfoundation.org>
 <20220629024207.6523-1-kunyu@nfschina.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a1dc2858-b53b-7535-d8a3-1f8ea70aa701@linuxfoundation.org>
Date:   Wed, 29 Jun 2022 17:09:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220629024207.6523-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 8:42 PM, Li kunyu wrote:
> 
> Hi Shuah, now I can't paste the test code, so I could write a demo and paste it:
> 
> 

What is the "test code"?

How did you find the problem? Which tool did you use it?

thanks,
-- Shuah
