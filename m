Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12F7595FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbiHPPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiHPPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:54:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9209F7676;
        Tue, 16 Aug 2022 08:51:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pm17so10088046pjb.3;
        Tue, 16 Aug 2022 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=dZzIcHBxE3lkefRICNpDvJxqV+9R54fIIT6t9/ak+2g=;
        b=F9EtWNSJnp3vj+vG9H74zj9nGRgtw4oOq7NorgJzh8QnbjOeJKFbmQGWQtuTmwYDP7
         shQStJZWjcuCb47Q3LSfHo3wzDBB+Mmhp57SPYmrtWOqKZ/8LwBI/+JqdOoWotjux7YB
         Z/jurLogBucIQ71kg3fTWTsiygQI2CQeKV5vy03DwzkzjRUn0tBrCVR+YtrUWIpeVXFv
         MdYy8lW1g5cka/3FickSLmhGpVWsMXNNlmQqT0gRdOp8Jm9fiX0uVYQ8wjJlTsNeTBb+
         BaI/FShBA8t7BtyFGVKzI/1hNt2wrYkxOQSCRVeuZTy7kdM9WPr6acHkxMYVXh67Wzby
         hOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=dZzIcHBxE3lkefRICNpDvJxqV+9R54fIIT6t9/ak+2g=;
        b=zugUfIYhv/WGG5PJnKd66M0a1/1jY05lBH3MfU1gUDlxA6SiIImxduJ1LrIqkc6Fgx
         evuyvGqa0v2Rn/T+ie0TIoqYjt0wUXMoAvLG+qWW0EfzQm3cv93TSRPIgEtG6ukKIjv6
         aEmdEs3/Ubi+IFGG+oOtD68A7BIc632nDbOb6g0CwQWnVnzZeD6bTMJ/oj0ppIneU7qW
         d46dIWGVsVBnZjXn5RnJlXJHjvxn9MULGxj7DODpjQqbuYeVdkLAfNnkLF4V6yv7b1JD
         ovN+tTCvtagQ6iVQCRituxrtkBpkzSePQejWiv9QubXYHOYJfVPc8BDeeK7fjKI0Fgar
         fyBw==
X-Gm-Message-State: ACgBeo0RStnJhLeVYMv2cG2kkOECC3piWDekvZ46oSb9gaffGLf3uKaH
        GXGyWSbxniRdlg0i4JS+YBnRqGi5/ps=
X-Google-Smtp-Source: AA6agR5l+XM0sK4Q0oxVQSNnOgUdpHQnFaqBzV/ZDNmPbroRtygwjQ7CNdj4aCNlZBleiapWX0H6Vg==
X-Received: by 2002:a17:902:f70a:b0:170:c5e7:874c with SMTP id h10-20020a170902f70a00b00170c5e7874cmr22252821plo.109.1660665062013;
        Tue, 16 Aug 2022 08:51:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052d200c8040sm8595567pfy.211.2022.08.16.08.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:51:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 Aug 2022 08:50:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/watchdog: fix repeated words in comments
Message-ID: <20220816155059.GA3310237@roeck-us.net>
References: <20220816124126.14298-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816124126.14298-1-yuanjilin@cdjrlc.com>
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

On Tue, Aug 16, 2022 at 08:41:26PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'we'.
>  Delete the redundant word 'set'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

I am going to ignore all those patches simply because the subject does
not mention the affected driver (but does mention the unnecessary
"drivers"). Really, and I have said that before, if you really have
to submit those cosmetic patches, at least do it right.

Guenter

> ---
>  drivers/watchdog/wdt_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
> index d5e56b601351..a5fed7ea0243 100644
> --- a/drivers/watchdog/wdt_pci.c
> +++ b/drivers/watchdog/wdt_pci.c
> @@ -347,7 +347,7 @@ static irqreturn_t wdtpci_interrupt(int irq, void *dev_id)
>   *	@ppos: pointer to the position to write. No seeks allowed
>   *
>   *	A write to a watchdog device is defined as a keepalive signal. Any
> - *	write of data will do, as we we don't define content meaning.
> + *	write of data will do, as we don't define content meaning.
>   */
>  
>  static ssize_t wdtpci_write(struct file *file, const char __user *buf,
> @@ -443,7 +443,7 @@ static long wdtpci_ioctl(struct file *file, unsigned int cmd,
>   *	open and on opening we load the counters. Counter zero is a 100Hz
>   *	cascade, into counter 1 which downcounts to reboot. When the counter
>   *	triggers counter 2 downcounts the length of the reset pulse which
> - *	set set to be as long as possible.
> + *	set to be as long as possible.
>   */
>  
>  static int wdtpci_open(struct inode *inode, struct file *file)
> -- 
> 2.36.1
> 
