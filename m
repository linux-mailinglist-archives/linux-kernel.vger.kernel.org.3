Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98137578C49
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiGRU7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiGRU7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 16:59:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3261F2528D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:59:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id mf4so23585814ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=G4xt1tsCAE5v1aPuO5mOncHkPCmfTeAk54UxkIc2Qmo=;
        b=aZZxh1rhvlV3iS5yeU8mQplf8hQFrCKIoPgu4ncOEANuQNQ2S1+jZVJSYliXp3IZZ7
         f4bmNDrHEYEKmqnJ77+sCdX769dLBdO32ogqumghD9tv9lRmIGBQ/3R/975HzecAD1SE
         IQUdoGRzZCS/brdX93651zSNgJNc0i/wmT8gGL/OwvZ/R8usWYb7M14KTC0Sbc5x0O/H
         Z7I3DgirWW0Rzsbh5tAfFofYBXmrCUg9ahFQUF35wcMctolakdIc4iRKKRQF3dLixdkw
         /hsy3QeG0XgwIZD0MLxKIaTHOx8z1hf6dn/SRvezJj2n3xvek+8EYFKm6sPXgeepEgLK
         StGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=G4xt1tsCAE5v1aPuO5mOncHkPCmfTeAk54UxkIc2Qmo=;
        b=qowBf5L0TmgKSNHodFOeMs9dwiQXRLceIUC3wpX2jHzLNY0Jm+gxKvMwNjf1gCBvX4
         ibqrVAWTCPl82p1N+ohQ68HFRBybu58OsIT2uCbF/IpUFzOYa76T/8diLsBHIG2yRtO0
         0pqmMgtXTlqMEIY+7JeJG89Ue+RzlReCvQmTINiQa/6p5QmqOrKPqFSnA2giM/G3zyVo
         n9zDzoZJt3/nzLk7xOATDZi7dr41bRwZef/YzftiHc89xfG364RVd4Ccin6LpVZvQA8O
         yOCcX2v3wh+tL9CYhR/2KuYhpdgUJb3QjoJoqpLsnRNxgtF72A1M72VQB0RPt01nqyth
         Z26A==
X-Gm-Message-State: AJIora9LTV7U2ctSKW1kIXe9NfNQn3YkzAv9OmOKxVcEu1RFZuRFreK1
        6VZubEdDbtETH+cT9T8ZYguszw==
X-Google-Smtp-Source: AGRyM1tVB4vvb5f/bKXAFwDhyy9bAciaV/Gd3r6IsQlbV9u1J3/xCyjaIxTW/riej87bVuuJQTaAPw==
X-Received: by 2002:a17:907:2c75:b0:72b:3431:2a0a with SMTP id ib21-20020a1709072c7500b0072b34312a0amr27796230ejc.234.1658177945709;
        Mon, 18 Jul 2022 13:59:05 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090695c900b006f3ef214ddesm5814209ejy.68.2022.07.18.13.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 13:59:04 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk3399-nanopi4: Fix voltage
 regulator config
Date:   Mon, 18 Jul 2022 22:59:03 +0200
References: <963AF33B-54B7-4172-92D1-E2898E256A7E@kohlschutter.com>
 <14EE0603-99C5-49AE-BDDB-C22C5B1924E2@kohlschutter.com>
 <7AFECB02-5A87-43DD-8161-6068720AB8E3@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <7AFECB02-5A87-43DD-8161-6068720AB8E3@kohlschutter.com>
Message-Id: <C8ED2EFC-A7D5-418D-A7D9-E1D37B5BECFD@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.07.2022 um 14:02 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>>=20
>> A series of issues exist around the "vcc3v0_sd" voltage regulator =
that
>> made it necessary to mark it "always-on".
>>=20
>> With the patch "regulator: core: Resolve supply name earlier to =
prevent
>> double-init", this option is no longer necessary.
>> ...
>=20
> Walking back on my claim in the commit message that no further patches =
are needed for the u-boot integration to work.
> Other than that, the actual patch is unchanged.

This change (removing regulator-always-on) doesn't work reliably; please =
disregard for now.

