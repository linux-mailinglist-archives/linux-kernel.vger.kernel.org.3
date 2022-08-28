Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7DF5A3ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 03:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiH1BvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 21:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiH1BvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 21:51:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA3233A1C;
        Sat, 27 Aug 2022 18:51:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so4764564pgb.4;
        Sat, 27 Aug 2022 18:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=TsdWYg1/XWjmBnfDv85CY2hpRDv7YjWMUxKvmvDv9V4=;
        b=ZW2shkgp73dSpsVXgcUHDdrnB8AN1jHKJBJMCDlj8uEfI69vKKybu/RLvyeVtHwZZ+
         cfLLCDHtTm3NOnsBUAv8YQ/WOuRR3sb0SBNfIf5s44UFqsce6ziWBpKC127AIYwkJXEP
         Aiga+ieNY+cY6R6yGo1G0CxhfKiJLiDOqGTqaMLEAe1cSdzpr5W1g5kF3PDsyNZyjIKD
         f2leioLKp/w2t9ewRvYflr+QDbLpk/BGpcc+rP3DpohVHoqAkpPnH5v9e11TwTE+Bax/
         /gBub2dR05oIwh5mgLl7DB2MH/1xEc7HMo8pxFLbFDGc5LaiHZPxI5Ewf9SLE/pgmsQa
         bTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TsdWYg1/XWjmBnfDv85CY2hpRDv7YjWMUxKvmvDv9V4=;
        b=j7XuvcqjGOfoVTBO+U4iMDD1oLaEz3FIROUviwwKbWYh0Gg140TNoST1WD1RdKZ0AS
         K8qngX75ozvBqKaZaHKGNSLuq7FrXlUsUpIn3PkZz3JLS6sVKYt/vbAnl4I0uAxuE4BM
         tkqWMc9e6i1c1hJ1QtgVS25oSOuZV7j/TZu6hphFaEONNBtEG+2+kx65Y/fe2qK9SD1y
         8hdB5zblzDtEUceCKCCO3o7sx2UFGLN8smEOD9X6ZmNqrI8TDeOqFylmW5q8IpDgfhbo
         WI00a8V9N8ZxZpAnrelY/6YMwOP50l8lEbGP7dTbwKlNykc907IzzVueOQiZ8xsflIMO
         /3sw==
X-Gm-Message-State: ACgBeo3pTt7pq3r2XWklfDMGFW8Szl5omctsLbzttDV4cxakKycsaKG7
        vb3L8HwbizGOr12+zKKLUUk=
X-Google-Smtp-Source: AA6agR6CV89n8XVQ/rikVS0vdw+KI2XOXLnkEAGObQSlv87ciFRyXGlGC7S53BWmlRHqC+M2VY3XEg==
X-Received: by 2002:a05:6a00:1356:b0:537:9b9a:4db3 with SMTP id k22-20020a056a00135600b005379b9a4db3mr10309230pfu.69.1661651465593;
        Sat, 27 Aug 2022 18:51:05 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-85.three.co.id. [180.214.233.85])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b001709b9d292esm4310229plg.268.2022.08.27.18.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Aug 2022 18:51:05 -0700 (PDT)
Message-ID: <6cb3b3fc-30d4-0396-fc95-8182ca72fb1e@gmail.com>
Date:   Sun, 28 Aug 2022 08:51:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Documentation: fb: udlfb: clean up text and formatting
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220827193925.19612-1-rdunlap@infradead.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220827193925.19612-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/22 02:39, Randy Dunlap wrote:
> -From the command line, pass options to modprobe
> -modprobe udlfb fb_defio=0 console=1 shadow=1
> +From the command line, pass options to modprobe::
>  
> -Or modify options on the fly at /sys/module/udlfb/parameters directory via
> -sudo nano fb_defio
> -change the parameter in place, and save the file.
> +  modprobe udlfb fb_defio=0 console=1 shadow=1
> +
> +Or modify options on the fly at /sys/module/udlfb/parameters directory via::
> +
> +  sudo nano fb_defio
> +  change the parameter in place, and save the file.
>  

Better say "Or change the options on the fly by editing
/sys/module/udlfb/parameters/fb_defio."

>  Unplug/replug USB device to apply with new settings
>  
> -Or for permanent option, create file like /etc/modprobe.d/udlfb.conf with text
> -options udlfb fb_defio=0 console=1 shadow=1
> +Or for permanent options, create a file like /etc/modprobe.d/udlfb.conf
> +with text::
> +
> +  options udlfb fb_defio=0 console=1 shadow=1

Maybe we can say "Or to apply options permanently, create modprobe configuration
like /etc/modprobe.d/udlfb.conf with::"

-- 
An old man doll... just what I always wanted! - Clara
