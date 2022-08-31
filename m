Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9392A5A86A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiHaTUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiHaTUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530F62ED;
        Wed, 31 Aug 2022 12:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD84611FA;
        Wed, 31 Aug 2022 19:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2763C433D7;
        Wed, 31 Aug 2022 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661973591;
        bh=r+HznmHXw3gavTH0Dr+yt0GsD2O1YnzfLJskA7pG3uE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sonMcGw2dQPiWuPRDZ5tpYPQNz4xAHX5DNOAcGUgbSkMbz80C4wZJuW9PjupnZ0KA
         qED0WQZ2y0Z2dIVMG7016yt8an2uhjGSKFeRy1HYTY0nHsn5qESexPj7SdphBmg4Tm
         Jx6grKQqoXyAQe6gYCl37dufl9RQ0b3GcsF8YzNnrhLV5QxQQODC6RPTAcPlCxSJf0
         WqbpDuRbqOHq3QYbmP5+ZGSHBwTtMsZmV5mBxP7IQynU6v0OGUJD/C9maNSXAUVuMV
         TxPPkcBagk3WF0vsSuGhCfREQT13MxZ8DBPpOQEuEyTB57Pqc4A9Cnkk09+a1uNXr9
         iV5UxU5jL/MaQ==
Received: by mail-vs1-f48.google.com with SMTP id 190so15556380vsz.7;
        Wed, 31 Aug 2022 12:19:50 -0700 (PDT)
X-Gm-Message-State: ACgBeo3I/uJ891RLVffHCAZ3npsHMOI12WdAPCkT8otc3Rl8V5/cKwZ6
        0DqTP1O9B7vSigVlCstZliTrhaQqGo9GQI3aDQ==
X-Google-Smtp-Source: AA6agR5jWVIyRa/qScOSs9F7SeTpXFOXzirSpcbRPicKznDUMtojYDvATZwEp0prM/DiOSMHo+Ae3PYRaeaTH1wvAY4=
X-Received: by 2002:a67:b009:0:b0:38a:e0f2:4108 with SMTP id
 z9-20020a67b009000000b0038ae0f24108mr7539745vse.9.1661973589857; Wed, 31 Aug
 2022 12:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220830192212.28570-1-farbere@amazon.com> <20220830192212.28570-9-farbere@amazon.com>
 <1661945961.480039.3614528.nullmailer@robh.at.kernel.org> <a8557b5a-6e27-2e66-161e-814fc0f69c1d@amazon.com>
 <CAL_Jsq+c7DaJFCgeHDsXQT8oqHmPS57S-o_EALz=nHDREhqc7g@mail.gmail.com> <2508ecda-cfd2-96ba-a802-47d25f225dd0@amazon.com>
In-Reply-To: <2508ecda-cfd2-96ba-a802-47d25f225dd0@amazon.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Aug 2022 14:19:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+G4afxQ3mDBZQf_d-=twwM9-qRh0Y6ROByo+ti4tk6Pg@mail.gmail.com>
Message-ID: <CAL_Jsq+G4afxQ3mDBZQf_d-=twwM9-qRh0Y6ROByo+ti4tk6Pg@mail.gmail.com>
Subject: Re: [PATCH v3 08/19] dt-bindings: hwmon: (mr75203) add "moortec,
 vm-active-channels" property
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     almogbs@amazon.com, Rahul Tanwar <rtanwar@maxlinear.com>,
        Talel Shenhar <talel@amazon.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        itamark@amazon.com, amitlavi@amazon.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, shellykz@amazon.com,
        Jean Delvare <jdelvare@suse.com>, shorer@amazon.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, dkl@amazon.com,
        "Hanoch, Uri" <hanochu@amazon.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:48 PM Farber, Eliav <farbere@amazon.com> wrote:
>
> On 8/31/2022 3:17 PM, Rob Herring wrote:
> > On Wed, Aug 31, 2022 at 6:53 AM Farber, Eliav <farbere@amazon.com> wrote:
> >>
> >> On 8/31/2022 2:39 PM, Rob Herring wrote:
> >>
> >> On Tue, 30 Aug 2022 19:22:01 +0000, Eliav Farber wrote:
> >>
> >> Add optional "moortec,vm-active-channels" property to define the number
> >> of active channels per VM.
> >>
> >> This shall be useful to avoid exposing sysfs for reading inputs that are
> >> not connected to any voltage source.
> >>
> >> Signed-off-by: Eliav Farber <farbere@amazon.com>
> >> ---
> >> V3 -> V2:
> >> - Add "moortec" prefix to property name.
> >> - Add explanation why this change is needed.
> >>
> >>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> I used dt_binding_check on my changes (I ported it to my kernel).
> >> The error is related to "intel-vm-map" which I did not add.
> >
> > The error is the vendor prefix is not defined in vendor-prefixes.yaml.
>
> I fixed the vendor prefix error (will be part of v4).
>
> >> I don't mind fixing it if you wish.
> >> It requires changing:
> >>   intel,vm-map = [03 01 04 ff ff];
> >> to:
> >>   intel,vm-map = /bits/8 <0x03 0x01 0x04 0xff 0xff>;
> >
> > That is not the issue. The issue is the type is unknown because your
> > schema fails and we can't get the type from it. Once your schema
> > passes, this should go away.
> Even after fixing the vendor prefix error I still see this:
> moortec,mr75203.yaml: ignoring, error in schema: properties: intel,vm-map

You still have an error in the schema. You should see a more specific
reason before this message.

> moortec,mr75203.example.dtb: pvt@e0680000: intel,vm-map:
> b'\x03\x01\x04\xff\xff' is not of type 'object', 'array', 'boolean', 'null'
>
> --
> Regards, Eliav
