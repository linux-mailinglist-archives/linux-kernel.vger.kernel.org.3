Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2D48FBBE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 09:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiAPIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 03:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiAPIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 03:35:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB780C06173F;
        Sun, 16 Jan 2022 00:35:59 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i17so6896321pfk.11;
        Sun, 16 Jan 2022 00:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lyLZTYSyuAn/6nSvG/d5MsLS1Bsklk+dE7iVisAOhLs=;
        b=ou41Nv8kXRUgFv98bk62qYY81G+O013+KlO5b3dWuLsp8FQ3BCZLZRejRkF2bmWLBk
         WP2u6ta/UyWGKxRzQwvbmN7mB3wMpHU+wzXAl6KvXL8Xp76v+HS9nCPmZn9+tauRu016
         HdZOh8u6RS9B/lN0N9itsoK5FW9i8Zxdxfnm9Jem6j2+QWIKWtA32LVG3YkprBKUBUWq
         hge2Hq9S+cHLg6yU2IAMnYWq8JXKFgMPtZsIvgmZEHISz0skYZ26OiCVKqDmw787gUvG
         2UQf81EGsRkT/uLhEKA1oXjd0uceMN2vmZo7oHHDBhsJucYmdBDhxE6l1aQlPb/K2x+o
         pNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lyLZTYSyuAn/6nSvG/d5MsLS1Bsklk+dE7iVisAOhLs=;
        b=ejeQzKiDg3NtCPg0T14pbV3OIT/kOD2IOJjn0INM/uuaSpusKKcvf7HZ6kzuN7qFkL
         AA7EUGlE/YRVReO75RQlN+rdOYq90WvC9wukZRn6VSOVyKgJIV4LFGB3dWtkMosFFfae
         WW3rTs5IMDaCZG+eTXmnL3ME4nRJ8JNtFqzgeQY+tQZUnrpiAUnBXQ1RcLa01T8suUvF
         AQJWUgfAbN+ss1/ztEsv/h5GTceihWaiM93VYbpgxwI+fxrou+Bl6XSJrnIOX/wn2UsN
         pOaq03Ky828cQmV40108LIFKSoayA4FYbVpKe/h17ve2pMIZccOkZYWcfI9cid3DaNdk
         o60Q==
X-Gm-Message-State: AOAM530YCcpTIKU93M5txFQ7Bf1CyAbz9f7KAF3/6YGV6vR7Q8TtRv1t
        o9QLKTEQ63Po2Lm1GY1Gl8o=
X-Google-Smtp-Source: ABdhPJzCTtBWFSIlmGVfq6v0JvCmEslFOuImFALxtxLfDwxvns/PqsoKIgK7MPegcLKd2C5Bi+Lhyw==
X-Received: by 2002:a05:6a00:1905:b0:4a8:2f86:3f18 with SMTP id y5-20020a056a00190500b004a82f863f18mr16150087pfi.52.1642322159294;
        Sun, 16 Jan 2022 00:35:59 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x7sm3378391pfd.196.2022.01.16.00.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 00:35:58 -0800 (PST)
Date:   Sun, 16 Jan 2022 17:35:56 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: liteuart: fix MODULE_ALIAS
Message-ID: <YePY7EO5iLmbhh3R@antec>
References: <20220104131030.1674733-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104131030.1674733-1-hi@alyssa.is>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 01:10:28PM +0000, Alyssa Ross wrote:
> modprobe can't handle spaces in aliases.
> 
> Fixes: 1da81e5562fa ("drivers/tty/serial: add LiteUART driver")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  drivers/tty/serial/liteuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 2941659e5274..7f74bf7bdcff 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -436,4 +436,4 @@ module_exit(liteuart_exit);
>  MODULE_AUTHOR("Antmicro <www.antmicro.com>");
>  MODULE_DESCRIPTION("LiteUART serial driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform: liteuart");
> +MODULE_ALIAS("platform:liteuart");

This looks fine to me.

Acked-by: Stafford Horne <shorne@gmail.com>

> base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
> -- 
> 2.33.0
> 
