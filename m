Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDCE5A5C50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiH3HA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiH3HAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:00:52 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7C6F566;
        Tue, 30 Aug 2022 00:00:44 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id a36so9124878edf.5;
        Tue, 30 Aug 2022 00:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xV3abq7+2rnbmJWT5ZvT6yxw5guw2CyFyWdbIvvWMJA=;
        b=a3rOa3KumgObTHu1BD0se6vYXFnT/rouwl6Q8ucjoh8olMHup+AU9M0th4a37b/SHI
         ZTLAaoayu0+WwMazygUzWkD1tn+UkItE+s0Lf3NoxJBa8LTRpHnL3rDXW/VkvdnXA7kL
         /ZCjiXnkWL+Rkk2cbwMRQ/eh5FZX/e62HnfD5OPA/UGSjileWlyOFwtZLVK/nH+svUy/
         uiNGLeh5W6oR0+VInQ9AqP7MeTWZQ0RnJFgAz7hhfwUYMleFIOY2YwfW/pVxdgBLm3PR
         k3upRYVao6zjqWh3h0TjvF8Ao8/NpBA0idJNDEVL7ByWDxZHnW3eD33JUWmsWTR97NfH
         J4tQ==
X-Gm-Message-State: ACgBeo2uZ+vTwFLWOYHdwOJs5RlJcRpJhaxSyJRGqOMUIGsq9fTbdy/K
        BeVhGms2cdTIFK3Xnp2at5E=
X-Google-Smtp-Source: AA6agR4tGOGu91wzrBwm/B8UAYaCNCFPwtb9QkVXj889cIUIe4ZPADcJyTRWviMB/KKXN9s8TAs1+A==
X-Received: by 2002:a05:6402:34cd:b0:448:8286:23f0 with SMTP id w13-20020a05640234cd00b00448828623f0mr5440366edc.40.1661842842861;
        Tue, 30 Aug 2022 00:00:42 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b0073d7d9deb73sm5380485ejh.68.2022.08.30.00.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:00:42 -0700 (PDT)
Message-ID: <1d8d0d72-a5b7-724e-a70a-71d9fd3330c4@kernel.org>
Date:   Tue, 30 Aug 2022 09:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 5/6] tty: n_gsm: name the debug bits
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220823062259.4754-1-daniel.starke@siemens.com>
 <20220823062259.4754-5-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823062259.4754-5-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 08. 22, 8:22, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Introduce defines to name the various debug bits used within the code to
> improve readability and to make its specific use clear.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>   drivers/tty/n_gsm.c | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
> 
> No changes since v1.
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5a20561c0a5d..fcf2d52d5095 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -63,6 +63,13 @@
>   static int debug;
>   module_param(debug, int, 0600);
>   
> +/* Module debug bits */
> +#define DBG_DUMP	(1 << 0) /* Data transmission dump. */
> +#define DBG_CD_ON	(1 << 1) /* Always assume CD line on. */
> +#define DBG_DATA	(1 << 2) /* Data transmission details. */
> +#define DBG_ERRORS	(1 << 3) /* Details for fail conditions. */
> +#define DBG_TTY		(1 << 4) /* Transmission statistics for DLCI TTYs. */

Could you use BIT() instead?

thanks,
-- 
js
suse labs

