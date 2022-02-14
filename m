Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF19F4B59FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357536AbiBNSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:36:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbiBNSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:36:02 -0500
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 10:35:53 PST
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE7652E3;
        Mon, 14 Feb 2022 10:35:53 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 490F15C0250;
        Mon, 14 Feb 2022 13:28:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 14 Feb 2022 13:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=Qcwq5i6dPGz8fm
        2l69OpbijAoZXeTdKUljxVFonj5pg=; b=ZfY/IqGewCEVDT+SpQQimzo7lV0aXw
        o7oOy+w/TdWN9r+Ip12oZbb8PvYA2rtzB884ybRgDBKxqlT+Ql7OQ04MJqWO5zhj
        iThCX/QxuWlO3G9NC90STBpKK6282ALvS/bLObbanvTo1lO6Q/mj5NvQr5JTrnAE
        JyE1mRsmgM9dC+D2dEMxQ/NCZ6Hk+iSJGek9Ydm2/EJRy9Az35IPUDzgmG9nWOPz
        e7Bqyt3LCc+BwmNbTeHnfF33CekhYUVCKj19eUghckHByFSoyE/w+MGOaBkAergd
        5+VJZNYS5/NX1NtJvpGE6F6LWjrxNiBrntb1d3TndcYd1zEDJ4/LKTKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Qcwq5i6dPGz8fm2l69OpbijAoZXeTdKUljxVFonj5
        pg=; b=Yf2rCmo191gvt55Y3HNHTt+drZO+Zk9lpbcdD0hH6iG3tRmmwoBB9coJm
        XYFD6VAa6ElSSqdIZC1kDo/nDJIt3aF0Qd03sR7FUA+4DfsNa7qkTh5lqGHyncGJ
        Um9NOoLp0JjkENh8zwDjSm1qbvGj+W9OxdZSKKNfs2NHwwQ3Nyj7DWwZ2SIaga6Z
        nq1OVm8EQAJxjx0OHWaTcW1MKjkH4bQpZakogejZv/uHIb8jMNISd77wzHXiobJA
        yt1wz2IvUEj8xx1zWDwxd4EY766Y5+zLMOFZYRux+4ErxxFcnpA0m9gAdD+PQvT/
        VqiNyq8t2u72pvs+NhReS/UxOvu7w==
X-ME-Sender: <xms:Mp8KYhqDXSYTHlRvrGn5HWuEG5GbH29glKPOou4OJvMM25hgdIeMKw>
    <xme:Mp8KYjpKiAlKFCouRAvlmKSB9WQM7Ws9X9hLNefeCXlVyXuoqDx8_iEs096GI6M9e
    WHx1FOmEVGPOS12w0o>
X-ME-Received: <xmr:Mp8KYuMOkDKYl0UJszQdSrzv-Va0hcirXmB3kYAj2_VfGXuc_vR14EK0Fg4lEc7yDrhA0AKF2QTTI7iUCwxkE4VrfMwvxCf2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggugfgjsehtqhertddt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpedtleffieffieeghfelueekteff
    uedvhfefffeigfeikeekuddtgfehvddvieehkeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:Mp8KYs603cxG8DTbpYBUzrWkPDAwp6k1loBUpyJv5_334M5j4dKgiw>
    <xmx:Mp8KYg7UAvn_v9K6qThCMsLMKygXZRA6l5CulYMZDv6bj0HeHUyKIg>
    <xmx:Mp8KYkh6h7JCrSzwvjez5dFrwv4F1j3qIwqAVuj830uH7L6Ea7ZmkA>
    <xmx:M58KYtvi-UsPV19EcRQGIezyZFYz-6wlN-IqMfkUdmavzZ1e2qijXQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 13:28:01 -0500 (EST)
Date:   Mon, 14 Feb 2022 12:27:59 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] update Facebook Bletchley BMC
Message-ID: <Ygqe6lwWUdgv+8ss@patrickw3-mbp>
References: <20220214042538.12132-1-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220214042538.12132-1-potin.lai@quantatw.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:25:28PM +0800, Potin Lai wrote:
> This patch series update Facebook Bletchley BMC devicetree base on EVT HW
> schematioc design, and rebase SLED numbering to 1-based for OpenBMC
> multi-host.
>=20
> - GPIO:
>   - adding more gpio line names
>   - include interrupt line in io expander for gpio interrupt monitoring
>=20
> - SPI flash:
>   - adding dual flash BSM module support
>   - switch to spi2-gpio on spi2 due to unstable signal issue
>=20
> - Hwmon Sensors:
>   - adding INA230 sensors for monitoring
>   - fix ADM1278 shunt-resistor
>=20
> - MDIO Bus: enable mido3 bus
>=20
> - RTC: switch to external battery-backed rtc
>=20
> - OpenBMC: 1-based SLED numbering
>=20
>=20
> LINK: [v1] https://lore.kernel.org/all/20220211014347.24841-1-potin.lai@q=
uantatw.com/
>=20
>=20
> Changes v1 --> v2:
> - update the details of new added gpio line names in commit message
> - add battery-backed rtc information in comment and commit message

Thank you for the details there Potin.

>=20
> Potin Lai (10):
>   arch: arm: dts: bletchley: switch sled numbering to 1-based
>   arch: arm: dts: bletchley: separate leds into multiple groups
>   arch: arm: dts: bletchley: update gpio-line-names
>   arch: arm: dts: bletchley: update fmc configurations
>   arch: arm: dts: bletchley: switch to spi-gpio for spi2
>   arch: arm: dts: bletchley: add interrupt support for sled io expander
>   arch: arm: dts: bletchley: add shunt-resistor for ADM1278
>   arch: arm: dts: bletchley: add INA230 sensor on each sled
>   arch: arm: dts: bletchley: enable mdio3 bus
>   arch: arm: dts: bletchley: cleanup redundant nodes
>=20
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 303 +++++++++++-------
>  1 file changed, 194 insertions(+), 109 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Entire series is

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams
