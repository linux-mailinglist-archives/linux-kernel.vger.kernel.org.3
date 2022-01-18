Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF86492A03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiARQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiARQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:03:20 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C960C061574;
        Tue, 18 Jan 2022 08:03:19 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id l7-20020a4a2707000000b002dde197c749so6018051oof.10;
        Tue, 18 Jan 2022 08:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZKOz+6+6qymgY1q2xEnV9xqoNItNzWHCPNsQtWudN2w=;
        b=K5eO+yY5gNtbNVUFmxJ7A2batNq9S6GV1wNK2qIF7X6unFrJv2kbZM5muJTdndBcN7
         69dW4DBRQiOU11pM1tzZeHQSz+LRBFprn7GGGC//OwDvf5o9a2/gAG0F4vrYJqfoBVb5
         jTL0ELnAuBoc1LchUZUImg10/vxoWguKOJzNZfqia0kyN9VwXukzlC6pT/KYZkQqlZHn
         EFtFdm7XsIuvRC5ew0Y1s7zJ6oMF5PWgbcP5u2RlDhpQU6rK76PLBxeuN2YW/XH+uRSN
         SlPxk7TTX6TLnisdYE3Dp35zH3Lm7RD94zI1a8EcManW/SIMlU04kE9ZyQBZza7U1Od9
         GGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKOz+6+6qymgY1q2xEnV9xqoNItNzWHCPNsQtWudN2w=;
        b=n/hcG9cw0RUv/WQZJZXXY50KOFbajgocVI6D2lK3O9c/gjwq9o2SM4fHYryCk8j2OI
         TGjprZQ4bVfx3AKxtU2PCmoLTNhZ3NrVijoKRh27bym67Dl42ogLGnKv5NgqFOzZV19z
         hEGDqP3tkPso3tCRCEJ6HvrTbywpLaPRsFy4lgDJ8sjv6MSpV3chNb1lnpr6BRadKXMp
         p8mU3Bfvt5xvwPtyGeD5s5AHPE3JyqUECer4V/RgjthXHVbb2be1P3UrTEznIKOlV3DW
         5dOUsR5Yt8fKPSq/1d/MH+rQoYuKryc7oLahIOjRBVodsUpmo06MOzfcjG9L341tCVgg
         C/GA==
X-Gm-Message-State: AOAM530aStxDJGlSbVhl1eDBDpDmaThEGfYAcxa2r0toge7EDkXIqs07
        RvYmDColmniQtGVWn6fhdAEmQerj7fw=
X-Google-Smtp-Source: ABdhPJwmefDtKVZHa/SpkB+FvmFNVz0sG2BSw6/Jf1Ty26Dib1SlPHoTyUYIZOs1YI22/vB0ksPXBw==
X-Received: by 2002:a4a:4f8d:: with SMTP id c135mr12342819oob.10.1642521798461;
        Tue, 18 Jan 2022 08:03:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w128sm8213550oie.20.2022.01.18.08.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:03:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [ASUS EC Sensors V6 v6 0/3]
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
 <CAB95QATXnzoRfOqt+Q3R9m+Mpm5ou=YQAGq+f5EOJMvGWVRy-A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f80a3b13-ebd7-3e20-df36-4d037e7a9f1b@roeck-us.net>
Date:   Tue, 18 Jan 2022 08:03:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAB95QATXnzoRfOqt+Q3R9m+Mpm5ou=YQAGq+f5EOJMvGWVRy-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 6:01 PM, Eugene Shalygin wrote:
> Günter,
> 
> I received data for one more board (ROG STRIX X570-F GAMING [1]), thus
> shall I update the patch set now, update only two patches (source and
> doc), or let you finish with these changes and then send out a little
> addition [2] later on?
> 

For whatever reason the last patch is unsigned and does not include
a description, so you will have to resend anyway.

Guenter

> Thank you,
> Eugene
> 
> [1] https://github.com/zeule/asus-ec-sensors/issues/10
> [2] https://github.com/zeule/asus-ec-sensors/commit/d45be0a21f47b26727b87d3d111304d0533beacf
> 

