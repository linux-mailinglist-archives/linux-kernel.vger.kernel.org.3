Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D96461E07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378899AbhK2Sbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350659AbhK2S3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:29:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A1C0048EB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:51:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e3so73055951edu.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GBYpAOe925BYrIse3QCI1ulmcepuLdu5an1jAdY1VrI=;
        b=kxatyFzeyi/rc+oHpXxoebQ+yFL4RQY+Q1mBNvYX9E4spJI2w5Ti44hdY9V8xVDAP8
         RQHppNJ2g+luc/DmSBYamVYQSMobW0Gwdh2728FM9hO4HIMZdLjX9JbiYXyzrqswl+sG
         4KedEYV8VS/uWooTSKnHj2JgRNDdm5tkrNOoGwo3jaZnXjlHum2tIiXSe4rN3rrirohk
         Mi/qUhFg90+rJBwkWDYSutTdJMY5EbIDfBiXwXd2+J+wSLULFvZbPi2I7Lyy7WkAzgmJ
         KqGLab5JNTg3cA7oIanGmsFAQ6YlcAHbZPaiGVz4b178aQJj7eZLjIrUt4YeT/WgPSGl
         WDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GBYpAOe925BYrIse3QCI1ulmcepuLdu5an1jAdY1VrI=;
        b=qG/1I3lKiE7Fu+CTR/3Yyp0Q9AqWNv2aiIZA1+LQ53mmYIgAPPL9HhwTm3o8uoUfLk
         /1IzmTPDalHOBzYWh5OrJt45YPiRBJ2WiUBEB0uA1NpCrFgTpbAqneDAFDq41Y4XzF/9
         9p57sE3+sHzli5RdR8UNge4SQORuA1/3qVU9PgvoJnYAPSLqcZ9WW0F8r7KLAZy232My
         AtMLjI99uaHGdQAbg4IisAhokBTYJBZOMx65CvM0y9ysZWR0oDtjZXPa/4cbinLAJlM2
         hqKzr8Hlh9LQyktx880zpHY849kgL6+uNGSipUQqpfZhXh7+vKTaY95R3I3OF43p+HJf
         DplA==
X-Gm-Message-State: AOAM533elq/0R3p7MTMqWgGfDyySzhVLUmSnaCZ1nbJtwgvWcEeZnmYi
        8ctojAhv6I17oXeApLnfEkGy9mOEOeRqB+fT8oGwK9HmCCO1rA==
X-Google-Smtp-Source: ABdhPJyzP17frZijHTBJmZpl44+A4bs23s05Y3uMLqMwxrTHIQnKvNEAg8uHLx/onOgUvgQAlAhodjXBIUtw+j8WNrs=
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr76354604edd.286.1638197467771;
 Mon, 29 Nov 2021 06:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20211126225329.1150651-1-colin.i.king@gmail.com>
In-Reply-To: <20211126225329.1150651-1-colin.i.king@gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 29 Nov 2021 15:50:56 +0100
Message-ID: <CAHTX3d+Sc47Cj7Rs7HxWSLapvwXsWa-1-VBknsFLXBPmEhyRLw@mail.gmail.com>
Subject: Re: [PATCH] microblaze/mm/highmem: Remove redundant initialization of
 variable maxmem
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

p=C3=A1 26. 11. 2021 v 23:53 odes=C3=ADlatel Colin Ian King
<colin.i.king@googlemail.com> napsal:
>
> The variable maxmem is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/microblaze/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 952f35b335b2..f328d4549fad 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -144,7 +144,7 @@ int page_is_ram(unsigned long pfn)
>   */
>  static void mm_cmdline_setup(void)
>  {
> -       unsigned long maxmem =3D 0;
> +       unsigned long maxmem;
>         char *p =3D cmd_line;
>
>         /* Look for mem=3D option on command line */
> --
> 2.33.1
>

The patch is fine but From and SoB email are different. Please fix it.
./scripts/checkpatch.pl --codespell --strict
0001-microblaze-mm-highmem-Remove-redundant-initializatio.patch
WARNING: From:/Signed-off-by: email address mismatch: 'From: Colin Ian
King <colin.i.king@googlemail.com>' !=3D 'Signed-off-by: Colin Ian King
<colin.i.king@gmail.com>'

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
