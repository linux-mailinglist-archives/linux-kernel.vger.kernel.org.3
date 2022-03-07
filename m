Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1D4CF218
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiCGGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCGGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:42:43 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B5438189;
        Sun,  6 Mar 2022 22:41:50 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id qt6so29594758ejb.11;
        Sun, 06 Mar 2022 22:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J7DC1Vzn2L5a72N66qdsn8mPgbxF2/NaUgybTaQB4J4=;
        b=oTwxVBaGorMjnUXba2XiGt45qtmYW9qFWItGNwcrJpG4grN5N43ss4S12B98ncaG6Y
         /g6+d9A8426MqgqSMjJmjLGI4yX8qMgUYz61bon6DD9UiBekZ2+qx/+8C6zTRwlr/SxW
         82o+Opmk///sWrBobAI201uC9oPuuPiBQdDKG66feZYgdJmrGfchBryhlUoygluVznm2
         NFd1prx7QlBIxcGtiOiVcj4iRQffyJb3GtSDB4K/WBleN7I6n6W6qqrPUMfNWi1m8pf3
         9MKy4jOWvZOzkfL2JxYtRQ1EMECdwQ8wmelkRJkEGp61s7lNSI5ntksWJtQYesiLLP3S
         D9Qw==
X-Gm-Message-State: AOAM530Uzd3oQ5KcpEGL6Td0MwU+OLNqEpctPNmLJKYXVaw8MKrVjc2B
        Kcn/WVwY5GpvRJ23IPXfYS1OdomF8AA=
X-Google-Smtp-Source: ABdhPJw7dZa0tv9xj0VQVou4oKFiZULTaWLDsEJ478Yot9VphVBdeR51NxVCUqWrCbUIWKn1Oala3Q==
X-Received: by 2002:a17:907:970e:b0:6da:9204:1d3a with SMTP id jg14-20020a170907970e00b006da92041d3amr7731948ejc.687.1646635308739;
        Sun, 06 Mar 2022 22:41:48 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b004132d3b60aasm5708170edo.78.2022.03.06.22.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 22:41:48 -0800 (PST)
Message-ID: <f48dcaba-8015-380f-ac3b-54818c48350d@kernel.org>
Date:   Mon, 7 Mar 2022 07:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] docs: serial: fix a reference file name in driver.rst
Content-Language: en-US
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com
References: <20220304100315.6732-1-wanjiabing@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220304100315.6732-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 03. 22, 11:03, Wan Jiabing wrote:
> Fix the following 'make refcheckdocs' warning:
> Warning: Documentation/driver-api/serial/driver.rst references a file
> that doesn't exist: Documentation/driver-api/serial/tty.rst
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   Documentation/driver-api/serial/driver.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
> index 31bd4e16fb1f..06ec04ba086f 100644
> --- a/Documentation/driver-api/serial/driver.rst
> +++ b/Documentation/driver-api/serial/driver.rst
> @@ -311,7 +311,7 @@ hardware.
>   	This call must not sleep
>   
>     set_ldisc(port,termios)
> -	Notifier for discipline change. See Documentation/driver-api/serial/tty.rst.
> +	Notifier for discipline change. See Documentation/tty/tty_ldisc.rst.
>   
>   	Locking: caller holds tty_port->mutex
>   

thanks,
-- 
js
suse labs
