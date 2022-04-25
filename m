Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85EB50E4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbiDYPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbiDYPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:50:51 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0161E11480A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:47:47 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g10so1564360ilf.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2QDLnU2Ilzxz2kbgX/PFHgazwfepy2150+tlBgHx4W8=;
        b=f+WS4AL90Cjdy1Cy9Cdi3ErtgTMmyrBGUuxBeSbTZRpkWufk/Qauo8im0ECSTltzFa
         rHVn5qtDbj4JnP4DC/Vju8OSS+AzYupebvsndCZy+EUzNFwrTe6UUPjpvG2yO3dnN/Dv
         5ZFy8iUQ5UDKkwKrgvjwb3x/83XLDvZ+X6HhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2QDLnU2Ilzxz2kbgX/PFHgazwfepy2150+tlBgHx4W8=;
        b=LaDFRSrhC39/awYIZpmpzqkV5UUommbIEfiF+pkigY5Cklq/MNKFGeQpTD/EuhlM7R
         vd+lDe5r2syeqemeOe1z9WbOTpMyCxILAO+q1xgsKXwI3J4eZpXsJo6uxGg/xznOLJXt
         7/6g9ueeMYax1hY7sPtf3smqePUi3/7b8Ek7W1PDp0n8BOy8kYeK7UVv9uCtX7clxgWn
         3zmKNtZm7XBZM3ITWdlARx6MxXk0yf7E2zpPXUgrqBRKO3KqtCUcQ0/bxZj5uN8jbTAf
         ZWkmQvUGPfl7GbuPrnn7jPRyTpwmHXrRPHwLV+EMw/K4Fe5ooW9/vd6m+N70xf15N4yf
         oFwg==
X-Gm-Message-State: AOAM532Jvge58coNJZGP2WRkLfa95dycvOjw9rVDU9Dj1ux2MI1iF72P
        3cxEfbZl0+z5W/lr9pBDBpS6fg==
X-Google-Smtp-Source: ABdhPJzYkmX0Dcteq1vGmKIRjDgHgXYOInw28+UZtrkqGAryvZMfTYi6ROaaFy8A3X18Q1Tb9GnMXw==
X-Received: by 2002:a05:6e02:1748:b0:2cd:a0ea:8ff4 with SMTP id y8-20020a056e02174800b002cda0ea8ff4mr1329856ill.269.1650901666376;
        Mon, 25 Apr 2022 08:47:46 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b21-20020a056602331500b006572790ed8dsm7763453ioz.40.2022.04.25.08.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 08:47:46 -0700 (PDT)
Subject: Re: [PATCH] selftests/binderfs: Improve message to provide more info
To:     Christian Brauner <brauner@kernel.org>,
        Karthik Alapati <mail@karthek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <YmOSQv2U8+Hs5WjP@karthik-strix-linux.karthek.com>
 <20220425094955.ti3hw7asp6h5funn@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fdf1cb0b-2b9c-0619-09b7-cf51cacdd9ce@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 09:47:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220425094955.ti3hw7asp6h5funn@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 3:49 AM, Christian Brauner wrote:
> On Sat, Apr 23, 2022 at 11:14:34AM +0530, Karthik Alapati wrote:
>> Currently the binderfs test says what failure it encountered
>> without saying why it may occurred when it fails to mount
>> binderfs. So, Warn about enabling CONFIG_ANDROID_BINDERFS in the
>> running kernel.
>>
>> Signed-off-by: Karthik Alapati <mail@karthek.com>
>> ---
> 
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> 

Thank you both - I will apply this for next to be included in
Linux 5.19-rc1

thanks,
-- Shuah
