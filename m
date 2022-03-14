Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B04F4D80AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiCNLai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiCNLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:30:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE98419BE;
        Mon, 14 Mar 2022 04:29:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qx21so33070034ejb.13;
        Mon, 14 Mar 2022 04:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhZboEGor3WhFks+q9rVZMWPKTrT8VjxffJKlKlNrSA=;
        b=iNgVU/ifAE2qoVnxLr9n5bHDcy4P/Loj04+tqgvQiJFxivo+XarOr1mIffGbXBaY2v
         h1WwpoPs3indrp0qdY0hMz1Qf/Qw6+dY/BC5er4AO5AYDbnHQTpBLzYc8mY95RfEmNBB
         Qw2IBBLrvz+7M3kFvBgF5lion5Bc+/MeNMdqeo2FcmOtTHSQCzfm7hVefzXbI4cb0o6r
         D8BaeF3bd4vhzE8fbsg7ZbYBLOIUxRhGOl5/XRayhq/Dkm1GtR6N4Oy0Hs9WQW2WkW7t
         ur1weVOn56BMjaNTSF5DyHXilWXeLXzQED20SzOp8SLLdo7UsAYyg9mGphjj2lcHhPJw
         Vq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhZboEGor3WhFks+q9rVZMWPKTrT8VjxffJKlKlNrSA=;
        b=15tExI828aOAbkfNtCG/4Oq0H2fc1gjnziKcx0/w5tz7pmQWAiJzmFTYkl2dEkRHLb
         cB+gUznPxT2Slg41OAdzZKyswfrwH2RChTOxT1ELQU3hvk/bIrcBERi4KGfkqWPLfGo4
         CoxCCq3PzBv3aGAqj5kPs2r78J1iWYZFYEm/rF19n21JdErZD/76h+DElAfBS3nDFcpq
         EXlx8YNv1qLbwFtcP20CeLXdGH/a3HcXzuQAtcu7vN2/xwvveXa0HAni4WOy7WBUDi2h
         yC6x8SsejndG2ol8wDkmGEfudEZ7/+K2l/hu/TNzLIqr3H5Sddacc/GJlJXKrszbc7AE
         jQmA==
X-Gm-Message-State: AOAM531r7LBAxCX+Ut5GkObkqb64mvuPo+xFjpdxsF5P+s7nYQbL8sdE
        gpmiLlrUIx8az47VdalTgKtydUY/9Q4knVHQeDs=
X-Google-Smtp-Source: ABdhPJy/8E2CPk5uCPa2ap1Qu1pp9p5kr/egPjM2OQIBP4g8LprXYfCdHo8LJILvqqeid1Jnms4ry3yVqpZTZ49Yviw=
X-Received: by 2002:a17:906:3a4f:b0:6cf:86e0:586c with SMTP id
 a15-20020a1709063a4f00b006cf86e0586cmr18315950ejf.626.1647257364864; Mon, 14
 Mar 2022 04:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647242578.git.mchehab@kernel.org> <bb359b4709ceb1112813965237d153cd366cae2d.1647242579.git.mchehab@kernel.org>
In-Reply-To: <bb359b4709ceb1112813965237d153cd366cae2d.1647242579.git.mchehab@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 14 Mar 2022 08:29:14 -0300
Message-ID: <CAOMZO5CHPYR+sdSS1ay_Zr1qL0XCGCJ2kqMxK3JxDuxDtjFCtA@mail.gmail.com>
Subject: Re: [PATCH 49/64] media: platform: rename amphion/ to nxp/amphion/
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
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

Hi Mauro,

On Mon, Mar 14, 2022 at 4:56 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> As the end goal is to have platform drivers split by vendor,
> rename amphion/ to nxp/amphion/.

Amphion is the vendor itself, so the current naming scheme is correct.
