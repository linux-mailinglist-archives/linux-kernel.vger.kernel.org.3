Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C717567227
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiGEPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiGEPJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:09:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD22313F92
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:06:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so9467287wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+cVXdg+Brnle8yemDKHWIkEdNxNp1s8TSLsVgVGe5J0=;
        b=MGwCh4yeqqLnhT0WMeoMr6CScRSYX/1HhkHLkHd4QnnDjSiVs6v9atM7MaOH9RGZDK
         dGO7qUntVI039HvOKrW3QKVdjI2CczNLcXdb7Dt1Ub7vmntUW/GmQihHPISmn7NdyW6x
         Oz3bmlZUkboe9bpM7bjhv3VgCAhihHMi8oG80QjJ8o+3hxS3yPiy3Q0+fWBsjDHSC4NT
         8Fmugcq3HKmqosRHKeCgvK/GzuEf+g62jHkWPXUR0XfqbUFTtkyOv51QXZZEcXaYblgq
         mTfli3sCq2GSvf3Tlj6JJp/NqJoNlsmSYIDI1XPGIDLvzIbbY6BYNAK6jXh5Tuj2jQsn
         0f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+cVXdg+Brnle8yemDKHWIkEdNxNp1s8TSLsVgVGe5J0=;
        b=DVpmGfrzHSka6ur5meGffYFyHW3/xHINNxf+E/hWt5nW1sG1b4NqNxYppl0At+kZIl
         n9bS4Pj2q5l7CNJcHOBpGUYyCcH0X7aPREKLkSatY1aVLLGLfyKC5MskeP2Y4gr7RLBW
         mCqEM0SAiQj0aSUfEafPX4NtWZQzsv3/mhnkgtsD4g64mrxMobKXHj3Rq94bg7QX4rc/
         0rR16aSXU/442jG1gAT65s2EpOtPsmH0Fo6JWi4cgTa8U2ATVmxG4wOPv6IsQB974pkj
         IE2zx8mfjbhXrGM0BlTI4F1CqHJWkJYrrKBcFozzpAYPCnLzfPYsd/C8OENowf2hBveA
         elCQ==
X-Gm-Message-State: AJIora9YWikxfoAK//XZ8YS7E0AUiD7/o1OpNgAFkAh3B5aBzNP/5pgJ
        Auf9DZh+yPCxUkltInVll1fgFJ8d7d+pnChl3ysZXg==
X-Google-Smtp-Source: AGRyM1sPaHkA/oz0kbKM+58TCz8Bc3vtUDjTnCx3JRdROJ2gHJtU1pj3EzwdjI0I3EXWoLbaZGRMWaQPNjnOe1p6KLo=
X-Received: by 2002:a05:600c:4e46:b0:3a0:4d54:f206 with SMTP id
 e6-20020a05600c4e4600b003a04d54f206mr40771971wmq.151.1657033615052; Tue, 05
 Jul 2022 08:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220519073330.7187-1-krzysztof.kozlowski@linaro.org>
 <640d2a3d-4c38-b921-45c1-048c255b5a9d@linaro.org> <d4972a70-8ddf-a394-3e8f-08fb778622d8@linaro.org>
 <57aca768-18f4-6b79-9490-c57123d71232@linaro.org>
In-Reply-To: <57aca768-18f4-6b79-9490-c57123d71232@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 5 Jul 2022 09:06:43 -0600
Message-ID: <CANLsYkzgG9gAropJVsdCe8PE+EJpQnD+Chc4ncm9otNyzUYZ2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmsg: qcom: glink: replace strncpy() with strscpy_pad()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 at 06:14, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/06/2022 20:37, Krzysztof Kozlowski wrote:
> > On 09/06/2022 10:56, Krzysztof Kozlowski wrote:
> >> On 19/05/2022 09:33, Krzysztof Kozlowski wrote:
> >>> The use of strncpy() is considered deprecated for NUL-terminated
> >>> strings[1]. Replace strncpy() with strscpy_pad(), to keep existing
> >>> pad-behavior of strncpy, similarly to commit 08de420a8014 ("rpmsg:
> >>> glink: Replace strncpy() with strscpy_pad()").  This fixes W=3D1 warn=
ing:
> >>>
> >>>   In function =E2=80=98qcom_glink_rx_close=E2=80=99,
> >>>     inlined from =E2=80=98qcom_glink_work=E2=80=99 at ../drivers/rpms=
g/qcom_glink_native.c:1638:4:
> >>>   drivers/rpmsg/qcom_glink_native.c:1549:17: warning: =E2=80=98strncp=
y=E2=80=99 specified bound 32 equals destination size [-Wstringop-truncatio=
n]
> >>>    1549 |                 strncpy(chinfo.name, channel->name, sizeof(=
chinfo.name));
> >>>
> >>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>
> >>> ---
> >>>
> >>> Changes since v1:
> >>> 1. Split series per subsystem.
> >>
> >> Any comments on these?
> >
> > I sent first iteration in May, then on 19th of May. There is review fro=
m
> > Stephen.
> >
> > On 9th of June I pinged but the patchset is still waiting. Anyone minds
> > me taking these?
>
> Hmmm... These are all fixes but wait for quite a long time. Shall we
> make the rpmsg subsystem orphaned?

Bjorn handles all Qcom patches for the remoteproc/rpmsg subsystems.

>
> Best regards,
> Krzysztof
