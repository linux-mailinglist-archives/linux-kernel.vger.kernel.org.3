Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B794B029E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiBJB7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:59:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiBJB7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1F2B6BB;
        Wed,  9 Feb 2022 17:46:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n8so2540555wmk.3;
        Wed, 09 Feb 2022 17:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4hS/S8hMrcbzcsd090a7H7Kvjs/YdvSJTEAtKUvaT0c=;
        b=UPYGrhCeCFm3efuGmjPifYeeiF7tS6LK1qydpI2IDkk1Uyj6ukty8Ilq89fPV6xRU3
         9B/pMZFIo6eJSe3vNfaKlgF8eyd+ddXhQ0ATCCvxbAG1wuizheGGNhDMmj9R87miJYQZ
         WhrcDBc029TwMvUu7wseFf/eDcC+sX6pHoqUM2Y+R1odRKiTtdjl6zDsc8I4KTcrjd7a
         nxM/Tdz3fDGJXvp1B5bnITLrXq5nk+fQYawpVH9SkMFvRZmAaK09WpU8klRnwQsWZmyK
         RxY65xjlwdfRo7vGPWcxVK1FambKB9+nMXBayPjmeMuaDeuMmYHt1/aB5oblhJ2f9iUi
         U0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4hS/S8hMrcbzcsd090a7H7Kvjs/YdvSJTEAtKUvaT0c=;
        b=2akjj/i8wW6knVfp589p3IlRsNA6FhwOlNUpFWyZY4w+seZ6KN3liLQp7OhfXg0QfX
         UnMFgka1HRhm3cq0GtniDeDV8e3rVW6+TRlOIFP0PFtRGRpIJXowSz16UA6mPNtYWZ1p
         YBR1RA6hBJQ8YCfzuajh+3bR3qdJwPSxcOqImLYG0/8Ym0KviuTUhAQljkmFNHudrKqS
         VYc2AhSNlbNQ3zYbV2oBGBKor/8e+i0koQF7YCUB1M9W2AOdGDA9oo4ZMMryaGSirfIe
         8nUEqjRVwZeNcPu7IEHrS9JQjBFljn87kF6wMtfAtqvtRiMiUgY5W8NSFOpaZIj6RBdk
         FaGQ==
X-Gm-Message-State: AOAM532Yldb5gLkd137PxqxMBI0F5oreRs/YDqXdjUKlJfTqsiXmdbgW
        3Ydh4yDCet3Ma4EzXLkvhfdT1cTrNSYswg==
X-Google-Smtp-Source: ABdhPJzmXI7yunJKDvBF1JSvA/wajCekPuYA4bzw3VQ+iAPTNblKmHmXMqrQ0D+M47cMkcmdfDPqkg==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr160081wmq.64.1644457616199;
        Wed, 09 Feb 2022 17:46:56 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id m5sm84571wms.4.2022.02.09.17.46.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 17:46:55 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] arm64: dts: meson: remove CPU opps below 1GHz for
 G12B/SM1
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7h7da3o6cg.fsf@baylibre.com>
Date:   Thu, 10 Feb 2022 05:46:52 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C70293C2-8CE8-42CE-911A-E0CC3DFB82FC@gmail.com>
References: <20220209135535.29547-1-christianshewitt@gmail.com>
 <7h7da3o6cg.fsf@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 10 Feb 2022, at 5:31 am, Kevin Hilman <khilman@baylibre.com> wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> writes:
>=20
>> Amlogic G12B and SM1 devices experience CPU stalls and random board
>> wedges when the system idles and CPU cores clock down to lower opp
>> points. Recent vendor kernels include a change to remove 100-250MHz
>> (with no explanation) [0] but other downstream sources also remove
>> the 500/667MHz points (also with no explanation). Unless 100-667Mhz
>> opps are removed or the CPU governor forced to performance, stalls
>> are observed, so let's remove them an improve stability/uptime.
>=20
> Just curious: what CPUfreq governor do you use by default for the
> LibreELEC kernel?

LE uses ondemand. One of the original clues on the problem us that the
issue isn=E2=80=99t seen in some of the retro-gaming forks on LE's =
codebase
which use the performance governor (and overclocks, etc.)

> Your patch greatly improves the stability I'm seeing, but doesn't =
quite
> elimitate it.
>=20
> I'm testing suspend/resume in a loop on VIM3, and with schedutil
> (default) or ondemand, it eventually hangs.  With either powersave or
> performance it's stable. =20
>=20
> Kevin

