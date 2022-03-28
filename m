Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE14E98B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiC1Nwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbiC1Nwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:52:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC975BD1A;
        Mon, 28 Mar 2022 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1648475436;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=4ezCWy705CocHbi8RdHxAqN8vv3gv5SFt/Dzp2Yq4pw=;
    b=h67cVVRQQY22Ho6Oj4lqPV6bbZckg/sqlHJTvISuhhitSpD81WickIMTAt5h0AFRCu
    Qg+4KMYijDSN2sgiXaUl4mkWwL9szWD4xXIJNJkYGv3z88l0PTuJb0dZ/VHDeEbmgBID
    CBrquT4GkxLKaOV2BIp8osnHX+l3cX0/OHzhwCQzswvxR4LPQN6v+l5jOK8elenecZim
    yxdVkybdH/gWZLIWfRewxjT6C6qAdZGJSpqqZf7tPJGeXqzB/cGuyUHgPrRZx7Uc2aQt
    y0IhuWC0oSbH7Z+AuXQhtPgu/MgbvE1jvg6fxo79GX5ZqOVxt5WvtyeuH2CF7eSsjLBB
    +nnw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHWElw43u32M="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.42.1 DYNA|AUTH)
    with ESMTPSA id u3e945y2SDoZ3IR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 28 Mar 2022 15:50:35 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <YkG2RPrtPaBNXb7a@latitude>
Date:   Mon, 28 Mar 2022 15:50:34 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9AFAC3C-46CA-4C40-8559-FD6934411CAB@goldelico.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <YkG2RPrtPaBNXb7a@latitude>
To:     =?utf-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Ansuel Smith <ansuelsmth@gmail.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 28.03.2022 um 15:21 schrieb Jonathan Neusch=C3=A4fer =
<j.neuschaefer@gmx.net>:
>=20
> Or maybe bcm instead of broadcom. Not sure which is preferred by
> Broadcom people.

Maybe it should always follow the list of vendor prefixes as we are =
talking about DTS?

just my 2cts,
Nikolaus

