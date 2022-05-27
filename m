Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146AC535F06
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiE0LLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiE0LLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:11:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FF57B0E;
        Fri, 27 May 2022 04:11:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n22so2028549eda.5;
        Fri, 27 May 2022 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpVKmAi8bEeOfj3xBmp1aXhzykGLkSm5+Fx4/RF94XA=;
        b=MsTF2+wpGe2/Z2GUFWPgUYQBuZpCLhPs/DVRZXjO+HwXN2OxjQOWoheVPU29S08Gu/
         Lx0QOxySDuAIvBG0vZDROkRmm5fU8msxSvs4XJavbZXewHJlZGWKU4TCgf/lPM5oIT6Q
         JCDhBPp4kmMuDJwDDSo3W1TvMPE/wb6IuKyZjK81dWBAvCuVC2Pd4ale/kkPXTOEJbyB
         h1bwCR5SDawyKyB7EEOc7yeKK+AL2OKqi2ZqOWPFuzvsy09xh2WhUJAbb9jwycg5/5Nh
         G5Dhk3r8uB/DF4Lure9KMR15DDHtS0drIcdx8mr5bngR6seITavjIZEiCTJ4uvBhyBBZ
         bDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpVKmAi8bEeOfj3xBmp1aXhzykGLkSm5+Fx4/RF94XA=;
        b=yQPvj8eukqwYzxVGKOJMrWbWZQYMQidAn1UcCEfEOUroRIVeGpGeCkDhhtgHi2LFHu
         ue1IWvveQrK6u6RvpAn4F/6DlNADdQc9h5QN8chFyKTYXgUsCsnBktlhwyzTW+DndkZw
         HzUoL61pkLumulMiYf7YF05Gs2nmx/LIbZyXE83Jk2cbbOe9bdhHBNjiSYJx+MhDb37E
         ryHW88JtLbmSHoClUjVYggx0nJIjjPsqO6yOBDxAbjcRs1I0Bb7iCCnUrRJ3L7wiuJMB
         lNhwEFqBRBjcsFWdaGpiir/gX1zwZqDt12J4tmbHXgRMaPMwpRHNaObcVgs5VMXa22PQ
         zdfQ==
X-Gm-Message-State: AOAM532GJ1vQQDTLZ5poxbd+QYPXPQLVqyGb0YGMPo0gQDpRbJvWlx0i
        4m9RZJCJCFjwk2/2+ACaAnkPW/5UPPW0agF0Kw9fxgSmK+U=
X-Google-Smtp-Source: ABdhPJwnFKu820uKBff/F+9PPU4iOhiABQu3/JulSUIQ5AUryPZvVp78fQ+eZGOWegYaNmZIdeHkMKHAi89AC1DMpuI=
X-Received: by 2002:aa7:d056:0:b0:42b:e355:6038 with SMTP id
 n22-20020aa7d056000000b0042be3556038mr4914454edo.315.1653649905539; Fri, 27
 May 2022 04:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220527102444.19683-1-ming.qian@nxp.com>
In-Reply-To: <20220527102444.19683-1-ming.qian@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 27 May 2022 08:11:37 -0300
Message-ID: <CAOMZO5D-gUdoTx3hLmZE2EeYfun-g2xLx6J4tNTSZd-yKCLgXA@mail.gmail.com>
Subject: Re: [PATCH v2] media: imx-jpeg: Leave a blank space before the
 configuration data
To:     Ming Qian <ming.qian@nxp.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        mirela.rabulea@oss.nxp.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
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

Hi Ming,

On Fri, May 27, 2022 at 7:25 AM Ming Qian <ming.qian@nxp.com> wrote:
>
> There is a hardware bug that it will load
> the first 128 bytes of configuration data twice,
> it will led to some configure error.
> so shift the configuration data 128 bytes,
> and make the first 128 bytes all zero,
> then hardware will load the 128 zero twice,
> and ignore them as garbage.
> then the configuration data can be loaded correctly
>
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
> Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Fixes tag?
