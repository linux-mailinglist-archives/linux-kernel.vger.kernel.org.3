Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC1463D98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbhK3SWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239483AbhK3SWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:22:01 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:18:42 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d10so22395167ybn.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9WZWLQ5yd9LIzBFcTCR7vKBVPOF3Yt1Fc56G0DPXmQw=;
        b=PYkNtWIp1sAeNNFlnSrPkXcq4yxkDp3mbkTKw954PBBCXd3rOP7ziMX7q2wC67KfMe
         GbNIVL1VP3H/J/24v3ZIFpZVV51ovrZL81zUoR0ytSP3jBt/I2cPbq6H72xonuZFoA3g
         V/GCye/7i6YTkrytUDsJkx322QQyNEFOe77icENLVra4njphi+H6YUbH2gB4Div6nTor
         aqKIQF1fwK9EasVC6rIM3iXRLid5vMzPSNwz5kkJPX2C1TrjbxMS7QTdrG97Bevsyb/P
         VfJRcdZY6qsKM5GjwBUA4ev7Nth5wmeaznzlEv773RbTKp1h54tCUKGjzP31pEWEbDn0
         2lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9WZWLQ5yd9LIzBFcTCR7vKBVPOF3Yt1Fc56G0DPXmQw=;
        b=WTBPK8ksP8oEPMfgVApGMCdHXKf3fm3Ie6n+N3CAIG97ra4GPOnzRW5F8+aeekY6MK
         TW2lmkWlGAI5yqmeJiF+egqkpd4QsJT07FWr578RDf2rmY7Fwx4OjMCGT+qqjt4xfEP7
         SoSEWhJhraXe1+vA0Uqm5agKrPCBzByNXztqvvytzj3f+KuYfIUf+oLEhQb9Zoqfn9/H
         EEscXfKGOphkKsmjHC+xRFIbBL+AKV41FZc5p3ZBlhPpOitT5klFL68S2I7WP18PxcAO
         33eRo532/xpi+gVrrZ9OBsfk+Nn+lm5R9LL2/hYOhPCWxp3V44rOl41WZ2PE6TjDZVwb
         Q7gg==
X-Gm-Message-State: AOAM533seZn2ajXPywmf3dDcv1ZOdD4WkkN7+xVQCHUCrIsF7FlMO8i6
        2Ortk/JQ7Fp/e3AK4Zc/g2ZMgWeXdAo3cqPW9Xn5Tw==
X-Google-Smtp-Source: ABdhPJy1FEqk3LNiGyBHz98wCUjyot2vh/FkdcuV7zC7nspa5wW5MTM6Zmn4WrxNaQYLP+SPJaQ3PVg72K81lAaiKT8=
X-Received: by 2002:a25:e64a:: with SMTP id d71mr878581ybh.226.1638296320946;
 Tue, 30 Nov 2021 10:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20211130175740.2216591-1-aaelhaj@google.com>
In-Reply-To: <20211130175740.2216591-1-aaelhaj@google.com>
From:   Ali El-Haj-Mahmoud <aaelhaj@google.com>
Date:   Tue, 30 Nov 2021 13:18:14 -0500
Message-ID: <CAFPZpNbjnv3x1+kZnmvV+-MD0vp=fDNk37h7HM0p0GrC7iTEQg@mail.gmail.com>
Subject: Re: [PATCH] S8036 DTS changes:
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore. Sent patch from incorrect workspace.

On Tue, Nov 30, 2021 at 12:58 PM Ali El-Haj-Mahmoud <aaelhaj@google.com> wrote:
>
> - Allow VUART and SuperIO to coexist.
> - Minor formatting.
> ---
>  .../linux-aspeed/aspeed-bmc-tyan-s8036.dts    | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts b/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
> index 30b68ce89..7f650f6c8 100644
> --- a/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
> +++ b/meta-tyan/meta-s8036/recipes-kernel/linux/linux-aspeed/aspeed-bmc-tyan-s8036.dts
> @@ -127,10 +127,23 @@
>         status = "okay";
>  };
>
> +&uart_routing {
> +       status = "okay";
> +};
> +
>  &vuart {
>         status = "okay";
> -       aspeed,lpc-io-reg = <0x3f8>;
> -       aspeed,lpc-interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> +
> +       /* We enable the VUART here, but leave it in a state that does
> +        * not interfere with the SuperIO. The goal is to have both the
> +        * VUART and the SuperIO available and decide at runtime whether
> +        * the VUART should actually be used. For that reason, configure
> +        * an "invalid" IO address and an IRQ that is not used by the
> +        * BMC.
> +        */
> +
> +       aspeed,lpc-io-reg = <0xffff>;
> +       aspeed,lpc-interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
>  };
>
>  &lpc_ctrl {
> @@ -340,7 +353,7 @@
>
>  &kcs1 {
>         status = "okay";
> -   aspeed,lpc-io-reg = <0xca8>;
> +       aspeed,lpc-io-reg = <0xca8>;
>  };
>
>  &kcs3 {
> @@ -385,7 +398,7 @@
>         /*A6*/          "",
>         /*A7*/          "",
>         /*B0-B7*/       "","","","","","","","",
> -   /*C0-C7*/   "","","","","","","","",
> +       /*C0-C7*/       "","","","","","","","",
>         /*D0*/          "",
>         /*D1*/          "",
>         /*D2*/          "power-chassis-good", /* in: PWR_GOOD_LED -- Check if this is Z3?*/
> @@ -447,6 +460,6 @@
>         /*AA5*/         "",
>         /*AA6*/         "",
>         /*AA7*/         "BMC_ASSERT_BMC_READY",
> -   /*AB0*/     "BMC_SPD_SEL",
> +       /*AB0*/     "BMC_SPD_SEL",
>         /*AB1-AB7*/     "","","","","","","";
>  };
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
