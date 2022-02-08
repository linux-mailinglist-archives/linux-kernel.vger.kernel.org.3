Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167914AD697
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiBHL1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356333AbiBHKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:32:28 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58749C03FEC0;
        Tue,  8 Feb 2022 02:32:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id co28so9394010edb.1;
        Tue, 08 Feb 2022 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3+9Y32cf+Ax3G/iWkV5vM08y7nrpNijPcp38VaOUAE=;
        b=Kw06RO75rbLUFrLHJ93ga19ZxxshO5/eizKWNfLYjMLV3cJLg4d6s+I98J5q0VdCGo
         NS6bdVcwDSY89lrxKuzs2BAoT4Fpucs1BIEecy7QnncI/TKM2grUufsKf8mumEt7xgzB
         gElndbyM+A7LeU83VNqK8dqsVA2jgtQfpn0Ew0uTKWbBmFbbM9waSxznq4LOd2UFOfIi
         5AoAAcr/B87VPn5AjrWpUQgsdKowxCKuJIGRJwVMstEcDgP+PZ/CajWf3g7IBNv9uLXt
         1s0Ml5wnJw0nag6BMDmDNPHTcbRIdl6rALNKSZTP67OzwrJaU5Q7Edci0gw/YsRFEyCp
         XiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3+9Y32cf+Ax3G/iWkV5vM08y7nrpNijPcp38VaOUAE=;
        b=pYlp37jRKIhFlVBCUt9GLmcknxEzsOO1OzQ5+iBlcqzwuXhXFVDTxiM+iInwIvPgiZ
         FY+Ccuj8mCVzscoQ9M4wCxpLZIvwIa9VPeKCOnrfZ6+dhvnoBw3fVQ2wnmbmseoDT5ic
         3LfdygKlaQIE+4YZ93iun+XiRbseuig9ynwkIGnryMkcKXxD/Yb3V+KX+ez1mPygIK3x
         vdk1IUs8hYOEM1PzuhOvNnG1es0tlsRHvay3nQrmloxwAz72wwCEV91WnZj7bnKYgA8i
         jd0nO4pNIy6aT+0Q44CcuW0KiyNnQ9IPYa4ywj4ETG2VJODz5+qvqC8AgBKy1tdvNVyn
         RyQw==
X-Gm-Message-State: AOAM530gdBl8apMDHCHG83EFqJFWjFXFqplOlolnvDo+qwoXsP+Xgfek
        g/t4Qus1AhnDuI9XyVh0SmIopHrRAbrYMAz6jtY=
X-Google-Smtp-Source: ABdhPJwz3uJ6NB6o/NiskBls8cso3tajnnfMcijvIzyd4aD0huokx70+fDoPUd5tajwSs1cuxL+FwQ51hqdYoSjLnWo=
X-Received: by 2002:a05:6402:2741:: with SMTP id z1mr3760419edd.264.1644316345736;
 Tue, 08 Feb 2022 02:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20220207232129.402882-1-athierry@redhat.com>
In-Reply-To: <20220207232129.402882-1-athierry@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Feb 2022 12:31:49 +0200
Message-ID: <CAHp75VexSp1kijGHoOijSHB44fHTWqj6LZPzhSBhN2ms2huh-g@mail.gmail.com>
Subject: Re: [PATCH v3] serial: 8250_bcm2835aux: Add ACPI support
To:     Adrien Thierry <athierry@redhat.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
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

On Tue, Feb 8, 2022 at 11:13 AM Adrien Thierry <athierry@redhat.com> wrote:
>
> Add ACPI support to 8250_bcm2835aux driver. This makes it possible to
> use the miniuart on the Raspberry Pi with the tianocore/edk2 UEFI

TianoCore EDK II

> firmware.

...

>         /* get the clock - this also enables the HW */
> -       data->clk = devm_clk_get(&pdev->dev, NULL);

> -       if (IS_ERR(data->clk))
> -               return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");

You shouldn't remove the error handling. Even if optional there may be
other types of errors that need to be reported.

> +       data->clk = devm_clk_get_optional(&pdev->dev, NULL);

...


> +       bcm_data = device_get_match_data(&pdev->dev);

Move this closer to the condition where it's used the first time.

> +       /* Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
.
If there are some not doing that, can we end up in the situation when
for the same ID we have different offset?
Also, Why not go and fix that implementation?
Can you provide a DSDT excerpt to show how it looks there?

TianoCore EDK II

/*
 * Multi-line comments should look
 * like this.
 */

> +        * describe the miniuart with a base address that encompasses the auxiliary
> +        * registers shared between the miniuart and spi.

SPI

> +        *
> +        * This is due to historical reasons, see discussion here :
> +        * https://edk2.groups.io/g/devel/topic/87501357#84349
> +        *
> +        * We need to add the offset between the miniuart and auxiliary
> +        * registers to get the real miniuart base address.
> +        */
> +       if (bcm_data)
> +               offset = bcm_data->offset;

...

> +static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
> +       { "BCM2836", (kernel_ulong_t)&bcm2835_acpi_data },
> +       { }
> +};

I believe this ID is allocated by Broadcom. Can we have a confirmation, please?

-- 
With Best Regards,
Andy Shevchenko
