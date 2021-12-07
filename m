Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7193446BF18
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhLGPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhLGPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:20:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70183C061574;
        Tue,  7 Dec 2021 07:17:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3300EB81827;
        Tue,  7 Dec 2021 15:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EC4C341C8;
        Tue,  7 Dec 2021 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638890238;
        bh=apVygb3YBJjJ1BswG3ZV0iV1RWPPJX6r3D9/1JkU4GI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PDJi/3JpoaGMtuea5qVejAwh+InG0ehFab46qgFw6a8tUVYyWFt4uy3ISV6XtSRYW
         ZWGmRbAr5u3VTlszUTNqYNXXCJXnGA6TBfggAEIJ1GKGBnmLTFglsJZDhQlcd5J0sX
         cEhMVJ2j0HNkR0sDNrATRh1UQav80rgtSjEkIrjAI0R7gVL9lQSK3Bvw3eRWsVgRMN
         ZLtigOKPdBulLyu1XhqYEE7eIeSmSse8ov2x95UhLNdLicSvvlfUBfQEsQ7mWbwJsC
         ZyLL7yMNCpEDjNtUdGNxRsq4ZtimLhn2UsvLcLowiypFXvJtLoSv9XDUsOQi4Ak4AN
         edujcFNwTcaFQ==
Received: by mail-ed1-f48.google.com with SMTP id w1so58194193edc.6;
        Tue, 07 Dec 2021 07:17:18 -0800 (PST)
X-Gm-Message-State: AOAM532jouO1HCDQ2es4Wx4aUlJWmnl55mFwnsMfEpNu4o4pcz3rnZsn
        /frZM8WR1flWsr2idnNTwbesXl4XOrejISL42Q==
X-Google-Smtp-Source: ABdhPJy7ilh8ksq4wHTJgpuxuW0TufUgvX+Mp+mQrVZgt9726uFad+w63v96wL5C7jGeqm1A3dl6a6Z6GMKVz87Un84=
X-Received: by 2002:a17:906:5e14:: with SMTP id n20mr29787eju.466.1638890235978;
 Tue, 07 Dec 2021 07:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20211202063216.24439-1-zajec5@gmail.com> <CAL_JsqL=4iUJjQXjGc7eacbYW5YE-VRC4yGhu8pLVd-zUKvhHQ@mail.gmail.com>
 <c2afe6fe-d4d2-c9c3-eb36-90969a0b657d@gmail.com>
In-Reply-To: <c2afe6fe-d4d2-c9c3-eb36-90969a0b657d@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Dec 2021 09:17:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzv4GLN8bmskKcA6HE+6nqDwOz=1oGW+z7r6joBFjKLA@mail.gmail.com>
Message-ID: <CAL_JsqKzv4GLN8bmskKcA6HE+6nqDwOz=1oGW+z7r6joBFjKLA@mail.gmail.com>
Subject: Re: [PATCH REBASE] dt-bindings: pinctrl: use pinctrl.yaml
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 2:47 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> w=
rote:
>
> On 06.12.2021 23:50, Rob Herring wrote:
> > On Thu, Dec 2, 2021 at 12:32 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.c=
om> wrote:
> >>
> >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >>
> >> Also fix some examples to avoid warnings like:
> >> brcm,ns-pinmux.example.dt.yaml: pin-controller@1800c1c0: $nodename:0: =
'pin-controller@1800c1c0' does not match '^pinctrl|pinmux@[0-9a-f]+$'
> >
> > I think you missed some. linux-next now has these warnings:
>
> Oops, sorry, I think I didn't test MFD bindings *after* modifying
> pinctrl bindings.
>
>
> > /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/cirru=
s,madera.example.dt.yaml:
> > codec@1a: $nodename:0: 'codec@1a' does not match
> > '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
> >  From schema: /builds/robherring/linux-dt/Documentation/devicetree/bind=
ings/mfd/cirrus,madera.yaml
>
> I'm not sure how to deal with this one. If you take a look at
> cirrus,madera.yaml it seems to be some complex MFD that is a sound
> device with pin controller and regulator.
>
> I'm not sure: is using pinctrl@ node for that hardware is a correct
> choice?

No, I think you have to drop specifying the node name.

Rob
