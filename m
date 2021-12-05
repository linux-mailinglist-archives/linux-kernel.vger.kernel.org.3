Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E914B468C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhLESNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhLESN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:13:29 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F7FC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 10:10:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x6so33640248edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 10:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oqCnAuMa6hQyTbbrJOr0/eprrgkd78cxU3mlprQfZ3M=;
        b=KaMf7C+Nm7XjOqLTQ/Kpw6pXtAw8SsBxHyYdxXpQXgoCQ3O5CukghJ1/WT3adhzChP
         y1o1OgkOhKXfr31jNhgm8eS+pHYGtsV+jZO3QZP7madXMMZsfKcaB9yylTe7hKlz9V2F
         6jFLq6Azx+vXrFbP26gpd16NZp+KjVAxaZWMManSYlafCspAzWCiXHbW2PbkxXZEuJxq
         esQMt9zve4wHGZMqptrEmafv2i0bxoZlKpxUgPii5oU7lRdc3h8J97Y//Vz1v5MkYsyI
         hUA/oGXSQegZi2U0DMsPa12UgvuDGKovFRxpAFXgbVUn/pZmvq7+j6UkZt4NEnwFxGQz
         dA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oqCnAuMa6hQyTbbrJOr0/eprrgkd78cxU3mlprQfZ3M=;
        b=fWy8zHvBpTg78noaeMZq5ISNUXWqicVHZQM/cTSFmgePns6TxtTuEr4XZDgpXAzdpp
         wkbQ54k/9RtZ1vMXikC3svEHwn5RK1wYEBGxpJCyMPzN3MJpwp9Noo5GewCrecoe0MBy
         VWW6Lu1kaBZg3Ew7wVU57ijDRVApdFDeIJQlxoHIOIQ4LxPmAoqOUgkbbtq0oqsuPnlp
         Q/jp/VF98XErxef+ZFXgsXJamYppAIi0Bz19XVouLkEN54Af+SWrXQL0Qeb40Y3C0VhP
         HJ6oT/zduCx0FgHFXCfBqK+OI58vm5XpDd+jMkEPKrHRKyOjP0xSOQ7Y6DoOldrjQ5ag
         5w/A==
X-Gm-Message-State: AOAM530L3ckb1UJ+/BLn6s+m6PfEPM6LizvGK8KynYxcIhkTA6VEE72S
        XGvny2Q7z6unwKMUay2H5Lg=
X-Google-Smtp-Source: ABdhPJwe8o2eOZUsWS2JJedJrp1cL7lPvVGYmFBlHQ6tTX1rFsnJtfHG8fKoHkyxDO0By5e1b0LASQ==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr40015002ejc.404.1638727800702;
        Sun, 05 Dec 2021 10:10:00 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::b792? ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id w5sm6631561edc.58.2021.12.05.10.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 10:10:00 -0800 (PST)
Message-ID: <a9a77dba-45fe-3d0e-438b-acfa5bed693f@gmail.com>
Date:   Sun, 5 Dec 2021 19:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 12/12] staging: r8188eu: hal_data_sz is set but never used
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211205135919.30460-1-straube.linux@gmail.com>
 <20211205135919.30460-13-straube.linux@gmail.com>
 <197e167b-2225-3593-dab3-4f1f61331de9@gmail.com>
 <b3886219-9a24-c119-fe10-12e5e7c6b139@gmail.com>
 <51a14a4a-8385-b155-a16f-b4cc8b0096c7@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <51a14a4a-8385-b155-a16f-b4cc8b0096c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.12.21 um 18:23 schrieb Pavel Skripkin:
> 
> and even why Haldata is void *, but not struct hal_data_8188e * :)
> 

I guess it's void because they use the same code for other chips.
And drivers for other chips perhaps use a different hal_data structure.

I'm working on embedding hal_data_8188e into the adapter structure
instead of using a pointer.

...still much work to do to get rid of the hal layer entirely. ;)

Regards,
Michael
