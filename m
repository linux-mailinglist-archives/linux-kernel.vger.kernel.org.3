Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE42558EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiFXDQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:16:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79764F3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:16:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s185so1216205pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+vDFwyU6gU2J6FMTxOqBa2GFVZE6B6F1CPfaNmdAisY=;
        b=oPf9v26asLtQByW8ysQTVAHXOd/SeOsXCALSM6mLz2VuTD8b8wWp/R1goEFpZxS7+Z
         PBi6RqjS4yd9y97kDMJ+2ycPGd3QtZtJxprb3Ihi6V+JG+z92w4dg9AVto9AEY+z5eXJ
         7T+jZ7X6ZjKbs4fvRbKbtP+PnSwIEP/NWyUNdhGIHOEiVgf6fN2vbMQPQhl6pwE1w48S
         j7r0fCsfWfYu1l+SzwK6PR1SU+x8v5twORX6lUxsLBoSDRR335bu9ZJwaHGK0xMk15/R
         MXv0vBiJxp8BmhTGnVa8WqOFkTAAwe8REypeDhyicem1HjFYzJC2JEUNh0FPpE496N6x
         L6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+vDFwyU6gU2J6FMTxOqBa2GFVZE6B6F1CPfaNmdAisY=;
        b=wqG5dSx+FBGMcVUhtF6Cw+x0cIzYtoMuap2X/c1rRif+3sNM2NqZ+6hsDaf+Hy9up2
         iIRmwcnRVS1Qksz7c0h0rDPt6TiWSdCLrqF8ogRPrOVrMCTV9GHjriCOsOBQX4n2vHWL
         I1ZaQPW/LEn67/IkZ+x+ax/20RZkuy56a1+jwKfT/KWUrChXieJ3wXiwYDmND9aby0Ly
         JT2sstDGC+FbCsZhYEfZqd33KcnFM7cwEaNT0bRqa8y2hSCeGVAbBd3sPWmYWFs40yer
         LEs5OL/W4gDJpXCwn3QvowJ6FqXjToatwLxPRZdopN7eL5eAlF3Z/3cB7N66sT6GyQsL
         c9NA==
X-Gm-Message-State: AJIora/fHud9YqFfB1cpv8iBdq6HBb3LY2ucIIUZkRskIGyf4+JK0ao2
        gqUBaDzuM4N3em6ehL1ayDc=
X-Google-Smtp-Source: AGRyM1um0CKTli+3oCXxDwQfDi9hCwlWfT9FC81sDHGDu3MpiJcQ4WnbvDd6nXDfo6qz6XyYw2ZWrQ==
X-Received: by 2002:a63:f506:0:b0:3fc:962b:6e02 with SMTP id w6-20020a63f506000000b003fc962b6e02mr10007713pgh.266.1656040584859;
        Thu, 23 Jun 2022 20:16:24 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d34c00b0015e8d4eb2afsm521684plk.249.2022.06.23.20.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 20:16:24 -0700 (PDT)
Message-ID: <bc46dfd5-474f-386c-c646-c15d82f5ffed@gmail.com>
Date:   Fri, 24 Jun 2022 10:16:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
Content-Language: en-US
To:     Vineet Gupta <vgupta@kernel.org>, Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     Julia.Lawall@inria.fr, rdunlap@infradead.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com>
 <YrLTCXLrr3HB39lv@debian.me>
 <d104124c-5196-bc80-b3e3-0ab55f0cc35e@kernel.org>
 <89bc29c5-ad82-4f20-2855-44e57b043c49@gmail.com>
 <ac0b07c8-0cd4-6ab4-2939-ead4c813ef78@kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ac0b07c8-0cd4-6ab4-2939-ead4c813ef78@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 08:57, Vineet Gupta wrote:
> "Repeated" is the key - First time I'd politely tell them to DTRT but will just ignore if things continue.
> 
>> Lazily speaking, I'd like to privately notice the
>> submitter about the situation, and I withhold these for now.
> 
> Funny that you say this: ever since this got posted I now see 3 patches for typo fixes :-)
> But it is something in maintainers purview and for now i'm ok.
> 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
