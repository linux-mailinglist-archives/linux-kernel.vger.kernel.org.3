Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94FC5424A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388739AbiFHBpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453353AbiFGXPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:15:21 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F763B70C3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:05:22 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-f16a3e0529so24795478fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hZGYROhtc+r5EuBPRXRPsq3auazBOIHrsoWkHCkus/A=;
        b=E6z/y3535PwEvaGG/kczDZYWKzEVC6yPiv3C5AOpZUUtDJzOO9teoQRjjnYAXGY/MK
         kTE/tyJWS3Zrxfva/UTAXkMXotRgAFmuAyFavxkHgbGfgyN9LP3pOizIrjZic/ngk6Cp
         kufmfKYN+H8sKOKZhCFGm+yOu+ewKoIOUHoyuFimHPlvSoUQBhuP4KYxaOyFwg7D+zMF
         WOJLKXYglQ+/VHqh5e0vVKVyKEY06n/ZzlR3ybpTbpo1W7vkWXet9QHfkGWCEGJjZHBp
         XnCXsWkRXca5yIfU/yOLjuJMe5j0nypTixqvhRDiwV15tugZS+I7LOVjsaGkMdZcyjCy
         bn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hZGYROhtc+r5EuBPRXRPsq3auazBOIHrsoWkHCkus/A=;
        b=dPJPTVMSBvHtl88yydVZWHIahElfuU9Mq80bkhMg++qlcU74RXIr4TnY6V2CXlzX+j
         H8sZfo620G0sgu6JWVviqEiiSUzYa9gf2L+gZ5WWXrJdvKE8RyxQb3VP8zpg7wj5Df/w
         nU3Qx4HqlF5DsljBfDPZmh8NavrgExxkQ3doLF/xpm4TkXuIYDK2+/fcdVz4Je3RPkfA
         NEtiO1f6fvT3dnhHhowroE/XIDTbOA4MG9M0PtDmbA87CAQnmbk2ArG0i2m+VNNYz+Yr
         ZJucqLynjgYj8r0RL9GIdB/F3EG1XDhNAYavTo4MQhzUSBij8dhgf66B0mHaX1bfNf+U
         yNUg==
X-Gm-Message-State: AOAM533aWDYCAeF3So+3gUftdOOQR6UPE185hJXVxbf9JN0Fynb+I7b2
        PbaQNyM4dK94uScbATqQwPKxYKwRsHE=
X-Google-Smtp-Source: ABdhPJw0ntHjWYuJvNi+dH0TcqFOGxYGzKyN3xmI9s3cUSfSR64Qm1HKl7eYIQiwkRtnt+5C7f+Bew==
X-Received: by 2002:a05:6870:b41c:b0:f2:5d2b:9a77 with SMTP id x28-20020a056870b41c00b000f25d2b9a77mr514272oap.62.1654635921154;
        Tue, 07 Jun 2022 14:05:21 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870ea0300b000f33ced2c50sm8519389oap.56.2022.06.07.14.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 14:05:20 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <69f9ec95-a680-d251-ebfc-1b4c20bfff5e@lwfinger.net>
Date:   Tue, 7 Jun 2022 16:05:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/4] MAINTAINERS: add myself as r8188eu reviewer
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org,
        phil@philpotter.co.uk, straube.linux@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1654629778.git.paskripkin@gmail.com>
 <d6f6420a0d5ceff6bb50d268023f7d2e117027c5.1654629778.git.paskripkin@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <d6f6420a0d5ceff6bb50d268023f7d2e117027c5.1654629778.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 14:26, Pavel Skripkin wrote:
> I was reviewing r8188eu patches for a while, but I am missing some of
> them, since I am not in CC list. I want to be CC'ed to help reviewing
> and testing more patches.
> 
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> Acked-by: Phillip Potter <phil@philpotter.co.uk>
> ---

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..60e5e4007844 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18920,6 +18920,7 @@ F:	drivers/staging/olpc_dcon/
>   STAGING - REALTEK RTL8188EU DRIVERS
>   M:	Larry Finger <Larry.Finger@lwfinger.net>
>   M:	Phillip Potter <phil@philpotter.co.uk>
> +R:	Pavel Skripkin <paskripkin@gmail.com>
>   S:	Supported
>   F:	drivers/staging/r8188eu/
>   

