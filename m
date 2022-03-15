Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA944D921C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbiCOBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbiCOBOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:14:40 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67481FA5C;
        Mon, 14 Mar 2022 18:13:28 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 13so3495357qvq.8;
        Mon, 14 Mar 2022 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dwAn3W7JqTFJWnJs64oLAKVQi0GEmuJXd5CMnlgQgRo=;
        b=Ux34JU5YorjpXisd5AMSmmAtUrKGTm9Mtqprl1tcSJdR9wJtcwpTcX15Y/Z40CP504
         QCJtfE4Oqkh+sLBjAR7PdLdkn/xyldqxP8XkVHoJDo8eQS53Fo8YOgzvB3YxM7bUnjUh
         hkaHGxrCmEEfZu9sEkeVL0d/WNJc8Afg4KuVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dwAn3W7JqTFJWnJs64oLAKVQi0GEmuJXd5CMnlgQgRo=;
        b=dLeWvFLC4v9tKLP/2+8eGs/UvPmRV49AQPY5kMyEridCGXKN4xOvAvS5Dy8gwjn2ar
         N1rjLW6JScXQ44pZt2LicYchGN34Ubr6Uw6rfwNdMyVkYi1pf2ObLZtqu2xh10kBNSlV
         UUUOYYPkLBU0ezuaAiO0BnJUHasXUbRCa9R562MyF4TBXjYjthcokylUgRgmA2xjVBL9
         Bith7Wmymg8rwtzmbz+e6KKKYzvCI6VzjP099wlCnkr2iHZ0glY1ALOYnAMtIdmt7q2v
         XLoUzLxxssqqzTMPINg/iXQh9ijxVNxiETWz7yMw2SMw81ooWv6eb7WpCAm33NDDJPK0
         Ac4g==
X-Gm-Message-State: AOAM530PwPnDaNoDiQUHD4GAHl+mPDDd0WCFA++9bYFr2vys0kQCxw4k
        TUICB0UGglUVVoyB4/lny2ZzYO8rjelHs9WnOQ8=
X-Google-Smtp-Source: ABdhPJytKfY1Xv1hYw9fXk9v623Ig2P8yrtMnEqcEpDjV9v+JQJgqJQZKcLwZoqzgNdI/js1Wht0gpsieyZ3Mom37iY=
X-Received: by 2002:a05:6214:2a85:b0:439:db71:f630 with SMTP id
 jr5-20020a0562142a8500b00439db71f630mr16198122qvb.65.1647306807951; Mon, 14
 Mar 2022 18:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net> <CACRpkdahSbWv4q7hoBAm_4+oKPEui9zX5-4m6wvPWfonWpbZUA@mail.gmail.com>
In-Reply-To: <CACRpkdahSbWv4q7hoBAm_4+oKPEui9zX5-4m6wvPWfonWpbZUA@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 15 Mar 2022 01:13:15 +0000
Message-ID: <CACPK8XeOE9mjmudvOS7uQg1e9Fh2e_cq1KTxkZsftbCo5YLk_A@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 at 00:17, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Sat, Jan 29, 2022 at 12:57 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>
> >   dt-bindings: pinctrl: Add Nuvoton WPCM450
> >   pinctrl: nuvoton: Add driver for WPCM450
>
> I applied these two to the pinctrl tree. Sorry for taking forever
> to figure out that I needed to do this :/

Thanks Linus. The device tree changes are queued for v5.18 too, so
they will all go in at the same time.

Cheers,

Joel
