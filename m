Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2F4C0F82
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiBWJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbiBWJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:48:20 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971085965
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:47:53 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id k9so5315329vki.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qMECgKMnAeJCt5deSyf/RWgwDprSNTJG/bLQ+2c8x/s=;
        b=W16BFV+yPoxC7oosWCJnGIE6zE2NhbQ5rH8ubdnBX1QYMr3AabCQkm5TNU58ACZzru
         1DJg81cLRBwuVi8Zo+jQ+ZjgvnnM55mIcNuiiSKqFKPmuugYU6uQvh1InJkSfuEChAco
         h8ITvXMpluM2nydVBUXuUkyQFbJPUyrTPc/fIbt8XRxwEnmnqUsIFSvBLO0ww3mPOVde
         DwnZ1bBTJ0hp3cHAqetZUTAIIAEyfQd5u9TRo6mkiOgjg8CVSG8wcJdAq79GcnyvIXLM
         rPkh9zMIVG5CakL0MWWEnWOYW+npsFm4SIIFNsAbLQcwGb3nAYJHxdgJJH3Dxt8wGh3A
         jD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qMECgKMnAeJCt5deSyf/RWgwDprSNTJG/bLQ+2c8x/s=;
        b=536vOu3F0BOwLHYemQsTrRinQWpxlwTdhFJWBkFCgVjpvg5H3pxpWvajKLPBzvNb1L
         ZK3SrCIGEnP+M6HJXRjeYKrxjLFmY39h0dxcgo+fLsJw0X2PCJtQiFjYQoM8N2yovRt2
         QXP8yO9uXKymNGRGPcBRnbBH5lIENQSU6C+YIZk7RaOB7rnK08G0a10osACnGElzTjZe
         jdc5nCGtvrhgg+qq1uX9DY2c5YU9kZEEGNzON0n6TGfMp/SQJdyD6TXTDAmNQNegJRnY
         xCqlG5qIweLnA2Dw4k+yGUagHtA115PsK+YqB/cx1QL/cUzWxHMh33HILixQ9uIT2FlI
         tKaw==
X-Gm-Message-State: AOAM533KJoiVDy24w/XMhaEYxJtRh72VUm/GadEUz7hCdMp2SQK5Hpiz
        tONYf/G3NzP6EMZTmPsJEFGuxu2AmUBVNh3fNPM=
X-Google-Smtp-Source: ABdhPJxY3c10KObUfirZ0ArvlzSlRI9T5EqzLO2vj/PVnlD+24tG0PNw6xlCNqxvvBtxH0pI3R+ZGGeE6bqD7ORTGnw=
X-Received: by 2002:a05:6122:788:b0:331:2063:3645 with SMTP id
 k8-20020a056122078800b0033120633645mr12421979vkr.10.1645609672679; Wed, 23
 Feb 2022 01:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20220223064807.261878-1-daniel@0x0f.com>
In-Reply-To: <20220223064807.261878-1-daniel@0x0f.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Wed, 23 Feb 2022 10:47:42 +0100
Message-ID: <CABgxDo+uF9pQ=sy7FEJ4WiYNpS3St9u3xDMt8MZNZXQF4kXSMg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mstar: Select ARM_ERRATA_814220
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer. 23 f=C3=A9vr. 2022 =C3=A0 07:48, Daniel Palmer <daniel@0x0f.com> a =
=C3=A9crit :
>
> All of the SoCs that are supported so far are Cortex A7 r0p5.
> So it seems like this errata is present.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Romain Perier <romain.perier@gmail.com>

Regards,
Romain
