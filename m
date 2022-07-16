Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A2576B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 02:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGPAY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 20:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGPAYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 20:24:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226A5A47C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:24:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g1so8181764edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8jfxx4RE1L6PObFpgYLe3VGx/xPkN6IIKKF2vyixvto=;
        b=ttBa2UbBKeBcedM5VCbE2dF8Fb8R/tnG19G+WXwTVbSTqG1oTp0u3QXSuu1yDvokh5
         QXrrUTBTPgr3mZoAe3NujogoGOPhJdD2szIDo2vVUq3JJk2MePiO/6tGLzFXgX44/krw
         LMaZ469mjAQqsvWglYLYkHeSrFiElKTVV43gRkho0rZagwiCj71D7bKSEmJK93pf6XQQ
         Rnbc1PfQESfvMLcDXLcxF5mkioWaARjstUxs1yJ/rlWOPxYXGtUzwiXDFL1eg5WnBe+C
         g5TVlKenKgBYv06m4uUJCVYS9n02AocDoDUnJ/tFBuW+kUj+wFYw7atCNe8IJ18JXRUx
         wrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8jfxx4RE1L6PObFpgYLe3VGx/xPkN6IIKKF2vyixvto=;
        b=f0/YJKN9G6epTYDqUXlETOWyEtVOrjko5G3MhoT9v0e6q++dBNN3v5IJ6Xk4RAD6Oa
         GCDupjiS69s2ybFKRHYFxcmFyAduB10V3J5XmKqpbbf5z4qZcNMDXneaUuu3scKI6F1j
         FtbV2tkzTfyhGAb8zI2WtJaVhcoPJh48LTyOtv1RFi0je0S0jQjzcongrB2EtvFyfy7p
         mKOuxweTw1lFioquQuywcN3I6EPKoWR8FHu5N9yzlbqZ+0o4XRMzIhdhY2H72k9Oy2ei
         7EdGO+VwDlQStpVbfcunCIJUJLuxE5JbooAk6cS6FXdurgjwkX/Gm6BkNs9VONfEMYbp
         ei8w==
X-Gm-Message-State: AJIora8pyOU96RfqVvyaed6eIY8pE0qxMX7vAYY2jdhJ1uj7Fl+DWhAX
        Ks62lzCyXyT43qJcHGSvStaToQ==
X-Google-Smtp-Source: AGRyM1tNcup+VZRbETUlw1suyFlV8QtfS2LSShbACHnJArc2NkI0rR1/KyBV9KTkE5dfB2Ut08q/Cw==
X-Received: by 2002:a05:6402:148d:b0:43a:8f93:1d1 with SMTP id e13-20020a056402148d00b0043a8f9301d1mr22124080edv.57.1657931091445;
        Fri, 15 Jul 2022 17:24:51 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id gj10-20020a170907740a00b00726c0e63b94sm2547537ejc.27.2022.07.15.17.24.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 17:24:50 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v4] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CDF716FC-F6CF-44A9-84D9-B48C46E6AC2C@kohlschutter.com>
Date:   Sat, 16 Jul 2022 02:24:49 +0200
Cc:     wens@kernel.org, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3912A668-9F73-40FD-8993-5060F632238A@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
 <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
 <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
 <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
 <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
 <17a4c6f6-d79c-a7b2-860f-e5944b778f9f@arm.com>
 <9405b97a-6758-ad4e-ccff-eed072096539@arm.com>
 <BF7CC548-88C9-4889-8A41-8E99C31EF81C@kohlschutter.com>
 <daf3b61c-d886-98eb-0443-de233d742041@arm.com>
 <CDF716FC-F6CF-44A9-84D9-B48C46E6AC2C@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>=20
>>> There may well be another bug slumbering in the codebase that is =
circumvented by 1. adding a delay in the code and 2. not turning the =
regulator off upon shutdown.
>>=20
>> Yes, it seems suboptimal that the regulator core allows this glitch =
where an always-on regulator which is already on gets turned off at all, =
but I guess that's its own problem. In the meantime, off-on-delay-us =
sounds like the most likely property to bandage this locally. I'm seeing =
a fall time in the order of milliseconds (attached), so we'd probably =
want a fair chunk of that to be safe.
>>=20
>> Robin.<SDS00003.png>
>=20
> I think we have a way where there's no need to pick a delay value that =
may ultimately not work in all cases.
> Following up with "[PATCH] regulator: core: Resolve supply name =
earlier to prevent double-init" [1]
>=20
> Thank you so much for helping me getting that far! It would be great =
if you'd keep following the thread.
>=20
> Best,
> Christian
>=20
> [1] https://www.spinics.net/lists/kernel/msg4440365.html

@Robin,

oddly enough, setting off-on-delay-us with values of up to a second =
(1000000 us) still results in failed inits.
I hope we can find another bandage until the regular-core patch gets =
merged.

