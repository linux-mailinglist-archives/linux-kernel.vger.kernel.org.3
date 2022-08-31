Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561235A777F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiHaHag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHaHae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:30:34 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C74C613
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:30:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B75465C01B1;
        Wed, 31 Aug 2022 03:30:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Aug 2022 03:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661931030; x=
        1662017430; bh=UvHsc3Tvg3hCau4XbftFll5OLxKu9QNVLjgp8k9+0cA=; b=e
        rRmqe0BuX6iTdNqMVuv+KZfhF0e0ahQ5HA8pkZQi4xIxmwmKHHoRZ63kArGzkVFG
        zMxmAoApwyxolTqzmx0ldEpk5tbA04kJV/1QarvO+fiSZBjW94nnxmsyqynQwYdo
        SHMvuoXRQOgT9MyjVJwJgFtk3Yz7EfaHote+oDzGc3Wz/WfumhlXdmFb9Twx1/Kp
        6itiYk2C0n0a4WMLfuRqV/fM3jM84mQgTbUTJEFxlTyJWA2vP8rlpHOvNJ61Dy2I
        E4r69xXrS5BtSwHb9KALjy2FJFh86lVZvo2qPlxj4L8qO3/jx4KUlbCvr0BRvq40
        C683JcjDUBF4EofDy2skQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661931030; x=
        1662017430; bh=UvHsc3Tvg3hCau4XbftFll5OLxKu9QNVLjgp8k9+0cA=; b=T
        Nv5L2PRw01LnPmWBhgpDWKVXjB1112dC+BRMjUCrdM0wLrOEkSUwp285E6/ZTRu+
        Oim2T4LczsdlkwMOqsTV2JYTYy/ZJAKmPtvumjJ8rbsTn9aGEhixGQELkXCA3RwO
        4yNo3wJzx9PMqw0efHFj3Gid9qQnzRUT4omFiPzUa6GPdevIf4yy2kMRJKU96RMh
        M8fuc9vRp6zyVUUWVpEbROvF4uVx5mAACnuq5503gNNfB4wpiQXr7foe2rKmKVT9
        TeIM+n1AyQZ4VtkKUeAWE8rpVg83Ck0TOmrKv3dB/wogJmRdrhD6LetBfHdwCCbk
        Hmy+qUBaHg6ziYKo/B87Q==
X-ME-Sender: <xms:Fg4PY3qR9f3S861vGVnYSSN6zaC-mX4HUsk1rO9RhHoVp6jZTR0oWw>
    <xme:Fg4PYxqpsPLWd_O8HDOG1JOJfBgEAktF-xnXfI08LTCSAWQLXb5Bs-KXDzudpomiK
    UizT5qBRFOzJQDYPik>
X-ME-Received: <xmr:Fg4PY0O0fXTXXaaVNU4bgh_UzPwF1wja2mKB6DkWVI-i-z6TlYzi6q86Q8k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekgedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpefhieeiheefvdekudffieefteetgeekveejvdffgedvhefgfeejudfh
    keekteeigeenucffohhmrghinhepmhgrgidrlhhotggrlhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:Fg4PY65eIRY6UbajnSu9BfSOFAfBup0ir2u3gYg_NTkBn3bJxPCcyA>
    <xmx:Fg4PY25o8c8nouyazclAjzQBaNyrovATegIZUxPYkjhaTrsEDB2e1w>
    <xmx:Fg4PYyjn6peYQbC0EFD0dsVRyNWciBPLsweMTIq8CCFO5HsugTuj8Q>
    <xmx:Fg4PY7j2JeocrJ0sfb0R7xFtPvvdqpWBnyY9dy_e49Qqz8zUhcpFAg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Aug 2022 03:30:29 -0400 (EDT)
Date:   Wed, 31 Aug 2022 09:30:26 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/41] drm/tests: Order Kunit tests in Makefile
Message-ID: <20220831073026.rjlqkznm6qf2yri5@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-1-459522d653a7@cerno.tech>
 <f6289e5d-98e3-1a0d-f514-136e2b7978c1@tronnes.org>
 <20220829190242.tk2hinttzzmzhnaj@meerkat.local>
 <20220830083027.4iyi2s5r5bto4h2e@houat>
 <20220830122217.h52zswusnlb3iggq@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220830122217.h52zswusnlb3iggq@meerkat.local>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 30, 2022 at 08:22:17AM -0400, Konstantin Ryabitsev wrote:
> (Dropping most cc's, who probably don't care about this thread.)
>=20
> On Tue, Aug 30, 2022 at 10:30:27AM +0200, Maxime Ripard wrote:
> > > I noticed this, too, and I think the reason is because these patches =
were
> > > generated with "b4 send -o", but actually sent using git-send-email. =
It's not
> > > a use-case I've considered (or tested) and the breakage is because wh=
en b4
> > > generates patches with "-o", they are written with CRLF line endings,=
 which is
> > > not something git-send-email expects.
> >=20
> > You're right
>=20
> OK, the latest master should allow you to do that without causing CRLF er=
rors
> like this series.

Thanks

> > For some reason, b4 send doesn't work for my setup and I haven't had the
> > time to look into why and let you know.
>=20
> Yeah, I see what the cause of it is:
>=20
> > Connecting to /home/max/.local/bin/msmtpq:0
> > Failed to configure the smtp connection:
> > [Errno -2] Name or service not known
>=20
> You have sendemail.smtpserver set to a path, which is supported by
> git-sendemail, but not by b4 (yet). I'll see if I can put that in today.

I saw that you fixed it in master, I'll give it a try, thanks!

Another thing I noticed when using b4 send is that I'm not sure how to
increment the version number of a series. With b4 send --dry-run it
wasn't happening automatically, and I couldn't find anything related in
the options (except for --force-revision but that wasn't permanent I
think?)

I ended up amending the commit json by hand to set the proper revision
number, but I'm almost sure it isn't the right way :)

Maxime
