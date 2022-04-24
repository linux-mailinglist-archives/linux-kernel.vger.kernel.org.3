Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFD50D31A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiDXQIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiDXQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:08:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C1D2183;
        Sun, 24 Apr 2022 09:05:22 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e189so14603088oia.8;
        Sun, 24 Apr 2022 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ac5EnQuKpLRFocwuDOiyopf1JFrNIjPvay8PD58wgHY=;
        b=fVtc8R6iX3YyAP6AJ9kz1u++52MqdMBULrH5AyrtMVvrm7bXYrvfwv+REcGr2hE2oL
         dLCltApQaF199qhPgZspXcjgYmlAfNLcoonKnuu/0pMB690yPuosCOq5krCymER5MhAi
         SUP2rMT4rfchqMsV29ILZU6ASzReKg0ClgxSWZXxOnqGjfmBCLoV8mpr3eKs7P6tYhn/
         FZ69GZiduDn/4nuEzc1I62t4UR2iOhJZrJ2pYpxHHEfnBBbc4nzuMddB5HsPv/IkGQr0
         zBEypu3co2gM6soytAshFUqoxaeAeTp3OT1a59orAfXAKyOfJC54sVdi/Mi5rCb1r44H
         IR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ac5EnQuKpLRFocwuDOiyopf1JFrNIjPvay8PD58wgHY=;
        b=ikE6bTzzSvU5dXD0e8nyQYj1qrZHmfxTXLfHvvQpQooS5fajzO5gYjSosW4TpfCauD
         Y6lig/AJK6le6INIOI/rERRYseGZSEz2k0uNGKCw7he25JVHJtrJ6UycSFhEG6UHBvln
         wk8Jwzgdk4FI0T/p/BaypXV4sZx926eMkMadL684WmDR7YotUQCpyuFa+TXfZxiXCylY
         1dHYTHjUbnB1N3F/Tu1FCH/f6z3SMTTlVOGJEbgfkssZEdUlngXzg+wp/PBc7QN8MJef
         fvNL08P7G5+rNzz3F5EW9R02mIPwMuVMvE5/cyVd2IvrXcnZp6xGIFJlPcA2tObok9Dz
         SWBg==
X-Gm-Message-State: AOAM532ufZ3XtW5QtEErl2OiNZi76Yd08sr3UAbzUdGV5gyYHdIl8APC
        Hg/VN8RoJa02LP6jd9bz02I=
X-Google-Smtp-Source: ABdhPJwpmbpkn9fi0aIt6tFzND53Dos8K/T2Zuv/UkTrefHxO7YC4k6EUAKnGGMDOQLK53ceEBJjXQ==
X-Received: by 2002:a05:6808:103:b0:322:6d3f:dfe0 with SMTP id b3-20020a056808010300b003226d3fdfe0mr6596469oie.207.1650816322301;
        Sun, 24 Apr 2022 09:05:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q8-20020a9d57c8000000b006056352c3dbsm2882421oti.29.2022.04.24.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 09:05:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Apr 2022 09:05:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Update Documentation regarding
 firmware bugs
Message-ID: <20220424160520.GA718874@roeck-us.net>
References: <20220424154824.9396-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424154824.9396-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 05:48:24PM +0200, Armin Wolf wrote:
> When adding the Inspiron 3505 to the fan type blacklist,
> the Documentation was not updated to mention the firmware
> bug on this machine.
> Fix that.
> 
> Fixes: 6ba463edccb9 (hwmon: (dell-smm) Add Inspiron 3505 to fan type blacklist)
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/dell-smm-hwmon.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> --
> 2.30.2
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index 41839b7de2c1..e5d85e40972c 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -331,6 +331,8 @@ Reading of fan types causes erratic fan behaviour.      Studio XPS 8000
> 
>                                                          Inspiron 580
> 
> +                                                        Inspiron 3505
> +
>  Fan-related SMM calls take too long (about 500ms).      Inspiron 7720
> 
>                                                          Vostro 3360
