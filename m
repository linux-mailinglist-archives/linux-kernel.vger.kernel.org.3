Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBD058E32B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiHIW0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHIWZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:25:43 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146515FE8;
        Tue,  9 Aug 2022 15:25:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E3ED5C01C8;
        Tue,  9 Aug 2022 18:25:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 09 Aug 2022 18:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660083940; x=
        1660170340; bh=wUwu7rEramo4VPL2of7nNhGsxyAcdYrNtJ7iJLfolt8=; b=G
        HGBHv7xnNkOHdzo3v7CYoIT11b7tr1nsuU98hzsl8r1yvod15Q7IRf7+LAFgWQa3
        C54AiOxBD8mx2++pzV/IMYT0oo0dctUGAl4ByVJ1wgVIGxK1UsfkYgDErCO8HGq2
        EJx3S2fVcxLj5SW7IH7p7tKvZZtrI028ELnRf3eR/diyrChdcsxw9/aEPdAjvthc
        p7eEAfG5rSCSeeWcun61Z4yWnIddcbriVPztnm6d04OrYMI57r3LuDioKJHunw60
        Y9ZaWt+ZnwKV0zC40vhxbqrmyh6Vq+LW0v9+w49TIiTiS2UbiRSVcxUmJjbDlcZY
        NOpv6DnyQbwmlt8G7aksA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660083940; x=
        1660170340; bh=wUwu7rEramo4VPL2of7nNhGsxyAcdYrNtJ7iJLfolt8=; b=c
        1+AbC51ttUtBW2+7r92rjPgjCHB+seZOd3jWWXfP8hGWdntCTYRhiEOZl0SziGXX
        Q4rqkw90+4idmhbS+X44ScSvszvO6JuztPB39fKYuzuL1LKMvAmnRKLZRhhS+Hqn
        vlicCeVqyaPur2m4Y9BRM5uISw/bXu8mMzm14/RpHjm6pZIpTPkMDPEBjW03ykmh
        pB8J6GU++YYsmvJMoFjFTfpGs1AqjwClfLzm5RPlZO61Ek/TuepLj1XYotnBFWR7
        hKD81YLk0VOfyk1iEyQyjWd4JYa4j9hlfVw5/o7XwHNzX3vfL2vdQyCyp+/XZjpH
        +wqDfptHqdv2YOpao3azw==
X-ME-Sender: <xms:5N7yYunBlLNABfMBnsErOdi1ZlevYvvzU9Gd7EQ1mpowtcQ56CDHbQ>
    <xme:5N7yYl0CUDUTp5HCFip7CKEnyDvy1uS7x7IQCWt3TIThe3_wbbVb_GAG473tbylQR
    qKoAZSD2z7RW9ppti4>
X-ME-Received: <xmr:5N7yYsrnTGBuD07IXD-r5gGTPbW3s3iDnr2PRziWvk8H2YYa2JT7BLwN56XR0OUJ9nhFlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeguddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeekfeffueejveeujeeugeelleehtdegvdeludektddtfffhieefledvudehfeejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:5N7yYimZGTiOPtKD9Oz23gV2PkDssfJ0xkNCno5gWWHBf6q1TOq-HA>
    <xmx:5N7yYs3QkN6dshHoDpd_LCigHC1rBWbUJcskUxZ7MjfhGKypVykUJA>
    <xmx:5N7yYpuxI6MnNcLQjNkZiERcUVa8uMnuD4OpkYMxdWmogGo_Ku3GVA>
    <xmx:5N7yYqBKxt_mvOlzn0mCLhgvfrXL9rGsev3z3pdlUEe2k0pTZlWWcw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 18:25:37 -0400 (EDT)
Message-ID: <43ca98e5a51d30291efc96ef4758ff508ee143a4.camel@ljones.dev>
Subject: Re: [PATCH v2 3/6] asus-wmi: Implement TUF laptop keyboard power
 states
