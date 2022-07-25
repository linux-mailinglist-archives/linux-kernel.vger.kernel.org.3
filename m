Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC9457FDE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiGYKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGYKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:54:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0E165BD;
        Mon, 25 Jul 2022 03:54:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p1so1547304plr.11;
        Mon, 25 Jul 2022 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iipJ7AtIgRfXNW1pKHlBsLbJHCUCYgAJVbkYPy8n2kU=;
        b=ZBqlJKSW6i86H67dVjYG2TclaSUj/VNIl93+bdU47SyxHuB+GttE4Cuu4vxqX8i4+G
         uG1QqTB9hfxHWk/FeaDUUyJTeVs0ND1Y5XKQmhpPvy2HL+uT8EpEGCLo1HZ+ibMqzSXw
         DP7rA5hGcOvNIH3NutnfYdLsDRoud1Xra8IU+BQrsoPBUf3hnZdHXRKLIjl/NyrEX6go
         x4krgLisN7rq+W3nKMDMFtA/y7wewaPD0EhLDOxZFdWrsSV41mFTS1HDTV+dr8KlKMgZ
         YeY4+ILMG5FbA/G4MT93LZHDojs9E8hIannh7QnIsWbKKgsdd3hWKrRYm+H3ZSOufAiN
         SPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iipJ7AtIgRfXNW1pKHlBsLbJHCUCYgAJVbkYPy8n2kU=;
        b=h2WP4BYpkL4y4OBh6tHZ2GTkOfECdoBiEh5VdzjetrSikA2Ry0qszROVt2n0uKfAXO
         pWaJymOgfQXC0/sqJfx7vxG5eB0GaoASG2ojD4X/QTRUNO/v5UI+D9izc2aOjrJKnfEy
         2tqD9z2GaODeB5AZYGQlWohjuqRT94Adc3CdzX3Qv770B/FyIfkORi0tSmdk8mWd4dsE
         C+KW5FTX8Ukac5XSih5dnELsrSHaFrpYn11AzZSn56E2jiHDrGRUXrWpk19oOxhAkN+9
         8k/SiUavEdAN5HYDFyvm07bSKb3RDDPlYiEnciDQVuRUitBJhfD7GSg10pDP5K2JvbDv
         sFmw==
X-Gm-Message-State: AJIora9tKE0VQRbaz+tYyVBY2PuYR/VZNHYxDNaBACLI5ERc+GzfaY7B
        uwRGEgkmaz2jQ1rd+gFf+N5p1BZ7iO9ahXX6paTWjQvjz30=
X-Google-Smtp-Source: AGRyM1uiP0ZgXXE7LSej1LGevAoaip96QQb7xT2652xsiBzPu/UtgQnKdGYDIO1HEpbKMuRaaofyiPx5H3C89o0C0EE=
X-Received: by 2002:a17:90b:4c8d:b0:1f2:c360:5e6b with SMTP id
 my13-20020a17090b4c8d00b001f2c3605e6bmr2993181pjb.195.1658746480165; Mon, 25
 Jul 2022 03:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220602080344.208702-1-martin@kaiser.cx> <20220724174737.212028-1-martin@kaiser.cx>
 <20220724174737.212028-3-martin@kaiser.cx>
In-Reply-To: <20220724174737.212028-3-martin@kaiser.cx>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 25 Jul 2022 07:54:28 -0300
Message-ID: <CAOMZO5BTFC8srxEM3=jWv6pQr+2oB+a3T-qCnByhdQ-xbZJS6Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] clk: imx25: make __mx25_clocks_init return void
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

On Sun, Jul 24, 2022 at 2:48 PM Martin Kaiser <martin@kaiser.cx> wrote:
>
> The __mx25_clocks_init function always returns 0 and its only
> caller does not check the return value. Let's remove it.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
