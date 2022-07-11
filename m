Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6F57068C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiGKPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:03:47 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CDC13F6D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:03:46 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 6so9166544ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YErQAJTNBsroUwBWXYZSk0t8HBKJD/pgmYdR3arRfh0=;
        b=qO08D9a7Ul7Z5pIUVipX8dvxICNRcJuNNXaX1wo2nbgYlSzbFEzRmKDZ4suiQmK5QE
         5O79C7VcQ4c1jAxkV+3LXFwCi7gdMd5yVzCrtB6FA8FKeflTC6ZxyNbgU3MrGUZvvaMQ
         uOeqcFGWeKUfWB0H5vNUdXkamNdMSfx9kTcmTnMMDupUr3wEfmS03f5C01EYjMMjF182
         RdH2CeywyRnTbfmCvQFwnratwesgRsH/pohx8RjZQQqPArZw8+o96ZLtXYtlxw8QQMth
         1xqtItUDFMbBfNREqfFtChLx+Hv8S4zoee203d/yqQi9NCAZZijzI+X8VEn5MkiG5MRu
         3RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YErQAJTNBsroUwBWXYZSk0t8HBKJD/pgmYdR3arRfh0=;
        b=r52Hg3TziRCaU4kOq2sl6z67PnNwhlSvubLZkPll0nWwkjwushsetPeqOGNFqI7mrj
         uDbgAleVi5ooBES/MYaWSDO0SDzf1JD0ljPhgHMC3kz6oMa7/+tvPkWwf5T20f6AUfYX
         YFErhs259OyBKO+PBiXfPpo+FRdmfEjYivbGQmYvhsc6V1+rkokFmPhAzHYtpBFSmty3
         xQVLihTJIDI+Kfxi+xiOTciHF8UqKemRLVUTHLSaGkmfLnH53hYvlRNm7CMloJMtFeVk
         dLBLhijd15UWJI1sKuqoTcsZjc0tSdOsIVOjaevxdrv0P6BZUMCiWu47MF7FdX+gMBMz
         kyyA==
X-Gm-Message-State: AJIora9kiUKXTyt0soKlTdugTpIjcyqcDRo1E+ZtXLld9uWltE/BHGGq
        nPT+Hy/3VrMsBsbhdkV9yl2GdvhRP4PIhAmYZUlp8MtFR4ehQw==
X-Google-Smtp-Source: AGRyM1tiFJtNJ7jK15XJtd5QoDyl9COVIoiZfo4OvbRUHjZkDRT+mHd4SC/hjB5hwMZl/g/faSWOphXDZp6BaQsUJ4E=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr17544509ybu.128.1657551825513; Mon, 11
 Jul 2022 08:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220710142822.52539-1-arthurchang09@gmail.com>
 <20220710142822.52539-3-arthurchang09@gmail.com> <3a1b50d2-a7aa-3e89-56fe-5d14ef9da22f@gmail.com>
 <CAD4RrFPihC+8LScC1RJ5GfOsLs4kze0QwALS1ykNH_m89Z1NGg@mail.gmail.com> <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
In-Reply-To: <48db247e-f6fd-cb4b-7cc5-455bf26bb153@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 17:03:09 +0200
Message-ID: <CAHp75VfH9M=h7UZPrWLwSmUXXPJFrO+zwAbf_g1k2_HPBM4HKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/string.c: Optimize memchr()
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     Yu-Jen Chang <arthurchang09@gmail.com>,
        Andy Shevchenko <andy@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jul 11, 2022 at 5:00 PM Andrey Semashev
<andrey.semashev@gmail.com> wrote:
> On 7/11/22 17:52, Yu-Jen Chang wrote:

...

> I think you're missing the point. Loads at unaligned addresses may not
> be allowed by hardware using conventional load instructions or may be
> inefficient. Given that this memchr implementation is used as a fallback
> when no hardware-specific version is available, you should be
> conservative wrt. hardware capabilities and behavior. You should
> probably have a pre-alignment loop.

Exactly!
The initial code is broken, NAK.

P.S. At least you may look into strscpy() implementation to get a clue.

-- 
With Best Regards,
Andy Shevchenko
