Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652E6591F36
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 11:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiHNJKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 05:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiHNJKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:10:01 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEA2A25C;
        Sun, 14 Aug 2022 02:09:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 89BC95C00B7;
        Sun, 14 Aug 2022 05:09:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 14 Aug 2022 05:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660468196; x=
        1660554596; bh=U5z+vIAK2wN19+T9d2bnGKigsa7e867hygBkLVspi9o=; b=F
        VmPShbjYLGVFbusD9zGf0p7+XOC2P69dvaAkMhdwujcVvChE/8gyEmIIa14oxN6O
        FrgDyCffWt1hQM5hcYQw7zic3rxuu+kcYfU9eUzGKRstX4b3ZDW0gToilonWDPmr
        XE1gwbvKnMmrUP52KiNsNTODkPcww9sYEpYpggQTqp9KuWbxqpF84KIUUugiwEk+
        5eZJXDAJ83yDaYZ+I2vIpF46iQ3YPpCKRky7IWL4eG4/TeSEVNhrEsMuoOJZhDqs
        9Q+Pc+cNmVB0RrNArxSceCwtwyKrPRuZ8nUVt68fIMpkh2jdjYmYdgEsLQnEZUoE
        hOqcsFWyPUKSFm/GNBOeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660468196; x=
        1660554596; bh=U5z+vIAK2wN19+T9d2bnGKigsa7e867hygBkLVspi9o=; b=Q
        eeSUVzvE3OJNc/W1+bqJML3DEyqNr/UXkTfFeHfO0SX6625p5vU3tb9HgjOzTq60
        xObnOtxdIvcrR7czrMxIV5JcjOgRKOcMn9uJzYuSb2B0HHjiqemveK2kGkc3f1i1
        Y4QVws5TLhSrL2SCRRu8BvQyXtJqhoGrgCWJU+Xyabo0IDN6w+R3TTxRZ02mmgC3
        O0mCSiR7GUhz8Yz9z4/jwYcrechup4mm97vfRyv1al7seteJwskbfQwpME8DZInJ
        e/dHMjgZSBfLk5h434U/OZs8BQ5alOwHaMHOAc9Sgw6AlWYDFkZfCD3ugssdrEXB
        HGzNcAXhIiGmhzeKy4OdA==
X-ME-Sender: <xms:5Lv4YhQkaCstgUG61BysrlCqxRZfp9SCc7yhagEbgW-t36Bl02YjGQ>
    <xme:5Lv4YqxwJ-4z2l4y0_diB6sIowNuukK3cEN9uZxeFs3wCY5qQVWzKCu4xnn4kolN4
    ZTOy3Sxd_BOg94y5fA>
X-ME-Received: <xmr:5Lv4Ym3Z9dNHx20w7maTpQuGXl0aJvi9BQAHHVhYFn7agI8hoKRwfzL8eD-Jrds_fs4H1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:5Lv4YpDtZFzdFnzlQfxQ5Yfv3LjiATVOl9ILbUXv_xNHSmgh-OZgtQ>
    <xmx:5Lv4YqhKbCE9FPQb9vSMWMwY6WtZzhMjqprW-NIuiEgieBh_MM-XDQ>
    <xmx:5Lv4YtpV9YkYGxVSwAgYm2_UGSspFuyazkwfUliUzALH6XdNGs7a4g>
    <xmx:5Lv4YtsEZ3B8bGHa3yoRfXlA2X7yfdLbJs0D5Z380_XQZFNC1EX5Yw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 05:09:53 -0400 (EDT)
Message-ID: <56171d4f65c02d3cba64d2f6d49e190107c12a18.camel@ljones.dev>
Subject: Re: [PATCH] asus-wmi: Support the hardware GPU MUX on some laptops
From:   Luke Jones <luke@ljones.dev>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 14 Aug 2022 21:09:43 +1200
In-Reply-To: <20220813105533.GA3258@wunner.de>
References: <20220813092624.6228-1-luke@ljones.dev>
         <20220813105533.GA3258@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Sat, 2022-08-13 at 12:55 +0200, Lukas Wunner wrote:
> On Sat, Aug 13, 2022 at 09:26:24PM +1200, Luke D. Jones wrote:
> > Support the hardware GPU MUX switch available on some models. This
> > switch can toggle the MUX between:
> >=20
> > - 0, Dedicated mode
> > - 1, Optimus mode
> >=20
> > Optimus mode is the regular iGPU + dGPU available, while dedicated
> > mode switches the system to have only the dGPU available.
>=20
> Could you please integrate this with the framework provided by:
>=20
> =C2=A0 include/linux/vga_switcheroo.h
> =C2=A0 drivers/gpu/vga/vga_switcheroo.c
>=20
> vga_switcheroo will then automatically expose a sysfs interface.

I did investigate this first before submitting. The way asus does it is
not standard at all. On switch you must reboot, and the change isn't
reflected by the ACPI get method until reboot. It's very reflective of
how they used dgpu_disable to work around windows issues that we do in
Linux by removing the device from the device tree.

The key thing is a reboot is required. This is not done on-the-fly. I
have a two year old GX502 which has the same method as exposed here,
and also a 2022 TUF laptop with same method. My understanding of this
pariicular method is that it isn't the same one as what Nvidia is
advertising, and ASUS is perhaps misadvertising it - the suspision is
raised by the fact that my GX502 machine predates what Nvidia is
advertising.

Kind regards,
Luke.
