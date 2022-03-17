Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C774DCE04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiCQSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbiCQSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:53:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B842221BBF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:51:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bx5so5640051pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vw3XaM6v46z2MuOTuiLDtIikE5mFUpXQTggdnZPb20Q=;
        b=YNQzE2c4U8b/woj51/ICQ9KfXeN9biR00rtSvs3CeHEc5pKderDQ+lRx0Pc4Se4eDG
         MdjX1//yOBAcpbxT94It7UqzBzhtdndBEZgvISaNEyw9iG83yAlLsuMJpWjh9ZIGm/ef
         CX5do56FUQ7IEDTgEUxBzfZpjMXbWfJKlzuNcD27yRmMdX9iE7m1OFlKyC7b8cGWb6tF
         ENwQ1kHdJyUTwjFXpQzJt5KM/MBHKbjjXVlh7Neopn2YpSGU+1zqyBmhnZeKFwwdzL6B
         dbRSftw+MU//29I2CZWQdUiZpuuql6sVSA/pGsUpnRyaIJnFBoSGfQOotN7gJo19/xuv
         Rkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vw3XaM6v46z2MuOTuiLDtIikE5mFUpXQTggdnZPb20Q=;
        b=jHQsJugpVlev8MOMnUYxxRdObYg7l+U2lAmuCaDHbLCKwPZIADAgv9c+O7wKNywfBQ
         WVDtHqJX/EQWmYpZXuBjWh3wHnz0fj70mWIxIro9XWTYvjd/w3EqrRp7igPwkpT4Stz2
         53eMEGL2I7RUhkQsgBYt1l2XAGjGgzwWo8ayyafbr1sLDQTd+AB/cIJCR2hfPaNIQfB5
         h6+NkSbYbW832wJ0cnFB9SiQkyvB+FiEPoUodWBj7rui0BeEd2XCspvdCekWUj/T4qAR
         3es2w/ITeIfHFDDEno6tmGq2w7gBUnK1nfs7f5C1AUJ4ZABrXOY8Qbr48QUiePxB/6nk
         +l5g==
X-Gm-Message-State: AOAM5309xmdDXMlfo4zSM0rB9QPpx/KFymYCLGf64+fknuWq3a6s7XG0
        p9A4FXpPPT3wf79uBszyH/MNyvopMPK+DRwlmijA
X-Google-Smtp-Source: ABdhPJwqBUNPutkqf0ZNA9iXOQ6U8fxduS3yLPrsiTJ0HTunQXu2ts8GnvQ/f5rybTBoEVsneLLdoiD3ctaUsdhl4S4=
X-Received: by 2002:a17:902:ec89:b0:153:f480:5089 with SMTP id
 x9-20020a170902ec8900b00153f4805089mr3655434plg.166.1647543116685; Thu, 17
 Mar 2022 11:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213109.2352015-1-morbo@google.com> <AM9PR04MB8397B7734E38A4E60C6965DB96129@AM9PR04MB8397.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8397B7734E38A4E60C6965DB96129@AM9PR04MB8397.eurprd04.prod.outlook.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 17 Mar 2022 11:51:45 -0700
Message-ID: <CAGG=3QXGZKy2HCs=khGbmWC5MWs47S654p1b7SCD+sRqMv2DPQ@mail.gmail.com>
Subject: Re: [PATCH] enetc: use correct format characters
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 10:37 AM Claudiu Manoil <claudiu.manoil@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Bill Wendling <morbo@google.com>
> > Sent: Wednesday, March 16, 2022 11:31 PM
> [...]
> > Subject: [PATCH] enetc: use correct format characters
> >
> > When compiling with -Wformat, clang emits the following warning:
> >
> > drivers/net/ethernet/freescale/enetc/enetc_mdio.c:151:22: warning:
> > format specifies type 'unsigned char' but the argument has type 'int'
> > [-Wformat]
> >                         phy_id, dev_addr, regnum);
> >                                           ^~~~~~
> > ./include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
> >                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
> >                                                     ~~~     ^~~~~~~~~~~
> > ./include/linux/dev_printk.h:129:34: note: expanded from macro
> > 'dev_printk'
> >                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
> >                                         ~~~    ^~~~~~~~~~~
> >
> > The types of these arguments are unconditionally defined, so this patch
> > updates the format character to the correct ones for ints and unsigned ints.
> >
> > Link: ClangBuiltLinux/linux#378
> > Signed-off-by: Bill Wendling <morbo@google.com>
>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Fixes: ebfcb23d62ab ("enetc: Add ENETC PF level external MDIO support")
>
Thanks Claudiu.

Could you change the Link about to this one? It's a valid URL.

Link: https://github.com/ClangBuiltLinux/linux/issues/378

> Can be also net-next material. It's up to you. Thx.
