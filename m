Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD37B4A2B73
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352301AbiA2DfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiA2DfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:35:16 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDB8C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:35:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v74so7938326pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xpheXdEDJM6VvCfIU64qNXEiyDxBWjW4KluJVHuQUq8=;
        b=qk0s19Q63d4FCHY6zN3MYD2/RLhB2CtR31+rQUXSro1imnRPKWj9qn1DpvmGx4hZCn
         siQ1TchQPOw6yc/jzjh7F+vMKNWN9lKn1VxOkWB4osIvobPGht+fYITAZgXhQXLjtHwE
         3hpXHGUNSMGWeva0d+Y8DXATmYSdfiaxqv2mZ39x5OSQ6U2n3FLN1ageb0/CW0O331AI
         iritYYNhUWQiYrwNv4Z9rRaZGtVgLY9jJJo4yF64qOmKegu/DcSIqFo5KWwchuNI0RuU
         gtpJWiW8Az9qt6XIt2b8q5724Cic2RKAdF6G0h0uCYmEoGSWXElY9RtqjYFb/W0o+u6S
         WTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xpheXdEDJM6VvCfIU64qNXEiyDxBWjW4KluJVHuQUq8=;
        b=2Ahihh7B1Idf8YQiHhmZLjBIfpDANjcoW2vw7+/Js5Gpfm1AlL5Z9YC0msyM+T5uPR
         1cfGiPfGC3v/w29QMqA2EcbqKEg0qGeiKYo1ceMrEkW9UH2zISbFjOAG+TtiTo6vDsXw
         RP1BKQZV2H57rOjtoYpYzWhGgoxCnkJiiAX1/8rkgWviDJkQt3aa6XsyBa/yZsFq4qMV
         /mTapTwn3V8oG7N2lPVUtu/B8syUWJZf/QWinQjHT9ZZAe1MNkJ299gif+yQkQDsULcI
         DkSrk45D0KHiNxjAyFSudpzamlntLL3T7Fx7Hz08Zv2CHHTguShyNHbaJT2DW/fT291A
         xFwg==
X-Gm-Message-State: AOAM533df6E/6qzgkn5s3+W7YdSI06yDkpOA2FwKs5irg3fe1OGEBpnZ
        Fug1c9Eaj0jdEbDRY75/7ta3eIAm49tyDO8W
X-Google-Smtp-Source: ABdhPJzeKLGw416T+p9clA7uBhbAloo6Y7BlYFBP1/1XY4HpKuYJVe4Ng0C83GcCvAyaFMeYJotKWA==
X-Received: by 2002:aa7:9838:: with SMTP id q24mr11061113pfl.76.1643427314445;
        Fri, 28 Jan 2022 19:35:14 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id s37sm5963592pfg.144.2022.01.28.19.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 19:35:14 -0800 (PST)
Date:   Sat, 29 Jan 2022 16:35:09 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: pi433: add debugfs interface
Message-ID: <YfS17W10UTAKn3dc@mail.google.com>
References: <20220124042506.GA7662@mail.google.com>
 <20220124042721.GA8078@mail.google.com>
 <YfE4d4UY1yIVvapC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfE4d4UY1yIVvapC@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:03:03PM +0100, Greg KH wrote:
> 
> Breaks the build:
> 
> drivers/staging/pi433/pi433_if.c:1166:25: error: initialization of ‘int (*)(struct inode *, struct file *)’ from incompatible pointer type ‘ssize_t (*)(struct inode *, struct file *)’ {aka ‘long int (*)(struct inode *, struct file *)’} [-Werror=incompatible-pointer-types]
>  1166 |         .open =         pi433_debugfs_regs_open,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 

My apologies, I will be more careful next time. I must have missed
something out on my module-specific makefile. 

I will incorporate the changes that Dan Carpenter suggested and submit a
new version of this patch shortly.

thanks,

Paulo A.
