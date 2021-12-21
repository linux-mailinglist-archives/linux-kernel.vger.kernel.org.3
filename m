Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1014147C0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbhLUNny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:43:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44916 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhLUNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:43:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF662615B2;
        Tue, 21 Dec 2021 13:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F10EC36AE2;
        Tue, 21 Dec 2021 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640094232;
        bh=ehLmWQXyI8uzgpYhZKSqd8ALWcLfPwPXFxgjvq0UdX8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h3ehuZm1uPnmDtm/afvooY6h4aInNCxvMyurJuymnEHc3dAGsGLC3/r+qILJmXDvt
         d2VondbSGDzp7TPC5yxIKe/9M+khhS2mt2pJ7X/FBZCIK5l/7AYA4e0usxK1pibZuF
         7uuapTxgxIlt4SNropZLKT3WEOHZPwr6v8e5Hh8BVx1Ss6J8DLrjPO+dDfFbsm3ITF
         07btAq0/2bNoRqIXK6l7Cn1WSccfvmrTPFN98AgNQNM1aXn3N7AeIHOtDApgx56IBY
         dVLSvMWgLyeCMaxBbb7rd9WlO/F9P/dGSwbn4moWg1TSat46uJMfN5TsdXvnbm9lqN
         wVfwMwFzizo5g==
Received: by mail-ed1-f52.google.com with SMTP id z5so52275961edd.3;
        Tue, 21 Dec 2021 05:43:52 -0800 (PST)
X-Gm-Message-State: AOAM532bmGPYRKQxRa+j2ZMhpytq6Yplk/nZUx6mOIfAYI6CJ2KnIFzP
        6d04/5iGfNBkfiqfek4gMC130Gb7QRpsULRQyw==
X-Google-Smtp-Source: ABdhPJzf6sF2sHY8OvqcAy5pdhOq+pNWj0G56N/8xyadU2QrWNbAtQsnLyAdk734lgyH7OEUuq1QSCjMOJesv6Pcyf4=
X-Received: by 2002:a17:907:94c2:: with SMTP id dn2mr2730772ejc.325.1640094230472;
 Tue, 21 Dec 2021 05:43:50 -0800 (PST)
MIME-Version: 1.0
References: <1640085372-1972-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1640085372-1972-1-git-send-email-abel.vesa@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Dec 2021 09:43:39 -0400
X-Gmail-Original-Message-ID: <CAL_Jsq+XNNVbUiJeqPvDrz_oZoV1PTxRcE9O5ovEAHQZ37cn9g@mail.gmail.com>
Message-ID: <CAL_Jsq+XNNVbUiJeqPvDrz_oZoV1PTxRcE9O5ovEAHQZ37cn9g@mail.gmail.com>
Subject: Re: [RESEND] dt-bindings: serial: fsl-lpuart: Add i.MX8DXL compatible
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 7:16 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Add i.MX8DXL lpuart compatible to the bindings documentation.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>
> This is a resend of the following, but as a separate patch.
>
> https://lore.kernel.org/linux-arm-kernel/YcCisM3BqM984k%2F1@kroah.com/
>
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index 6e04e3848261..1f482e166467 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -30,6 +30,10 @@ properties:
>        - items:
>            - const: fsl,imx8qm-lpuart
>            - const: fsl,imx8qxp-lpuart
> +      - items:
> +          - const: fsl,imx8dxl-lpuart
> +          - const: fsl,imx8qxp-lpuart
> +          - const: fsl,imx7ulp-lpuart

It doesn't really make sense that imx8qm and imx8dxl are backwards
compatible with imx8qxp, but only imx8qm is backwards compatible to
imx7ulp. Ir only makes sense if some feature/quirk specific to
fsl,imx7ulp-lpuart is gone in imx8qm.

Rob
