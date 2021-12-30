Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2E4820A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242272AbhL3Wez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhL3Wey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:34:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3769C061574;
        Thu, 30 Dec 2021 14:34:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j21so102825632edt.9;
        Thu, 30 Dec 2021 14:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keDpfpmYkXFiVgktyndmnfL9DTHJGo7630SMho0JAeE=;
        b=ai6bQPVEAVEI84Hr676QSSliE+FR4kHYNtcIKRXGqvO0ZFSSntFZrdJGBovV7M2b8d
         p2CRo0K5/4qPORmzar5tSkOD19nOcQHG8T01qunC12cBe/fjgsvFXdSdtU5B4jfmuyLq
         AVLIM5tab73qpz3JSJ5WbJ7S9wE6eu00OJbybBCG2A72CwOsGoiiec3uorb7kiOsOmkw
         t4FsZpo32HpTTzn9N2DIE0LDn9l1TQA5nY3LlixgsZWZLfEsjZ6u7M/F0zA9p7cbT/Qo
         dfZbj3t6uqZLqrHVWO/TfQkS6xiRBdNO0eVecXvuVQ7oRFohDMw9alrxsjyQunudjRw1
         Nzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keDpfpmYkXFiVgktyndmnfL9DTHJGo7630SMho0JAeE=;
        b=y5lm3OX8zROthuYyBgeyWIwwRxfdhnQq64dASrSmkld7QWsFrzQnY82XWCFwYlx9ej
         kaad+f+JBOpMWxJRchTwv2KWq/vUt9WraoABYX4qN5GBrnlJ1OATs5HQs8ukbl0krT2C
         p71m6ZOScKVJFw2wGWGBdY/qPTDcV/spdpts9CerqyzlNzMllhcCMItI41xnYpOBch33
         eMbIq4pOGrCNhHvSQCDuAK2LIbH0m8zhnsbvGO1rsD+KC0RzpfTKMEbCBsB3ZOnxHcQ0
         qRvs1SXZdsQWzC3/0W1YA9AYFYu+mYhO0csalN8MlQJ3KSBDTd6BuwbiYaD1zK6uaDx4
         2ubA==
X-Gm-Message-State: AOAM532Qe1ZMhI/9IOO2rR+MncJVtU4r6pmAI6GBKnfm0/E59w2GDUgX
        tCn404kHBXOrWpL1CiNNHEWNjgC8C2NYirdclh0=
X-Google-Smtp-Source: ABdhPJy06stqBtrzO3pPH2Sb6S4wUoQroR8A11+Jus2e4clCR7PxO5IkHtNeOhstYloGzN2BG15vOFzp8x/xl7qa0w4=
X-Received: by 2002:a17:907:75dc:: with SMTP id jl28mr26131756ejc.13.1640903692114;
 Thu, 30 Dec 2021 14:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-4-yu.tu@amlogic.com>
In-Reply-To: <20211230102110.3861-4-yu.tu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:34:41 +0100
Message-ID: <CAFBinCB0RTfOLbV3ZC+9dJEiw2_y41V+JvNP9GOPaQcCLB7UdA@mail.gmail.com>
Subject: Re: [PATCH V3 3/6] dt-bindings: serial: meson: Support S4 SoC uart.
 Also Drop compatible = amlogic,meson-gx-uart.
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

as Greg already mentioned the $subject line is very long.

On Thu, Dec 30, 2021 at 11:21 AM Yu Tu <yu.tu@amlogic.com> wrote:
> Deprecated, don't use anymore because compatible = amlogic,meson-gx-uart
> don't differentiate between GXBB and GXL which have different
> revisions of the UART IP. So it's split into GXBB and GXL.
actually it's split into GXBB, GXL and G12A

[...]
> -              - amlogic,meson-gx-uart
> +              - amlogic,meson-gxbb-uart
> +              - amlogic,meson-gxl-uart
> +              - amlogic,meson-g12a-uart
> +              - amlogic,meson-s4-uart
In addition to Greg's comment I suggest splitting this into two patches:
- one where the "amlogic,meson-gx-uart" compatible is marked as
deprecated (Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
has an example for deprecated entries) and GXBB, GXL and G12A
compatible strings are added instead
- another one where the new S4 compatible string is added

The idea here is to have "one logical change per patch".
Deprecating and replacing "amlogic,meson-gx-uart" is one logical change.
Adding a new compatible string is another logical change.
I am hoping that this will also make it easier to find a shorter
$subject line (which according to the patch submission guide [0]
should be 70-75 characters: "the summary must be no more than 70-75
characters")


Best regards,
Martin


[0] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#the-canonical-patch-format
