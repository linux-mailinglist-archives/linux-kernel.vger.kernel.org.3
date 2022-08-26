Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8797C5A27F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbiHZMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbiHZMrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:47:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC035C2FA6;
        Fri, 26 Aug 2022 05:47:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p9-20020a17090a2d8900b001fb86ec43aaso1592794pjd.0;
        Fri, 26 Aug 2022 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+Kcf/ilkfosRaI9H3BNXX0k/yxzDkhOZSru9GqiL9jA=;
        b=WNOTzWNVgtdaIp1aUJra0XEKEqYUVT19JjcYu73V6mhk+cNk+Ytox93PhWpF+Tg2HP
         VKVEi5IKMB7VYGNKy8eaAuqr2BVSBtOoJwgcT0xnJ68h6x9dUWQ7khJ2alpWzC44XY5W
         PMLXxsRaTrjUuINDQWQ1sXHbSPmkt89HkcUKyglqQELcoNJhAMwaBEBLqT583quXVpon
         8w+lD8jYB4SPKgSJe8/p3PQ3FSvxXcOP9xVGSSZzVYvrQzMpYM082NJ3BKJ8qzpIBaOJ
         STZzTv3PpZW/gbWqkVlSlqBMZq8UH3Tp/WIzSmOuV3pbmh1iQMFaQdmdv7hPWaPxgt4u
         bjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+Kcf/ilkfosRaI9H3BNXX0k/yxzDkhOZSru9GqiL9jA=;
        b=eTEnO8wotoxPOXAbANI/eCjAuQNkn/oCU9p1vDXwITIO3McHSuklOZx+Ts0HHnB5wu
         XQOooFaWoUIJPuREeAUxJHAahpEWbdZ/PVphJPUn1m9L1Eph7hg3c3bfESiXXkh5kZ4D
         ELei/gRUn0p4fGCsq/1zlkHfbB9ftleEKO9E86ImjY22HS3fXmdpJrBnqeGOYWHL0gBe
         VprPI9+tChPiu0o0blFYm8Cz1yCRuLoVGAYYXEgrZg4VOtH9OlgFNKUHqwkbeV/x55MW
         rF35xrQqMMjBdKacymjQg+pNCgZgLcmjhl4SlxdRVHsY2ljKPIzvLi1k8nBNYdwizLnW
         /keg==
X-Gm-Message-State: ACgBeo0ah0zqagIbivtg+3uRlXZJmPecuXsEL9P8nndgMRZNDz9Ph31y
        oJUo6J6GRP3pxWO6JJvqL/g=
X-Google-Smtp-Source: AA6agR48WOVhmjDpuEYQ4QeDwx7heuyx3xJ67kLhmkxct+VbL+HX9Ms3zVtGihUaTm2ir2J1CmBEsQ==
X-Received: by 2002:a17:90a:cb93:b0:1fa:c4db:ef42 with SMTP id a19-20020a17090acb9300b001fac4dbef42mr4237385pju.10.1661518064229;
        Fri, 26 Aug 2022 05:47:44 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b0017440342b5bsm1158443plh.206.2022.08.26.05.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 05:47:43 -0700 (PDT)
Message-ID: <30415bcb-c367-9ee3-a5bb-4c97510f4749@gmail.com>
Date:   Fri, 26 Aug 2022 19:47:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH net-next] docs/conf.py: add function attribute
 '__fix_address' to conf.py
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     menglong8.dong@gmail.com
Cc:     kuba@kernel.org, sfr@canb.auug.org.au, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
References: <20220826061914.816239-1-imagedong@tencent.com>
 <YwiU4DPEPryi1cMZ@debian.me>
In-Reply-To: <YwiU4DPEPryi1cMZ@debian.me>
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

On 8/26/22 16:39, Bagas Sanjaya wrote:
> On Fri, Aug 26, 2022 at 02:19:14PM +0800, menglong8.dong@gmail.com wrote:
>> From: Menglong Dong <imagedong@tencent.com>
>>
>> Stephen Rothwell report that the function attribute '__fix_address'
>> causes a warning when create html docs with the command:
>>
>>   make htmldocs
>>
>> Therefor, add this attribute to c_id_attributes in Documentation/conf.py
>> to clean this warning.
>>
>> BTW, I'm not able to reproduce this warning (both ubuntu and centos are
>> tested). I will appreciate it if anyone can have a test for this
>> commit.
>>
> Hi,
> 
> The patch description can be improved, like:
> "Stephen Rothwell reported htmldocs warning when merging net-next:
> 
> Documentation/networking/kapi:26: net/core/skbuff.c:780: WARNING: Error in declarator or parameters
> Invalid C declaration: Expecting "(" in parameters. [error at 19]
>   void __fix_address kfree_skb_reason (struct sk_buff *skb, enum skb_drop_reason reason)
>   -------------------^
> 
> Add __fix_address keyword to c_id_attributes array in conf.py to fix the
> warning."
> 
> So next time when you spot documentation warnings like above, specify the
> exact warning in the patch description. This will help reviewers what warning
> the patch is fixing.
> 
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> 
> Also, don't forget to add Link tag, like:
> Link: https://lore.kernel.org/linux-next/20220825154105.534d78ab@canb.auug.org.au/
> 
> Otherwise, the warning disappeared on my htmldocs build, thanks.
> 
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

Oops, ignore my Reviewed-by above (not LGTM until my comments above
are addressed).

-- 
An old man doll... just what I always wanted! - Clara
