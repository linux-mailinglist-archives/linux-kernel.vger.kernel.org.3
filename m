Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB54A6290
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbiBARgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiBARgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:36:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33DFC061714;
        Tue,  1 Feb 2022 09:36:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x23so35530257lfc.0;
        Tue, 01 Feb 2022 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t8XM8YQCdnrLqQjmIyPCS1pWQ5VZ3HXbW2LziRHl1vs=;
        b=YWvHVpTFLXjM7CMAt/cmK/9psyjeYenHbFmBcQ4eU1F9o5cspuXVcnUtF6Mh9JBr1i
         0U5EWSgCdkKapxIzP5hSIl/a6gfCzAx8cFd8iau1ziztRiGD1XWVbFQhD7xstUyNz8DN
         eha73qWqQmSxOPVGQqmGzXUVndUMsVWcvECG31Rw/BSC0+RhO7gPtE00vJAQQayPmnQW
         rEbboEZn5WEdB5MNQP7ReNtF2yliG1GNpo26i8V5X/7IE1qPnaeGCEyiGtQ6b4EnJfMn
         qrZskt6pBIQRtf0ycfb0HiSIMfO9lQ+VM0p/wi8bGm9/oswG42Hgklz+aiVT7/81lqQP
         XDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t8XM8YQCdnrLqQjmIyPCS1pWQ5VZ3HXbW2LziRHl1vs=;
        b=WNWpYeqaEl+TokG4dBAlZu1zB8D6ncD1WQRh4qyg0mnc60vTbvv4b7RSv0YGAZLRUB
         TWZi2BzhNTYDT539uw4+sLkQPfKn6krPcIpVz8GFfvq67bl5tgPO6kvRu9Q/25QPT4NX
         OZefBh/eoXZFW+b+UA/GH+aGSj8LCzc48g0olK7nHky322k4qS/eJ39RGqwPMw5QzbVg
         1s6AagJDZAi1zFUbPeRGpxmwgJ5s2V7Klg9s2bLZ/dMthX03fn8BwZA48FFnlIocB6nm
         9flPX5cbij4Kn01YxPiQylN37/IDrSLpcyDCG4cHeUD2PZbGJ3ClAvAteoEwM5wgcm0y
         pm4g==
X-Gm-Message-State: AOAM533r9mrVsfnqAoylOoWBR1tINd3b5KSVKLNGe6AKAwCEuzd0F4Lh
        Fyhb9lvEiN7zSMKR+iHs/D0Qn9HPUTs=
X-Google-Smtp-Source: ABdhPJy8Ovc8oU3X4U9kL7+78QiRAmLbHyZwiQjIlu9wftg3u56zQFLHxcB0YPyn0Qt2w32Y0kjsmw==
X-Received: by 2002:a05:6512:2620:: with SMTP id bt32mr19282799lfb.311.1643736993869;
        Tue, 01 Feb 2022 09:36:33 -0800 (PST)
Received: from [192.168.1.103] ([178.176.74.140])
        by smtp.gmail.com with ESMTPSA id q12sm2098831lfc.155.2022.02.01.09.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:36:32 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge
 to yaml
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220129204004.1009571-1-clabbe@baylibre.com>
 <CACRpkdb9R-BwdVzyeaQOjagsQU=2-06VNqKPG9fMa7C93eDC7A@mail.gmail.com>
 <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <bc80cd49-c95e-6b9a-1210-7d3832766b02@gmail.com>
Date:   Tue, 1 Feb 2022 20:36:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2b0fa854-16e7-3d0b-a04a-971249646fab@opensource.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/22 2:56 AM, Damien Le Moal wrote:

>> Thanks for doing this Corentin!
>>
>> On Sat, Jan 29, 2022 at 9:40 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>>
>>> This patch converts ata/cortina,gemini-sata-bridge binding to yaml
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Knowing that drivers/ata is a bit sparsely maintained I suggest that Rob apply
>> this patch when he feels it looks good.
> 
> What do you mean ? I am doing my best here to maintain ata !
> But I definitely do not have all the hardware supported for testing :)

   I can probably help reviewing the PATA drivers if you want, just like Bart Z. did.
But I don't have much of the PATA hardware (what I have is in my old PCs I haven't
booted in a long while)...

[...]

MBR, Sergey
