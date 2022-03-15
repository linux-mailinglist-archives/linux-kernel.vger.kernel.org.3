Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797CD4D90C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiCOAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiCOAEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:04:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D81AF21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:03:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l2so34098616ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaFiWYFimi6t+iDaRbg5VVUqLWbBbcAAPN8RwZuBxaA=;
        b=Evf9i8Vavlbp/u63YDa0b6dZ80bygUabrLqlyN40q1MZ27k5qrx/u4OW/4tuhC8OMF
         +Bye2Mp1QIvPSqzamY+t3RQchPD2MLYoUdTSDyMuNbof9w5LnR/WIqrhoZv0PcZw7JDn
         ewg7P3pD6vnbLmBfI3E8uBBcXZPtS86aOy9/aSN5TGuA8odGcTZ5tRVLS7oyOI9Gqxrb
         dTHG7G3Hm0LzHx+2/Ki0WSQCHGYlfXa69jJ7wtRAuqRAWuc5QsRn5eOJmmUchv3T1jmh
         CFHY/AJbnb+eHiv+rFZG6Po9pmOcDfOa0U2TnOp56tYIZCLcL1S7LQdVbRwWBzlkTgdB
         f4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaFiWYFimi6t+iDaRbg5VVUqLWbBbcAAPN8RwZuBxaA=;
        b=rP36k6juxzDauyyyw7DrGLzjNm485Q7uJHY2+hGwsnZ36UCzekRuJOnPv1Na4iAzHn
         j2ekv94CzhS2KajB2PaS+bvwf4r9bsCjOTmEn30ZGd5lBsuRK3hY7fjR1L/5i4Gt9ouA
         UUsTxXzc8d1ITvGrfiRsn1/7GeKWJ/rar//nfHlS5SpMRstEwyY/UXLYB1rNkJinb8K7
         NbpwItWBvKl9P0Yjj3dTLpDeqBK6OHJ449ZXjfkYD5g3psXnwxSZf6ZNuueJePScHhp7
         wqjpsjIAcFVscyhv8wB9h1wyEmYb/M2CModfAWpwXqT2Bqb++HvZd1IjH55kA7LFRdR8
         cbng==
X-Gm-Message-State: AOAM533SWkVxP5tipQ122zPix9Eo4no8fR1xVz+roH43pfkSYakeeB0p
        8AyRuPmzOop5H+oksVU3MZTWE3OrNofm2ts8Zv5xrwUuHLQ=
X-Google-Smtp-Source: ABdhPJxyj894QQIw5lT5V5GCdo2yicrQwpuE4rn1dkU8fipKlETir9Y/deoFS0Uih9bzTNQN2ZF+WA9I0zSMZIVhy2U=
X-Received: by 2002:a25:2308:0:b0:628:9a66:7327 with SMTP id
 j8-20020a252308000000b006289a667327mr20187412ybj.626.1647302611182; Mon, 14
 Mar 2022 17:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220228010103.2725893-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220228010103.2725893-1-peng.fan@oss.nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:03:20 +0100
Message-ID: <CACRpkdZ-6pj2fRBm8XOG78z2PcP_3fDPXk6xmr4LTrPEKsJS0A@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: pinctrl: imx93: Add pinctrl binding
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, robh+dt@kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 1:59 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Add pinctrl binding doc for i.MX93
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Patch applied.

Yours,
Linus Walleij
