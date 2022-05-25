Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE4533DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244447AbiEYNgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbiEYNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:36:00 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26516B029;
        Wed, 25 May 2022 06:35:58 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ff90e0937aso140117627b3.4;
        Wed, 25 May 2022 06:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKjjcpLnSifwU6ntjOTqclHj+h8rBziZUbb3L9lxcDg=;
        b=lgYGhqBepZQKci488ntebJ/0rUbvTS9MHf3P4x/dQfBL6ZkYsfjkI3xiDGwdaaEQ1G
         eFvvgKTXEdY+BfOrrMqwafHylX9uvbfaITN/oakR7u9pWQ2+YDMah9oPnQ3siplGQ+As
         Qg71yz+tVJ3vPILsTjairH66IzQre8M3Ebn5/ycbmF6mU2XbrNpyvBgJl51JteHi7/BQ
         vP1BHRDi5dPZjH+1vm6PFPS1Xp8McgMfrDZ2wYV/R5wwEn1gJmDl0jNgTgSs66z5ysj5
         YZYk/4RlMe2t3aoDy7HN+sXTYUpEa7Tm3PNTfWw/kdB8TcejFw/sR1oWgYhyGyxPNsqf
         7kyQ==
X-Gm-Message-State: AOAM532v8ttno0Jb963ZJco2wILO1VUr4hvO/LZgzmw6Pt7AFIF/ji42
        mxjKX44igvRfYfbmBEmDbO52POAzC2l+HZdS5Jw=
X-Google-Smtp-Source: ABdhPJzQUvt3Yu6IiEi8JAkJDQsOorfs7WMwyEkr4paJ5HARc9sR0Jz8djKLhlGx4MgG1bHOvbSE9d2hzMJkr7J/J1k=
X-Received: by 2002:a81:6d8e:0:b0:2ff:a8d9:d574 with SMTP id
 i136-20020a816d8e000000b002ffa8d9d574mr21948441ywc.301.1653485757927; Wed, 25
 May 2022 06:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220521111145.81697-3-Julia.Lawall@inria.fr>
In-Reply-To: <20220521111145.81697-3-Julia.Lawall@inria.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 15:35:47 +0200
Message-ID: <CAJZ5v0gatD6rsLS582=yk-h4m2wGyt8g9OJ69iN26Ldm5esr7Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: fix typo in comment
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org, Len Brown <lenb@kernel.org>,
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

On Sat, May 21, 2022 at 1:12 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  drivers/acpi/cppc_acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index bc1454789a06..e6c1df0b3cc4 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -305,7 +305,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>                 goto end;
>         }
>
> -       /* wait for completion and check for PCC errro bit */
> +       /* wait for completion and check for PCC error bit */
>         ret = check_pcc_chan(pcc_ss_id, true);
>
>         if (pcc_ss_data->pcc_mrtt)
>

Applied as 5.19-rc material, thanks!
