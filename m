Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA956C478
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbiGHTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiGHTsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:48:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1329C1128;
        Fri,  8 Jul 2022 12:48:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so2941975pjo.3;
        Fri, 08 Jul 2022 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBeV/OEgLqBxkQbXvrr4ONvUzsJQ4WYLxaMOQiThl/s=;
        b=jDqt9G4/34S4KPrCz3lhJU4XGUo6/qs8bw63wesqlk5h2wEvQwvZdwTglnG6zSnTew
         5bPqCrADnep4xYq/9lSC9SCuT9T7hxAVT0apy7LEpQelXl6CC5+Oac+IN1Xt/k3V6CHJ
         hCR664kwCscXuzRYC2mZkIaD49bG5BOb9wJ0KKdMGpPHfSF5GBQWbkNEJelol04oCNS4
         ZbRvOXtjumR5y62qHIM5KGycBjw2A7BNSizwDmu9ccdlLawGTSFYVydfeoBTPjDPD1rK
         H6mouPl5aAxiWDgm+xlv9tHIY+jcG0bCBnXBetOAAksF1E2ChGnZOA0pMh3KidM6HZM1
         NPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBeV/OEgLqBxkQbXvrr4ONvUzsJQ4WYLxaMOQiThl/s=;
        b=zPIcdIYkBoowH2qgJw15HS5VpjNUGNaDKZQpJpmGrmtTvszinaP6dcs+heARYPNPhd
         eVe8tp+fDt50/OmgOwS8Js7vUK1ugK/E5XNAF1qEjvhcDix2cm/wcBVowR4YGIG2t8pf
         GGw18O/lTuErmnN54rCwqcOgITVm6vwWDnqQmfTGueYt9drb3VHSa/1oYN/9KTLIF96F
         n4CXhIMY8snJWWxWrJogdbwQXEya9hE9TrpeQeEbNyGlQXHTcvDJWWW0y+3eVjVWnUF9
         OnS5nQuow1AW8/Uq+379S0xszdS8uu2NUZwiwakZ+I7iTM8HBRAmJ1XVSFTLhrZ3i8ye
         vkgw==
X-Gm-Message-State: AJIora8f8JDCwFbiV3rFsW4kdjI7xCFibxMrgBuIUngv8MLOSfUrydW1
        ye5jiOaVcri1189tL869re22TepxRM0tMP3SXRpXMy4IzYc=
X-Google-Smtp-Source: AGRyM1vB/zeygFk5gaI/7h0y3iXb7EBHt12/zeW7dw9ssHDe4uPTSxddLEAjVzBkeY039sMTxaXRdPsAeMCc0rppxb8=
X-Received: by 2002:a17:90b:4c8c:b0:1ef:9d26:3087 with SMTP id
 my12-20020a17090b4c8c00b001ef9d263087mr1621043pjb.195.1657309709593; Fri, 08
 Jul 2022 12:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220708100952.1998673-1-ping.bai@nxp.com>
In-Reply-To: <20220708100952.1998673-1-ping.bai@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Jul 2022 16:48:18 -0300
Message-ID: <CAOMZO5BVrcodf+1wvdifsUWy_j4Md4Lz1kBhrvCJa_4JPtqAzQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update freescale pin controllers maintainer
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
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

Hi Jacky,

On Fri, Jul 8, 2022 at 7:08 AM Jacky Bai <ping.bai@nxp.com> wrote:
>
> Add myself as co-maintainer of freescale pin controllers driver.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

Thanks for offering help here:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
