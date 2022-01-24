Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9814985CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbiAXRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiAXRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:05:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D1C06173B;
        Mon, 24 Jan 2022 09:05:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m11so57669202edi.13;
        Mon, 24 Jan 2022 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UW0WvST/0Oa4ZjXuG6POTABmuJiaJNLkhhJeZeOhG78=;
        b=D850RRPva1SwXrxvTF9WZqL6Xs92ThOHEAqe8093T6q70DSgohb3KjzHHMxOiUvs7W
         VoOwpmImmHYhF2Yowp0pNsXZ15hRZ2EugkFVwP2JGvXaNYJAXKIKOOH4aapSlYpd3QW/
         L/7zCLdrLqWZbUqurNLKDH1vZwfogw44uEZ3TolYd3NewrOdiBdiIGQ0IocMe1wAB9n3
         lcmOSrGbSfn4fmlHqAAGtXc/tYl87fv9N4o06LZX0+3pMfwcIAO/swxHpBd3e98oRpAk
         P0FNtzaUtJn0Vw7YiWTRGiYbDf9q3FCyxJAkm8dCnO1KWLeUzaR/gryrKAUkj7fjWT2k
         LKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW0WvST/0Oa4ZjXuG6POTABmuJiaJNLkhhJeZeOhG78=;
        b=3bR1drKkpnQms57Fof+AALF1Wp5wJQeTmzzLQAojjTf404l6yM/MuPbCFou63du/sc
         LO0ITek9GGJE9tsXaJmo6oyo6vCj5j1rGZYwEX1hfJ+zX1x6BtWZviO/Y1FULMUcPMbG
         ekRKmFufHbeceIQsiZCRycEXTfWZ4nHRStwAXK/cX9p0mKkNREHYr8Y+y+h/7Q98UYfV
         LDRkZq653ZyGwcBfhSRt8cotZJ63QBRiRbSVdtTRJhfAOaVVqzBgkRNNNjlcaK+MV8Bv
         7RFvQHZZDew5ndKj3N1+Sh+hTlgIid9hrF54b5B7G/Nex2GPI/jvfuGWK6PcDVmv/dLX
         SLkA==
X-Gm-Message-State: AOAM5307nyPcqj6xHAvyY+Nyb5m7wQGHpgdtkjFm/mi4gtmeJKJOoizK
        GxJo6QpBtPHzTcMxr3LddJrPpRoDPMwctIzDsek=
X-Google-Smtp-Source: ABdhPJwZBDsfiV38aRjijP5Fo5LDP5lt2TDVBLzwDO2annMP5B+E4KvN1YsJw7ihfURZlZZFVMP6MqBEVbuYP1ZlP9s=
X-Received: by 2002:a05:6402:350f:: with SMTP id b15mr16695962edd.77.1643043955928;
 Mon, 24 Jan 2022 09:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20211220072332.81072-1-reinhold.mueller@emtrion.com>
 <20211220072332.81072-3-reinhold.mueller@emtrion.com> <CAOMZO5BvLZYh3=q_-XNcw-v5wDcBpR3Qo26Gd3hTtJ_a-FQiuA@mail.gmail.com>
 <e6adf5d9473e417d85a1845b007a4ee1@emtrion.de>
In-Reply-To: <e6adf5d9473e417d85a1845b007a4ee1@emtrion.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Jan 2022 14:05:44 -0300
Message-ID: <CAOMZO5AwwEZHxbw4jvuewn80dCOe3VerO4mDsa_qNNabVn9Srg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
To:     "Mueller, Reinhold" <Reinhold.Mueller@emtrion.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinhold,

On Tue, Dec 21, 2021 at 4:33 AM Mueller, Reinhold
<Reinhold.Mueller@emtrion.de> wrote:

> Yes, of course the emCON provides a connector connecting two slaves on the spi bus.

In this case, then please pass gpio5 13 to the cs-gpios property too.
