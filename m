Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B7E4AF554
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiBIPd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiBIPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:33:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECE1C0613CA;
        Wed,  9 Feb 2022 07:33:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B005F613F8;
        Wed,  9 Feb 2022 15:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282CDC340EE;
        Wed,  9 Feb 2022 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644420837;
        bh=94JhqkfPyGm5fI8uqElS/q7uYfUeEV75ByfM2U5lMf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PvhHN1x99kHaQ6SIeyKuc0HYSgDdAaE+QFS/bnBHwZPoi9p/NkYGRuMUHaUutZKry
         dpyazFKmdc1w5tuQjVRo4n9aPQW8L0V4eOU3RMC2kINmblqFq88nzgnU7RayND1wSS
         OzZWkZ/CZsKt5MQUAq+EikE2Sxdqvo2ORJY+/XQwG7FcMeCg8fztKx/4vKw0KES94f
         x1eLiYZDbvBEG2OQ3oF88V7jjFQa70Mp31ldavrQ63rlPdDbmDo11HsIBanS+hod7q
         VvxuugfESSaFi2P4S67g+43J5xH7SVRIIzV3L2lIz2VMJ86H+GqiuuKsCGcHsMJ1eb
         pRIsj+OCLASbw==
Received: by mail-ed1-f47.google.com with SMTP id s7so5914694edd.3;
        Wed, 09 Feb 2022 07:33:57 -0800 (PST)
X-Gm-Message-State: AOAM532Vempwa+LkfhSpsWboXbkyuhi69bj+Bq3azchax7CIMITHu8on
        WUZiTPnYRdLTyQY68X57Z94nMS9/s2r3bBUSkQ==
X-Google-Smtp-Source: ABdhPJxIQT/yPUyK1ZYhL/YnMo/s0Nictx67v1DM0eQXfYq4bvcfzBEBoc+KIS1H6jV+lGZW2y3nv/axCNFkNwiiq80=
X-Received: by 2002:aa7:d406:: with SMTP id z6mr3167126edq.66.1644420835447;
 Wed, 09 Feb 2022 07:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20220209100413.23714-1-potin.lai@quantatw.com>
In-Reply-To: <20220209100413.23714-1-potin.lai@quantatw.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Feb 2022 09:33:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLM552FjvjdECq56kYsx9+mPuyvpUNibtuH--pgyF4pDQ@mail.gmail.com>
Message-ID: <CAL_JsqLM552FjvjdECq56kYsx9+mPuyvpUNibtuH--pgyF4pDQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arch: arm: dts: update bletchley dts
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Patrick Williams <patrick@stwcx.xyz>,
        Allen Wang <Allen_Wang@quantatw.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Feb 9, 2022 at 4:04 AM Potin Lai <potin.lai@quantatw.com> wrote:
>
> updates:
> * seperate leds into multiple groups
> * switch sled numbering to 1-based
> * disable inchip rtc
> * add flash1 in fmc
> * switch spi2 pnor using spi-gpio
> * update gpio-line-names
> * add interrupt pin for each sledx_ioexp
> * enable mdio3
> * update ADM1278 shunt resistor (300 micro Ohm)
> * add INA230 for each sled

Please read documentation on writing commit messages. Answer why you
are making the change, not what you are changing.

Each bullet should probably be a separate commit. The question to
answer is are there compatibility issues (what happens with old DT and
new kernel and vice-versa)?

Rob
