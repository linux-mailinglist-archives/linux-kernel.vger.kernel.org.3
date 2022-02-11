Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809674B1B23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbiBKBV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:21:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbiBKBV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:21:28 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE33267F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:21:28 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c6so20617335ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apbl1IBbPTd7mPNpWX7lJo6c6WmezPKP8rRQADu0iqI=;
        b=Al9EYQ6UivIBEzJt+EXRPWQS4tQ+SZS7j9RAp0oHXZxyun1wJHq+IzElQLvKCTvlx+
         QBg7KKMmxyv59N9pScYHlAEq8x3bjRI3h7T8UnGSTlkPgvUKGYFIJ/97N7e+4t6IG4hr
         NUr+mc/t4DlsQamjGODM4GOesMED3y6G8pGjm9M8vi03iswVLNqmI1LCQCT8NHOSDF1m
         D2Efq5FYVMAUWCONNrXorHlk3VOhxOr+M+nqRtaUpiiIzJUSqBCG31ONIb7a0D3HCXqg
         wUQTiNi1kGcORkQGYyocKAElbLnegbHE0Os6F9IA/nq17CGhARVSu2cCgvmQuGsI+Cb9
         W/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apbl1IBbPTd7mPNpWX7lJo6c6WmezPKP8rRQADu0iqI=;
        b=tP+9fQvqrK8veunmAhPH2cty9BxxsAsQkDyCCHIMAT6E97o2ttXfLllLZu7Efpfq5e
         1E640o92Np05IR1PY0TUepNys+iv587wiXyM5fRWVlvXU/A2QT0j8o4dIJR1lD1Th79v
         rSJj8+8IL8r/4c3NDztuH6pP2y36KXjJKBXC2W4gSDUNkQr0a7O85Zl0V3TxE8gigfep
         hiXIA9IQhwYZzrbgzY/2li6i6jz+DyM2ULK6tq5kNWixJx0K2xR5hD1fUsA3ALkP86aX
         zOewuh4XBIGUlA9wa25eogIZpitD8DC/5EIAkfQf58+IFVk7YENkbwbK7ZOejlWuaeQ4
         4wrA==
X-Gm-Message-State: AOAM531Ol+8DAnkrmmlV+DIPlHAbwIdVqbjywOkOR/mbKDojas05LpNS
        S2HcNWjqaGfrtqA4MzW1Iuk0gkm3+8zsoaNJIMl+cQ==
X-Google-Smtp-Source: ABdhPJzXkCGm7OG5XsU6NkyfdBiqjONEKooP872F/l4oHbI98KkoThhR0NUJt7FrNPPtYs39W5QwDbpuLA78r846f48=
X-Received: by 2002:a81:4402:: with SMTP id r2mr10308216ywa.126.1644542488134;
 Thu, 10 Feb 2022 17:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20220202091551.580372-1-colin.i.king@gmail.com>
In-Reply-To: <20220202091551.580372-1-colin.i.king@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 02:21:16 +0100
Message-ID: <CACRpkdZUe65yuEBOctguBW4jUFt8U26Rsb_TwdFTdxKbKt58Og@mail.gmail.com>
Subject: Re: [PATCH] pinctl: doc: Fix spelling mistake "resisitors" -> "resistors"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 10:15 AM Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in the documentation. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Patch applied.

Yours,
Linus Walleij
