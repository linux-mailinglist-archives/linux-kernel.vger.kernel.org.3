Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13DC5228F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbiEKB00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiEKB0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:26:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE764D9E4;
        Tue, 10 May 2022 18:26:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z2so1124270ejj.3;
        Tue, 10 May 2022 18:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvfiOTtqCMinHntPJghe2tAinuCO5v0PtBVLPwSQ7Xw=;
        b=IT2YsSa+KlFPxWLz7VYVpluaeuLBPZsvknp7OYOsCNpwO7y03s3I7DTdKHN3FAiQ2Z
         bG0d3yiMua3KShteUyfkcgWogjO54PWDWRmU/NOUzvCviM3QASQel/nUeDiIRe+wV0vf
         jkkkkHn6pdQ8/ELxLmMcnn5PkGTWfHvif2xUcIAsc2H5yD20H8R4oLaKgPmzFzHjibd6
         Q+5bFHzeNUVTBJxjZq9LuzTcF5rjOXHtT+LBgJHXhZ8D9gPgQKDpVhe/XzamM97dI294
         qQ/9PXi2vahzo6x121R3xqgSxImmoyqictKFjqSFsSIc1OVfwz4sVKz/5lYnmZsR9uxG
         lJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvfiOTtqCMinHntPJghe2tAinuCO5v0PtBVLPwSQ7Xw=;
        b=xfKNNfuIvukH/30qtiD0PuZBLjq3WFCDc9KwTGyNNtL2ewTKwXqWz3X30yhil1Hluu
         /DPlLjXjAjcG0A57eMcKw7EvVGGeMI10q5qBnpoMkx0YSzKU4bbnMY8uzIVv2Ek85xhh
         wmycHxsN/CdVQhPQM30RQvXenZ3ts1IBQnJBA4KSXtYp0Ra/EyPn5rs2pgzzDc9LZYRY
         sMB2h8czCKy8XJFguHVrgcUeLtXIg1G5rWCTzBH2ttvuJr8H91VdAnuk+mxC+LkEW/Ac
         QQ0XUYB488mP32WD9HZTdqzVThnTK73lK6GKjcyEkg0mZAdkL7nqHN8S3LcgYPrlgcpH
         zjfg==
X-Gm-Message-State: AOAM533j7Qr2kZ5swaLYjIiY9sq21Xh82EmsM37iXjo0KIuXcZvChoJB
        jGCcMp70y2BrXWGngUT6/a894NTyw3LH9/n/BNo=
X-Google-Smtp-Source: ABdhPJy2UWzt9+ZBfW/ZU9LjONSYUHdkm5v6PfxnlnbjActnnTufr6GAZLz3AITobYht4uWyazqi7RihJuJFOqFEKd0=
X-Received: by 2002:a17:906:1845:b0:6f4:346f:f767 with SMTP id
 w5-20020a170906184500b006f4346ff767mr21292457eje.214.1652232367153; Tue, 10
 May 2022 18:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220509111126.7032-1-max.oss.09@gmail.com> <20220509111126.7032-4-max.oss.09@gmail.com>
In-Reply-To: <20220509111126.7032-4-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 May 2022 22:25:55 -0300
Message-ID: <CAOMZO5B1ESLpmK3fM9CzqYEWz969BajPAEbetofC4rDxg5V+dw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify
 inverted backlight
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
> Set #pwm-cells to the default 3 to gain access to the parameter
> which allows inverting the PWM signal. This is useful to specify
> a backlight which has its highest brightness at 0.
>
> Also adapt the brightness steps as the backlight doesn't light up
> for very low duty cycles.

This should probably be a different patch.
