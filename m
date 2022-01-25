Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259F249ABF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiAYFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiAYFnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:43:11 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB808C0613AF;
        Mon, 24 Jan 2022 20:03:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h10so60312wmh.4;
        Mon, 24 Jan 2022 20:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C3FYe6TcjYjJbJdwbX6OqfjeFpVDE2oMdSSX3Pq1Ukk=;
        b=pKcHkaFv8cJewfXGxbaoexn8ygvz6aAsVsgb9im1bfgH1/UQPgeCfqahJ2dR2Jd6hw
         AOgIxBugel8w8NhNgNGUc96a62L5XLi7ClRbyVQaZ/sWNJTCZIFAWX3weKU8H0yMhADj
         GshQQfTaDIR+ZlBSv64qpiXbAhGVgFWhYXgI1NfaxBLlAfZYrCChvz7mNWx8KV61CCBN
         oipUOMRVHvtv4shz3+ZU5vVYSz283rDSviTI8EVMkwsiULDNG+eCrrZhNHOmOIOsMsrK
         ISx+Ta2LMa0Eh2OF2o+sGHLDFeQv4ktn5kAjzEIZJGfbHqgi10b/wM+h1LpOutSeBVLN
         rghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C3FYe6TcjYjJbJdwbX6OqfjeFpVDE2oMdSSX3Pq1Ukk=;
        b=pcio16Ww+L0DZKc+O6hwKqRlTUhl1byC78D9FPewjLNks1ojDHsG9x6iloAFcfTAh1
         vRFV2s5zsZaOIK1+yH/RVBlWy2FUX4ASiR+KsLVuxVsuypBZD+H2aOCjRVetquaQg0LW
         oTvYilpr7tMapfNI0Wkxgx6ZozQ/ZxXfWKjeJeoqT8a1P7tNsc2GHEEGvN0CLbX+Ynjr
         DyegoWSde+frn35KJeDWRnB2e+60sS9wbb7BwIMiZ5PCplUUOfdwjlEJ52ZHjlUlV2ut
         qln5U0JfP/aE8R8RmSZdu3IT6z2/0//zpprg7jr+BtDKbENz5trVwCWfg/0psirIG6Ze
         pEmQ==
X-Gm-Message-State: AOAM530t+8zPFH0Xzm01ES00c8ZDsySXpBRDP1oATRsMXkvsgDDdhrCP
        lJPPumIj/Ycf4Frea5HV54s=
X-Google-Smtp-Source: ABdhPJw35D0LrxgrZWlhbeSpwAo2a4wXCmg7DUqpptX4Hs+orfcpR6co5iihxpSUNgAQICwdVQ+zVQ==
X-Received: by 2002:a05:600c:3797:: with SMTP id o23mr1116133wmr.158.1643083392066;
        Mon, 24 Jan 2022 20:03:12 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id z1sm1039020wma.20.2022.01.24.20.03.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jan 2022 20:03:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 0/3] arm64: dts: meson: add BL32 reserved region to
 Beelink g12b devices
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7h7daoyka3.fsf@baylibre.com>
Date:   Tue, 25 Jan 2022 08:03:09 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Furkan Kardame <furkan@fkardame.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A7E4C5F-AECB-4A3E-B074-E2E3419DD749@gmail.com>
References: <20220122073221.2398-1-christianshewitt@gmail.com>
 <7h7daoyka3.fsf@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On 25 Jan 2022, at 12:02 am, Kevin Hilman <khilman@baylibre.com> =
wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> writes:
>=20
>> This resolves a long-running issue where Beelink GT-King/Pro and
>> GS-King-X wedge on boot or shortly after when booting from vendor
>> u-boot. In some distros the issue is often reported as triggered
>> by large file transfers to/from USB or SD cards. Reserving the
>> BL32 memory region prevents the issue.
>=20
> The BL32 is typically common for the SoC family, so this change should
> probably go into the g12b.dtsi.  Or probably even
> meson-g12-common.dtsi, which is where the BL31 reserved-memory is
> described.

Hi Kevin,

Would you be okay with the same change applied to GX devices too? - I
normally have these two catch-all patches in my tree to deal with random
tv box hardware and it would be great to drop them:

=
https://github.com/chewitt/linux/commit/4315ea4612389fc08d0a008b562cafbda9=
6374fc
=
https://github.com/chewitt/linux/commit/3c0df794baa7ea9d32d8ad54530b5a056c=
770ea9

Christian=
