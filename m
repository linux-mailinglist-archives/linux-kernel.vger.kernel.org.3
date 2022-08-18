Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD565990B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343637AbiHRWmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245337AbiHRWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:42:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC4CDC5C7;
        Thu, 18 Aug 2022 15:42:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y141so2800935pfb.7;
        Thu, 18 Aug 2022 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=a8D5WHgBXK5ytVEsagwFdbi7hPSDRYEStMPhUzyyyaU=;
        b=CTsoL8T1NnCFuX3UdscZX2dntKRju7VKL6f/NVcUXS46eWdjAoiPgrzSda/jLoXGOg
         knjk4Ld3NzORIqSauJRyP1ugOako9BGTvhhwHXYH9yqqeKA5OQbBROm6bTWdBvpc+FwX
         RvgyB0pro1CM1SRJCdTlAbbeI13Eov3A8DXA1FCGGZEGm2R81c/mOgS22d2m1kGnGKHE
         JKsq8G9PCo0e0fAHPaj6Ek+Ja1pOqT0GGa4ShKL7Fv+CQnZYG/I7B9T0DkwGM+W/gOVO
         po6hUEwFI4kLHKWHoLrmqsWeFgrULiOPpOGAxuHDN/6ZdwrqybKwqOuUYWS1koxIWwKZ
         6uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=a8D5WHgBXK5ytVEsagwFdbi7hPSDRYEStMPhUzyyyaU=;
        b=s9VtPSwio2m4U6Epg2HFabsB6owbFx1CLYqymBzpoxH5U72Aq0HNCW39rNT7niHQbG
         +gwOZ6rezv7Shapn8HE2/LkrAoX/IA5392pwxY8y315347q3Nay59hw73QsWZgkokRwu
         8DNOFYFyGDSkfflh27bcwtdeffQMTw1SZSaCpTb91JZVgHVXk5gLJhV+0GcK/yTu5U4D
         y/CzrYGjzcPineOX/AX1K50YbaE6seKcYQEA8uwVUauNyhQZbjvkAy2Dv0QoPHf3F3C6
         DUVPP/bh+U2nb9Gf8e/8bHcFtFVhezLNC0vQ0exyb5oSe4Z8CAG07UB/gYfza7iHvCL6
         uk+Q==
X-Gm-Message-State: ACgBeo3n+S7EbXa+VHDuJ/xsjjWhryBZ+y+ipk6dOqeLJ80GY+4l1dRG
        jXzxcGPKlGL9Z7cm1pycsCo=
X-Google-Smtp-Source: AA6agR5c8xCLfRRU6JmlLD7pIEdGRpq5E4FMq9E885oq62Vm3D3iy6Et6WoKVuCl7E83+I6TmMuMgg==
X-Received: by 2002:a05:6a00:acc:b0:530:e79e:fc27 with SMTP id c12-20020a056a000acc00b00530e79efc27mr4938970pfl.61.1660862565734;
        Thu, 18 Aug 2022 15:42:45 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l4-20020a622504000000b0052859441ad3sm2066582pfl.214.2022.08.18.15.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 15:42:45 -0700 (PDT)
Message-ID: <83347b74-5075-90ad-1f8e-575bf4cdaf50@gmail.com>
Date:   Fri, 19 Aug 2022 07:42:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] docs/ja_JP/SubmittingPatches: Remove reference to
 submitting-drivers.rst
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
References: <acaf13cd-52f0-c7c2-add0-0644cb1e77e4@gmail.com>
 <87edxdcwnj.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87edxdcwnj.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 11:02:40 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Reflect changes made in commit 9db370de2780 ("docs: process: remove
>> outdated submitting-drivers.rst")
>>
>> Reported-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Fixes: 9db370de2780 ("docs: process: remove outdated submitting-drivers.rst")
>> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
> 
> So I can't get this patch to apply; I'm not really sure what the problem
> is.  Does it apply on your side?

Looks like thunderbird used "Content-Transfer-Encoding: base64".
Resent using "git send-email" with "Content-Transfer-Encoding: 8bit"
Hopefully it works for you.

        Thanks, Akira

> 
> Thanks,
> 
> jon
