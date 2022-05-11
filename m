Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221535228F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiEKB2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiEKB2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:28:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A433B18C06D;
        Tue, 10 May 2022 18:27:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id be20so706028edb.12;
        Tue, 10 May 2022 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1NY0AoAg0CnY44TTSpjO00eqVV5HqyRvttB8vt6qWE=;
        b=I6f+4dunzcqeGA+Jv4IWOi7wI3WXl6YqaT6Ty6CHx1tRLF61QtuORfBftRol1RFWVj
         s73SLpsQtvaP728lRAogsyKcC77Ov6/t75Gco0MY/tgRbQoB1k3S/aBqIpuXg1Aw5Tef
         JBfNuoJ7IwiXmRQqXMMRhEjgOBGdrYPjWch86EZyPOlokT0W+pyvtCOMgn2i45dLvMNK
         OMRYBfHf4tLOJmK9ITCGXgW3zQxwySch7+Q7UpCQ+572pASZPuPP6iNiCH2qTt5it+zT
         TwQwH8ImxZ8lx8XYkvSHIZ7n59n8d0hIsvpCBAj8NsuskCLVFJyvdADQwAZCLDSlG7pR
         geGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1NY0AoAg0CnY44TTSpjO00eqVV5HqyRvttB8vt6qWE=;
        b=2i0Ihme6J3v6IY+ZM4HzzvNRZZ+NDxhSoBGFjK2zVG3zm8jvCoHNCWx5m4w8sMQDD4
         bZSNE3CvXAv4ZhOEhNG9NN6ksHovDsOK+Jb0Tt0VtT5tAR6RAKBe83HFatRdCXgVb4bV
         RyLb02S1lrOY9OXXv70nxC6UMzPyYLGaeBsPiO9Hu9SnglIGAESDujaOxdlqw02SGRcm
         4WKh2IsqIg0y4ivJjDI9Aqr//pqKVTAL9IfG8DhcEMqZpHIFYDzCZ1AdnIYsrgXy+AEa
         J/wH2P0DcdWuFtGfdFMB8zK56wASy9g1hfMbT8LjTfJcNBf83vPRT0v+ozUnQ4B16Zcy
         D9Rg==
X-Gm-Message-State: AOAM530BbUeaBQd8g1hnFLJcBsIi4ArK4JuGuSyMTkw2Puv3lAbdYp7k
        OfmgGbwOQd5+hTVwDy6LIfpd4zykv4aEuDyKreM=
X-Google-Smtp-Source: ABdhPJzCr465sXWS4MK5Tsco+o/aksr5kOPAtcdQVK2Q+O2MLJA7U/qy14IXebV/VmwfsSn0a/NEH11kI0O9Z3Bii6s=
X-Received: by 2002:a50:ab57:0:b0:428:9f9b:d8e3 with SMTP id
 t23-20020a50ab57000000b004289f9bd8e3mr13108696edc.305.1652232477211; Tue, 10
 May 2022 18:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220509111126.7032-1-max.oss.09@gmail.com> <20220509111126.7032-2-max.oss.09@gmail.com>
In-Reply-To: <20220509111126.7032-2-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 May 2022 22:27:45 -0300
Message-ID: <CAOMZO5A4LW7-5tFGCKPT8otaUozk-0Op+Rsr81NhaWo6THn+7w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] ARM: dts: imx6qdl-colibri: Fix capacitive touch
 reset polarity
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
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

On Mon, May 9, 2022 at 8:12 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> The commit feedaacdadfc ("Input: atmel_mxt_ts - fix up inverted RESET
> handler") requires the reset GPIO to have GPIO_ACTIVE_LOW.
>
> Fixes: 1524b27c94a6 ("ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi")
>

No need for a blank line between Fixes and Signed-off-by line.

> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
