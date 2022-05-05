Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705FB51CBA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 23:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386055AbiEEV5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245426AbiEEV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 17:57:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65C532E2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 14:53:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s30so9889698ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCoDgmddTtLI0GdQtfmKUixQsE6y5QSv0lEy17c3ipQ=;
        b=A3GWTybPmCx3FISILTMAMvbsp71fP2NKB9pVjjCmQTH1WsiHhNpPOttu6hz+NcvTkI
         lYylu1w8CbkzEOlJ9p0zHVhTZ4KO4cK/blbEW1yMqQ/zt9ozOQ3KEdIv1A9TizdkSvw0
         doZ4aZ3IXigf2UODRTDyZPQF5+u0bhnqWE9LHN/XiOsmw7BSo98wjRR9ah+EesKgQBxM
         maJCG/z3NUdygYqVFxGZOhQBMA3cZDkTSnWUfJiYUqLcri1YI1MAmhaGWob8C/Eo6k5V
         J6rGRilzFC76EcPxHNtRP3616ucWIl3HAq3fXfcYHihmazTKP096Syk2I633lxnZjnHp
         YX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCoDgmddTtLI0GdQtfmKUixQsE6y5QSv0lEy17c3ipQ=;
        b=GhCx2RC41ZVyfb3PvI07yWP+c0QkcslsLRDC3KoYFOcvSBWt5z/q3JIUhoPPDFMOxm
         HTrGtOyNSDP+EjVmeXuMoBkCZ0xcN+boO6Qg83h7+0NVongTMmhdpbLTIDPhlJBIwuTL
         8pukZNepj++EYE/Jm9/7l0LGNzKQfwgyU6mQ11zqTkdqSwa7pcCQgwKreJkDQNrNauns
         kkDF/CcQ1bMHeucZkJ9ENZrh1nDBlcQZfj/AJYnYehESLsv1pJwhIFbdm5TbbiuTCHtQ
         f+USp3B5NKxYuwiMMnCUnAEQRcgJUjiifnnGHjeO7OtGaUNqETEMoYJJKXtLyJIWXGhV
         vNcw==
X-Gm-Message-State: AOAM531dlHrLy7OwNKsPxgSmILr6NZPUlC6p17NlSU6EoVd4fLQlAovu
        wkbFtt91pgHersuoQEjiiPW45+tQRzKsuuua+PZS1DJpjN4=
X-Google-Smtp-Source: ABdhPJxBkrbDKRoetUh3zQUrvDTTWSIxWCrEP3DoxVTsAJqLZGfgHgccPdMURtafA2RAtc5Ooi28YRmCvzqeKVmKy7w=
X-Received: by 2002:a25:bcc7:0:b0:648:d728:d39 with SMTP id
 l7-20020a25bcc7000000b00648d7280d39mr215055ybm.514.1651787616791; Thu, 05 May
 2022 14:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220318103729.157574-26-Julia.Lawall@inria.fr>
In-Reply-To: <20220318103729.157574-26-Julia.Lawall@inria.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 23:53:25 +0200
Message-ID: <CACRpkdZ1a5qhy8M0ATNij4HeF9usVgktfPRb6JOfJ0XFc30svA@mail.gmail.com>
Subject: Re: [PATCH] ARM/ixp4xx: fix typos in comments
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Linus Walleij <linusw@kernel.org>, kernel-janitors@vger.kernel.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 18, 2022 at 11:37 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Patch applied!

Yours,
Linus Walleij
