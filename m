Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A7575237
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiGNPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGNPx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:53:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991932BBA;
        Thu, 14 Jul 2022 08:53:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j12so778862plj.8;
        Thu, 14 Jul 2022 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSV9uu+AuHbrVWmSxWJ5hlL7FSlm4yniGon0X3L1vGw=;
        b=mSOGAe0IKtLgYDltoZ2uj03mfF1ldaSBFDrVOojxM/0dInRStf82hVP8tc6hwPRUP/
         JjGSfnACwsaSYaKJkon+JuELynFqR7GTekeURDDy4J/bQfTOi1mwG3OonHHvv0iVYWbE
         NMU5eaCu86gstGoHoj2/7ps0eF17oGpRcyFP/0Vz3+ulQvaTy235HrBBQl3hucqtIFnB
         QKKeMKhZwv/2hqTwFkYVio0Jv+/U1SwxBloqiSiGzU/zyFJqToSFLVmzvBVjhw/plBLa
         yVXBHBmWIOQPowaH0vSyMdp21SqKIYsMys54UW9Y29XZBZFaZEeL0rVXWXcMnky2dTZQ
         W8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSV9uu+AuHbrVWmSxWJ5hlL7FSlm4yniGon0X3L1vGw=;
        b=ysy/KxrbZdXglaUrJyq0RSJZiUvA54xwoqW65iJUd4Dw8aJDKY0V7cdgnG8qVar+Br
         PT45Bh68y9XHK5nphqmte7soBNHhf6XbBb4FTXNI79cMCZ4eOFf30JrxCOtaDt2USZt8
         iMB1wIZrehf2u1kFMktHKgA+lNTrvka8SjdVcuiHPjW86wTf0FYfrsHiWaTZuohhllyQ
         1V25nzDxau5gaNy0nktvggI+eG+UuVhptBsPTpQndCUWhfQwCauSGRapaYwe4wFg3RBn
         ua9DVtJK7WQRUrlOKBQP/79QT2EyIDjiH68BST5AtrRFZc0e1cpahTDX7CrXmoCVOw/f
         0mfA==
X-Gm-Message-State: AJIora/weDxbNlIeuWUp/Dsg8VL7Xhk2aK7ATUYsfjJx1XNsIGMyBALy
        nlrijKhn0ng7uQhFcQi9q0l1J9DsRQKO0HQIcbQ=
X-Google-Smtp-Source: AGRyM1uObPdXPPCi/cljNCfrUnmG0La5SB8Ejt58qBm3+R9+LoCHi+EPoyalgF9uM7Lg98OYdmVCyTRBCYh7IwVOSNg=
X-Received: by 2002:a17:90b:2243:b0:1f0:b0a:e40c with SMTP id
 hk3-20020a17090b224300b001f00b0ae40cmr17249622pjb.76.1657814002376; Thu, 14
 Jul 2022 08:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220713074118.14733-1-frieder@fris.de> <20220713074118.14733-2-frieder@fris.de>
In-Reply-To: <20220713074118.14733-2-frieder@fris.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 14 Jul 2022 12:53:10 -0300
Message-ID: <CAOMZO5DCpxiYNXPOg+Cmc+6gBxZBp0oQ=wtGf14r8Y+_k1S2Sw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: dts: imx8mm-kontron: Adjust board and SoM
 model strings
To:     Frieder Schrempf <frieder@fris.de>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi Frieder,

On Wed, Jul 13, 2022 at 4:41 AM Frieder Schrempf <frieder@fris.de> wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The official naming includes "SL" (SoM-Line) or "BL" (Board-Line).
> The legacy identifiers are kept in brackets and are still used in
> file names and compatible strings.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

The series looks good, but I cannot find patch 6/6 in my Inbox, nor in:
https://lore.kernel.org/linux-arm-kernel/20220713074118.14733-1-frieder@fris.de/
