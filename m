Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3D1480784
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhL1IyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhL1IyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:54:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29386C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:54:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k18so293522wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 00:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Pkvw6csXcwg8RmHKDtZs5IoBzTWTuHVHlsv8fcTdUlA=;
        b=Ct2mi1cHUa+RMp0BrDtn1d34DSv23tMc9y4kSBfmbDY3Z+fKHk9PPkBjW5sLZcpXds
         kEqJu2LGedZGXZy18oUfNTexbX4vWR0uzupmsbVEOtR3XU1GfUG4lx7ZxR2d7Co4Iiel
         H2I3jpLg7SYUQ8y6tcc707IrEzBMH+V1nmoTBfjUhoe17hAx1kDypbllgXNzTJHvcpGN
         fk2FoFTOiaBsg+0/RCR5zFhbeyipBPQeFw8OaYMsNt9iN413VfszbKO8VHVsaepA0QSG
         NGG9KccSP21OjrXA6WFPfdNdZwk7Vb7LiHO6oBf8xvgnxsrKmI8ORCfO4+05cI6NMG73
         PuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pkvw6csXcwg8RmHKDtZs5IoBzTWTuHVHlsv8fcTdUlA=;
        b=eZ575H6fFakWzr4/D1oVJwRDuP/le11CjmjQQF7fAmS2iunFZM39FMOY0PTKi3Aw7i
         400W9DpSnyFFUedK5X06KLei4/kvhz1zZs9tUuj1YE5AvJx9Eqf03uYOpx73G6tXiqdA
         NJDcuaxf++rBKf1I3B2LacJ8BZaIJWXv2MXsOsbffTAIhP9WuXIpzYTug7eco/4HziP/
         W09KE8wiMkTJOHG8PyywZqDfphG4w+9tilt8IQWAXrY0BqCoWwbz51V/hkCC0zd7qYJ6
         5ZUaTJWh2iAH8mkMvLJ8mU29ABq9NovjFkNpMukLVqCR9Cgl5D/2TFW21bAz+iV4Uuyl
         3Rjw==
X-Gm-Message-State: AOAM531fT2BhxMVBGKylHgXsCcNOhdhCbi63dLGf5B4Ece0uce+3IPBI
        sE9J47M98TsCG2vIjGM+j95cLRSTpeI=
X-Google-Smtp-Source: ABdhPJzJwFqCDidmXrCsnTzWItkz/+RA3/ErHCgqLsOgssbSGD8r7NhVvYVFnC9k/aBcOYcSvtRRtQ==
X-Received: by 2002:a5d:6989:: with SMTP id g9mr15150714wru.12.1640681639686;
        Tue, 28 Dec 2021 00:53:59 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::d7e8? ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id b1sm19413505wrd.92.2021.12.28.00.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 00:53:59 -0800 (PST)
Message-ID: <48d870dc-7ab1-92e3-af13-30bb9e73db0b@gmail.com>
Date:   Tue, 28 Dec 2021 09:53:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] staging: r8188eu: DM_PriCCA is set but never used
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211226162921.10227-1-straube.linux@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211226162921.10227-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/21 17:29, Michael Straube wrote:
> The field DM_PriCCA of struct odm_dm_struct is set but never used.
> Remove it and remove related dead code.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/hal/odm.c              |  1 -
>   drivers/staging/r8188eu/hal/odm_RTL8188E.c     | 15 ---------------
>   drivers/staging/r8188eu/include/odm.h          |  9 ---------
>   drivers/staging/r8188eu/include/odm_RTL8188E.h |  2 --
>   4 files changed, 27 deletions(-)
> 

This patch is outdated, please drop it.
I'll resend it as part of a series.

Thanks,
Michael
