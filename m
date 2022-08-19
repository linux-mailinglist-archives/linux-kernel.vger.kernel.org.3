Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C15599CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348973AbiHSNil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348474AbiHSNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:38:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D352DCD;
        Fri, 19 Aug 2022 06:38:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q9so2798420pgq.6;
        Fri, 19 Aug 2022 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=iPZV9dQjqVQ/vppwSoQKr/gWD34ac0i1nS8ZDCqevyo=;
        b=j4WsxHlLzkms/dCD/k+KI+QLZ37iqJLjO36Qu6E4/+Na15KRxxH6Ui7iinZ4D/1iuQ
         76qXAJ7pGuDNzjkitMgNhlzUVWWEmjq9naB1bBS0bGwUUqYqRgNB4ySW5aIE7kLxRfCk
         mdzjqnds5Y8LWzSZcQ4AY8fQNxajkqVsle4CpBLGEb5mZbxlCwhegQJD9F0moJUVPRg3
         8QVuw9OyNB0knZ/8d1QHMDEFuaiyhjet4tpi7tDiMBOPqP9wrnudluT77TrJy/iXa2h5
         tE7DwZo9ehlT6f7EQFcguplSvE5lsUS5NG7w0sfnq5H3xE+2FGrJCTSK+4IPk/tEHHBa
         HUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=iPZV9dQjqVQ/vppwSoQKr/gWD34ac0i1nS8ZDCqevyo=;
        b=SwYAFHT34Jcm3CI1VXInc/rgtQujxTvMadTiH8zC4a2j5kmbi+9FFOuZZCM0SyS92C
         Hjx9E2tPHgpYJlzQ3Orp6PlBQ9KT0Fbpf4WBUk7Ah4Y6kvhi8R1Tt3OaUW6BJAYdR9UX
         p3a8pzF3znjyODwXxE8thzBuo98RUFhhImkCKEYSUudAfoT69qNlOmKuoPAn6g54xe/i
         XH/3BDqWjtuSeCE0v6RogXcJUJtzqSiNrUPU3yNp/Howca5KYZJXLAhWbhSY5QjHNlvr
         dq/niZ2WV7IHhg3pYfFFJJ2eMJdH46CxsviCFLzqPZ/k8bZiQwGyq0PLE99FQ08eqRu+
         s2jg==
X-Gm-Message-State: ACgBeo2ul6RynVlw0WUpfGV0GJ77NyJanHiSvk7VYwGfyzHmoiBlC7Hg
        ugE5CSlBpg8VV838ez8URao=
X-Google-Smtp-Source: AA6agR7i6q9TJNA0yGydGB8c294QRmQVJsTmFGQWm1dR8mLVu4X4UA2h0IYbbZfvW7kjXffwC299Wg==
X-Received: by 2002:a05:6a00:15c3:b0:52e:677b:7026 with SMTP id o3-20020a056a0015c300b0052e677b7026mr7939659pfu.75.1660916317274;
        Fri, 19 Aug 2022 06:38:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o4-20020a170903210400b0016eede528b4sm3170166ple.61.2022.08.19.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:38:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 06:38:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Juerg Haefliger <juergh@proton.me>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Juerg Haefliger's email address
Message-ID: <20220819133835.GA3109335@roeck-us.net>
References: <20220819055039.840221-1-juergh@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819055039.840221-1-juergh@proton.me>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:51:09AM +0000, Juerg Haefliger wrote:
> Use my main @proton.me email address.
> 
> Signed-off-by: Juerg Haefliger <juergh@proton.me>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --
> 2.34.1
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f512b430c7cb..d7efa940dc37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6178,7 +6178,7 @@ F:	Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.y
>  F:	drivers/memory/samsung/exynos5422-dmc.c
> 
>  DME1737 HARDWARE MONITOR DRIVER
> -M:	Juerg Haefliger <juergh@gmail.com>
> +M:	Juerg Haefliger <juergh@proton.me>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/hwmon/dme1737.rst
> @@ -21784,7 +21784,7 @@ F:	lib/test_scanf.c
>  F:	lib/vsprintf.c
> 
>  VT1211 HARDWARE MONITOR DRIVER
> -M:	Juerg Haefliger <juergh@gmail.com>
> +M:	Juerg Haefliger <juergh@proton.me>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/hwmon/vt1211.rst
