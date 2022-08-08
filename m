Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2A058CA32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiHHOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbiHHOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:09:32 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2166DFC6;
        Mon,  8 Aug 2022 07:09:31 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31f445bd486so81528017b3.13;
        Mon, 08 Aug 2022 07:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KP+Y2CoREOwPEAfcEIIlg58FxBYlnBpo4RuuRj/LAAs=;
        b=mCPAPFWOmLxAGVcafKT2BH3k5nKbfvl0DZ7ZGHfuLkRdBpx6pma+fiSR8IT9RlBBWK
         dmxCBNAt9urM74EsNoSBNOb3Paj+rbTPlP+QF4YGvFDSgEQr8s7fEDL2S6QpYp85VY77
         7SbH1UsD4aCmIIB89kGm9z28Zkr1pz2IEukV+obM0OwmHHqFmDZIbBlfUzOeJmGap2VN
         9pz0VMsBuvbUrjV7Vii86o1UuJPwee+ZPlsysezDJf0YiP9WfjER2TWPV8nmuIV8I0/v
         Pj1HXzoXF55+dcR0Lr8BgmQQswJ+zSvOUfM0CU5wmX7PxkNmyxSPLVgbNe53/2L+YWyW
         kqzw==
X-Gm-Message-State: ACgBeo05Ah2ETaDS5Y4JkzG2ZZm5p5K3AqyqywzCQ852taTKuCkXOLQG
        xd4/ZvztQ3ef9hgClOjkyK2f0m7wJXjIRiTOvsRfNaTL
X-Google-Smtp-Source: AA6agR6yfjb/GmD7Ttd6VPQRNP/F8jZYt+Ogyd/6i3bkpXlre7HoSBdHobjOTx+jMnyGBxhcqk5pLRZfIVP94vNbSE8=
X-Received: by 2002:a81:ae0a:0:b0:324:59ab:feec with SMTP id
 m10-20020a81ae0a000000b0032459abfeecmr19118034ywh.7.1659967770546; Mon, 08
 Aug 2022 07:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220808024128.3219082-1-willy@infradead.org> <20220808024128.3219082-31-willy@infradead.org>
In-Reply-To: <20220808024128.3219082-31-willy@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Aug 2022 16:09:13 +0200
Message-ID: <CAJZ5v0h7ipSZBJLH70CGbOGiigoqsQAuyGu4Dz856fcYkyGNhg@mail.gmail.com>
Subject: Re: [PATCH v5 30/32] ACPI/APEI: Add missing include
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Mon, Aug 8, 2022 at 4:41 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> From: Kent Overstreet <kent.overstreet@gmail.com>
>
> The upcoming patch to switch tracing from seq_buf to printbuf means
> we're no longer pulling in headers that we used to; this adds a missing
> include so things don't break.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: linux-acpi@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/apei/erst-dbg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
> index 8bc71cdc2270..370993c9c381 100644
> --- a/drivers/acpi/apei/erst-dbg.c
> +++ b/drivers/acpi/apei/erst-dbg.c
> @@ -11,6 +11,7 @@
>   *   Author: Huang Ying <ying.huang@intel.com>
>   */
>
> +#include <linux/fs.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
> --
> 2.35.1
>
