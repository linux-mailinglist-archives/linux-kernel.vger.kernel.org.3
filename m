Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96537546768
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348843AbiFJNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiFJNeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:34:07 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA734EA8;
        Fri, 10 Jun 2022 06:34:06 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3135519f95fso102232567b3.6;
        Fri, 10 Jun 2022 06:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6ECJedJvloi1HGFoYaKDExh4EWkviU5WWXywQvPon0=;
        b=rVnhOkkNHhTiGMth6YdiEQslWpXvfqLYdKkNcwd0DLL0xN47tPz/3nBQY/VPan7VQJ
         SnEBfULrhyP4wqIPA+ygNaNbKGTieWnASauV0hxYQRUqojDC+fYgxLI1Un6dCZ1PnNPj
         S/RiPfMgYy9oTwmlw3XDAVsQ+OwmJpixaOCQfcSekPQE/DkyIiirES0c6zteuo3fyA/v
         aM3vyCpLEQyLd0h1mLcRGnzwZxj8kldj9q5gejoTU7gdj9BfHLUnQyA4f+26qYLAAOhj
         MjyxpHjpWHaHUClbZg4caBt5I9g5sR3pHSS1Uj1dQtLwk8yr7lMiErTAabZLChp3di7N
         vFbg==
X-Gm-Message-State: AOAM531i/yprsbv44SKj1Zxj2Tw8KR6m616ujrA30R7zagFJ1xFrKmMp
        6sWCSV/I+gsmE9bHpMrf62Ccq4d/TWv8DIPgkFwVYQDK
X-Google-Smtp-Source: ABdhPJxOxa8glSpv9tbI8qCUA87VmBFTGvZ6WN/5NnYTVw4ckZZYEf3WniMBfs6Y6WGAWVwnxC4xqWWu/Te6zm4jpvk=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr48674377ywm.149.1654868045603; Fri, 10
 Jun 2022 06:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <fad9b50609f9d9828ea14772dbd4d195713f1c4b.1654846687.git.lukas@wunner.de>
In-Reply-To: <fad9b50609f9d9828ea14772dbd4d195713f1c4b.1654846687.git.lukas@wunner.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Jun 2022 15:33:54 +0200
Message-ID: <CAJZ5v0jBVyxegaETv5D25N+LNZWRUsJeVcx-p8cGXYod8=smWQ@mail.gmail.com>
Subject: Re: [PATCH] genirq/PM: Unexport {suspend,resume}_device_irqs()
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 9:41 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> Ever since {suspend,resume}_device_irqs() were introduced in 2009
> by commit 0a0c5168df27 ("PM: Introduce functions for suspending and
> resuming device interrupts"), they've been exported even though there
> are no module users and never will be:  The functions are solely called
> by the PM core, which is always built-in.  Unexport them.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or I can take it if no one else does.

> ---
>  kernel/irq/pm.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index ca71123a6130..c556bc49d213 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -147,7 +147,6 @@ void suspend_device_irqs(void)
>                         synchronize_irq(irq);
>         }
>  }
> -EXPORT_SYMBOL_GPL(suspend_device_irqs);
>
>  static void resume_irq(struct irq_desc *desc)
>  {
> @@ -259,4 +258,3 @@ void resume_device_irqs(void)
>  {
>         resume_irqs(false);
>  }
> -EXPORT_SYMBOL_GPL(resume_device_irqs);
> --
> 2.35.2
>
