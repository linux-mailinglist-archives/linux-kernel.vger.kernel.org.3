Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F147CA14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbhLVALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:11:24 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:37789 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235367AbhLVALX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:11:23 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 03E4D58039A;
        Tue, 21 Dec 2021 19:11:23 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute1.internal (MEProxy); Tue, 21 Dec 2021 19:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm2; bh=wf
        /278djVLUJ9KQpmHQkebWJnkBPeStQ6eJqWkZGqek=; b=0ChMgnUmrZpC82WEaS
        /mhtwWum/pD2KEt6E2ckRPtezal3/sttkBTCXq9SzoGzpKAaaM7OE7lZkO1NVDnJ
        6KDQdl2IgHb8ibqMgkzTrrIB4IY9NOag4fBU5qXFWxIITlGxs3vgLTPR8GSnK5fD
        8W/DhlFsamofXh8InYkiW2Qucgt1o3384tX6KbJv1T2BOFeEjajt4X2bvEtS2yQ6
        Wmlz1ZV3ipPUMY8AXQwJJd3+fVzdCEHEwT/wNJ6c+jermpZY3SM9Wx76zQF4/Vtw
        ql4guIAtf0kPLN0tyq3gJ60YOWugBmfpqbjvDZrAColUc/EAsLhJ45EbcTexx5YO
        vPpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=wf/278djVLUJ9KQpmHQkebWJnkBPeStQ6eJqWkZGq
        ek=; b=Iv9sNLOO+pVjelF7DWF3S5byyVaZkszOqI/RIRMLPtqNMf5BDmrnWBgBA
        eP9lfp9s5GbjkwXK2oucFW1T5q0a4m/3AX234TFfIwMhm2C5i3VKGxscm69xTbj+
        P6sAv/nEia17zMDw9D2PuwCHiM2nymKPMLyWwq+LmO7w8+BgVWebiDauIChk8/zi
        5n6vn2ijggACg1Pnq3uaSH3vbfPQ6p2TBOUuFq0lIiL1UfKK7VzICa8e9AT6BAQ8
        xC8rfUAWKqg4PFUJepypmK7UFkURYGAdhB+0rFbJHVFkP5Kei+Hv4ooDDqslXOhJ
        6e1mb44I6UZxxqvrvdooQZyUEvwqQ==
X-ME-Sender: <xms:Km3CYb8CVNrOJePNFiJ9Uo_GfyZgtt-jyIL9bVULYkPcteLOj7DckA>
    <xme:Km3CYXvhRuL2PU1Y5r4i_JMmXC6Sr_HsSApQNUJZIM50tuxRB6HCNZ76f1xTcQPiY
    6WFOmq2eubGzDu0ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddthedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfho
    hhhnucfvhhhomhhsohhnfdcuoehlihhsthhssehjohhhnhhthhhomhhsohhnrdhfrghsth
    hmrghilhdrtghomhdrrghuqeenucggtffrrghtthgvrhhnpeejtddtjedvgfejheehkeev
    keelleffgfeludeghfejgedvkeduudehtddvhfekleenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheplhhishhtshesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtohhmrdgruh
X-ME-Proxy: <xmx:Km3CYZDbhoVYr_tQlbeJld6SGPvxPSiVFlK-sO2JPHuH6EqyjOn6SQ>
    <xmx:Km3CYXdIUpHWsashOu2ykv3BH6K4-P48bzoXJu3gN7_KzteYAPbCRg>
    <xmx:Km3CYQOJGwmnXelNHZbhsrD4nq7Zk3p-QOpc5I7HO9EGUzqhylwy9g>
    <xmx:Km3CYRFi0kzrFikojgCYD0Xan0cRa2I-UQDuI11NkclgGly4YqNWNQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6A2BB1EE007B; Tue, 21 Dec 2021 19:11:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4525-g8883000b21-fm-20211221.001-g8883000b
Mime-Version: 1.0
Message-Id: <e7173ab2-d3b2-4f75-beb8-32593b868774@www.fastmail.com>
In-Reply-To: <20211220064730.28806-2-zajec5@gmail.com>
References: <20211220064730.28806-1-zajec5@gmail.com>
 <20211220064730.28806-2-zajec5@gmail.com>
Date:   Wed, 22 Dec 2021 00:11:01 +0000
From:   "John Thomson" <lists@johnthomson.fastmail.com.au>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

Thank you for working on this.
I hacked together the same functionality based on kernel 5.10 some month=
s ago,
while I was testing an MTD parser based TLV NVMEM cells parser,
and have some general comments.

On Mon, 20 Dec 2021, at 06:47, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This allows reading NVMEM cells using /sys/bus/nvmem/devices/*/cells/*
> which may be helpful for userspace & debugging purposes.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  Documentation/driver-api/nvmem.rst | 11 ++++++
>  drivers/nvmem/core.c               | 60 ++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/Documentation/driver-api/nvmem.rst=20
> b/Documentation/driver-api/nvmem.rst
> index 287e86819640..20f7d68143be 100644
> --- a/Documentation/driver-api/nvmem.rst
> +++ b/Documentation/driver-api/nvmem.rst
> @@ -185,6 +185,17 @@ ex::
>    *
>    0001000
>=20
> +Single cells can be read using files located at::
> +
> +	/sys/bus/nvmem/devices/*/cells/*
> +
> +ex::
> +
> +  hexdump -C /sys/bus/nvmem/devices/mtd0/cells/mac

I found that NVMEM cell names did not need to be unique, but sysfs entry=
 names do.
I am not sure if there are characters that NVMEM cell names allow,
but sysfs entry names forbid.
I used an ID allocator, in a similar style to what is done for MTD sysfs=
 devices in mtdcore.c.

Could the cell (data) binary attribute be in a subfolder for each cell?
Example:
/sys/bus/nvmem/devices/mtd0/cells/cell0/cell
or
/sys/bus/nvmem/devices/mtd0/cells/cell0/cell_data

This way, we can easily expose additional properties of the cell.
I exposed the name, offset, bytes, bit_offset, and an of_node link (wher=
e available) this way.
I only needed these for testing, but the cell length (bytes) provided a =
cheap means for initial validation.

I did not look into cell post-processing, but it should be considered:
https://lore.kernel.org/all/20211006144729.15268-1-srinivas.kandagatla@l=
inaro.org/
and RFC https://lore.kernel.org/all/CAL_JsqL55mZJ6jUyQACer2pKMNDV08-FgwB=
REsJVgitnuF18Cg@mail.gmail.com/
Will the cell data exposed here be prior to post-processing?


Thank you

Cheers,
--=20
  John Thomson
