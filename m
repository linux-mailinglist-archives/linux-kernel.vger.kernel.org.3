Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3305ACF44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiIEJzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiIEJzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:55:13 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55118186C2;
        Mon,  5 Sep 2022 02:55:12 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3378303138bso65418257b3.9;
        Mon, 05 Sep 2022 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kZwowG+rRON5KFSUE0R9YJYWgBrkd2+kJINr3ZwEXZo=;
        b=Vl1e3lhr4VBYOH0566THbq5E7P+PDrFu12F8dop24wzAOHlXYdtoS44xu2rgMicuvp
         tA7YB486fFdpf8kVtFpNecJH1s4DXPlxHiW6LQkPh/LWtoRWVE5AHVHmq0SZwgAi87o9
         wEXwyzgeEiMe9khhpJkOsw2zjnF+351IkAyQj1AQodm19bxNYQTuw2r3ZRJi19DQ8Rtx
         3Om79/0Ta7Gr6MSxgSucqk93FAlG0v0w89dq18ngW9nbBb1AX7Z+BV6kOoLnB8YYNiK3
         nKw+MnTtefiAlqU/F83VERFQTnah38RoRnpml3JJpVMCKDt8aMbdYtZDFbs1AYhOw90P
         JVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kZwowG+rRON5KFSUE0R9YJYWgBrkd2+kJINr3ZwEXZo=;
        b=Aou85Y4pfEUikvVnJTW1U5h5nhblCfNMUsQfwpAQfs9Vuk3JN35ObbK9lWDw9E+x2N
         7sp7mewleAWPgUCLOkLb2xdoTwCF1koWTuK9eHdL3ZZibsBPRhHWYcGr4kmBe3WL1WXM
         ywolwrvFjFpqz2Q4aLd3vVTK7lTdTh5IDoVwC3fM9Ye4bdkBU8WLgsApEXJBMPmJNkKF
         I/CSWGSpQaehDKCrVwNNQ/uJY7xfCo0+RurMQekHR9Or2Tb9dQCr47/y166Db1J+vNO+
         zzKAoPMd0v2KOMdxLPDPZW9uvZVmhDtFy8nOTLrOqV2n6Pcr4htZFv3zRjYQQwrUnmNw
         xR/Q==
X-Gm-Message-State: ACgBeo3aTQxB5+syGmR92iU8hCozY3mqPE0D8zY6ExqOgpdGFBIQQb63
        YzehHL65uFJ730llXcv8JLA57qPluxtmJ/mvpXo=
X-Google-Smtp-Source: AA6agR5VnQe4agp3+bventbZ7vQ9gI0u6eIpSo3fWiJh/oMJA6ijI89J9YKmciXOJw3L4bSRSWRikz9lWxdlZfz3zGk=
X-Received: by 2002:a0d:f701:0:b0:32a:17d3:d189 with SMTP id
 h1-20020a0df701000000b0032a17d3d189mr38205702ywf.401.1662371711515; Mon, 05
 Sep 2022 02:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220905093546.19735-1-lukas.bulwahn@gmail.com> <4DB82E66-0BB9-4B43-917B-55E115994876@cutebit.org>
In-Reply-To: <4DB82E66-0BB9-4B43-917B-55E115994876@cutebit.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 5 Sep 2022 11:55:00 +0200
Message-ID: <CAKXUXMzGJv=Xvbv8VRqFfa=n-0D84Hk2FALqtyqmxD9ovDKCMw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: rectify entry in ARM/APPLE MACHINE SOUND DRIVERS
To:     =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Mark Brown <broonie@kernel.org>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
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

On Mon, Sep 5, 2022 at 11:44 AM Martin Povi=C5=A1er <povik+lin@cutebit.org>=
 wrote:
>
>
> > On 5. 9. 2022, at 11:35, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Commit 3df5d0d97289 ("ASoC: apple: mca: Start new platform driver") add=
s
> > a new sound driver at the location "sound/soc/apple/", but it adds a fi=
le
> > entry referring to the non-existing location "drivers/sound/apple/*".
> >
> > Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains abo=
ut a
> > broken reference.
> >
> > Repair this file reference in ARM/APPLE MACHINE SOUND DRIVERS.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Martin, please ack.
> > Mark, please pick this patch on top of the commit above.
>
> Hi Lukas, fixed here already:
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/=
?id=3D55e2bd9c41e800638676dce3f19dcfd16b309a08
>

Great, thanks! Then, there is nothing more to do. Please ignore this patch =
then.

Lukas
