Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE85954C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiHPIPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiHPIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:14:44 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694DBB2494;
        Mon, 15 Aug 2022 23:21:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EF26D5C00D9;
        Tue, 16 Aug 2022 02:21:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Aug 2022 02:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660630883; x=
        1660717283; bh=jy6xmsOjEA2Va/wNOYVF/8wst1Di1Hg7OHE3XzBlbbw=; b=f
        8mb6KOmAZ79IMZEWUx+YYQgDjG3pM2Od7tcVe2Czx4wLSiKMCLPwGhTVsozbJndh
        CbR9zxZjfuSbUFBedV1S0xgP1sf1+wuaGv2olaZmU0EyZxdg8poOjoacUJ1pynwr
        eGPauIDzNi7VWOFI+8GOTZCqAreMYzgnN94o73ZjylDtDEUglsCy7l4S6XLcEIjj
        GPcG+cAzKseunXaVGNQKXLlEBNsZ/j7/NE1SJpR0mlb4By7Cc5p7V1kZUbkhGgH0
        5g15RN9BZaktlZ0V8BWlAcrf7roHE6SdhTR9l7666wV/2ps8xjQMfFF3opClwv5M
        1DlSgX53H7Din23pXLnPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660630883; x=
        1660717283; bh=jy6xmsOjEA2Va/wNOYVF/8wst1Di1Hg7OHE3XzBlbbw=; b=W
        xDkgwflJ2OlqqhsqlbQ0RK1cYVY5u+6p83MBO4c7NlcmcVLbhUEr6EphS9kWtpky
        lrSiWch7/VpKo+Jx5vgzbHPjz4tgBz5YhbFrGFs4CDQuD7nIpLAWQTHsiBRBDAgS
        Mh4yBjtlPmuVNiGD7A304LzY1I6Sx8pqNgDorH7U8UbAmoSQSivJD4KIG2UvlTxo
        H9spb6QuGk+GT+njYZDaGS2nKLrxAPUDAXmOqbR76gJQz9pz3JE+rbPLWRRoMTL0
        rXQT9nNeg7Lpva8htHaqH/BTI0g0RYQGMSsULaKM4G1C+wDXuAWwatrYXseehyl7
        qea1X2G3usWbN6eQLfCvw==
X-ME-Sender: <xms:Yzf7YiqXqZXe_qWxXuvjpm4-3DMZM-HypQH9y3AYOsXM1ijGkFIsSg>
    <xme:Yzf7Ygo1syUW0pmk9-RLgNX1pegGYUxZCB7UptlcxLqXsopk_HV4hUbVGnwxGj8-I
    p39cuT-5q-Z1FZAgrE>
X-ME-Received: <xmr:Yzf7YnPpjJcr8c7E14jmd-hMDzS9C7YtQ4U3rlMEEDBpQ-66Q6RaND5vAj6IawB13CEz4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhu
    khgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepteegteefhefhteegleejudfffffghfekleeijeeugfffteeiudefvdetteeuuedv
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:Yzf7Yh4kpFWaZxqvGYAQXldbAZWPJvnHyAbiDHf6MmCURsjJXddsKg>
    <xmx:Yzf7Yh4ZQnusbyGdx-udyTl9vea8O5kYxkg-8ubNIpPb-zeJTaxOYA>
    <xmx:Yzf7YhhCRIql1VMxQa42-P4LyeGgmGqDVdg8pC_h_N_xmRg_GRk1iw>
    <xmx:Yzf7YjRVRPIie8C0yumJECDBJ7LwaPE1-oAe-hC1SNRb8_po0TCbmA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 02:21:20 -0400 (EDT)
Message-ID: <449cf9505daeb7b49deb199c101eb7b94e518ea7.camel@ljones.dev>
Subject: Re: [PATCH 1/6] Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable
 method")
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Aug 2022 18:21:10 +1200
In-Reply-To: <fc250b82-c7c7-9215-f3dd-be87e0a72edd@redhat.com>
References: <20220812222509.292692-1-luke@ljones.dev>
         <20220812222509.292692-2-luke@ljones.dev>
         <fc250b82-c7c7-9215-f3dd-be87e0a72edd@redhat.com>
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

> Thanks for the patch. Note that the Fixes tag should be above your
> signed-off-by and then the patch should otherwise have a normal
> subject + body. I've changed the commit msg to the following
> while merging this:
>=20
> """
> platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute
> =C2=A0=C2=A0=C2=A0=20
> The dgpu_disable attribute was not documented, this adds the
> required documentation.
> =C2=A0=C2=A0=C2=A0=20
> Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable method")
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> """
>=20
> and I will make similar changes to patch 2/6 and 3/6
>=20

Ah thank you, sorry about that, I thought I got it correct Perhaps I
didn't read
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#descr=
ibe-changes
well enough.

> > ---
> > =C2=A0Documentation/ABI/testing/sysfs-platform-asus-wmi | 9 +++++++++
> > =C2=A01 file changed, 9 insertions(+)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > index 04885738cf15..0f932fd60f4a 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > @@ -57,3 +57,12 @@ Description:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
* 0 - default,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
* 1 - overboost,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
* 2 - silent
> > +
> > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/devic=
es/platform/<platform>/dgpu_disable
> > +Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aug 2022
> > +KernelVersion: 5.17
> > +Contact:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Luke Jones" <luke@ljones=
.dev>
> > +Description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Disable discrete GPU:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 0 - Enabl=
e dGPU,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1 - Disab=
le dGPU,
> > \ No newline at end of file
>=20
> Next time please make sure the file always ends with a newline
> even in intermediate patches.
>=20
> Regards,
>=20
> Hans
>=20
>=20
