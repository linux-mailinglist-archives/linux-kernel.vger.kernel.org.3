Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0024779B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhLPQvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhLPQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:51:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EA8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:51:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q16so4517121wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JNyiABbzSh1geCiJi1HXfzVfSuW/3LT7bKbOspfg3Io=;
        b=IP08B9cjRg3l3tiMqtzsy1+LkMzeYqqFcIgf/QFO6gbrflGDDnx6+9PWZzUQk+Qso2
         A3LTngaUpXJXE5zsmokpwswk+qsAYiDProcjE6t3nsNYyQ9k2SD7SR1BfMKb9N74mWy5
         glzI/HEHBwCt3fBL9uF/2E6UFKIthk64V6r+Ug4NLjP0pdZtWLa+3qUt6f7b5vR7PwNO
         9aWP7ZKgqaNlWjYSlQwIyWm7KGaQghQ55QfzhZnaBJBogks1ccliH+ti1Ct58kSJ791+
         BfFmIgoo5iomFMHzsW5rqociw7+uA2xU+cjnOGtb8W9Nw/cnlbwH64vZuHDuYQggKbAd
         6zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JNyiABbzSh1geCiJi1HXfzVfSuW/3LT7bKbOspfg3Io=;
        b=PGlfCoGrZ3W8S1NgeGJOcEENZLAO4QpSDI6AhzA9idBvFKlxbv6PicSbw1e0dMK/vW
         E0r8kS86nIU3oldAzMkBi15eDCZrqnIkHggtsZ0uZqhSsWGhKFGsoI19ZTMRsDWHH7AA
         6UUxsY6YwM1Rbg2gbMhF9GeyIuACl6ZxYhR3rE1vNf7OZLy2gR/bujbmXLMwEBjIPUy3
         bgbh/+En2X61Kms3vWZE+fVugBE5CONIMtnoC+SpEUfC0x0mMwgpUO9yZ94BBa/fTZsQ
         4UuGjFlqnTer0yUEjqOXo+E9xBITebZejvQmWS/aUIWnxv3MWF7N25Oni7i0uxPdqle6
         ZJ4w==
X-Gm-Message-State: AOAM5306gGsAVbibswPG8KitUEmUUs1sf1yV6jQSP/at1daeLXoaQfGu
        Rwu+hEkgyxLE/TQdeNqhshZzksYHWEZ6HA==
X-Google-Smtp-Source: ABdhPJwM8mGDoUjiTAKpbtdjkv5P7+B0j1Ym/aW/6YMZqlUg2MTlhmRICw/BK8uDkoc6ZTlXbihJaw==
X-Received: by 2002:adf:c182:: with SMTP id x2mr9933874wre.646.1639673489408;
        Thu, 16 Dec 2021 08:51:29 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id u13sm9300804wmq.14.2021.12.16.08.51.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 08:51:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <fd40010f-f2ec-b32a-6850-1e054af43725@canonical.com>
Date:   Thu, 16 Dec 2021 16:51:28 +0000
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <150C4E84-2C69-45DB-AF27-1E0C223D8D7A@jrtc27.com>
References: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
 <BC1B38E7-1170-4C05-948A-D18E80AC49E7@jrtc27.com>
 <fd40010f-f2ec-b32a-6850-1e054af43725@canonical.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Dec 2021, at 14:17, Heinrich Schuchardt =
<heinrich.schuchardt@canonical.com> wrote:
>=20
> On 12/16/21 14:49, Jessica Clarke wrote:
>> On 16 Dec 2021, at 12:35, Heinrich Schuchardt =
<heinrich.schuchardt@canonical.com> wrote:
>>>=20
>>> The SBI 0.1 specification is obsolete. The current version is 0.3.
>>> Hence we should not rely by default on SBI 0.1 being implemented.
>> It=E2=80=99s what BBL implements, and some people are still using it,
>> especially given early hardware shipped before OpenSBI grew in
>> popularity.
>> Jess
>=20
> Do you mean BBL is not developed anymore?
>=20
> Some people may still be using a 0.1 SBI. But that minority stuck on =
an outdated software stack does not justify defaulting to deprecated =
settings in future Linux releases.

BBL is still actively maintained; its most recent commit was 24 days
ago. Also, the amount of code CONFIG_RISCV_SBI_V01 affects is tiny, so
I see no tangible benefit from making this change, just unnecessary
breakage of perfectly functional systems.

Jess

