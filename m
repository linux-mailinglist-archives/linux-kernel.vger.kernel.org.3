Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64556527AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 01:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbiEOXol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 19:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiEOXoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 19:44:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101DDF2C
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:44:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso84839wmp.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5tB/0RCkRxYJE2Qleq67jSfMpolKftLgFUqc/n2KSk=;
        b=BshpUhaFSHFLX0VKlXRdy1W3UnxKmtMdnadQocHcM//WBwuQKwgQDps5xc12FlEwrB
         AMdxGyxFG+QGaj1rlqZUXIcnauGONir5158+WHB2GZxUPgoxdjJlZwv4BRPqaq4pQRND
         LC/CAxArbF2CghHoWiuVq4FJLhXjgl7+/oG+MBUY9n7dh+BDI0WkX0WRUqYdKOfUwRau
         wSu1XgaIki6+H3fxKqDqN0gYmf7dNWhFaTFIKgnvMbp81D1oCKmvlZw6A21pEXo1BH1d
         bDwjvO6d+44tFFdPoW3AeZj7OqOuJMx7eWkAo6KhapmzpkPI8RtUgCWT1JxXiByIEvVP
         XApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5tB/0RCkRxYJE2Qleq67jSfMpolKftLgFUqc/n2KSk=;
        b=O44qVXl6YRp747DMePs0DvuO5iU2vR+YJwWRo38oR5UDCpzKaNfEKJ8vLIk9kpvVXx
         4XBxhgnSkn37tTgFoOQkKm0ROKWbLminw3BcLsCBapHVtOS7Ef+KIYMTJ9y1FP+hzg0s
         KajTWnVxoOG6R49IZJOfO5FjS2P+vDrd4vouEfQljzVcwQYUt7bWWVrzR26wkvvF28ch
         WQoA9K3U/OUHTLLxnACfoqkDs6Oey5yWVNXXsvTJSrfE5l91m1SMZUSNb7Vvukc5qtoF
         8JsmmyX7ZAlUa7krNKEaGDIoaWbwWHHWsiY72rre+CvKSsVQZyBixn+cc+vhnvD1ujZi
         UtPA==
X-Gm-Message-State: AOAM5313yICrxxKEjylCl3ajbazEuuHLOEqn4I0y1IbB4nuJZRYjVZBi
        DFgOTzeJVUWeG33xRrmla/S/zos6J/POviIw1WFx
X-Google-Smtp-Source: ABdhPJyKjW2SH6nATvuNpvvi/xOKsv5suy15BWls/9/d/oSHHezTLGxr7PZnOioVWJlauOAkDlManyF7x2s3jkqURxA=
X-Received: by 2002:a7b:cb97:0:b0:394:3374:7f93 with SMTP id
 m23-20020a7bcb97000000b0039433747f93mr14386282wmi.204.1652658274523; Sun, 15
 May 2022 16:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220515073110.304193-1-sshedi@vmware.com> <20220515073110.304193-2-sshedi@vmware.com>
In-Reply-To: <20220515073110.304193-2-sshedi@vmware.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 15 May 2022 19:44:23 -0400
Message-ID: <CAHC9VhRPTV2sDdGgczLAN7dW+kkX06=1=Qas4QGztXtricBjag@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: fix most of the checkpatch.pl warnnings & errors
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Shreenidhi Shedi <sshedi@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 3:31 AM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>
> This commit fixes almost all styling issues reported by checkpatch.pl
> script.
>
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  kernel/audit.c | 205 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 127 insertions(+), 78 deletions(-)

Please don't send me patches like this unless you are an established
contributor to the audit subsystem, and even then I would strongly
encourage you to think long and hard before hitting send.

Most of this patch is just comment formatting churn, which is okay if
you are doing something else in a nearby section of code, but a +200
line patch of such changes is not okay.  The printk ratelimiting
changes are probably okay to submit in a separate patch, but I didn't
look at all of them.  Although some of the pr_cont() to pr_info()
conversions warrant a closer look.  The EXPORT_SYMBOL() relocations
are probably also okay is sent as a separate patch.

-- 
paul-moore.com
