Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7E5283E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbiEPMLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbiEPMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:11:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855CA2648;
        Mon, 16 May 2022 05:11:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so28266966ejk.5;
        Mon, 16 May 2022 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOy5qVB2LDTD7mjYjb2E2LueU2K1wUDWp9QvfCkRMko=;
        b=lfxgqYptFo0Wq5qNEDBJ/wJLL8dK6iRUmTgTQG3cDPaIm1TS7apfA/Eg3qsDKKSNYC
         abAuRMMzSzL7Del4+j4jit2F2zNVA4MJIMN3FoLaB/auAsUxE2OmCX513pnayXCGW5jI
         Xrx7guWVXxWYW7pT2UV+rakUsQDhBQfJQ/Uoo0zOGFLntnGOBWTBu+elNO4soB4apQKi
         BSxopJNkwH6lHOjIroxkm1OSUbOg7j9Ly8umrKVWhUkxZ9Pa4JoT/bKb2+VrcToRzv1C
         l6w8ZkncHUyNyOlWycSLVRUftMN8NBgPQlmjxoeM4EI8eMH6aHzA7HlrqqYlf4o1US6G
         8Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOy5qVB2LDTD7mjYjb2E2LueU2K1wUDWp9QvfCkRMko=;
        b=nlbnXcgMBP4hKLKMntaAxS11Oh+Ryw364t9jqbS31W6PVQ9x4omlD88sEs6UD6O6qi
         p2kaCuseFapiayrBl/iwWpKVhU2vS71UFRdsVy97NTfuVNf58Zu0uiUyfczvec7+zC9M
         IvUb6fb/3mMgVnNsyjQvRR37CBm4aE9lJhGJrP8XhoKo9BxEIWeyn7joHomXUVc3RTG9
         SZVnl+RC6iOWPhtj/WwbUoEv5W6Y0E2KSHpP6fWXHEXQOzJozEXOeKluXMkcimAEiR/C
         D78/U3bAC4yJ8hbcgs9AMXzu8JrTxvsh/umYGlIeonUMMUWePI1DLn/HjorxRMGj91+L
         LpmA==
X-Gm-Message-State: AOAM530+BLpWlzDQfFsPL1Skj89s0WEB5sePWHm24O01CKvDoocrHsTY
        Baia9B3NPtM9wtrZrhkAa5ekB7N5epwCV+0gItg=
X-Google-Smtp-Source: ABdhPJwwJfzlwd9o1tDZ3FvTZAkJVVI4291fRZAaz5t3NSDAisicH+V3My+P1ClfVDX6sUrkZvGkRe4wR/OdIkzsWRw=
X-Received: by 2002:a17:907:3e25:b0:6fe:526a:a663 with SMTP id
 hp37-20020a1709073e2500b006fe526aa663mr1229952ejc.626.1652703059149; Mon, 16
 May 2022 05:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220516115846.58328-1-max.oss.09@gmail.com> <20220516115846.58328-13-max.oss.09@gmail.com>
In-Reply-To: <20220516115846.58328-13-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 16 May 2022 09:10:49 -0300
Message-ID: <CAOMZO5DzVFRW=HF-oO96THqDqmHsJywityDKFF7YNZTtCdjAuw@mail.gmail.com>
Subject: Re: [PATCH v1 12/17] ARM: dts: imx6q-apalis: Add adv7280 video input
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Max,

On Mon, May 16, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:

> +       adv_7280: adv7280@21 {
> +               compatible = "adi,adv7280";
> +               reg = <0x21>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ipu1_csi0>;

I suggest passing "adv,force-bt656-4" property as this fixes sync problems.
