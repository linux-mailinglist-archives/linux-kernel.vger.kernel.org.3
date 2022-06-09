Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E58545461
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbiFISsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiFISsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:48:39 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E042C06B2;
        Thu,  9 Jun 2022 11:48:35 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-30ce6492a60so250777857b3.8;
        Thu, 09 Jun 2022 11:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfgs3zwI6Rth5egEh1uHX/PS8PM8WensrtQySUC8V5c=;
        b=tVka1LKZE1A3lPhBCEbw30cZZXHQ9hAgFUhw/QQwGUrCWShgqyzMH+1AAqiZ96fmlA
         NTIiXjVgwdqehcUp53MpZjopgoprCZbRIIvfldZ7a6LCbI4dx8xFdlx48suroJmwcGsf
         8RRvuzTcJhLs4KkaGI/MHU+CDrw3HSvk/VgjZQcvwW8giZIh6IXaYg/jTcFdj1LRPw8h
         HpK7jTxpXydQ3hyEI7elDoIBGVqg5m4V2wUAeF+AxaCluoCC8oQJbxf5Gx5a4CSPiozS
         oKm03GJAIMvp+N78/NajoPHwYqMtTepe5MIxsQTBEpt45/2faZeZu5RBCh2lj1Q25zvi
         OIWw==
X-Gm-Message-State: AOAM5326W6ksESlCWem8wtlTtbr6cQiJhLIsJQLddsDnl5r6uKXHYo3w
        56Hxr9Yk+i9VwWLGpCkgC9TV5WRFpptbz7a042s=
X-Google-Smtp-Source: ABdhPJxVs9MnNScxd5uOSVc2Dz0VtoMVGY20F5PJ5ue0hd/35cGKtgDhnygbjd3vHJgSnIe8CXdJIwlnJ5INio2uOcU=
X-Received: by 2002:a81:8844:0:b0:2fe:a7de:20c2 with SMTP id
 y65-20020a818844000000b002fea7de20c2mr45512057ywf.515.1654800514786; Thu, 09
 Jun 2022 11:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220604041253.9298-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220604041253.9298-1-wangxiang@cdjrlc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 20:48:24 +0200
Message-ID: <CAJZ5v0iMedFgAhkX6QNgjPf9PN_+LOVUWqCCqTDnqvbbMjsGog@mail.gmail.com>
Subject: Re: [PATCH] ACPI, APEI, Fix syntax errors in comments
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Jun 4, 2022 at 6:13 AM Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'the'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/acpi/apei/apei-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 33b7fbbeda82..9f49272cad39 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -3,7 +3,7 @@
>   * apei-base.c - ACPI Platform Error Interface (APEI) supporting
>   * infrastructure
>   *
> - * APEI allows to report errors (for example from the chipset) to the
> + * APEI allows to report errors (for example from the chipset) to
>   * the operating system. This improves NMI handling especially. In
>   * addition it supports error serialization and error injection.
>   *
> --

Applied (under a more precise subject) as 5.20 material, thanks!
