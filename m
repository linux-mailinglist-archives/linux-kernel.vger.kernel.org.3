Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5625766FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGOS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOS5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:57:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB33B969
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:57:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id fd6so7440044edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cGwhK/ZtvSr9wwZc7/rNFgjUf04Hq4lw/c5RyLtXhv4=;
        b=n30FiJMdCmOAUiVxpAmFVASHuizhc6AX2acGIQrmGWi2ITlMu7dy5tY3GAusQZCwUX
         mClk0//XWWNtoKOlVDp3bevjwUCPlPu6qT58ckogGwW3fiPwV3AnX1JH80Tcv/qvJxbD
         dd2hnpWUh+kbDnSUzqOnXj71sddyRZYkIlR5uwqBsXNmW8E86IjtsWgCOCj96w7UTJh1
         ekclrrbo31eDkn55oa2xD7ZY8kZCRduEeNmKBSZ3yK6cNK/PRrM+v1/yUUWmbSW8KzBk
         1G3I9oE8dPOml71Mav31UBLpfptw3Ree6F9LzjmopmoauGHoWKXK8zG7iMIjoX2r53ev
         BDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cGwhK/ZtvSr9wwZc7/rNFgjUf04Hq4lw/c5RyLtXhv4=;
        b=P3i1lad+Yz7Ln4Ex/IkC+bi1/c7C377rFboLbXDijFu++4EzpxDLEGgFf2f1vkvoex
         nSt9cTYXPzBeKQPlIWr6CNA/bGzkP2/LAkWfOegURMrDG7QgOmB2+om800ejnanQpFUd
         0QVxm88j5mG1DTAknMcGRlTmUXWPkZAECUrv6pTy6P0AVFViS1sltAuJ0vc2ABcnpJWr
         EfgV+kzW0QkRWLiwp3OONn028dEcSOck/lkiwLTMMGML/nX9SlJATiG+pAv4Bubii8bD
         LhUmlWW5nyfdALomCb4WSBKCEHZaEvkrbylpyal2tMQiqfSP0doOcBVwW0ajQpH2NwDt
         QvBQ==
X-Gm-Message-State: AJIora/xMhmU00Tz2mgr8Od0AsA8xeuOnB9mi0dNMb8bOe+17eo4kYON
        u/nlwNOM/Rer8F0ue2wfVBkErA==
X-Google-Smtp-Source: AGRyM1sNSdrb4hPilLYMF0OeyZKR2sc7pz98xPbz2HQO6R2iT7Hy2/VCmJFBU0H7V8xJJER7HTBMcw==
X-Received: by 2002:a05:6402:40d6:b0:43a:cc69:1db9 with SMTP id z22-20020a05640240d600b0043acc691db9mr20997614edb.380.1657911447021;
        Fri, 15 Jul 2022 11:57:27 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id o18-20020a170906769200b00726abf9a32bsm2329648ejm.138.2022.07.15.11.57.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 11:57:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v4] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <17a4c6f6-d79c-a7b2-860f-e5944b778f9f@arm.com>
Date:   Fri, 15 Jul 2022 20:57:24 +0200
Cc:     wens@kernel.org, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEEF9E7B-E8A9-4E33-B53B-72D72F9EA536@kohlschutter.com>
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

> Am 15.07.2022 um 20:11 schrieb Robin Murphy <robin.murphy@arm.com>:
>=20
> On 2022-07-15 18:16, Christian Kohlsch=C3=BCtter wrote:
>> OK, this took me a while to figure out.
>> When no undervoltage limit is configured, I can reliably trigger the =
initialization bug upon boot.
>> When the limit is set to 3.0V, it rarely occurs, but just after I =
send the v3 patch, I was able to reproduce...
>=20
> Well this has to be in the running for "weirdest placebo ever"... :/
>=20
> All it actually seems to achieve is printing an error[1] (this is =
after all a tiny 5-pin fixed-voltage LDO regulator, not an intelligent =
PMIC), and if that makes an appreciable difference then there has to be =
some kind of weird timing condition at play. Maybe regulator_register() =
ends up turning it off and on again rapidly enough that the card sees a =
voltage brownout and glitches, and adding more delay by printing to the =
console somewhere in the middle gives it enough time to act as a proper =
power cycle with no ill effect?

That's definitely something between placebo and homeopathy :-)

I can confirm that setting a limit higher than 3.0V still works, which =
means that the one time incident where it still crashed means that =
there's indeed a timing issue at play, and adding that undervoltage =
statement (unlike the ramp-delay configs that I also tried) added just =
enough of a delay that made it work 99 out of 100 times.

> If you just whack something like an mdelay(500) at around that point =
in set_machine_constraints(), without the DT property, does it have the =
same effect?
Adding a delay for vcc3v0_sd works, which is great! (patch below)

Is there an existing path from device-tree parser to regular/core.c that =
we can use to specify this delay specifically for this regulator?
Also, what delay should we choose to make sure it works all the time and =
not just 99 out of 100 times?

Best,
Christian

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c4d844ffad7a..0e15ec2548f4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1483,6 +1483,11 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
                          "IC does not support requested over voltage =
limits\n");
        }
=20
+if(!strncmp(rdev_get_name(rdev),"vcc3v0_sd",sizeof("vcc3v0_sd"))) {
+       rdev_err(rdev, "DELAY: %s\n", rdev_get_name(rdev));
+       mdelay(500);
+}
+
        if (rdev->constraints->under_voltage_detection)
                ret =3D handle_notify_limits(rdev,
                                           =
ops->set_under_voltage_protection,


