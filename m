Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072B553B382
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiFBGY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiFBGYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:24:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630833D1FC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:24:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y19so7991443ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5D0vl5etA8w4JFTs0vHtApM3qn6L1pxjO0+FVACzdE=;
        b=g75QB1/l+H5UTXr61eehn8rEV+hbX/rxxop73yItMFVgKP6VDZeDQx5T5s4aUnBw9x
         dfGvoJcF4A7RljamyLVb+RAj3d+nLo0Wcz7QLWAxuftjwXIhm4kMIDlFoy/2EOlVGQOL
         vNZhJUEK3rcYm89WnkibFT/AbCp7482KmBIX4sxENAhz8tqUF67XyV8cAheEdZpFIKaV
         huQjyRI9o/kud8XEJKAUavgRDcPQG+4LZu+7lJSCKuDdGcSljHhMqZ1maw7qF78XxL+w
         b3qlDbYPWbJwTmFePNE/6sowjb2lZCg3fVvM3vj6e1REkDdRIKPTFZyBEcRv8X/H2Ztf
         F7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5D0vl5etA8w4JFTs0vHtApM3qn6L1pxjO0+FVACzdE=;
        b=HAXgWtyxAp+CCtXnub68pL1w77ZqaqRyxQc4LVtJ3BjItV3v5bqlHJPkTkfX7bSJ4o
         hmy3vcpiaVDN+UwBbzVzbarLBorahr+VyY5h2ezX5xk8HV6qvexPJkD+pfCzc0AKraJ+
         gxkdRnCpSj1PRN6meVftydU+QZstZaZ0D6RSZMnQvFYk6uiXyuFIfg9gs+wJ0MWmj0/u
         X9oILHRGXi0Nhc3k5TwW4HbbGT1uuYt6VxQCaPrz7UqEJYBgoW1HmKhmn2b6CQbyrrb9
         Il2VqvA05qxs6LPNEvUSiAWLfR5qQwpwhK2iKH8HeY10pO9mV8bPzJOMHFvVS2GuhOR0
         T6IQ==
X-Gm-Message-State: AOAM531SpciK6A/Zohz/3NMpKzIDKhvFFzok2fzgxiyWsRVWMVnIj3Bs
        0emGsP4Ggx6PCigO02zIT9OBha4rt6FXRVMiaIw=
X-Google-Smtp-Source: ABdhPJzryWNXbIM+B3SICmMolS4CCFEktZVkTRjDsh9+ftc0bT9pt18UrkeaKEhT+8k1Fa/Mtba9tEAp+PTdgD1u1AE=
X-Received: by 2002:a17:907:d8d:b0:706:61bc:5d2f with SMTP id
 go13-20020a1709070d8d00b0070661bc5d2fmr2804836ejc.727.1654151059892; Wed, 01
 Jun 2022 23:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220510023255.1283529-1-starzhangzsd@gmail.com>
In-Reply-To: <20220510023255.1283529-1-starzhangzsd@gmail.com>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Thu, 2 Jun 2022 14:23:43 +0800
Message-ID: <CANubcdVNEsJvGz+gpJjvF14_D_+K9Xv5UtQJdf9s1o07ghFY1A@mail.gmail.com>
Subject: Re: [PATCH v3] pcmcia: add MIPS_DB1XXX dependence
To:     linux@dominikbrodowski.net, Jonathan.Cameron@huawei.com,
        broonie@kernel.org, arnd@arndb.de, lukas.bulwahn@gmail.com,
        daniel@zonque.org
Cc:     zhangshida <zhangshida@kylinos.cn>, linux-kernel@vger.kernel.org,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

Stephen Zhang <starzhangzsd@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8810=
=E6=97=A5=E5=91=A8=E4=BA=8C 10:33=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Shida Zhang <zhangshida@kylinos.cn>
>
> drivers/pcmcia/db1xxx_ss.c uses the bcsr_xxxx() from
> arch/mips/alchemy/devboards/bcsr.c, which causes a link
> error:
>
> drivers/pcmcia/db1xxx_ss.c:(.text+0x2b4): undefined reference to `bcsr_re=
ad'
> mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x2fc): undefined=
 reference to `bcsr_read'
> drivers/pcmcia/db1xxx_ss.c:(.text+0x374): undefined reference to `bcsr_re=
ad'
> mips-linux-gnu-ld: ../drivers/pcmcia/db1xxx_ss.c:(.text+0x380): undefined=
 reference to `bcsr_read'
> drivers/pcmcia/db1xxx_ss.c:(.text+0x534): undefined reference to `bcsr_re=
ad'
> drivers/pcmcia/db1xxx_ss.c:(.text+0xcc8): undefined reference to `bcsr_mo=
d'
>
>
> So add MIPS_DB1XXX dependence.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Changes from v1:
> - Rewrite the commit message.
> Changes from v2:
> - Give credit to k2ci for reporting the issue.
> ---
>  drivers/pcmcia/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index 2ce261cfff8e..04b51cb67fbf 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -151,7 +151,7 @@ config TCIC
>
>  config PCMCIA_ALCHEMY_DEVBOARD
>         tristate "Alchemy Db/Pb1xxx PCMCIA socket services"
> -       depends on MIPS_ALCHEMY && PCMCIA
> +       depends on MIPS_ALCHEMY && MIPS_DB1XXX && PCMCIA
>         help
>           Enable this driver of you want PCMCIA support on your Alchemy
>           Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300
> --
> 2.30.2
>
