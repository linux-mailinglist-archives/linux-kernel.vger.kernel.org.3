Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FBE4B8D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiBPQNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:13:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiBPQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:13:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE62E0AE9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:12:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id f17so4786375edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbPJ3n5RfOCMAbabRRWgoVSNDfOSeOFNd1MQ9EnXwM4=;
        b=pC52/Sf3+x/HEtc4q5aCHZJ1FWX7NmmIZXZMex1YSTqhzRovMr5YCowtF7juLMEcck
         ReYIzWkhCLkS3ECXeHHYgN0Y9ttiWbhnPOTAZGteOYHx86kC56CVi1hQTYJjpSd8/lri
         /NYi3F6S4F2de5IWONPJi4HkO7MB/g2Kx5Zmmt9uIhArB28YmtUE+PKLyidKPFrIM3C4
         DPAKTNdxHLNy2J9vDn7cGfiWpzyXWW997NEAKC4W8F7GuIl6p9DlxHyEX4xyTCX3YLRC
         Ko32/ozfoMc/57SOqyVE9e+M47KiZau2Q/Cdo4Er/H0ekkoeWckWu87jj/qrO8vj5R3l
         cpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbPJ3n5RfOCMAbabRRWgoVSNDfOSeOFNd1MQ9EnXwM4=;
        b=oQKynu78CSR+YrPCYxLg0Rj2r0Z+Nj1m0eV2Rx7hfXuptQCqOqZhs22/+m8SbVlity
         qe7w3Ogl3JHIHIU8Jko9lcX/1md9AmvHh8Cwn4FT3jxSc20k9bnpJcaXErfBJYHMeIXj
         8Z7TsK3VF8sqwHAOM1LgF5WNY7DZG62A8CR9I/tlZsrQ8NWMVaWrEVEFIZdpJiqY/cBr
         5X+4wy8yVQAKOfQjzlUUWRvWLeOk2tdRnmn+7syiP6GWW9Y8V92MPE3XBr4WqX/01bWJ
         wh22BI/P3hJh/QDyB06o+zWAAsB4BnZVnXRfILYfB6IwoKsBLh2sosD4X3NyrG6YSIdF
         PJpA==
X-Gm-Message-State: AOAM5331sGzXuMU3HkitjDT6Ll8e+O/CsrnHTZmaWkmGNS5gJNFvqAsr
        D64to56N5epyISJMyUtmxhdZzBkXzXWbwmx+g6Zelw==
X-Google-Smtp-Source: ABdhPJy1a0u1XwoRZpKXxj1eL9juRcpeRxgjfgjoaYfDrYGvnCCZvt02pHQy1VA0jNtAteH0353up6Iuv2xxrq7kNBI=
X-Received: by 2002:a05:6402:84b:b0:40f:73ea:c3c1 with SMTP id
 b11-20020a056402084b00b0040f73eac3c1mr3684618edz.169.1645027973442; Wed, 16
 Feb 2022 08:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20220216062601.779690-1-ztong0001@gmail.com>
In-Reply-To: <20220216062601.779690-1-ztong0001@gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 16 Feb 2022 08:12:42 -0800
Message-ID: <CABXOdTcZoGy3w_aVPju0DLr+Ab0C8XUsMs0+XsTW0QacR53iug@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: honor acpi=off
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:26 PM Tong Zhang <ztong0001@gmail.com> wrote:
>
> when acpi=off is provided in bootarg, kernel crash with
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000018
>  RIP: 0010:acpi_ns_walk_namespace+0x57/0x280
>   <TASK>
>  ? acpi_get_devices+0x140/0x140
>  cros_ec_lpc_init+0x25/0x100
>
> Driver should check if ACPI is disabled before calling acpi_get_devices(),
> otherwise acpi_walk_namespace() will dereference null pointer since the
> acpi_gbl_root_node is not initialized.
> This is a common pattern and should be fixed in ACPI framework to prevent
> such crash in the future, but since many drivers are already doing explicit
> check(acpi_disable) we do the same thing here.
>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index d6306d2a096f..95412a55ed8d 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -550,6 +550,9 @@ static int __init cros_ec_lpc_init(void)
>         int ret;
>         acpi_status status;
>
> +       if (acpi_disable)

acpi_disabled ?

One does wonder why anyone would disable ACPI on any of the supported
systems, but in either case this is wrong. The driver should not abort
if acpi is disabled but just not call acpi_get_devices().

Guenter

> +               return -ENODEV;
> +
>         status = acpi_get_devices(ACPI_DRV_NAME, cros_ec_lpc_parse_device,
>                                   &cros_ec_lpc_acpi_device_found, NULL);
>         if (ACPI_FAILURE(status))
> --
> 2.25.1
>
