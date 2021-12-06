Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201E646AA7C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351932AbhLFVfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351778AbhLFVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:34:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A65C061746;
        Mon,  6 Dec 2021 13:31:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so48548941edd.0;
        Mon, 06 Dec 2021 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGGJ/0Da454drz8o7P1nv4jVOxoCQJvdP5iy7oytDZ4=;
        b=K0ChTKtCkttJcpgJlZGR09ZMimEXXDr5JXRo98CPQe926UQKVnaKkQyIpRzw0SW2Vg
         t6eHzqLL63OAzoE8gVOr78Brz3nDOvj4lJ9LXhOBXFYiEkariFZud5so108iAy/egNPa
         NbELHHQM1V3dj4Fb+DwVTEICQagSJ3zB6KhtDauKLgoZBgno40IA1xdeeLbDSDAciNxu
         PRdyvm31IHlecuQTs2ZJMuHunZlbOXMMF5N/XgL6txEeFUftWtlW4DlcD1sP3DsDQP8R
         BLLRDFg1Yb6CUyeWd6DZcSPFEvkDRCJJoW4DxhHe8hya1UdGhZzvCOMjGAJDYxeHSQc4
         8FRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGGJ/0Da454drz8o7P1nv4jVOxoCQJvdP5iy7oytDZ4=;
        b=74mZW2afpzWlIWw/w89518gfxpJ5Egs8SrjBbAjGPgTKsnAWTAN5aUXfPbeDKL10cA
         u9Hns8eKTH4qB7tLSD+kJIapeRi9xQexlCjaUIicfXhNuPSweGLzNc1X+sYuKc0cYLWh
         nnD7u7xZIIDqIGcbIz9HR6mNKzqpVQzkjgBKoN4jq9Ix6kc9fVfhp59r0JgyjEHLkOrt
         /BiC+mjYE5qL0NH8DZYe88KiRiOBzglBgxGS/zdUQtuckYhWBSwYI1S0yhBWPI6YEBNm
         PyzqVNmnmOjEFEfh8gu0H7crhO1NUjfu7lxh8BZvc1Gca+cis6F7lyODrglxDcb6p+sL
         5oWA==
X-Gm-Message-State: AOAM532kPm37wBp5nYWEPneeDGjXGkvYjCuOeqrC/fNXxC6yEZxCtk1M
        AYOkZ/mWicaVINYURFYd0X5vmMqZtIqOgVfKRqE=
X-Google-Smtp-Source: ABdhPJygraTF13+5Ta4kUTyDW17cbvSWjq1QANG+bwG/TFPN2n5D+bBOLN/c2NiwEQZDBBVWZEW6PykAfRfEd/XmMcc=
X-Received: by 2002:a05:6402:354c:: with SMTP id f12mr2590207edd.256.1638826287556;
 Mon, 06 Dec 2021 13:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20211206100200.31914-1-xianwei.zhao@amlogic.com>
In-Reply-To: <20211206100200.31914-1-xianwei.zhao@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Dec 2021 22:31:16 +0100
Message-ID: <CAFBinCDbWtFuWP9h8sYR4LabFwkT9moKBvxX-uOTWN21uuC1gQ@mail.gmail.com>
Subject: Re: [PATCH] serial: meson: make the current driver compatible with S4
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 6, 2021 at 11:02 AM xianwei.zhao <xianwei.zhao@amlogic.com> wrote:
>
> Because S4 UART use a different clock source, the baud rate calculation need to be updated.
> Reset the UART during initialization to clear previous status.
Could you please explain why it is needed (is the divide-by-three
divider broken, does this patch decrease clock jitter, ...)?
Think of it like this: if I add another Amlogic board.dts tomorrow,
then how do I know when the "xtal_tick_en" property needs to be set?

I found that the public datasheet for the A311D SoC already mentions
AML_UART_BAUD_XTAL_TICK and AML_UART_BAUD_XTAL_DIV2 but so far UART is
working fine on that SoC even without this patch.

[...]
> +       val = readl_relaxed(port->membase + AML_UART_REG5);
The old logic worked like this:
- calculate the new register values
- write "val" to the register

The new logic uses many extra steps:
- read the existing register value
- mask off some bits in the "val" variable
- update some bits in the "val" variable based on the calculations below
- write "val" to the register

Is there any reason why we need to change this logic to set AML_UART_REG5?


Best regards,
Martin
