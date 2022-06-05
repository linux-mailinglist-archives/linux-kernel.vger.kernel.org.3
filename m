Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5B53DADD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbiFEIkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiFEIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:40:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140222FE7D;
        Sun,  5 Jun 2022 01:40:04 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h192so3815544pgc.4;
        Sun, 05 Jun 2022 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3cNO/ZmiNxVWesEjFLdNPaV0vvUFExRHEz7YWaDi1CA=;
        b=g4JHpmn1aWNTk/McDk1oHzQoXPPLPxNjbEwZTr9wCBrGmtelG7E5Wa4iV4IH4PjOTo
         zeRrLTZXlKj2Dg9Q6bnv3WeT89Wyo6Vg4yGUeIU1Bi0n4U+7Eu/pFzxK/pfoHyUhUMoB
         QSPejsBiz7E5zmxWFsoasCWsbBqCs8F1jalaRD8TIghMpHQYJKh8l5tPRqeElH9AQUlN
         LWiiH6xDS5nXYYKSJuX9qbAj2rQnqPmwGaotgFYsrR9H9fGN09q37Nc6jaE0CG1A+w/h
         VbG0Dl4xNvTD7edY3AQWUlvtO5emHS+ZZB+GRVDIzLYh2XX7+6J4kqMNfLT3CjD1bBIR
         d5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3cNO/ZmiNxVWesEjFLdNPaV0vvUFExRHEz7YWaDi1CA=;
        b=rOoe0Q9a0BAutZtXO2vaT8Z0HXRrL36aXmz/InKPjtTEC5/7djnE2luVwPaZGTmYZw
         NWPvRkjOr8SDXyMf6Hk+CLwK/DJmwaq1VyuFq1f6IDtgUBGojl1ZJrbw4wpCrqyqf93c
         WvoigKwKKioC2LhI4SJ3ThZ03ii0mHj/nA7281RWTrRvSvBGpWf88MuMKup4vA6kWX2w
         6L6qno7RW33mdG9gNYDyORxG/1f2usKp+59YX+Nu9k183K7NVp5eLe6v2wv28pY54Ihi
         4MjXu02Nz+bV0wYi1VObsJ7XQGi0TuOfdZzi+cRjmZMVV+dKX7dAy4D8Y3pDMfe8qSup
         weHg==
X-Gm-Message-State: AOAM531ZrG+m+zEYu2DjZXW6pa1JJ2yuKc90abN/9KtbbmKIO7tylaeT
        o2ZdLX8950OjjV7rabBGcBXFtmF+j44=
X-Google-Smtp-Source: ABdhPJzLFnP7Of3foCpLB/QsC9tCG3rSBeZu7x5bfBYcdCFuTTWlx8gpt0dvv5hYBI4nQoJr4JPHNA==
X-Received: by 2002:a63:8248:0:b0:3fc:523e:1f02 with SMTP id w69-20020a638248000000b003fc523e1f02mr16163897pgd.90.1654418402899;
        Sun, 05 Jun 2022 01:40:02 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id r16-20020aa79ed0000000b0051b693baadcsm8412451pfq.205.2022.06.05.01.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 01:40:02 -0700 (PDT)
Message-ID: <5f00819a-cd52-a2c7-77de-28a4649c33dd@gmail.com>
Date:   Sun, 5 Jun 2022 15:39:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] docs: usb: fix literal block marker in usbmon
 verification example
Content-Language: en-US
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220604155431.23246-1-justin.swartz@risingedge.co.za>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220604155431.23246-1-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/22 22:54, Justin Swartz wrote:
> The "Verify that bus sockets are present" example was not properly
> formatted due to a typo in the literal block marker.
> 

Missing second colon?
iff --git a/Documentation/usb/usbmon.rst b/Documentation/usb/usbmon.rst
> index b0bd51080..6d5ec1e62 100644
> --- a/Documentation/usb/usbmon.rst
> +++ b/Documentation/usb/usbmon.rst
> @@ -42,7 +42,7 @@ if usbmon is built into the kernel::
>  	# modprobe usbmon
>  	#
>  
> -Verify that bus sockets are present:
> +Verify that bus sockets are present::
>  
>  	# ls /sys/kernel/debug/usb/usbmon
>  	0s  0u  1s  1t  1u  2s  2t  2u  3s  3t  3u  4s  4t  4u

Otherwise, the literal block rendered correctly.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
