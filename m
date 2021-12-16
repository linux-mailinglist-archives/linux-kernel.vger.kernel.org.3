Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD36477389
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhLPNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhLPNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:49:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB796C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:49:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso1770014wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 05:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3LQ3OmAQD9kzIVzbdsxECsWSS2pGDKwJ8pVBtgMaI2c=;
        b=miXBZ27ePAY3Phek81QCN2DvuJ95HPOphUuaLslf3DLF75CkR3Q7ETq3976wiRwWva
         s/PC2FYhV2jKtYQ5z01F0cKm9xNoHbsuHdDkYsuwA9NP1oFwmlaQMFBHvU8ry3GUIdmd
         2PVyBo+ad7OGMzsmzV3i+6mUOAaOEG3zsMH/1M+oS3Hnv5NN7xs82E3YFP4O1dh/vmND
         19NtpPbWqksbarXXYggzq8ip2tDL6PnU8JQoHYVQzRzeEueUjLqMCmVM5ovv7jFgEiHT
         QNQAYm74EK5rm4gNju/+/JIdoM4fbxUuVf1FEIGTMy/7Heb4hFvDr2Mpbo+7vqpIYXL1
         tCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3LQ3OmAQD9kzIVzbdsxECsWSS2pGDKwJ8pVBtgMaI2c=;
        b=HHNJ9tD5lJvqU/sy2rRbSYPP1mdnnvQ5Xu1hf0iRAt+EhAzvUpZHFL0Rwx8XqCVVEF
         ET5zBwZnFgNQ1qe0v/LSTxuQp0RmCwnccNA6ZJVnmPrKX+gzweMUnQL4Mdn072MFdRPa
         +JPSMCSqVP8LYsfEGbp8KVKQ+NkeZUVI0XH8XBwfazxQkyjBrF9w+Cq0cdv5qsWH13S3
         laEXcF9TmTxgdnOnLCJK7ScVz4YLVkXvpauHb9DRdXoamtHJ7bLW9ZbZqxNni0CyMtJy
         vgzwFQ4NdiZ9WZKBQh5LAKb7ESYne7MT/QKQfnfD5GFPjCNqbydOtcLgCa6P7+6mSJB7
         /cbQ==
X-Gm-Message-State: AOAM531k5aUNCpI4I/XsQ7sCqkNLDKZ1LRwvkVz6iWnahmM5/NVZE4Sn
        CmfUsPGWjeg4mjTCgSvCzDj7Fg==
X-Google-Smtp-Source: ABdhPJzTl39YAx8e+eYpdbxrlhfmg4gpX+V0JbvxbDfgImCQ6CC4+8BmH5IcY00rEfyCQVmZ3xYvog==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr5170891wmc.56.1639662577472;
        Thu, 16 Dec 2021 05:49:37 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id t11sm4660401wrz.97.2021.12.16.05.49.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 05:49:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
Date:   Thu, 16 Dec 2021 13:49:35 +0000
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC1B38E7-1170-4C05-948A-D18E80AC49E7@jrtc27.com>
References: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Dec 2021, at 12:35, Heinrich Schuchardt =
<heinrich.schuchardt@canonical.com> wrote:
>=20
> The SBI 0.1 specification is obsolete. The current version is 0.3.
> Hence we should not rely by default on SBI 0.1 being implemented.

It=E2=80=99s what BBL implements, and some people are still using it,
especially given early hardware shipped before OpenSBI grew in
popularity.

Jess

