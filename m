Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67E34A2D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiA2JXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiA2JXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:23:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884DEC06173B;
        Sat, 29 Jan 2022 01:23:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a28so16502970lfl.7;
        Sat, 29 Jan 2022 01:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KVPWNoQrOh4gwIS/NTKfwX1pCCKtfusbVveEiycdTlA=;
        b=DMKpx/mOMfOI21feRiUbT2oeVdaTx0RfWxyiFQ2n5jAFIdjM+oaXTaAWOTF51h8lIt
         EfCy8DZfnipXO8aRfg0Mp/Y/DjwkUY3kjMzpyh3LhL7emtVBR7jykxnh9KuyyXu+IVzo
         +Uv+hRCF2HBbvSkvq1KbPU4KnQotY2tyU8EVZdjGW4vNrC/aXsFj8v4RKWA1bAAqY7/i
         V2GDPndsnk0wdqVwuogA7Uf8+TfDu7G4kdc3n4ksVQStfs7elj3cdb+Af92cwJuDqUCa
         E67uootxFouyYc2Y3LyprLnGvamc+q6i/Jx0IbmUFkmG+vGEWG4ZJBJSGSrxIRWng7kM
         0gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KVPWNoQrOh4gwIS/NTKfwX1pCCKtfusbVveEiycdTlA=;
        b=Pduayh2X+wLC+1M0LO/qTliA5JVcxBzVQc2glsoUpQxxFUi2ziPkr3zeoHgrIT/cQH
         6NqEtQ4TK75XOCH907C+Cm+1dxXv2WeSB3UkVwaPwSoHsfCtcHtphT7yDn89jeIZJSNB
         SI33fxvnS7BRytmU6bdVmRogmfGi7B9DJeUw3nv2a5BcRcdIdq0m9/1cnBSZGKWyIt6e
         9PDwsnwn+yeTn352kf27/XX6RRnWHtYdzt5q9hxlEy5QwE+mMmG7Ui1xfLa7O9hb7RpQ
         s038DhrYYmqdUCqq/vEcdY9UTn7hPzuSAu7XNs3UXGWPxZ2ZaG79gPBX1mQRfYIWiAik
         nB4Q==
X-Gm-Message-State: AOAM53328oqGAGrmWQeGqC1eXrwYBnF04Z3zvfu14B5wMdqEKaZSowGT
        cA3YHB6WuKF24TsA0YTk1l75GSpQHAcbsQ==
X-Google-Smtp-Source: ABdhPJyaLcKoXoj1+6kWfERTDb9i4r4ZTSXhTaGOw5RGwBC3tS/TconpSBW3IKUr+gPuifjgzU+3Ow==
X-Received: by 2002:a05:6512:33d1:: with SMTP id d17mr1232439lfg.455.1643448199773;
        Sat, 29 Jan 2022 01:23:19 -0800 (PST)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id u15sm658935lfq.107.2022.01.29.01.23.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jan 2022 01:23:19 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rename and sort the rk356x usb2
 phy handles
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAMdYzYpkXdXDST+N8dEn7UvibXmytwNeJ+KZ9bn9Oq+RJuSaeQ@mail.gmail.com>
Date:   Sat, 29 Jan 2022 10:23:18 +0100
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBB7C392-C5E0-4E34-AC17-5323414623F5@gmail.com>
References: <20220127190456.2195527-1-michael.riesch@wolfvision.net>
 <CAMdYzYpkXdXDST+N8dEn7UvibXmytwNeJ+KZ9bn9Oq+RJuSaeQ@mail.gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>=20
> Good Evening,
>=20
> While I'm not against this idea, my main concern still stands.
> I spent a great deal of thought on this, and decided to go the route I
> did to maintain consistency with previous generations.
> As such, I see one of three paths here:
> - Pull this patch only and depart rk356x from previous SoCs.
> - Do the same for previous SoCs to maintain consistency.
> - Drop this patch to maintain consistency with previous SoCs.
>=20
> I ask that others weigh in here, as offline discussion has produced
> mixed results already.

just pure user perspective

(who spent last weeks considerable time to develop DT for rk3566 tvbox. =
99% of my work was by reading/learning from other boards existing DT's. =
Any inconsistencies in DTs makes work for such ppl like me much more =
harder):

For option 1 - i don't see value
For option 2 - what is reward for extra work needs to be done on all =
other SoCs?

so option 3 seems to be natural choice...

in other words:

for me:
option 1 brings practically zero value + increased inconsistency.
option 2: extra work - but consistency is like in option 3 (so where is =
value?)

so option 3 offers the same consistency - but without extra work...
=20
just my 0.02$

=20=
