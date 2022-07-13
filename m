Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD112573AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiGMQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbiGMQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:12:03 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F750737;
        Wed, 13 Jul 2022 09:12:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so10876131pgs.3;
        Wed, 13 Jul 2022 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eg0jwY36541hZJchyMVRy74UzB7/OP6ZiEWz2ML7whQ=;
        b=ABdQ3enjC2i0WpYuqLPdEWwq995SWkYpZdRmXGmEytGAWNPT8YjQ8IUVXUL83X7CRp
         tT9eRG4BaONmE7P0sGH1S9B7orouZGsLnde6IZsMMQy8zrmvXzJR5Su0cRdKMws13GYs
         /PU7vDg8WMtOrOrll0BFKNKQoOkYVqIozfjX8amgNshWx1mSYF7qTIOlNtt8zjNbAjC/
         mrIpythPVWCwJYmZJj0Y2PSEp119AWO00cU8nqefOcyKhnOZ51QUcSfB4xxRv1wvFA01
         qJIOjmuwj8haVMJdo3uEHFfd66yYx1R2duSKRlbk9HQZIwoeef9yqIx6jMhDbWHiu6tb
         QW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eg0jwY36541hZJchyMVRy74UzB7/OP6ZiEWz2ML7whQ=;
        b=HZ3hiX+wGb0l4f0rGGAHS8Bg7PzQ3ekYeE8fZkkPSvcna5nbW/uwimS/PAgLVCdCbw
         G8zJ6ubklY4LeYhUsbPwSj4bEDdI13oKOmBzXFCUSa8fMd9oNL3q/woIEQTrjCvwNR9x
         aIvu5DqPolACJfRnv47fnhWXcocnwQYlzxR5T86pdFQk49ouFJG65g3godgFDN//6S56
         ToZ+ThXKzqpXxLiju+hlKtB7K36fr5nDy6aY92m03jklznd5emi2ueyTdJzyejXdEUpZ
         rabBxluR/U6Khj+g+knygHfaK3vUZg53T1QandYJjE4B5XYheSdoOjV3xOHrphOxxkqy
         AHDw==
X-Gm-Message-State: AJIora+flLsm+YV66NalN5zjqP9m3AtHC6TT47/wUDZgjShEk9QwJZu7
        M7wDeHS3vHbDSxa9EeDPwWk=
X-Google-Smtp-Source: AGRyM1tGVVzrg6o6zLqFqCGLE7KCRNXI6LzLmpZ/XGzwxSj3+MWmbmwFm6bY9m/47ZcNEJ4G80/omw==
X-Received: by 2002:a63:85c6:0:b0:412:a94c:16d0 with SMTP id u189-20020a6385c6000000b00412a94c16d0mr3620950pgd.253.1657728719544;
        Wed, 13 Jul 2022 09:11:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mi9-20020a17090b4b4900b001ec84b0f199sm6501149pjb.1.2022.07.13.09.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 09:11:59 -0700 (PDT)
Message-ID: <d86e4fc9-c4bc-b503-6f73-deac083452d8@gmail.com>
Date:   Wed, 13 Jul 2022 09:11:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH 7/8] spi: bcm63xx-hsspi: bcmbca: Replace
 ARCH_BCM_63XX with ARCH_BCMBCA
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20220707065800.261269-1-william.zhang@broadcom.com>
 <20220707065800.261269-7-william.zhang@broadcom.com>
 <20220711021131.3289881-1-f.fainelli@gmail.com>
 <Ysv/PNJzSEwRnQVI@sirena.org.uk>
 <ce3f1df4-6919-e666-a8d0-a856e5d7bc3b@gmail.com>
 <YsxLQgR8qj/JQY2G@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YsxLQgR8qj/JQY2G@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 7/11/22 09:09, Mark Brown wrote:
> On Mon, Jul 11, 2022 at 09:04:39AM -0700, Florian Fainelli wrote:
> 
>> Each patch is independent from one another and there are not dependencies on
>> the Broadcom arm-soc tree(s) other than for CONFIG_ARCH_BCMBCA which was
>> introduced with v5.19 with b32c613b3fda3e1c26119609f1ad6b19178f82f5. That
>> said, I prefer to take all patches via the Broadcom arm-soc tree(s) to
>> ensure a timely inclusion for our upcoming v5.20 pull request, and ensure
>> that all drivers are converted in one release cycle.
> 
>> If you want to give me your Acked-by or that I drop this and take it via the
>> spi tree, please let me know.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks, FWIW, I had amended that patch with your ACked-by before sending 
it to the arm-soc maintainers.
-- 
Florian
