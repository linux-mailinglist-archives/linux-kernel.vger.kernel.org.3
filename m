Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBD578190
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiGRMFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiGRMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:05:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A423BD6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:05:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v12so14921977edc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=2m7X8qnGvOPuB/k/gxIxFRz8uurz7Jjf68vIvwEBn7Q=;
        b=Ke+92ZUe1d3U0vcqv2StxR5LSom8LxOe8Jjn5QPMp/ubNsOrsKZHd9aXw3ymNB9k8R
         /wJ4NvzBNWHuVL0q/DvHUheNzmZUhnUYUE4cPvKotRXEZ2+uHlLriyHYeJPa79Gt19rx
         6KumcLnruu+qEbdI/miGn7Ueq+caxxUw9Pwd+QKspxMiY/ZowI65OFxPTP8wxaujE3B2
         qmKpNoJ3f1OPNGnTgarHWRnm/HVgvhNVqImVGVnSH+NZ/TX4CoaJ/dDntrf51SJI0JfP
         +6EiQn5tx2+1mFNRn/zdNPgDlHfNZT3V/SaUtgMZhhlTox9YYb+PwKETFfMLWfRL4XmY
         NxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=2m7X8qnGvOPuB/k/gxIxFRz8uurz7Jjf68vIvwEBn7Q=;
        b=qQ+FNKUHOsZATGyfoV5x+1+8lxlVlop+FfL4MkJ05xFWRTrhW9G6S5kWvlE8lF0Iy1
         fplTd2AZDuRcIznr8Q1Kb5fAcDOX+QArNkHxo0ZgxM/bivwB05JPLeL692ojWG8bY15U
         HV0KXNxwUZRmEsfIKDMWiABlDy29LFmRwvytVQ3c6oZFRoNAy1FapFZVEPSopsNT5ZvN
         ZjDxfr19H3P66oZ9D0AqPKmoGpiWvJTKUHJqiuAWWCHOs5rXkt2UuvZxZpVBRuYQNneG
         bMbvQUnBwRZlY8Yjiz9aKI+180A2BrBPRF85GNCkDKpi/k82xFuT4PydlAZlOf1TuzTS
         YrfQ==
X-Gm-Message-State: AJIora9ife860qUQ8nB3aZOA1/0+cp4GjLiyIOaBL/ULZMB7G51SVzMC
        OpyV9ovSq2BBUJdUOfSUiaIuLA==
X-Google-Smtp-Source: AGRyM1vWVE2+l8m3UREufbTk+9CTepAs7pbOq24rEV1wo5MvPzLDey20EYw06ryipLk0tnq7niPiJg==
X-Received: by 2002:a05:6402:290a:b0:43a:444e:dca with SMTP id ee10-20020a056402290a00b0043a444e0dcamr36483364edb.355.1658145902239;
        Mon, 18 Jul 2022 05:05:02 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id mb1-20020a170906eb0100b0072aa38d768esm5430355ejb.64.2022.07.18.05.05.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:05:01 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v6] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
Date:   Mon, 18 Jul 2022 14:05:01 +0200
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
 <3912A668-9F73-40FD-8993-5060F632238A@kohlschutter.com>
 <7E830C9F-BB5D-4EFC-B3F4-1C580E9326A3@kohlschutter.com>
 <E5A1A1E7-449F-4161-87B9-7A6CA0CAA42C@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
In-Reply-To: <E5A1A1E7-449F-4161-87B9-7A6CA0CAA42C@kohlschutter.com>
Message-Id: <C153DF3B-C5F7-42E5-8A86-D9193578C96A@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 18.07.2022 um 14:04 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
> mmc/SD-card initialization may fail on NanoPi R4S with
> "mmc1: problem reading SD Status register" /
> "mmc1: error -110 whilst initialising SD card"
> either on cold boot or after a reboot.
...
Walking back on my claim in the commit message that no further patches =
are needed for the u-boot integration to work.
Other than that, the actual patch is unchanged.

