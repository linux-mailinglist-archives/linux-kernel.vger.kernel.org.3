Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF64D4A4988
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbiAaOnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiAaOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:43:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43FC061714;
        Mon, 31 Jan 2022 06:43:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37B42B82B51;
        Mon, 31 Jan 2022 14:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED7C340EF;
        Mon, 31 Jan 2022 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643640211;
        bh=Dc2kmj5FEF7ZvGlDWBocizPOtVYI8Jgd1WaLXdhVm3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cFbtXvfLNaStxS8qjhGd98F/ZjphPTgGnOQ3nRrg/7033xnnM//aci+hP62mH/lm9
         gpCIiH4Jm3OQv1xFN6HX+VmioT2nZFUU7ETIsqtDpKFt+nmm4BqoFYipUoVvaIcLTN
         eGKJHGcGMlrrh9Hmw6tBz9spvafiocPacEuCtTjIFY5YY75MZjK0nbXiwb1kvQ/egK
         nd/8RumfNucD8gB4x4BcF9BRskAe9/rEIVdDg70sX7aiGo/fyhfaQ95cipFNor+Uu+
         JcClYBCl+h1obdnojWVB/UPbOq9M8bhypwE8IsR40g4BXK4ZILlTmbDVAglMSgf45C
         eaIkuQf0utBgg==
Received: by mail-ej1-f45.google.com with SMTP id m4so43814649ejb.9;
        Mon, 31 Jan 2022 06:43:30 -0800 (PST)
X-Gm-Message-State: AOAM531esLgkrTUqevqivqjg2KhzQEEVmCGsuo2R7KuFCD1wKdRB2U5u
        lX8U1tOAkm3MeddHXFMaIOgckSc7Zvrfc6KO2A==
X-Google-Smtp-Source: ABdhPJyrzmFyw/iiA9KfsoPfSGgHphTiZm35NmQr1nLK73qQnYOxSNF9JG9gj+sqmumUj1F6lshbu0u0qIAttsjhANw=
X-Received: by 2002:a17:907:213c:: with SMTP id qo28mr17914216ejb.325.1643640209327;
 Mon, 31 Jan 2022 06:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20220131112028.7907-1-t@laumann.xyz>
In-Reply-To: <20220131112028.7907-1-t@laumann.xyz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 31 Jan 2022 08:43:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=OBDgemXxa6vH_t-SVr2JKUGdQ2+VoHTZSodyUiPROQ@mail.gmail.com>
Message-ID: <CAL_JsqJ=OBDgemXxa6vH_t-SVr2JKUGdQ2+VoHTZSodyUiPROQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Call pkg-config POSIXly correct
To:     Thomas Bracht Laumann Jespersen <t@laumann.xyz>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 5:20 AM Thomas Bracht Laumann Jespersen
<t@laumann.xyz> wrote:
>
> Running with POSIXLY_CORRECT=1 in the environment the scripts/dtc build
> fails, because pkg-config doesn't output anything when the flags come
> after the arguments.
>
> Fixes: f8d8b46cd20e ("scripts/dtc: use pkg-config to include <yaml.h> in non-standard path")

It's actually 067c650c456e ("dtc: Use pkg-config to locate libyaml")
that you are fixing.

I can fix when applying.

Rob
