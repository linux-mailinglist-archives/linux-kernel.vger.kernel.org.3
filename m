Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB51E4E1A90
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244881AbiCTGvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiCTGvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:51:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D1244A25
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:49:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r64so6904422wmr.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8zlmcZBe54nzv+sPTCpjVIQwlQlmj+Rk7igGR/RQiU=;
        b=pX4zif4eg8fCDj8Pfh8tupbxqQSdh+FZH3MlyHmQO4y5SplcfkqADTwoBWPzPe6lhb
         QFNNosPdZ3rsIySIlcs6hc7cpizRRUVmlXoKOKajZhwX2xafPykjM/1RmvOJrMG3YPeI
         WfqLrSpF1fhrzMyvmO+A/6n/YRrCUWXyU9CtJTcDWw/xGOVRH4ONYxFDJ24z3Sqht5t2
         elGg8oN72AyO+KhPoXTI3CQQXa9CPgTfx7EzleEX9W/G/xglmPMLb5ZiR24K/Fhx/H3r
         PfLEXFJtuM7rXG3+49doY6nujMGYiWDTYIzSxJZj6do2onZIe7qEXkls1mW24QTqyS1w
         tv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8zlmcZBe54nzv+sPTCpjVIQwlQlmj+Rk7igGR/RQiU=;
        b=lhZUVJqYoNGMvTsrto9EqwhHIaLAkgYO4FOWhkXwxioOJvmYPttQ0iN4mcOFGGOK3J
         nkiKGeaAVagh7O/5hgvgirnphoeaXCzD1tcD7P8d6fCgd1THbftQQwPx41Fyha5u7Lif
         vanNOwc/pC8YEiHMwYVtdrLj8rNoaZG4DvN3aCCat6yynl0EA7b99JHXZoQYXH5q+bNf
         Y8+rX2XV3Ivjib45UZg/h35WiCOl1II/pPESS8a+d6H4p3Utonm163ZC+P+S4W4mzKnL
         SX24GN2IQXksDKVs82qYEdRQ2s13TzSxH9Yfug4i+ihJ1QjjUc3axfMkMfzZvYLJdoz3
         w9Vg==
X-Gm-Message-State: AOAM532SSI67N59FFVr1P07xYyMddVPCAGT+ZOIAY2a0dzzFNRAY0i2/
        VC88RXIIy/g50+4MyZMyImo=
X-Google-Smtp-Source: ABdhPJxtKjt8AqmhFu+MN7rzZi35l53F431OBF5ua5oY7VpSjEJPNejwLvKq/68cdabO2j1V79LzjA==
X-Received: by 2002:a05:600c:a08:b0:38c:93c8:36e9 with SMTP id z8-20020a05600c0a0800b0038c93c836e9mr5823801wmp.97.1647758977549;
        Sat, 19 Mar 2022 23:49:37 -0700 (PDT)
Received: from leap.localnet (host-87-20-105-171.retail.telecomitalia.it. [87.20.105.171])
        by smtp.gmail.com with ESMTPSA id l13-20020adfbd8d000000b002040daf5dffsm948321wrh.18.2022.03.19.23.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 23:49:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Ryan C. England" <rcengland@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        "Ryan C. England" <rcengland@gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Fixed a struct coding style issue
Date:   Sun, 20 Mar 2022 07:49:24 +0100
Message-ID: <2821664.e9J7NaK4W3@leap>
In-Reply-To: <20220320033337.47118-1-rcengland@gmail.com>
References: <20220320033337.47118-1-rcengland@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 20 marzo 2022 04:33:37 CET Ryan C. England wrote:
> Fixed a coding style issue.
> 
> Signed-off-by: Ryan C. England <rcengland@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index ddbde3f8430e..f2bf7995b403 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> -- 
> 2.27.0
> 
Hi Ryan,

Welcome to Linux development.

You are working on an old version of the staging tree. Please rebase to
the latest version of staging-next. drivers/android/ is not anymore here.

Aside from the above, what style issue were you trying to fix? Everything 
looks fine in the line that you changed,

Why did you decide to add the "const" qualifier to vmfile_fops? Do you 
know that since then the fields of vmfile_fops are not anymore assignable?
What should we do with an empty list of file operations?

Furthermore, why did you drop the "static" memory qualifier? Do you know
why it was (I suppose correctly) "static"?

Please don't ever forget to build your code before submitting patches.

Thanks,

Fabio M. De Francesco 





