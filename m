Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85C85A0EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbiHYLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiHYLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:22:54 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98440AF0D5;
        Thu, 25 Aug 2022 04:22:53 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-33db4e5ab43so50450307b3.4;
        Thu, 25 Aug 2022 04:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zBAuYd6aZRMYP844dVDfOezCZkLQikm7pyO5BZEXKKI=;
        b=JzMqRCkVM9VsRkdpF4v2tDsQJ7EDhByun+gvctBM/gnN8oGe+g4ft9OI3ok210bluK
         z5D1xpj7e0ObikgznTXY57lsMxsRNmiyXNX+JeFAek+2cgBV8KdC6LNQJ+fRVJgpy6/V
         grPZA3TxTQqmsiCLREc93EDdYjecspdcXPkdl2vfr7hCr0jvRs0ppAXrjEQ7/GfOU45K
         kh0jumTtWDQna8mUm+OXmM1QJhgr6OS5eYm2DEl9oIhmWj+rkQGZmFpFVcTRnorXsVY3
         wGXmznMLJZh669Q2i1N9kEriZtH70qM0zPDzBdpw8yjo6I7us9EOCeTjgzhM1UtScNNe
         t3uw==
X-Gm-Message-State: ACgBeo0RzbJGCJcAuELhvrFnCeY+23Qzd1XAoRiVLpoAKELLU2XOXQyE
        Sy20RM1u4Mpc/aGYlwRPsSUk/kEet4thb6noR7Lm2a1+
X-Google-Smtp-Source: AA6agR6RKiwnjg0hA/QPVGn7rIdPTz+QbBVSW+tdchz15JNQtcfsiMul8ktR7HFomkZ7s43z4KN+FNjEXqFI7U1eWds=
X-Received: by 2002:a25:8d84:0:b0:695:836a:fcaf with SMTP id
 o4-20020a258d84000000b00695836afcafmr2755715ybl.633.1661426572692; Thu, 25
 Aug 2022 04:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220825090347.30555-1-junming@nfschina.com>
In-Reply-To: <20220825090347.30555-1-junming@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 13:22:41 +0200
Message-ID: <CAJZ5v0jVpCiwscgVQqS3yEwGaHUCPzR9pNDjt6qY6U4jJubt_A@mail.gmail.com>
Subject: Re: [PATCH] tools: Delete the initialization value
To:     shijm <junming@nfschina.com>
Cc:     Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
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

On Thu, Aug 25, 2022 at 11:04 AM shijm <junming@nfschina.com> wrote:
>
> From: Shi junming <junming@nfschina.com>
>
> From the perspective of commpier,delete the initialization value

I'm not sure what this means.

The initialization is unnecessary, because the variable in question is
always assigned a new value before reading it.  Is that what you
wanted to say?

> Signed-off-by: Shi junming <junming@nfschina.com>
> ---
>  tools/power/acpi/tools/pfrut/pfrut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
> index d79c335594b2..52aa0351533c 100644
> --- a/tools/power/acpi/tools/pfrut/pfrut.c
> +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> @@ -190,7 +190,7 @@ int main(int argc, char *argv[])
>         void *addr_map_capsule;
>         struct stat st;
>         char *log_buf;
> -       int ret = 0;
> +       int ret;
>
>         if (getuid() != 0) {
>                 printf("Please run the tool as root - Exiting.\n");
> --
> 2.18.2
>
