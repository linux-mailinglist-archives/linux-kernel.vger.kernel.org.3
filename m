Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82294830DB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiACMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiACMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:06:12 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F67C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 04:06:12 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id i9so46430778oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 04:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMtHzyhEWbqbm19bVoiJeE6YWmveNNAe5Zu3E0UI3Oc=;
        b=uzTrsZk/Rmjx4CCFEqq2hfEJjdD2M2PyV2u8dBo/tqhMOUK8y334ojBAN9M4XYew6A
         as5dUkU4jhbxm4reTdOgCk6X2kPvp49Vu648qKO3NxL7xhXT0H/8iu8DFzPH0KPmz798
         AbkjwYRJweLAljUKAVCAZaM0DrMg0PmkKtw1YYmwejal16FiuDQSE0v3kmOhM3XbVKAW
         cBD6DdaWGkx7EPXnM+CUR6rneEJI0q1umXTc0oyGz9BwEmvhVZDcONI/f3Y2Fi4a5vkn
         GJPM5aGsDvcvvpdKWy18YJXweyCsMaNPE54RwFvcSO/ctiAjSYAjn9XpZgjpUTZJrK5C
         5kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMtHzyhEWbqbm19bVoiJeE6YWmveNNAe5Zu3E0UI3Oc=;
        b=OZoAb6j/2UsADCUvSXVUV17fX2+61bzhm1DewkQuTBkUqc9xvOIvJAfCnpRGR4bspE
         kCq2/f/vBKNO0qdxps30J8kdd1ZD8wsbczbdkEoDtXqA3KVmGEEl9FRu2X6solG2Rmi5
         XTHk9Rt2APnBi4uF/I1BF7Z9O31T84yyYWLEC/eOVMJ+XU80bt958Cz/pTPY1b7rejEd
         I41XMf03K5QtIyvKDH+MylRvy9ja6unWcfNmmgKhWOkO2+5s0pxJqgIQgwlSwNTGP/GH
         o/sRLGy+5rb5u8xor7IGjv6MnLntap2ARIVnqZVHpGFWvwl9kb0uaqIfTyhNEIknhHw7
         uQDA==
X-Gm-Message-State: AOAM532gTVYE5JEDEeS7qBFguDyhpdqHz1z6YYY5leMCGRUjVytIQc32
        WkH1nfnTkMpk7VRR5GmltGzbBBhBcseO9QWGXjdZ6g==
X-Google-Smtp-Source: ABdhPJxMNNhtiBRZB7BYPRF5RRlNnz8lpBlpxtTV6Loaqhq3INx3P1wTddJQAxYXRUYIn5lE174L8pzu0iHYTyzNchY=
X-Received: by 2002:a54:4613:: with SMTP id p19mr34543676oip.162.1641211571365;
 Mon, 03 Jan 2022 04:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20211229184854.3466-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211229184854.3466-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Jan 2022 13:05:59 +0100
Message-ID: <CACRpkdZCnbBvzo6KkAQa3T793OVt680DLGrKx6b1OrmeCvKneg@mail.gmail.com>
Subject: Re: [PATCH] arm: pxa: remove dead and obsolete IrDA initialization
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 7:51 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit d64c2a76123f ("staging: irda: remove the irda network stack and
> drivers") removes the Intel PXA2xx Internal FICP driver, and the config
> PXA_FICP and the config IRDA.
>
> Further, this removes any proper effect from the setup functions in the
> file ./include/linux/platform_data/irda-pxaficp.h. So, delete all users
> in arch/arm/mach-pxa/ and this header file.
>
> Clean up radically various left-over of IRDA in the ./arch/arm/mach-pxa.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I see there is some noise from the kernel test robot about some missed
lines of code, but with this fixed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

IIUC the future for IrDA is in BPF for the people who want it, so if someone
wants this they need to go and fix it that way.

Yours,
Linus Walleij
