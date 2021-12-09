Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA9C46F50F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhLIUnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:43:43 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:42865 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLIUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:43:43 -0500
Received: by mail-qk1-f175.google.com with SMTP id g28so5973559qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 12:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5cbjPR8V32UhlFm9qsloDchGghKjugVek16cCsnJHSA=;
        b=2CWQzdeau2sGk2fxTvoEhaiP81Dv90g8JZFTPGFEw7SAfpvIvEf8kJW25r0Zu0AHjC
         0oguC9Ug/TXkyJ4nCX4JsGoHwQBLixSkhS5NYS1koSb821S0ns7KViP5KqHeSWGAEkTW
         q8Or9LjlZ5WnObQ4WtsFd0XtG3VSB/7qAROcdGxa1ioxCaRpMYx2pQM3/K87vswE+MWJ
         ELqyCFcZi4KiJ2XaDnQnli2m72DGVuvwcaPSM50+GrtcPc46Yk+EVkhKfyf4PHa8zwNv
         o9FPiAkg2mQkAnYWTGzEUDcEVzG+P2AgxPQdabzR3QVswxtTLXCiFU5AIV2ALypOa+0D
         W1DA==
X-Gm-Message-State: AOAM5300oigP7sVxRtW7d1qIRS0pU8CatW9PFJ9aOx/eefGc/i2kpHKE
        P9DAjJxN81vsmWy+yy9zbuY=
X-Google-Smtp-Source: ABdhPJwpsY5mERenb55w41K1LFFG6m6k32ejx8rHLGpKk25AU16nKcF56PbrN3yxgGcA1MBVcb8atA==
X-Received: by 2002:a37:b53:: with SMTP id 80mr16026972qkl.91.1639082408763;
        Thu, 09 Dec 2021 12:40:08 -0800 (PST)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id b6sm577679qtk.91.2021.12.09.12.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:40:08 -0800 (PST)
Date:   Thu, 9 Dec 2021 15:40:06 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v1 1/1] percpu_ref: Replace kernel.h with the necessary
 inclusions
Message-ID: <YbJppiVtI+F5Pda1@fedora>
References: <20211209123033.3492-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209123033.3492-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 09, 2021 at 02:30:33PM +0200, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/percpu-refcount.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index b31d3f3312ce..d73a1c08c3e3 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -51,9 +51,9 @@
>  #define _LINUX_PERCPU_REFCOUNT_H
>  
>  #include <linux/atomic.h>
> -#include <linux/kernel.h>
>  #include <linux/percpu.h>
>  #include <linux/rcupdate.h>
> +#include <linux/types.h>
>  #include <linux/gfp.h>
>  
>  struct percpu_ref;
> -- 
> 2.33.0
> 

Applied to for-5.16-fixes.

Thanks,
Dennis
