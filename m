Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954B35096D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380862AbiDUFbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352029AbiDUFbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:31:48 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281A10FE2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:28:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id s18so7801516ejr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3N/qonhyjGP0i1sK5zTlSa0gs6xhUWDn8X/WJpeI81U=;
        b=63RtMjodGPEmVfMYJp+8NWPSArb9Njl2d6G/HNftMaCug4UxCu3WfEM0lmmDgUnRSb
         UcWLNjBSiFAkLyhgTbe/oLGyiA0ZNRm7/43w05ZVqNbHZrsCBlPxkQVTGh5nSdXNDMHF
         TG0DT2cKvRWO4UNtUdOSIKrDUYqJSpYLd6/u/Bs4nMmjrqcXLazLPawVjUXk/+PAuzPQ
         KH5eYTsyLmTnkwHoyzCpvIS+SUi01dDGre186Qps3+5LXPV+4fKEietqr71i8/4ftzc2
         Y+oe6HOgH3kpYGsI6mPKMLo78EC47XM7JAhgx9NpB3xilzzSJ6Q74b6WFoWTKkKt/Xro
         J9mw==
X-Gm-Message-State: AOAM533iJlXdJaCYgxAfRfrLvi+rsRde2TfBqrCT22QmnUHZl8YGFNo6
        eM9vfS7vL8B6r79G7CppI2Y=
X-Google-Smtp-Source: ABdhPJx41H+rzJ2+1Hxlu+TAF8OxkCaIqyJhu/1ZrnHBpyzM+0eiTwVqZlVWV6fOB9rp5MjH2p8mRw==
X-Received: by 2002:a17:907:a0c8:b0:6ed:3184:18c7 with SMTP id hw8-20020a170907a0c800b006ed318418c7mr21320351ejc.375.1650518938043;
        Wed, 20 Apr 2022 22:28:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709066d8800b006e09a49a713sm7457474ejt.159.2022.04.20.22.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 22:28:57 -0700 (PDT)
Message-ID: <938179bc-1b71-9bcf-2553-c422aec7de21@kernel.org>
Date:   Thu, 21 Apr 2022 07:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: fix location of moxa-smartio.rst
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220420235545.17081-1-rdunlap@infradead.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220420235545.17081-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 04. 22, 1:55, Randy Dunlap wrote:
> The moxa-smartio.rst file was moved to a different location,
> so update the MAINTAINERS file entry for it.
> 
> Quietens one build warning:
> 
> MAINTAINERS:29715: WARNING: unknown document: ../driver-api/serial/moxa-smartio
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 5b437ae9fcbb ("Documentation: tty: move moxa-smartio.rst to tty")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for the fix.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   MAINTAINERS |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13313,7 +13313,7 @@ F:	drivers/net/phy/motorcomm.c
>   MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
>   M:	Jiri Slaby <jirislaby@kernel.org>
>   S:	Maintained
> -F:	Documentation/driver-api/serial/moxa-smartio.rst
> +F:	Documentation/driver-api/tty/moxa-smartio.rst
>   F:	drivers/tty/mxser.*
>   
>   MR800 AVERMEDIA USB FM RADIO DRIVER


-- 
js
suse labs
