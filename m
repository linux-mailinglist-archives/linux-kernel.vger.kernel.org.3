Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B5D591512
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiHLRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLRvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:51:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C759A13E3E;
        Fri, 12 Aug 2022 10:51:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id d71so1352405pgc.13;
        Fri, 12 Aug 2022 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WEA1888h/ieE6nd2BvRR3fpE0byse4GYM5OvrhENBE8=;
        b=AeSOESN/lsu2livNGNA7NmhRkMbK1jf7WbrwuEVUCejJPUgUIrVkALzejlIoS6Lhyt
         LS6eZh3lfhTEZeTykAW4//AIAzPMu3VL/XHzhORLjn3QBuYJaHSBUlNCdXfGmpg0JFfZ
         4WJocsDHN0hLFC9mVe608HvPbvmeY4246dv/D9hkyGcPCC9OCptCCSDYRm4qgxdHWmu9
         2myBxJwliCqNxh8f45yojKVYDIgturnSMjaabjZRXY7PJWjDAo7XghfkvIr+7PIsVWcS
         pVEw9VcgDgqLeNQDiZDdLh437jRJx7sQy6nlq4F56k/Ib3RW6bSpbKlaAcAHSXRtR2TJ
         cmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WEA1888h/ieE6nd2BvRR3fpE0byse4GYM5OvrhENBE8=;
        b=WZ+1eW5ll4aOpbrjX6rUXQOXZL3vDhtQagBpHLoGLRqBs2fFM9LDzSmv3OiKey6nYn
         kSOOiOW6yqh6c/RTDaMYaWt/lbUS3WRQOYc7xnecLLqVwxdNaFg2Hk6uA9r4iQ7p4+mW
         pfqFTWdMthNSu8itxCMRQKLuYLfAkjDhK1hzysMArN858kzh9xFLo8KBvFODlbnHRJDk
         IWUdO89HxYunKnVI/BwFhr3Eud4qgMMcVWpAjYv5nBTL1VyKWq3unEaGdMP/481nydd3
         G2hqysJ0OSwkE0N7ZfX/++lwZTJKtnLRwNJVMbQgdz3VDBPTxrqqyRQ83Ijj5SY783Be
         UcrA==
X-Gm-Message-State: ACgBeo3wm+dTPUyARJ3kCP0CLJjwb9n8B/M5ElJhCEgnYRCKMJ3VIwWw
        DUSIptSSHxwPTDPKcBRGJ7PeepA3n77YUFLCZtg=
X-Google-Smtp-Source: AA6agR7fzE/CUjrjosOy4+T368TDzbIKTblKgh7L8JKBXHauNiGkd0RElkY1B8JPoyTc8MdRefJQ6FdnCwzhUFrVB5w=
X-Received: by 2002:a63:ea11:0:b0:41d:9296:21e6 with SMTP id
 c17-20020a63ea11000000b0041d929621e6mr3850122pgi.603.1660326665318; Fri, 12
 Aug 2022 10:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220812173526.15537-1-tharvey@gateworks.com>
In-Reply-To: <20220812173526.15537-1-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 12 Aug 2022 14:50:51 -0300
Message-ID: <CAOMZO5B5OMFMjXuM6Lk7iy_f3GnvWC-O_0uEds3jD-5oTtjMZA@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: imx8mp-venice-gw74xx: fix CAN STBY polarity
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi Tim,

On Fri, Aug 12, 2022 at 2:35 PM Tim Harvey <tharvey@gateworks.com> wrote:

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> index 521215520a0f..de17021df53f 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> @@ -123,8 +123,8 @@ reg_can2_stby: regulator-can2-stby {
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_reg_can>;
>                 regulator-name = "can2_stby";
> -               gpio = <&gpio3 19 GPIO_ACTIVE_HIGH>;
> -               enable-active-high;
> +               gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
> +               enable-active-low;

This 'enable-active-low' property does not exist. Just remove it.
