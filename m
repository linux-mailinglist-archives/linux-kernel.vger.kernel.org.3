Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D84047CF97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbhLVJyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhLVJyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:54:53 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:54:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id f186so5039152ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CWBvAwfqDYL5LTJRobpShVxnlEz39kj9AjzUTYziGMk=;
        b=c/JA3ksY9FZ1CvwEGKK5xrJouuPyZ4+2DTQcnZ5ieeO5hXJ0URkARJHEvXlLD1BJ+G
         kJ6bCI2ye23d8Hj2Jubjn7ZShv+F9ZzWabXx0GnspNQs33vUSVTr5lb7EnVu312J8k13
         YZGMTA9+chAbhnKvrM3V3qAA3Xer6C3xnIBY55E1See6DbyrbMsjMY7F7gew5HSBA1CK
         sbKZcyBCG+NMzsi29oxNadbBpLstHg1TlQxYUGFVchfhk/WZQ6lgI/tDj1bvq05zRFmg
         Pcn8tWP7QEIGjN3wj79Rrn5Yf4bVSik0gpSyKkNnaiIWsLrqrJ/U2DFKsGZA4LFOYTjg
         VdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CWBvAwfqDYL5LTJRobpShVxnlEz39kj9AjzUTYziGMk=;
        b=kSyLKfCu33BqS5wC94bSeg4htCX8+bm+Ri2bLZfTethiDQLCMnto88YBFW5jnQ7nG/
         Nyl68EKuOxA6Qce8it8Cx5f2JLm8VdJkNmFNvxHIHMRbFFHyND2hNaVcUUn2mpAL/u56
         pIHtVdcmrfH4EnoBMFzlnWYUbb7k/5F3PPvXMKxPNd6c5u2ETjyaHSgWuJGvwA/fDYkK
         A3QUoSQB8uvjw37HSF/emfFbUJZ1KIouBvfr/SALWxwPYpHJeUcL60uc3rhXl4oA/YLm
         ptVgEfkFb4EPWkhm6i/gU02Sju/duOJGYns2NgaIH4qaG1DKMMdDePI1Y02cWOcumqXw
         gTNw==
X-Gm-Message-State: AOAM532BivqVO6lReifAjMDgTigIpSZHg5SKYaTmEy5FdJhGK2AQhcnx
        PzrNNSpGTsvcIp0hvsLKsKlrPzCOqcHo58ldz3w=
X-Google-Smtp-Source: ABdhPJxbX4Nlmn1Ka4s30MrIcI2+BmQE+eAGYEuJfHMOmRhX3UA7dGYEPcm/C5yvU02o1zp2tKtWZUE0NnHF2kuDFXs=
X-Received: by 2002:a25:3b04:: with SMTP id i4mr3029321yba.767.1640166892081;
 Wed, 22 Dec 2021 01:54:52 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Dec 2021 10:54:41 +0100
Message-ID: <CAKXUXMym0M1UNuNGUVpFr2yUwOwjkZ_sQpCD0jC8YB+hs=j-bA@mail.gmail.com>
Subject: Addition of config USB_HSIC_USB3613 soon?
To:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Vaibhav, dear Johan, dear Alex, dear Greg,

I have seen that the greybus arche driver has been under heavy
development in 2016 and 2017 with some further clean-up in 2019.

However, so far, the config GREYBUS_ARCHE for this driver still
depends on the out-of-tree config USB_HSIC_USB3613, with a proper
exception made for compile testing (with COMPILE_TEST).

Will this USB_HSIC_USB3613 config and driver still be added in the
mainline kernel in the near future, so that the config dependencies
are consistent in mainline?

Or, are the further out-of-tree additions still maintained for the
current kernel and will stay out of tree? Is this arche driver not
needed anymore and can be dropped?

Best regards,

Lukas
