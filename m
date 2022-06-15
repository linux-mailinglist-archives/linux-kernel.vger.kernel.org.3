Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72D154D356
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348862AbiFOVIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348521AbiFOVI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:08:28 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93935A98
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:08:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e24so12319488pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aNGpEfRhlo4h8RO+zOBXvmjCTnGFl0J69C1xqFUH1TE=;
        b=KLKROuJJT5Wkl1qGn7IZPtIv6SQ0xvc1cwU8hHT3b5pIEqG+pcYiuIHh2KaKr4ji3+
         A9MtBveIg40nczwOcZaRi4yfY47kvS7afLsfN8GcB1JPoQqD+OJq8FvLs5ghG2i51TyJ
         W1eedT62FH9GxQtGoIzRxo+PIHp8lLiCx6JAvPRErXgn+Dv7Vr4Ea+ep4JA1d3DveBb/
         BAlyQgDmMzNaIEQ/n4xQM31svawdyrkkMY1OImWHAzPqbx0FN2eEGZQODoyqjHc8rH8C
         qJNFoagXh0VwkWgWpZ5C7orpTCfmpmhqjbYEthqlFw/CZzWOiTtUPbDHnMai/H+uhCRm
         9M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aNGpEfRhlo4h8RO+zOBXvmjCTnGFl0J69C1xqFUH1TE=;
        b=U2UO5pk/7PApkSPiXrvJds0qYunahM+G3S5FLI2J2lMd1mynPmSECllxSkPaJPTy3x
         I9tKuPaucnTGB4s2ztEXYS90Y0rM148gsOXctoK8OydK8LE+aIzv7fOydbXyK43xVB/t
         9V8pXlmHqf2Lxpl/MJ2nohlom1jre0afCqPmvIxFrKS/yW21sQEMMiIgnoqRrd3Q01uy
         i07H6KeHzeBzIuj2Xda6MHPNoeT3eX6TheoNMdxgPF1F3geJeZzfoEeH5etcU3L44Ah4
         6MmbADUXC04+1tjTcskdz0VYGheFSV8xGvCeDr0v4krKRF1n95KeDga6hN6oGQABggP0
         W6FQ==
X-Gm-Message-State: AJIora8ArA/jumPoHpZ007KPDgGZsjh/OY1Ql4hnDDyMTAHmfDnsi6Jn
        kBoAmQyRHJGWHvjq+VAIJW9KhA==
X-Google-Smtp-Source: AGRyM1s6hw6kjYJrreZr7AQcdN6no62kRQQdLjeoRaB610eXRgPm3G4l+haYAkkqq3LknCevCg3JPA==
X-Received: by 2002:a17:902:6946:b0:167:8ff3:1608 with SMTP id k6-20020a170902694600b001678ff31608mr1609426plt.116.1655327307445;
        Wed, 15 Jun 2022 14:08:27 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0015e8d4eb1f9sm81521pln.67.2022.06.15.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:08:26 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:08:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] mfd: tc6393xb: Make disable callback return void
Message-ID: <YqpKSULrQTcNtaZe@google.com>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
 <20220530192430.2108217-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220530192430.2108217-5-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022, Uwe Kleine-König wrote:

> All implementations return 0, so simplify accordingly.
> 
> This is a preparation for making platform remove callbacks return void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-pxa/eseries.c  | 3 +--
>  arch/arm/mach-pxa/tosa.c     | 4 +---

Needs an Arm Ack.

>  drivers/mfd/tc6393xb.c       | 5 ++---
>  include/linux/mfd/tc6393xb.h | 2 +-
>  4 files changed, 5 insertions(+), 9 deletions(-)

Doesn't apply.  Please rebase and resubmit.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
