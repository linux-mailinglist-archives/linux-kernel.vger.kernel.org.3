Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B925675C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiGERbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiGERav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB31164;
        Tue,  5 Jul 2022 10:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2926661835;
        Tue,  5 Jul 2022 17:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7965C341CA;
        Tue,  5 Jul 2022 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657042237;
        bh=Xm6gyl8dLz3HwAyqze5mcVqlYQ5A+TfaMjczrDNH/m8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sfUVQLg6qApxRQd+TRROC+RGtI4lAvneBvQI9tBSHDWmi1GuVoJ6GEPBFXYm+Ft5S
         b2hxgqwn/phfwX1jH/dKR/Pe43C2Mkt+MJ16OmHHUCa1qHnEtaz9pZLK4z1z6ofqSu
         rMZFz9j9EELh4MVwldr2hCWSWuw9IX6Rd7IQ3foMbW1+8FkyWx2CqChtKI5UzOJn36
         jteZ4vpTQ1IIDbsasttq5iOSAdhN49NE8M5ciVdVUZ2mlO82Eu5/VUp18PG/VuiwNP
         4jjLaAEoI9v1pqWyWyBYouHaGkFx3GkYhYGIas26QLFcXXQhvBXwwR8w9TVk+2G8cW
         wEyV1UWdXqO/A==
Date:   Tue, 5 Jul 2022 19:30:31 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] leds: Add support for Turris 1.x LEDs
Message-ID: <20220705193031.5130142e@thinkpad>
In-Reply-To: <20220705155929.25565-2-pali@kernel.org>
References: <20220705000448.14337-1-pali@kernel.org>
        <20220705155929.25565-1-pali@kernel.org>
        <20220705155929.25565-2-pali@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Jul 2022 17:59:29 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> This adds support for the RGB LEDs found on the front panel of the
> Turris 1.x routers. There are 8 RGB LEDs that are controlled by
> CZ.NIC CPLD firmware running on Lattice FPGA.
>=20
> CPLD firmware provides HW triggering mode for all LEDs except WiFi LED
> which is automatically enabled after power on reset. LAN LEDs share HW
> registers for RGB colors settings, so it is not possible to set different
> colors for individual LAN LEDs.
>=20
> CZ.NIC CPLD firmware is open source and available at:
> https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_C=
PLD.v
>=20
> This driver uses the multicolor LED framework and HW led triggers.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
