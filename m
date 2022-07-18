Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB556578C63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbiGRVEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiGRVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:04:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DDC2668
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:04:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r6so17027382edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=lgYxQ6VDW00cU97BocyveA5Xw2LA05J8ZBbZjuEjBbs=;
        b=ysRZ20nSv1AY8vsUIYaB1KCb7Q30mE3E6K7n7d95wId/RdkNd+qdCO7zLW56+1lhQx
         FMAM3HJmvHH/obQ6GgmbKtJC5GXi2HgDaNV6K344sLUkdnRiGUnYNHG8msV+0ACStmvf
         p8Il0CHFw8LAeE8GpBIH6v9wj8AdFvCoamt3z45quczVKBP0WAzHocSWT5duzbo33hoP
         Xj+nasYNkfyWb2VkRfgNNq5R0v9Y4cUzdKTVhK4HCIhxA1y0eNXu6RRzhwNHhzbEpsVB
         +QevqZ4FAxbXohECqUjQJWRr/f+73oGlYrgrVKbUFRRNGFl6aBOzivd7IZmAufOh1GMx
         o6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=lgYxQ6VDW00cU97BocyveA5Xw2LA05J8ZBbZjuEjBbs=;
        b=pLEtKU+98UNA1K5di2kMaUKUFLDcPSQ0h4glhp8WTluuemP17qWvslRRTUHrxj2xv/
         rcX4WolxLgFl1VVXUzyt7ntylH9WbNvbhVic3cp8wSUe1ZI+/erVW3YuxMHV5QICc5bK
         3a7ZzQhqFt38iGsOPUGL/MOPQm1j6EugrG0GtJxfF73WUt2A+CmQ+6KkKOZRZmz4G90u
         NO1eW7ka5kcqOmdJAg4Fne8cQvTFA3+3IDPCpbzKe2LKzrzhZFSJUxflWOoeMVaMHJKB
         KG4HN9NemC4DX7OgZn3LgU3SeOwwn5raIQyeTEGQIl66L/5up7TWMN3zCvAiH48BAxPI
         PUJQ==
X-Gm-Message-State: AJIora9WIaFhdENt8Fywpy8YWbbdDLYdPItl0hfUo+2XJx4z25OZBIZ5
        tbZDO/kyeJxSHu2N6Jdnbf+LCw==
X-Google-Smtp-Source: AGRyM1uMAGPcbJs10DHZgwCacO7JwWJg0/uGhTxHr3qyP+y4XQdgLemNimWtsQu4TGNXOnTXmYe6Bg==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr40569237eda.134.1658178284768;
        Mon, 18 Jul 2022 14:04:44 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id sa42-20020a1709076d2a00b007081282cbd8sm5885440ejc.76.2022.07.18.14.04.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 14:04:44 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v6] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
Date:   Mon, 18 Jul 2022 23:04:43 +0200
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
 <C153DF3B-C5F7-42E5-8A86-D9193578C96A@kohlschutter.com>
To:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
In-Reply-To: <C153DF3B-C5F7-42E5-8A86-D9193578C96A@kohlschutter.com>
Message-Id: <38DFE34C-E4A5-4DBB-AC57-5D92D703B877@kohlschutter.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.07.2022 um 14:05 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>=20
>> Am 18.07.2022 um 14:04 schrieb Christian Kohlsch=C3=BCtter =
<christian@kohlschutter.com>:
>>=20
>> mmc/SD-card initialization may fail on NanoPi R4S with
>> "mmc1: problem reading SD Status register" /
>> "mmc1: error -110 whilst initialising SD card"
>> either on cold boot or after a reboot.
> ...
> Walking back on my claim in the commit message that no further patches =
are needed for the u-boot integration to work.
> Other than that, the actual patch is unchanged.

I can no longer verify that the v6 patch actually increases use_count to =
2.

At this point, I don't have a purely device tree-based fix that works =
reliably, therefore necessitating the code changes in regulator/core.c.
If anyone of you knows a way to reliably increase vcc3v0_sd's use_count =
("cat /sys/kernel/debug/regulator/vcc3v0_sd/use_count") to at least 2, =
then we can remove the regulator-always-on statement.

