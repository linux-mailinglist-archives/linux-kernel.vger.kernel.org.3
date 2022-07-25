Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFE57FDE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiGYKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGYKyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:54:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07A165BD;
        Mon, 25 Jul 2022 03:54:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so12335828pjj.5;
        Mon, 25 Jul 2022 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krgkw1I7zAd+huSeZmLpqFdl30Kwxr2g1Y18wftGeFg=;
        b=eWZ2WQqtPqIuzdmclnhYugt1a7e5z27AH5KKapYBpcLrNMZJS5biCqmdyASKrok2+a
         Gl/Evdxr8XmfMeZws1rUkbwAGagrvsxqzpip9LxTzgz2DhlmUk1e5zWrg4JUK5NPUWKA
         BiQn3lZ1El37vYxQLiTMY2rk/gYKie7riAhWjmGN2zj8DXLa2mayGPYuCbGHFz/4GpqF
         slRmJqgtU+aUyOn3IUDZ6ymwpp2LIPZuv+93EfTGSn05O2oqraatGY4HMxpo24Aaqr4q
         e6ACX1c5aQDbEBNDaOboN2yCmyZfp999V4E1yPNZgjBfMZSF9gNA0UYk4qehW2/TG6bt
         uNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krgkw1I7zAd+huSeZmLpqFdl30Kwxr2g1Y18wftGeFg=;
        b=fO0xJfXabq3qgwyyrQKAPCHgET6Efd/QwPclAVz93c9UxWLiUa+SzzZI1pFjr2OMhV
         lIUVIgvquL3UQyaohfiiSvem08fL2Ivqp7i0bxe60txGoy+uF6sA4NoCm6D2Bez6IAYN
         9UHs+iOz4a2fdUTtf00GPNEYXTs5rGZd+YuuxpFYqQgd5n0B7VlQlqwr/mUEuq7FbXoA
         YZppT0D9TXCHnUbV8w1sH5Uph5snSzwgRxC3KG1B/GghGIHLTjtjD4UDE5h5dgr+BaXN
         cCdojIOhD0CtIRSU42mgWs80hfxgqBeYzDXhGywtFQtKV4jMu9taMa2LKTddDEJSiZiA
         /yAg==
X-Gm-Message-State: AJIora+eYdCFr8F2jMgI6YMuakNlRsd818KpBPIiLrj0yqy6wclxlT6o
        +cvVu6vqmi655aWj/YXpe+7QQobWr7RKfeS02d4=
X-Google-Smtp-Source: AGRyM1uhkSpIkdoQcbxMktVHZecGFWJ/I9n0a87I7zviaMzl382Zn/3XBaeGsZeNhmcljYCbUHPKhbw69xC6W9IWpbQ=
X-Received: by 2002:a17:903:1208:b0:16b:81f6:e992 with SMTP id
 l8-20020a170903120800b0016b81f6e992mr12086691plh.55.1658746442637; Mon, 25
 Jul 2022 03:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220602080344.208702-1-martin@kaiser.cx> <20220724174737.212028-1-martin@kaiser.cx>
 <20220724174737.212028-2-martin@kaiser.cx>
In-Reply-To: <20220724174737.212028-2-martin@kaiser.cx>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Jul 2022 07:53:50 -0300
Message-ID: <CAOMZO5D=DEi=B0ZXBSkrWwUPhDLmHX7ptaCo5FbUsFVB3hoWug@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] clk: imx25: print silicon revision during init
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Sun, Jul 24, 2022 at 2:48 PM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Print the imx25 silicon revision when the clocks are initialised.
>
> Use the same mechanism as for imx27, i.e. call mx25_revision.
> This function is unused at the moment.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
