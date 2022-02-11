Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732F84B1F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347675AbiBKHTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:19:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiBKHTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:19:36 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE410A4;
        Thu, 10 Feb 2022 23:19:35 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fy20so20745549ejc.0;
        Thu, 10 Feb 2022 23:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eyr+k5MIXDuO745m6jwHbykSM9pTm41Qg3KUng2I5bA=;
        b=G64W731dlvyWLNkI7Hd4YwwJv6RNWFQXlxlBKNz1K7j46nVxu3h92y7bXJBvZ0aeNL
         9YR/0rWt8HJ2hTy6eb2xFiW+dV/CDnuYkEVDD7pRYxnZKGk0ZCgkwSfB6z6G4ulFC6GN
         eqQIjAASDWshS4cRIQZSZh6Fx+uGvc8WA1mgNiynj9jf6xfPmuTx3Dk+X0ZSHCsN2nHY
         M7y3igGjZQ1QzuiGoQg4+ZiNvuAidJ58eqtKAcfEwjDzlUTbMpbBLffkiPkIyUwmNBrQ
         lX2rm2nTFoMtZ1IutWKvpAPwW1RC1l/9Wl2Isde1Xvd6lFyUypLF7urSprFThc57kvRB
         nGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eyr+k5MIXDuO745m6jwHbykSM9pTm41Qg3KUng2I5bA=;
        b=Xlmn22SxOEgBO36YiBPgQxU/Uh0M7gbMNh7R4S7uXqweJ1eJbbbrF4dEH6ZZbd5n6Z
         PPGuBAsS3sILDnvG5AH6KQPn84knDkK1nIiz2gsY1C5cwPvlG6rLsnuNxNV+L9wCnKOi
         RPoj9omYJ3Pz5U3BDEDnkxdqOaVk7eAjoqMxxcYqkjEdYBem8EPF2V+GUNpy+Y/mYGxT
         owu8GSCSAe+nnIzRJDHGIDQHZU3mEmM0I4lO+ko1JUrvPngw8FvTLR6IcDZ9nyH2KJ5W
         xSp1yC1T+5MqN6uaVNfemEcjxq8aT57mMjCuDIwXUDoVtBieyKE2wAFAQZytf4uuvNak
         s7bw==
X-Gm-Message-State: AOAM530ip5j3YhggYg9i9QZpVAzDwpvy6WNYB8+iMi5ieXj8eLsTi/96
        r1I3yY1Nro0dp9bAixq9cZeEQ3Vai6Nl1XgKV1E=
X-Google-Smtp-Source: ABdhPJytMGOwVYbNRUat6pl2WpmZXfQRsKhLuWHbdL37IA1eTf3GybFocliDjiRWE5Y0jjF2JjV7RhOpA8yeSWRSqK4=
X-Received: by 2002:a17:906:5d0a:: with SMTP id g10mr252126ejt.595.1644563974461;
 Thu, 10 Feb 2022 23:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20220210172246.27871-1-hnagalla@ti.com>
In-Reply-To: <20220210172246.27871-1-hnagalla@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 11 Feb 2022 08:19:23 +0100
Message-ID: <CAH9NwWes070Z+VmpfvkUfx+vGn_41H_Ps2960uaktJkyXPrWuQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am64: Add ESM0 to device memory map
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>
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

Hi

Am Do., 10. Feb. 2022 um 18:30 Uhr schrieb Hari Nagalla <hnagalla@ti.com>:
>
> AM64x SoCs have two ESM modules, with one in MAIN voltage domain and the
> other in MCU voltage domain. The error output from Main ESM module can
> be routed to the MCU ESM module. The error output of MCU ESM can be
> configured to reset the device. The MCU ESM configuration address space
> is already opened and this patch opens the MAIN ESM configuration
> address space.
>
> For ESM details please refer technical reference manual at
> https://www.ti.com/lit/pdf/spruim2
>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> index 120974726be8..0622a93ec136 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
> @@ -66,6 +66,7 @@
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges = <0x00 0x000f4000 0x00 0x000f4000 0x00 0x000002d0>, /* PINCTRL */
> +                        <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
>                          <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
>                          <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
>                          <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
> --
> 2.17.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
