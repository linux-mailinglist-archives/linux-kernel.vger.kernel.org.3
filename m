Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C2249FAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244891AbiA1NhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiA1NhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:37:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1CC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:37:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id qe6-20020a17090b4f8600b001b7aaad65b9so315079pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lMTcQ6qP0dwEhEJ1b2Pji1K8lhptV3Mxc6UezRbTYrM=;
        b=kXXTVeqs6Ib4QSXjeuqfm7SqkcWy37ZYLefCrZswMokOFiYpXYk2i8xGJHf1Peip86
         Ky618vKqFDTPpmBIKsXbr9C520RjAxsd6lMv4kBNnOSDGuJ/w2pUCbaqGcBpDAi8bOga
         /dSjZ5ZiHIq4GDTnYrlG/W28FWC3hcs8/4n69FImqA4N88o6Ed9wTWMfHhNTMvfU+5v1
         lR5IfhAFdO7KBV4BlTTdIMDIcv2Wnil+Otyn68Y/1ymm0vq2sY9ZexSR36jUW6RIAFr7
         /IOTkFymKzTcqV/KRH+UokxmK5RB/0dMgGLeyWUNMZD++UrCM83pX+RZkqyNbmtUJ9Qk
         RHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lMTcQ6qP0dwEhEJ1b2Pji1K8lhptV3Mxc6UezRbTYrM=;
        b=mNWUg2qtg8w4Tzsm/aCbQFPOIOwRh+Xp8uT+aho6IHJ90SJgiYZb1MjjWNm0GQhN7+
         fum2PVicJycjDU3yc7cUohbXa58uBwGvZ3t+pQbGwYh6kiXjkfhuA2lMDMi2YLopqDJw
         hZxAMio9KlJeO8YEnPvfSJWhi/20ij3tgj5ymHanPegwriwvkrU2sOGU6kFuLYj5LHLk
         IfUc9gi0DpWCOsCE3ps0HMJ3kK5ry13bwaFYfb/ldOJYRM/Bs/ln1LoKr72tBrKQjTpE
         NJ8OsmMoJhdT/zP8+ZEsZtKmlrRESCFCbsBxIQUFs9X23iQ0xs5wcOa7miYdmX9WzvDm
         G74g==
X-Gm-Message-State: AOAM533igDKugdXFnZVssQc1eTmEUL1MqiJN32JHwjujS7V3NGB9MvdR
        FqlGpzokz+XFe2ctIGSPA1iLTc+y6Jhtbw==
X-Google-Smtp-Source: ABdhPJx58u/IepgFllZjnObr67weMiu+W39wJlT1YIdB9vo7DBrkQ9VPV0QuPQLyUa0h7Urc1LzVVw==
X-Received: by 2002:a17:90a:4109:: with SMTP id u9mr9890389pjf.120.1643377027341;
        Fri, 28 Jan 2022 05:37:07 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k21sm9649920pff.33.2022.01.28.05.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 05:37:06 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: add bio.h to the block section
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
References: <20220127064221.1314477-1-hch@lst.de>
 <990369e1-0868-5cd1-2f97-286c50be2cba@kernel.dk>
 <20220128074439.GA3098@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6aa375f6-31da-1edc-5a4c-c99c97500b5b@kernel.dk>
Date:   Fri, 28 Jan 2022 06:37:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220128074439.GA3098@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 12:44 AM, Christoph Hellwig wrote:
> On Thu, Jan 27, 2022 at 10:20:50AM -0700, Jens Axboe wrote:
>> On 1/26/22 11:42 PM, Christoph Hellwig wrote:
>>> bio.h is pater of the block layer, so list it in the MAINTAINERS file
>>            ^^^^^
>>
>> part?
> 
> Yes.  Do you want a resend?

Nope, I fixed it up while applying.

-- 
Jens Axboe

