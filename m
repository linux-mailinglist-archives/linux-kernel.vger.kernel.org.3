Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8D501C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbiDNTmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiDNTmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:42:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7E167ED
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:39:36 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k5so10831311lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mOzDZgPKCeJFKlKho+EJ9pfBvN7kmckeP2vEOpMjjHs=;
        b=Sd3ErO7OkQ9pEz0AQ+nQamORwzrUBny28QC6oShE2YXaOnXjfD6nOClX3+wYdRPM0O
         mgNDwXW+EUFDfgFzUZXOE8/cmWB3w2fVYhV2UWB/SPJIZfrxHlXRFHMj9fFapi44c6KD
         Zs/bYe0gBfE2Q9CIRweCHw9k6ZPIBpE5RPvO7r4zms6FC6BiCOqG2ki/mRmDoP0IsE61
         Val1oX8jQAsEyutm+o4lfKST5KyRY71jpOpiKJrx229PwR29jYdRzsBTIa/GScFhow65
         LsE7eVYXSypvjlLM9HXiTmL+leHYRuvhDALHFgzTcW63l09Tv5p4xTmUIPM4BaBbUPb0
         0Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mOzDZgPKCeJFKlKho+EJ9pfBvN7kmckeP2vEOpMjjHs=;
        b=r5/0PD88TvKkQcPM/PVgdHqUBE7TM6ANUMTVd+fP4dRTCTilVE6TgfM5JUdCIpKu0Z
         2yMq+kQxAvAtkb0nTw1sEMfjvnM0Y5x1GwhbJRT4SAdRqS4uw012k10wEF+RsHeVMxuZ
         hxRoSekYSJczvFVuAaIxdapRnq09ul3HnOKk/VNfsiye34soT+/mywEEUB97ciV2dCjj
         iDQErWOd+Rf6nm3WlmsF6ibHkS8iehDfpT7DJb7/9gqr3GrfbXh+5ENv8LbUT8rxbzfE
         DeHhlx6kdl4nWINUB3Uae5yUwZiWwiZpaB6toWJodaYlqvkqvQP+xdxPrgzg4A6+2nFG
         NVhQ==
X-Gm-Message-State: AOAM531HPSDsYQnoSWL1B5eepbWGIlgGIgvHvGCJbn0CD5qPj4KpAz6v
        5AUNOOYLV1L2emJq5NrV9fI=
X-Google-Smtp-Source: ABdhPJzkJADCjlo70EZY7IUyuhNy0vKezJgRvh3sNOAw1J3An09BX0DEPfgE0dur+JuCqrl8iOWDmg==
X-Received: by 2002:a19:8c4b:0:b0:44a:b6a4:4873 with SMTP id i11-20020a198c4b000000b0044ab6a44873mr2753878lfj.549.1649965174316;
        Thu, 14 Apr 2022 12:39:34 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.225.17])
        by smtp.gmail.com with ESMTPSA id t12-20020a2e954c000000b0024b3811ab30sm76809ljh.101.2022.04.14.12.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:39:34 -0700 (PDT)
Message-ID: <dec6d7fd-58f1-7504-05e8-e9c17eefdb2e@gmail.com>
Date:   Thu, 14 Apr 2022 22:39:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/7] staging: r8188eu: always log firmware info
Content-Language: en-US
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220414083853.3422-1-straube.linux@gmail.com>
 <20220414083853.3422-7-straube.linux@gmail.com>
 <80414992-a662-e884-05ca-dcc0c8b07b99@lwfinger.net>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <80414992-a662-e884-05ca-dcc0c8b07b99@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On 4/14/22 18:36, Larry Finger wrote:
> On 4/14/22 03:38, Michael Straube wrote:
>> The local static variable log_version prevents logging the firmware
>> information more than once, e.g. when the device is unplugged and
>> plugged again. That is not necessary and complicates the code. Remove
>> it.
> 
> I think the slight complication of the code, one static variable and one if
> statement, is worth not spamming the logs. My recollection is that there are
> other cases besides unplugging and replugging that lead to the firmware being
> reloaded.
> 


What about pr_info_once? Anyway even with old code message printed only 
once per driver load





With regards,
Pavel Skripkin
