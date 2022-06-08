Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C2542B66
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbiFHJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiFHJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:22:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165D15370D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:43:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so17737961pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b/OA3uX/VIqIsAKWguuIWEBUnBMR3TwOeCiIaNIxBbo=;
        b=E5z/u78/2SFbjea+l8hKeATWtlkIk8Jo4pkpRspH9VE9rLSCx2JO34oGwBsMkJGE3q
         SnFAQznSYagMw7U9/PayLNztfA7lHRJe+8rqzCTCw0ZOSI2nK3eUC1mmfcnT0OkdCT3W
         7woEwTknPtGDTQuzLXakiiIfLZGFCPrJtkzEd1I1nTWM6Z8QoRz+KrDEFIC5xSNlgEW/
         xvJN+qtFu1K/5mYR0SaiehL87PRrUcQK3KxszNGZdGR3kZIhOuvNueEbGpY2ih+zxIvv
         ST0OOT1rJGkwfHeebE4q+052UycqHVTUvHM+ch6Wknrn5rBhFCtSTphPvDAwKSjj0DKO
         R2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b/OA3uX/VIqIsAKWguuIWEBUnBMR3TwOeCiIaNIxBbo=;
        b=TjH/JPylbIrxC//z49+AMfEFUEdU7aYZiUBXXu4VR3EoV1F9c6by+mmO74F52qvCjU
         NmjvL8wW/PP60NN6nOSpplLu9W4pyUPye2fDw9fcuhD/BE1Lz9UAE+lBmajnw5gfcL9j
         7i6Oii9RFv1w6+uvOLUhDO4O4+IfaCHkflc5cFgF6WAFsGd34MKQowHlQrsyV6TBCXtF
         +vi1YTVzPK+KpyZFbFmSiijtvgK7JVb4oKwZfDJ9TKvGGjbzkCwyxIQIL5lwj76rSubz
         dcNHN0DdJDVyyNAPQ7vq4Xr4B14jBAvoxn+Tx7nJbU9r3kKoaXkjh/9wl9EDDFSwFTYY
         V9/Q==
X-Gm-Message-State: AOAM53217Hd2pWQyypYb7jxv2IAyS6WJotzeNpKpKHRdCq/wtFIq+/Oa
        +m1LJQSGFB4EUiOtWhH3fog=
X-Google-Smtp-Source: ABdhPJyzHzCyYgm0CxQT2pEBsL2/4zUsC0wUCNhTi16pFoN7yE3KvqiFnngdwzJkMymfXdIKGgDGow==
X-Received: by 2002:a17:90b:4c84:b0:1e8:6bea:d278 with SMTP id my4-20020a17090b4c8400b001e86bead278mr19456125pjb.232.1654677805612;
        Wed, 08 Jun 2022 01:43:25 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.243.215])
        by smtp.gmail.com with ESMTPSA id e16-20020a056a0000d000b0050dc762819bsm14426698pfj.117.2022.06.08.01.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:43:25 -0700 (PDT)
Message-ID: <61db56c0-af8f-6e8f-a4c4-c561f18bd6ac@gmail.com>
Date:   Wed, 8 Jun 2022 14:13:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] audit: remove redundant data_len check
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Shreenidhi Shedi <sshedi@vmware.com>
References: <20220515073110.304193-1-sshedi@vmware.com>
 <CAHC9VhQge7uUSwbDUkA9=VCY0dL+UDUjBRT7aSMEEVGU6jQqLg@mail.gmail.com>
 <CAHC9VhTpBAeEm6U6-=YW7e0JV-WS3MeOjT4g9S-V4ZM2OboBAw@mail.gmail.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <CAHC9VhTpBAeEm6U6-=YW7e0JV-WS3MeOjT4g9S-V4ZM2OboBAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/22 1:31 am, Paul Moore wrote:
> On Sun, May 15, 2022 at 7:35 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Sun, May 15, 2022 at 3:31 AM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>>>
>>> data_len is already getting checked if it's less than 2 earlier in this
>>> function.
>>>
>>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>>> ---
>>>  kernel/audit.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Thanks, this patch looks okay, but since we are already at v5.18-rc7
>> this patch will have to wait until after the upcoming merge window as
>> it isn't a critical bug fix.
> 
> ... and it's now merged into audit/next, thanks!
> 

You are welcome and Thank you as well.

-- 
Shedi
