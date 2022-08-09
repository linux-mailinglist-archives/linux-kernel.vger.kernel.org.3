Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CC58E386
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiHIXED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHIXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:03:59 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7923A6AA15;
        Tue,  9 Aug 2022 16:03:58 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D4D135C026D;
        Tue,  9 Aug 2022 19:03:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Aug 2022 19:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660086237; x=
        1660172637; bh=1CmhGkiO/qNhBvEH10/VjJXKi8kf/mGQveffQloDLnw=; b=i
        tNrluxbhZ9IQAv3vuUjGmfrUKWU/nI+GzMq4f8MZsJPkzZHQFuodvfVAFn389wEJ
        vAQn8TEpg8ZOj5MYeatdP7bATWEzxrERxymqtinK+DPdgC3wCJwegK/8VhpaYOH6
        NkpaIIvs8nObqkD6i/lpIDYqxkL/ALSshEP2dPA6ws7HKhhHUE9l4UNUT863k10J
        qRibslfhU7Z+VDLCgOhfLqLaW74ePzv2js0Bg4nnhzD5YZK0Ar0zOePrG8dxfLEk
        63IDgAgD64D6AGHI9LsKe8XlbSL1tk5XMeTDa8C8JHKCzHp4D/INa10c52kRd/Y0
        FkLrOgYmEHZrCAlLJPBEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660086237; x=
        1660172637; bh=1CmhGkiO/qNhBvEH10/VjJXKi8kf/mGQveffQloDLnw=; b=u
        BVX3PLCzzJW9bDsz//C1itq9lonQw3vHcJEs+gG6n0sja7/voFHD1jX1VJgornXr
        ngUDs2DtIGAU8ZK7hwK6kEXCaze8doY45Woqnj9SIyEBgYoGyq3vjlKeHY+6biLw
        bCJeis4QmL8/GtOhGBpMckuDqaTstAF9PAMYVzP94/qp5lBfgZinhMzlBu+ABSdl
        hgVGvO9iHLOi0j+cGaKM8ig2Lv+0gSvIrPh0ucnPMQRrV85rKoEiWy6j5e4tJeI0
        OxY1jHMOpM0Mx6beyn8KCZ2eAb3IHvEWOVNepK3w8cDcMwiYm301lWx+DMUQcJfp
        XP0CGtsw/wj1mIPXVPpEA==
X-ME-Sender: <xms:3efyYiyiFkvgvntuuGzScshj3AF8mv_62C8FQ515AaMTk0dR9jOE9w>
    <xme:3efyYuSw3D5zZq3eOuGt7neNudER26ByOGnk5uF0rapr_vXKENlVkCCqp-Ebw62j4
    z7YNygXQI0tPavBl_8>
X-ME-Received: <xmr:3efyYkWBdMwAPzTiP0DsO7o7s3sywRkIrZFlYDq00Te1_-PG4DpsmrTjFsDo76ZcVSzwfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpefgtdekheektdeghffhfffhgedutddthfehhfeuiedvjedukeffveevudevheefieen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:3efyYoh0PgBEJWR00SvtGEkLOwx00RgzZdIDrnk7iiNMWX5-Ez2JJg>
    <xmx:3efyYkCS7dCkrGD3tzLf9fvwnpgvBK524s3M_tib729K8ohebqkCtw>
    <xmx:3efyYpJhczoJSpVn3XRdGXyQTkd-5Y30eB6qptr7cnTRk7xL9vkGXg>
    <xmx:3efyYnOngBzzJdZmFUM9tv0jkmBiPigGwPLbMuqBJyn07xKd53bvnw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 19:03:54 -0400 (EDT)
Message-ID: <7362f2f7795bebe9bbf9c00f0efd3eaa9143015d.camel@ljones.dev>
Subject: Re: [PATCH 3/5] asus-wmi: Add support for TUF laptop keyboard states
From:   Luke Jones <luke@ljones.dev>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Aug 2022 11:03:46 +1200
In-Reply-To: <20220807124102.GA32221@duo.ucw.cz>
References: <20220805081909.10962-1-luke@ljones.dev>
         <20220805081909.10962-4-luke@ljones.dev>
         <20220805120859.GB20036@duo.ucw.cz> <ZTI8GR.GMVLPPJWYEO53@ljones.dev>
         <20220807124102.GA32221@duo.ucw.cz>
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

On Sun, 2022-08-07 at 14:41 +0200, Pavel Machek wrote:
> Hi!
>=20
> > I'm sorry but can you direct me to a source file or other that
> > shows use of
> > "pattern trigger". I don't know what this means or what to look
> > for. From
> > your response it seems I should certainly be using it.
>=20
> Trigger is at drivers/leds/trigger/ledtrig-pattern.c , you'd want to
> do something similar to drivers/leds/rgb/leds-qcom-lpg.c .

I think we lost something in communication. This looks like it is all
done in software.

On these laptops, TUF and ROG, the LED effects are all done by the
keyboard EC. For the TUF series you can reference this
https://gitlab.com/asus-linux/reverse-engineering/-/blob/master/TUF-i2c_lap=
tops/led-rgb


It's for this reason I first went with a single node using "n n n n n
n" input.

Kind regards,
Luke.
