Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4550F4F3FFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388011AbiDENUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbiDEJTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:19:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98336237E6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:07:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p15so25279275ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kJSjygeoIUEg15KEgznSTxJtmLSlX3j99Gbfk4k6bTw=;
        b=BndCpHbRsWd6v9wYTuGwTQqEPbjP9eHNrRdtXrSGV8fG9UcpEcQ/yBmITbPMTE4+qm
         sd6oJWbX1cCsjwY4F1Zmbei5RtCpG0eoriiJbERYskO8uAWG5dlcDnrtWhjAKvCDoZ9u
         lmIaOv2I9muviE18eVTGJ10lQhNx6gE1arefCmnKLIXDoSaS/cvb+DxGhJCK8ZySH7lP
         9eXGOIlDWyeyDCDmyuStxkgBcG/06bJMGSN/aI30KG6h7s1/TCvR473Fs6Q/c2xWepL5
         YQNJaocsIHdlEDjig/56mixNPFNePdh0sbIzBj0g/MkffXf1EOx3u5Ipk8QQvkvau86f
         8ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kJSjygeoIUEg15KEgznSTxJtmLSlX3j99Gbfk4k6bTw=;
        b=QXx3aGcykxlv594c7Wia1IcayBF/f0s4gtjMemHdshgtKgEF9KZWyD9u8NepIJwhOe
         6JoVgjkxf6uY8pHXTbBs6dNwE7f0RfdjrTuAlzXS4I2lr1561vwFhWLRcoRil7m6qCF7
         h/mJlYjt/1iy/XYo+aAkcbcm0JKXYVpU0+yV73ZRtaQpUNedoKpHRwrG4PZx+wyfS8Dk
         lZHayPcKAPeV6RpJLFO8D6A8mI4UGnD/oyiS9rFtmimdK0vkHfPBInNlHtsXRHHw6j9b
         gi06iGa376kW6kaHya6O1A/BK1g4hkzkDaM2nI0+NrvTpcDIFB1DM6OrmLmCKV0LdjMG
         4rzw==
X-Gm-Message-State: AOAM5334kx8Q4E+yaDcsXWBFE7tKvGzOCm3WguoMkQf5+f/5Aap5oB7g
        n9S8GdvozGOgmw+Qfd9RZe5FgyL9/aQ=
X-Google-Smtp-Source: ABdhPJw9/2/4/0IARD1YEes9d1GNkT6ZQG5MG5TlQjfRSVS5zf4flLb6Q+lHMSGG8wYs+xRWXowjTA==
X-Received: by 2002:a17:907:96a9:b0:6e0:db4a:ba8d with SMTP id hd41-20020a17090796a900b006e0db4aba8dmr2536171ejc.87.1649149641139;
        Tue, 05 Apr 2022 02:07:21 -0700 (PDT)
Received: from [192.168.0.151] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm5314719eji.67.2022.04.05.02.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 02:07:20 -0700 (PDT)
Message-ID: <5420967d-5007-8ca7-7a8d-124b9ad96905@gmail.com>
Date:   Tue, 5 Apr 2022 11:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] staging: r8188eu: remove HAL_DEF_IS_SUPPORT_ANT_DIV
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220403165255.6900-1-straube.linux@gmail.com>
 <20220403165255.6900-2-straube.linux@gmail.com> <YksBcUBXbgzXmEBO@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YksBcUBXbgzXmEBO@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 4/4/22 16:32, Greg KH wrote:
>> +bool support_ant_div(struct adapter *adapter)
> 
> That's a very odd function name to add to the kernel's global namespace
> :(
> 
> Pleas emake it more obvious what this is for, with the driver name as
> part of the prefix?
> 

Looking again at this I notice it can be made a static function in 
rtw_cmd.c.

I'll rework the series and make the function static with a more
descriptive name.

thanks,
Michael
