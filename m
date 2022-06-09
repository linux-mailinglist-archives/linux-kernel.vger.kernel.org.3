Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2315451EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbiFIQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiFIQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:30:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C3287F49;
        Thu,  9 Jun 2022 09:30:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so48567003ejk.5;
        Thu, 09 Jun 2022 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/sjdWC0GS+tRAh6Vs/BzO5ThKtSyT6V2dJOpuhJPMA=;
        b=JPnRdvX9X4TXxEyeuJ8Yxp02z/JfppJq5UtxO2GCEse22e4eHn4PrjnOJ4CFGWF89B
         A2K8cKZ3rjg3a76o76wceKBOkfdyYRymE/pGv2ajxNK1SmoPANCajnCvqlCYknx6W+7U
         IfRYjm1ZJDYZcAPYH7oIIzIZ4jHlDDwtOEMri8QV2a0JKjf6onrMj8T27uQwo6ECNJm7
         +dAGXQ4jy9FKGfQop+MKkwTsnNm72qRaBLsKo70jIVPJYPzS4h/gW9YicZXUhDYaZuBq
         NQ51eGFVI+HNEhBwuV3nsjRvAoHJ3fff6bSqZK5zSLKUooF/9oEq4Cn3LpSbc3xQDbtq
         PL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/sjdWC0GS+tRAh6Vs/BzO5ThKtSyT6V2dJOpuhJPMA=;
        b=CBXCka8ErUY7YHUVQnmThc9eVyYiGUbuzXcycKW743bSrmxtVnzzK/N6Ee9jZFUphR
         NaQ9tXT+cYdmayGKtgxQPPG+Zel3i+flRphrV2akcd/olxMWRC7OVBXel9y25UBcEeAB
         EifjR9HzGymu3kODImkmmG2bemNBjrOt171ZExUgmj4i/qp6ByKfCkbxjXioiahsnZOT
         fNGrd84m2ZNbx2wOqMInMLgWerT12xBP3myDNgIqBmSLpU646qV2HU2bxfnUfigF+U3A
         Eu+e248ksa6ckI8aggLaJSsUXk88hO1VJtPwAuJuuujfZLcEicT4S7d184T8eHE311Dt
         JCKw==
X-Gm-Message-State: AOAM530RBajsRoWrZAc6Nz+9PHBYRej5xQtio1/cHjICRoO265YdvHCn
        OkDbHVJHoqkLWX5eSYnaX+CzWIS6hvWFfnRWfgA=
X-Google-Smtp-Source: ABdhPJx4+RSPuKs/dqA5hWxIDDmYaAWEjprpjzlXwC1ilPF3Uwt4ukdpBGT6Wp+CzuffPonJSSKrrpnIS4CXpDZpH4E=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr31469936eja.44.1654792212477; Thu, 09
 Jun 2022 09:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220608212923.8585-1-jorge.lopez2@hp.com> <20220608212923.8585-2-jorge.lopez2@hp.com>
In-Reply-To: <20220608212923.8585-2-jorge.lopez2@hp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jun 2022 18:29:36 +0200
Message-ID: <CAHp75VfPoranKhsHJo=8jJXXhdvqn4-x2E2UJa-Yxb_=tO3QDg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] Resolve WMI query failures on some devices
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, balalic.enver@gmail.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 11:32 PM Jorge Lopez <jorgealtxwork@gmail.com> wrote:
>
> WMI queries fail on some devices where the ACPI method HWMC
> unconditionally attempts to create Fields beyond the buffer
> if the buffer is too small, this breaks essential features
> such as power profiles:
>
>          CreateByteField (Arg1, 0x10, D008)
>          CreateByteField (Arg1, 0x11, D009)
>          CreateByteField (Arg1, 0x12, D010)
>          CreateDWordField (Arg1, 0x10, D032)
>          CreateField (Arg1, 0x80, 0x0400, D128)
>
> In cases where args->data had zero length, ACPI BIOS Error
> (bug): AE_AML_BUFFER_LIMIT, Field [D008] at bit
> offset/length 128/8 exceeds size of target Buffer (128 bits)
> (20211217/dsopcode-198) was obtained.
>
> ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [D009] at bit
> offset/length 136/8 exceeds size of target Buffer (136bits)
> (20211217/dsopcode-198)
>
> The original code created a buffer size of 128 bytes regardless if
> the WMI call required a smaller buffer or not.  This particular
> behavior occurs in older BIOS and reproduced in OMEN laptops.  Newer
> BIOS handles buffer sizes properly and meets the latest specification
> requirements.  This is the reason why testing with a dynamically
> allocated buffer did not uncover any failures with the test systems at
> hand.
>
> This patch was tested on several OMEN, Elite, and Zbooks.  It was
> confirmed the patch resolves HPWMI_FAN GET/SET calls in an OMEN
> Laptop 15-ek0xxx.  No problems were reported when testing on several Elite
> and Zbooks notebooks.

Perfect!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Also needs a Fixes tag:

Fixes: 4b4967cbd268 ("platform/x86: hp-wmi: Changing bios_args.data to
be dynamically allocated")

(I believe Hans can help you and add it on the fly)

> Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
>
> ---
> Based on the latest platform-drivers-x86.git/for-next
> ---
>  drivers/platform/x86/hp-wmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 0e9a25b56e0e..d3540dd62d06 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -290,14 +290,16 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
>         struct bios_return *bios_return;
>         union acpi_object *obj = NULL;
>         struct bios_args *args = NULL;
> -       int mid, actual_outsize, ret;
> +       int mid, actual_insize, actual_outsize;
>         size_t bios_args_size;
> +       int ret;
>
>         mid = encode_outsize_for_pvsz(outsize);
>         if (WARN_ON(mid < 0))
>                 return mid;
>
> -       bios_args_size = struct_size(args, data, insize);
> +       actual_insize = max(insize, 128);
> +       bios_args_size = struct_size(args, data, actual_insize);
>         args = kmalloc(bios_args_size, GFP_KERNEL);
>         if (!args)
>                 return -ENOMEM;
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
