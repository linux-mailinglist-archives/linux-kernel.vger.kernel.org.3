Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD1465960
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353697AbhLAWj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353647AbhLAWje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:39:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79649C061757;
        Wed,  1 Dec 2021 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S8wvWAQX439S3fpNTLU5TR3BBnKBwJG32nxaxrKWcXg=; b=ni3JerVhYsVluiXVTfNTBGrEpX
        fNfQMfk/UEva13D2Vi4y+OkTKhCV2y26uTm+F9fVPTpRrHh4zykali3ZQBkxCUA/QUQT+vlXa0UT9
        n0c35/hHOXbIC568TSdA80Ll+Ip6ebVh7EryvDAe9+zsOCGaG4ezHzfNDWs7VnlhqQLw=;
Received: from p200300ccff1410001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff14:1000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1msYCm-0004iY-AZ; Wed, 01 Dec 2021 23:36:00 +0100
Date:   Wed, 1 Dec 2021 23:35:59 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v15 1/8] dt-bindings: mfd: Initial commit of
 silergy,sy7636a.yaml
Message-ID: <20211201233559.3bc64f8b@aktux>
In-Reply-To: <CAKmqyKO-KUhfeeOTFtMzLrZ5MUiL2-5qov-g+VYZxC_8du=ksA@mail.gmail.com>
References: <20211110122948.188683-1-alistair@alistair23.me>
        <20211110122948.188683-2-alistair@alistair23.me>
        <20211117223950.3a7eaf7a@aktux>
        <CAKmqyKP_gQ1qSADMPwmyf-V0TqGOYf2GitzpDXsmBUO6_iqK7Q@mail.gmail.com>
        <20211125235935.5a1b7d33@aktux>
        <CAKmqyKO-KUhfeeOTFtMzLrZ5MUiL2-5qov-g+VYZxC_8du=ksA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[...]
> > > This is a vcom in the sense of voltage for compensation. We just
> > > currently don't support setting the vcom.
> > >
> > > I had a look at the Kobo code and this is similar to
> > > https://github.com/akemnade/linux/blob/kobo/epdc-pmic-5.15/drivers/regulator/sy7636-regulator.c#L614
> > >
> > > So I think that vcom is still the appropriate name for this.
> > >  
> > seems that you did not get me. If I understand the code behind it
> > correctly, it turns on all power rails (the +-15V stuff, VEE and so on)
> > with the defined delays, not just vcom because it sets
> > SY7636A_OPERATION_MODE_CRL_ONOFF. Controlling VCOM separately is possible
> > by using SY7636A_OPERATION_MODE_CRL_VCOMCTL in combintion with a
> > vcom_en gpio.
> >
> > I do not see a reason to turn on vcom only without the other higher
> > voltage rails, so the behaviour is not necessarily wrong but if I read
> > the binding documentation I would expect that just vcom is turned on.
> > That is the mismatch I am talking about.  
> 
> Ah! Ok I understand. I'll rename it to vdd then.
> 
Most important is IMHO some human-readable description in the bindings
document.

I am also just wondering whether this kind of logical
regulator which turns on several other regulators is actually accepted
or just slipped through review. I have no strong opinion here. I just
want to be able to clean up the tps65185 driver in the same way and not
having two similar pmics with different bindings and then a mess at the
consumer side. 

Regards,
Andreas
