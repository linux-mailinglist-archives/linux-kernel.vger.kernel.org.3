Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F9152F60A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348025AbiETXQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbiETXQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:16:35 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3AF57146
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:16:32 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i66so11565495oia.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yxlZFui2Yaf/yMfrSBImiOBBtFzo9plT1mEwwLvskcQ=;
        b=QQ3Ji43YCSMIg8zi7tO8mgLiPY7ZQlKggsWtAYpivQLNqk+AhHphjiJJkj5BEw3goj
         FHAHKy8fWM7leVzFHXGZMrZAsYfuKb1BN8Imu8P6lDBZMim3CdRugYFXBeJvJ565G170
         wl0TR4s69nBhT8PKphKsRvd+mvXC6hs6/WoYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yxlZFui2Yaf/yMfrSBImiOBBtFzo9plT1mEwwLvskcQ=;
        b=m0f4HywHuOFrhhiY99HQLYClZ+kS9xz4ZEcyXTFGoxzqMQZ7Vhupmn4OENwxE/8kav
         1qEF00LU8kOMST5+s+8eZJpJPOFUmFZhuq0NG6xt6/i2bMQesysSAOWyL4alJX7TsI9I
         5Uectc4C2Tnq4gsD6/bl+cjiExMKINMLJ+3uxwVSG+iVVztdgcbXCPr6Nv9k22+6PLxi
         5/odLA21TxetPDD//AaGvX+j9NzpeRCWTSmxZes97vTqyXl41MMExOoK1G2Zyzv5ECT6
         TCoe+m2mDitCh3fzOyw85QtOl8FdgaVHGvTqgHn62ahLX3dFvUNe+7+lbPctvGMn+alm
         MdEw==
X-Gm-Message-State: AOAM531BUCGTN/Y3OicBziaMzTGZP7/hAeLnuw5vyuEUtpJrv864ozxd
        JHjF7OGuYm/dbsmcxDd3OLC2lVdWwYFqhFdi3OEygKHkC2U=
X-Google-Smtp-Source: ABdhPJze2O0r826Wkv9TYht2+IV2909AuAPrg2Bpl39RVQNOr0gbPg1aiFpRQF/hshBLa8Bf37FBjT5mXHnyiWqAZ6w=
X-Received: by 2002:a05:6808:23c3:b0:326:bd8d:7993 with SMTP id
 bq3-20020a05680823c300b00326bd8d7993mr6933836oib.63.1653088591458; Fri, 20
 May 2022 16:16:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 May 2022 16:16:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VSMyJrs9bTE2XEC=q7VtZi6YKFaKJQJyLTZhVaYa9-Jg@mail.gmail.com>
References: <20220427020339.360855-1-swboyd@chromium.org> <20220427020339.360855-4-swboyd@chromium.org>
 <CAD=FV=VSMyJrs9bTE2XEC=q7VtZi6YKFaKJQJyLTZhVaYa9-Jg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 20 May 2022 16:16:30 -0700
Message-ID: <CAE-0n52dG8ucjgsaDVXDw1hXsG3YNZRPKyYVTr+JVJHpFoAizA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Only include sc7180.dtsi in sc7180-trogdor.dtsi
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-05-20 15:16:03)
> On Tue, Apr 26, 2022 at 7:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi            | 1 -
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts                 | 1 -
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                   | 3 ++-
> >  19 files changed, 17 insertions(+), 19 deletions(-)
>
> While reviewing a different change, I found something fishy and
> tracked it down to ${SUBJECT} patch.
>
> Specifically, after ${SUBJECT} patch then I run `git grep
> include.*trogdor.dtsi`. When I do that, I see that
> `sc7180-trogdor.dtsi` is double-included in all lazor devices. :( It's
> included in the actual dts files and also in the lazor.dtsi file.
>
> That's probably not right. I think we need to remove the one in the
> lazor.dtsi file?
>

Good catch! I sent a patch to fix it[1]. I recall I compiled
before/after and didn't see any difference, so I suspect it's just a
waste of time during the compilation phase but otherwise not causing a
problem.

[1] https://lore.kernel.org/r/20220520231355.1559104-1-swboyd@chromium.org
