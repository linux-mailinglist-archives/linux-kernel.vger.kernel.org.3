Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611E04A3173
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 19:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353051AbiA2Syl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 13:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbiA2Syj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 13:54:39 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED5DC061714;
        Sat, 29 Jan 2022 10:54:39 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ah7so28057210ejc.4;
        Sat, 29 Jan 2022 10:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dIx/IqWiv/WWm7kyGBaD8OgAX89Qcfb4TRiFj5tbEo=;
        b=l1c+s/Ubw5dRxJadxh3PcbeOrd3x3kbo6i8JmXjzEQMZaSTO16HQdx3I0vUreojh8A
         5mIJ83BN5mNHZAgJg+INAsnQri3TGqmnQ0DBWeF1SpYfsvnH4MqLrQk5/AyrAHTAxEVo
         ZsArQrsEzOnLjRNP/UzelTlsxsZWzzCYjTeWwZZc+jSiBfdUzN5Kc0aoyB/jnJQ2JckI
         wJ3hKoBwta9a3ZHAD4DzsnZ3CGlwDYxl5cXszd76KYXPfWPsVZNfFaB1RS/A2W8ynhAk
         +/wPxXFt2IDRRhN1vsBtwXc8p8CP8DtCqFK/5wfdMjxXhZKhrfCXrx5hOY5wKo7TAFa2
         uB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dIx/IqWiv/WWm7kyGBaD8OgAX89Qcfb4TRiFj5tbEo=;
        b=3gKakXVq22vLZPK6vd5SEQ4gS9CXy/jwJ8Y4NYIBb6PMb9Q52j2EDQDBaaFcnlXTZ7
         3iepxDtdls2CYtp4HBuUG7rQl8roYa0Xx7DvhHjnLOqYgfYvgBU9laQt6DNq70j4K8+O
         0Nl6Orzgv1Foz7OZUXF4jvajqknyzEzUtSA0LA7LntaJ1MbyqDv0BZyAPKfTFBtc1mKM
         Od1DheUEJe+STEY7YA+SFl8bY/0CV2/HaJ8XsASZ/xOYRO/Ks9hEJZQTLOFDwoPlUApc
         lV4e+Urhrl1TQpDddS6+rCvw58+sg0XZ8JCO24eEa/lB8uBhtqUosBNpRLSWQtPazpSs
         gJMg==
X-Gm-Message-State: AOAM533xLL+L2j3z3xfKQ+dUT5oIb3++ZT27117tmIbyzNsHSZOsJx99
        /iYHmNQnAuBzOxlah88kDyMqlmrSH5bmxMszTWjlDt+bRb8=
X-Google-Smtp-Source: ABdhPJwUYgNNHPJYIUcBsTAd++MKr5tL+VooDz4sr2nMIPD4IgrE8R7vylTrJQW1Y+cutuXpRXb6G/sD0JTzSWu4TTs=
X-Received: by 2002:a17:906:eb8a:: with SMTP id mh10mr8511020ejb.492.1643482477674;
 Sat, 29 Jan 2022 10:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20220128170722.1624767-1-usama.anjum@collabora.com>
In-Reply-To: <20220128170722.1624767-1-usama.anjum@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 29 Jan 2022 15:54:26 -0300
Message-ID: <CAOMZO5CSE8bwASsk8_Z3J_i1rSKoiENx96_bLaYxQnvghgWtyw@mail.gmail.com>
Subject: Re: [PATCH V2] media: imx: imx8mq-mipi_csi2: Remove unneeded code
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:MEDIA DRIVERS FOR FREESCALE IMX" 
        <linux-media@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:07 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> ret is constant in imx8mq_mipi_csi_pm_suspend(). This function cannot
> return error. Remove the return variable. Simplify other functions which
> are using this function.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in V2:
> Removed fixes tag

Reviewed-by: Fabio Estevam <festevam@gmail.com>
