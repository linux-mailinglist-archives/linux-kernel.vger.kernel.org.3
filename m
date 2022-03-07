Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A24CFDEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiCGMOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiCGMOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:14:43 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9F4BFF8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:13:48 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C08C3F5F2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646655226;
        bh=m0uKneq0JoikL42mXxDjF/EwLxNv6F4NkgutMu3gMRo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Uhml3gBPdpJPdOv5ZVGCvp6Cr8zKe2MbeKmQWObFHXFbM+DneSCqJ+gwqcYXuZazl
         CNzuCbVWzyPff5qrCMmvM0TZw4XzZHKH7+gm6RvEcmZ/afvShhIp5V/LSCNpoGZu+h
         tZU2KRyrVEecv7xngSZR8YrP0F99k15VKd1dYmpzp2jNC/s3raIDq6bPo0ZzPll6iI
         Jy0ZpogCkVlay/76thkIJ/Ph0lBqF0ckLu88r7eUSH8i1nJRz5Vy4E7s2Z3jXO3VVa
         Hke7D6MIiSIS0ApRuTQuJpKCw6EkC/oee9cEXfZBOUH62CYMPlBYkM3MhKGCRPIKJB
         Jcqw0scqJKvFg==
Received: by mail-ej1-f70.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso6865072eje.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:13:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m0uKneq0JoikL42mXxDjF/EwLxNv6F4NkgutMu3gMRo=;
        b=bYu48k+IhAfbNSRIeclWaYmYXSJaZFvDM1oBHwLuPUCzYsioZrZxOrVYEXRDSU6lyw
         TJiymEwmrL4f2N2REjrBepar7bGcjvzR6MUaqaeyHxlRxKj/hvhDMIm786z8NbL5yWNx
         hjCp/OmNTlQyuhCq3OBd5d6NsGNyzpH+VPGAEClTfNBnu+HIUrwm//OXKVl5DlVNXCrX
         a3TaqOGcmFUmGAi5ESvA2oX2hsaX+GJVHBOPP6OZJH0F/a+f7uWjedi+k4dSldZgcDUy
         WBz6ZmvMhEhtIZTU642YE73k1NyzikMpSdsBaoYiUrcQIMREIMeGwgdf52AxGgbqCFqx
         PhSQ==
X-Gm-Message-State: AOAM532+twQypTI4JiNADRVhBLwaNLidF9kDIRpUSEm2Ak5rKqkotLaj
        mCDrnyi5fMuILg6uiT7cNj8rQvX/5baEpXEuyLbDQDYbR7vBkLBHEE4DyIXa+r2zdrfaXM5JQlI
        tpCtcbz0usgMZlX05UMw0kjH/g/Is5FH9qekLkcUnMw==
X-Received: by 2002:a17:907:961b:b0:6d9:acb0:5403 with SMTP id gb27-20020a170907961b00b006d9acb05403mr8706934ejc.568.1646655226211;
        Mon, 07 Mar 2022 04:13:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywT7IBmPGMfvXgI54h2O/sp9f7H0qBKfZ5y5SAFWqU5Vcyr1g+IKctTsIB2+Ivgs7cal6HeQ==
X-Received: by 2002:a17:907:961b:b0:6d9:acb0:5403 with SMTP id gb27-20020a170907961b00b006d9acb05403mr8706919ejc.568.1646655225992;
        Mon, 07 Mar 2022 04:13:45 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fq6-20020a1709069d8600b006db088ca6d0sm2164801ejc.126.2022.03.07.04.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 04:13:45 -0800 (PST)
Message-ID: <3655d921-3798-0a01-1b7a-32261389dde5@canonical.com>
Date:   Mon, 7 Mar 2022 13:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 26/26] usb: gadget: udc: s3c2410: replace usage of rc to
 check if a list element was found
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Al Cooper <alcooperx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220306175034.3084609-1-jakobkoschel@gmail.com>
 <20220306175034.3084609-27-jakobkoschel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220306175034.3084609-27-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2022 18:50, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable [1].
> 
> This removes the need to check the rc value to determine if the
> break/goto was hit and can be made more obvious
> by checking if the variable was set within the list traversal loop.
> 
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/usb/gadget/udc/s3c2410_udc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
> index e3931da24277..fe6ecb0d16d1 100644
> --- a/drivers/usb/gadget/udc/s3c2410_udc.c
> +++ b/drivers/usb/gadget/udc/s3c2410_udc.c
> @@ -1265,7 +1265,7 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  	struct s3c2410_ep	*ep = to_s3c2410_ep(_ep);
>  	int			retval = -EINVAL;
>  	unsigned long		flags;
> -	struct s3c2410_request	*req = NULL;
> +	struct s3c2410_request	*req = NULL, *tmp;
>  
>  	dprintk(DEBUG_VERBOSE, "%s(%p,%p)\n", __func__, _ep, _req);
>  
> @@ -1277,16 +1277,17 @@ static int s3c2410_udc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  
>  	local_irq_save(flags);
>  
> -	list_for_each_entry(req, &ep->queue, queue) {
> -		if (&req->req == _req) {
> -			list_del_init(&req->queue);
> +	list_for_each_entry(tmp, &ep->queue, queue) {
> +		if (&tmp->req == _req) {
> +			list_del_init(&tmp->queue);
>  			_req->status = -ECONNRESET;
> +			req = tmp;
>  			retval = 0;
>  			break;
>  		}
>  	}
>  
> -	if (retval == 0) {
> +	if (req) {

I saw comments from Greg about it, so please keep similar approach here
as in patch 25. I propose to keep retval.

With retval restored:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