From:   Luke Jones <luke@ljones.dev>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Aug 2022 10:25:29 +1200
In-Reply-To: <CAHp75Ve4kFJz-4QqpUYTujQRkOkFZ+w01eHRwZyvQAA+GkNG9A@mail.gmail.com>
References: <20220808030420.8633-1-luke@ljones.dev>
         <20220808030420.8633-4-luke@ljones.dev>
         <CAHp75VdNa8csSF5Je87kOzC3EQ4yetZqpxXFZu1D7C4A6XCTNg@mail.gmail.com>
         <X5LBGR.15DO7CCYH6ER@ljones.dev>
         <CAHp75Ve4kFJz-4QqpUYTujQRkOkFZ+w01eHRwZyvQAA+GkNG9A@mail.gmail.com>
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

G'day Andy,

On Tue, 2022-08-09 at 10:29 +0200, Andy Shevchenko wrote:
> On Tue, Aug 9, 2022 at 1:27 AM Luke Jones <luke@ljones.dev> wrote:
>=20
> ...
>=20
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sscanf(buf, "%hhd %=
hhd %hhd %hhd %hhd", &save,
> > > > &boot,
> > > > &awake, &sleep, &keyboard) !=3D 5)
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > >=20
> > > Same Q here: wouldn't it be better to put each of the parameters
> > > to a
> > > separate sysfs node? Or look at the LED ABI (that what Pavel
> > > mentioned
> > > for multi-color patterns) and see if there are already some
> > > established ways of how to represent necessary information?
> >=20
> > Same argument I make for the RGB mode nodes. But here I think it's
> > probably even more pertinent. The reasons I would like to keep this
> > as
> > one node are:
> >=20
> > - It's separate to the RGB part
> > - We can't read the device to set defaults on boot
>=20
> Hmm... Maybe it's done via one of the WMI calls?

That was my hope, but I'm unable to find one. I'm fairly certain that
this set of keyboards uses the same controller as the USB connected one
(the USB one has two versions in circulation also), and I've not been
able to find any packet data that indicates the USB ones send a
"supported".

Checking with `fwts wmi -` reveals nothing (all passes).

I've emailed my contact in the ROG engineering team at ASUS to see if
they can provide any insight.

>=20
> > - Because of the above, if we set a default and the user wants to
> > change perhaps "sleep", then we're going to have to write some
> > incorrect guess data since the write requires all the flags at once
> > - One way to improve the UX is to add _show, but then this has to
> > display incorrect data on boot
> > - We end up with 5 more nodes
> >=20
> > The same reasons above apply to the RGB nodes, which right now I'm
> > of
> > two minds about. We'll see which way the RGB mode patch goes after
> > some
> > daily use.
>=20
> I just realized that in previous mail I mentioned Device Tree which
> is
> irrelevant here. We can't use it on x86 traditional platforms, so it
> means that platform should somehow pass the data to the OS one way or
> another. If there is no way to read back (bad designed interfaces),
> then we can only reset to whatever user provides.
>=20

Umm.. Do you mean:
- load module
- module sets a default (all on)
- user or userspace-util sets user preference?

Given that the system daemon I develop (asusd + asusctl) is in very
wide use, I guess it's not such a big issue to both split these nodes
out and set a default.. I guess I'll go ahead and keep the expectation
that the reworked RGB-mode patch sets.

It seems to me that the appropriate way to do the "write-out" for both
mode and state is to have nodes:
- keyboard_rgb_mode_apply
- keyboard_rgb_state_apply
- Input 0 =3D set (doesn't stick on boot), 1 =3D save

going with the above I should rename existing nodes, especially the
current *_save node. And this brings me to my next issue: currently
behaviour for the *_apply is:
- write 0 applies, but doesn't stick
- write 1 applies, and sticks on boot
- reading the *_apply nodes will show 0/1
- if already "1", you still need to overwrite with "1" to apply.

This doesn't seem appropriate does it?
Should there be a WO node for *_apply, and another node for *_save
(which would store/show the setting)? I'm inclined to think so, and
that this will add quite a bit of clutter (6 nodes for state, 4 for
mode).

Kind regards,
Luke.
