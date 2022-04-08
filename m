Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554214F8DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiDHEBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiDHEB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:01:28 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F79611DD01;
        Thu,  7 Apr 2022 20:59:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id p8so6620903qvv.5;
        Thu, 07 Apr 2022 20:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LH7BSmcw66GeM+EmzxlBarmKYsAdtHEk0ooqfqKL/mM=;
        b=bWEhQ0kAlrWqks42MLZazJH5TjXVGo+CStcukV2r1bXxuC6Cv3l7MXVj+ODkdZgyAf
         fOMp/spx6HB50Uf5fF7Pnl5Ui7NIjxbRve0c/SjcP1J6Zd+eWdaq6SKUCyvm8M1Nz3VT
         fhXEbwngwfkothEOeX5XNuZHvl18NoLVEq+SiV1m3lcS+qEBkdufOSgIhFRNZ0b0xPQz
         Y6kO17xvN3s/oGhSwQQ4k2GhudESgt8TqRyHjb+0PhjiHR2nsQ5oKXxlEYzvqDcN0xm9
         QQgp74Pn5Mvy32eaO3i02hkGtiNmWjf/lgH6Wtig5KwYyNY4Eqmn0zKfUyrj9haafMX3
         aV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LH7BSmcw66GeM+EmzxlBarmKYsAdtHEk0ooqfqKL/mM=;
        b=Sh1N6L6qaWMu7JuAV11ArXfJgX28+RBvPeiz2TO3JruX+3Ksj0WkiAWW34UQjZWWeA
         SYOR4lu/2IgXlf01yuFED5x5gF3n0XP3cQannSnVh/Ow1kUvQ3C6FfV+hWWdP6YdXLcY
         5kLxlNiLWYlbRegNIKKdcialeLA0qgIrZYRbCptWhVWZ2Vxdo0LPxJx/BMu0SJSO9PTn
         3gFn3fTPrMYcTYcG51D7IyzRceHSkB98/NX6NyhJEiW+Wp6FekKmqU7b3g1YdEGV5yHS
         NFnSAdhd4m7RB4kDzLaTiH2mpr+SHb0FII0Hg+Rq1qrUpU+wDUNUZNLr9s5daC777GnK
         y1QQ==
X-Gm-Message-State: AOAM533yByLA6A+p7BskktOenj2ip+vjzxkJea0TjMg9Dvc4jGdA6kDs
        XWJlDP8bP1SxKz9NF1xlXiE0g+XXzcmOvOARz9dBa06Y
X-Google-Smtp-Source: ABdhPJxN4XFE24e6MURxbFEIrINg1xg82tRehgTuR2/WA/T3kAlKtfe7uX4E/0G16i8B4yF4fxRJZFGCHDXdME4ua8Q=
X-Received: by 2002:a0c:d845:0:b0:42c:33e4:e491 with SMTP id
 i5-20020a0cd845000000b0042c33e4e491mr14587659qvj.100.1649390365515; Thu, 07
 Apr 2022 20:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220217040205.1898644-1-bjorn.andersson@linaro.org>
In-Reply-To: <20220217040205.1898644-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Thu, 7 Apr 2022 21:59:14 -0600
Message-ID: <CAOCk7NrPGCFk9zmLFfuBGHAjujm75L2BzeegAxF3Mwz36dpTzw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm PCIe Gen2 PHY
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
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

On Thu, Feb 17, 2022 at 4:41 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Qualcomm QCS404 platform uses the PCIe Gen2 PHY, enable the driver
> for this to ensure that PCIe is functional.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
