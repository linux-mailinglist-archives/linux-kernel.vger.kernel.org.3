Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395055AD227
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiIEMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiIEMKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:10:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623755E329
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 05:10:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id se27so16666578ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uyNua9RZQMBItV/dSaLLMta7RxU5C+SpWZWfOrY8VqE=;
        b=CvZl2BNgxHZZJAaGpRdi91gjD9aZilrYGjQoVPw63tfBxHFTW5FAMCSdVAt/g4GyRt
         AWvjsc0Lj5GB63nTVoHVs+203PpfqM60vQWfSJ2GkAKiT9tPxI/OP0v1ulvRgRrAPM6a
         XuRg4MEofe677tHTiSGWuIdz2l7p0MfmV07RmYsgFVALm0AUUHvi3m3SA54ovXwsoJnu
         n5dckUOMeiihWxYGODm7IuHSMRJNa04TgqG5CV+OopbzM9qqtKjLvttgIONTCmN4S8D0
         Jw0un4REChwuseK3rjhSXk0YDQz8X6qG3SXORic09R1I/b/piUEnZ+Yz+XUycqEOuVma
         TaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uyNua9RZQMBItV/dSaLLMta7RxU5C+SpWZWfOrY8VqE=;
        b=dlxN9EpP0hC+63Q9DmqSDIiEyWIX1n6tJ2OXknSlzZRsRYuJaankFaUL2L5usPDrDw
         h+Sq6c0VQ9Mue6Vr5gynmxY9tr8capemeZTxEdx63Hma64x2BAa6KvwPKEoDQnfT7Z3H
         9AmJAZTajLtVOvUkEhWRZBwdSEMN0+9IDeZakUJ/yV9zwO3IebdcStzlsHXJKyhlnMTo
         VscScTrFd5lnlQyb/jJea+ueSHluZN0Pnl9/TUiIpb1taZaRyPWVdRhrZHwvus/t1v/V
         yOtlFXoGXWpFoSI0LJR0bTPo/z4NMOEmBZ5WEF6ixfc9tzaBmUrAVajF1grn0/YEcpyy
         XKWA==
X-Gm-Message-State: ACgBeo18gXXLrp+c7Z4fgXau5PPMxNtM8u3iJxnZhU3IS6wiSGwn7Gc0
        DwjpfTb4BZVPS2D7y2FHacE8zpzFpWiHK1NIRrJj6w==
X-Google-Smtp-Source: AA6agR7kIMLy48otphEzF4h+sD1WW5s5Tya3a+Km+N9oAqrNsvYl2+e+ii7HXFFJ6fs6JElYzHmj3EAC5JaFUCoRJWM=
X-Received: by 2002:a17:907:2707:b0:741:7c18:4e76 with SMTP id
 w7-20020a170907270700b007417c184e76mr24283717ejk.690.1662379849958; Mon, 05
 Sep 2022 05:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220905071300.1832105-1-13667453960@163.com>
In-Reply-To: <20220905071300.1832105-1-13667453960@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Sep 2022 14:10:38 +0200
Message-ID: <CACRpkda62=3ho+R4OzUYHXwrSDSBnqCOxhc4XVAe8i8nSHtvKA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: berlin: fix spelling typo in comment
To:     Jiangshan Yi <13667453960@163.com>
Cc:     tangmeng@uniontech.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 9:13 AM Jiangshan Yi <13667453960@163.com> wrote:

> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>
> Fix spelling typo in comment.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Patch applied.

Yours,
Linus Walleij
