Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE3146998C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbhLFO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244997AbhLFO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:57:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DFFC061746;
        Mon,  6 Dec 2021 06:54:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y12so43779723eda.12;
        Mon, 06 Dec 2021 06:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LW1BYGyD1FrsuN8OaH1EYpOJNibso1Z40XxZHZPtTn4=;
        b=GyaohrZqlHknwgP8z1/U81lrjK6R1xtFKBXnuAzjdMx2z0snNBUcYlS9b27tzMWZ6c
         In5aLO/mv+KzQZo8L64KbgWWLTYExi6j4HU7DdKSoKjifsXJUekm8DMMNj/fvUicAPtN
         DrMOO2UrprHt2B8evbHNi2+xg6MrjrPoTtGjs33Z3ND8B7jCMkkxSbt5Veglif7zvHZe
         TvVk62MACV/RG+9iQdzYuy+j+C+jOUmZKa7AxNBpl4ZRaUkHSrXJaiie7pJQvzY/Df81
         gDIM4ay9mJPmoqZP+89OReek5V9OWLYdGbJt9i4axnQS55LuouiwN8lIH2bm06Y1eQjz
         IDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LW1BYGyD1FrsuN8OaH1EYpOJNibso1Z40XxZHZPtTn4=;
        b=nNfj2pz/dUYLWbyXrw4pRZUK22BDX77IWj2BPYREAEzuXG4QR6pitqknXcBNDzGoHt
         sjrYy+OBtgu+RrziO+3gFTF5zc0i5mxtFZAFszgYuElu1pjzt+ITqWqGqIXMuY8xbbwl
         3TGtymAH+Zl4gEHdcbDgbH4rfJSY3/tF+MYMWSRL5pC4kObsK9NZJES9yyDQqy9RwPtc
         yqA61mpZYKID7CFUbBCpCIcJPFPY/76iWOvU//IzdCJCJ5+D7eO0Gnk10RkV0GTqGxoR
         UPtjZoQzHbxCF/N2E/OiKbIyQhu3PrOs2+lwCFW1d8QuI4iMgMA7ebldZgbHPACjFvpS
         wrrg==
X-Gm-Message-State: AOAM531BCZwLIN1ZPcRPomsHHBAeeKTCA1aVIaEaYd21q+64izoMzfTx
        Kf15ZkN8LHZA6xE14OdZAOxtdH2iCzIo931W+KxMEv16
X-Google-Smtp-Source: ABdhPJy8zsn0hmEb/oqWd5Cknlc3dy5ENqov/JpF1U5cDxLUqIH++Z4sEpXmxtE1qyu0UtY0jdZfRYMFcV8lyENVMN0=
X-Received: by 2002:a17:906:d930:: with SMTP id rn16mr48020240ejb.223.1638802462900;
 Mon, 06 Dec 2021 06:54:22 -0800 (PST)
MIME-Version: 1.0
References: <202112061855.SidQyicE-lkp@intel.com> <20211206142601.373807-1-michal.vokac@ysoft.com>
In-Reply-To: <20211206142601.373807-1-michal.vokac@ysoft.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 6 Dec 2021 11:54:11 -0300
Message-ID: <CAOMZO5AByeyYZ89gBSNtcJaJ68Dz_K4J5+eVwRrbn5AP5VMeSQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Remove not-yet added support for
 sound from Crux
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:26 AM Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.=
com> wrote:
>
> Remove mistakingly added support for audio codec. We support the coded
> by our downstream patches but the appropriate driver and bindings are not
> in mainline yet.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: a4d744ac2bab ("ARM: dts: imx6dl-yapp4: Add Y Soft IOTA Crux/Crux+ =
board")
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
