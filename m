Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8F58D691
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiHIJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiHIJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:31:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75910F7;
        Tue,  9 Aug 2022 02:31:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CE9C05C0098;
        Tue,  9 Aug 2022 05:31:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 Aug 2022 05:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660037502; x=
        1660123902; bh=RrfMx3XRdnUfuzzc7yUQQwGDi3u7LUZo67YnJ/L3d3c=; b=S
        v4kAauOp+Bg34ycYRn6sJgSlkTLVCeURT1/04F+hamVybMPb45SJb3b5lWGLU1rz
        VLku2vbDlOSBws2qqYEuwvYsbHwfcGu5K9gym9H/dFLI1asFy5k7FTv/D/xKh23C
        J5lg5j2Qm9atBWdQGrXRq4D+39cx9Kn8RlOQhq3t/tYrbi2/LnmboPwKmq9Gwd/E
        /IUaXvUKQzE+srPYW9PiQtnrabe7QgN78/fBO8ikb1W+t5TsViRwAQKRjCXvy+Pn
        GLLU16ydP9SjpiNjO40I09c3kdYcdvTEozAg7vF8mQms5/RsifnoqZo576vt9cPg
        HdhIaKlK/r+bNPSua6X+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660037502; x=
        1660123902; bh=RrfMx3XRdnUfuzzc7yUQQwGDi3u7LUZo67YnJ/L3d3c=; b=s
        +WUAV6CkSStaUhLmmr8+38tBYjfhkBfdtEWK4iUFxGx8ETxPdXXjCwxmw6BRD2d0
        TQq365BVk2baaHmzs1InREXgvVS/pTPY6PABfcOA7IBic0jiSeU+I0iim3845bcs
        nES4qJb6gUl/3fljzGlPcbIEb/HTpom4wljt2q04iMUGjRH9AXHYi8gAhd513Anu
        6LTTJNsDprQMiee8HgL1eJ3dDhxaXC+xmMsb3mCs3qWiV7keg8Ng7Ms2islf5Wgf
        ofUEpjqs0qxLwBxcKzrS9KEW/LWaWMuCL/9TI2v4rxNexOsBwQ87f1qMJAPyEYFz
        B0Y/uv5YsVHyqtHY5Q2zg==
X-ME-Sender: <xms:finyYi97fI5uPBQIqpXxs5kGRxriswRHsyPUYcPDrUL5-ve69yx33g>
    <xme:finyYivJ9hocbzFwbB_oEbZEIjo9Z0UMTJm9JhAENI76H03f16Y3ivsjzfca4FB6s
    TXgaBS2_I7Ib3Hn5A0>
X-ME-Received: <xmr:finyYoCh1Oi-HJ8Ex3RBQmOHNfTKAuk4dq6u5hrbtTSkoN5Z6CT74zQMsRhkToqE9ybswg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvveffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpeejffejjeejueehueetleeukedvgfffteeigffgieffgeevhfejieekgeduleduheen
    ucffohhmrghinhepuhhitgdrvgguuhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:finyYqcvhVL7psKOpQp7XulgcOqmjyDGjmecEHTdS2HcqXJRh_V3bw>
    <xmx:finyYnMYvccqN9Vd1QacZZhWiIERS8J6RJbPaKPf8m_uCZ5yZpVI2w>
    <xmx:finyYklXZbSdCHeQao5XimVQpWPbd2Kxxq7kQEAKbtbTUdPjqdQBDA>
    <xmx:finyYgr9ewx0WNXGxSyGSEIcMON0U30_UR9XsWX-BA8FPz8xPz6Czg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 05:31:40 -0400 (EDT)
Message-ID: <6fee3e143bd339ac9e4e8513c96a3af2137a3b3a.camel@ljones.dev>
Subject: Re: [PATCH v3 1/6] asus-wmi: Implement TUF laptop keyboard RGB
 control
From:   Luke Jones <luke@ljones.dev>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 09 Aug 2022 21:31:34 +1200
In-Reply-To: <CAHp75VepmbLv1cx2cS6gbe_prs+cHZ0DYjJNkcuOXxeJaCqDGw@mail.gmail.com>
References: <20220809025054.1626339-1-luke@ljones.dev>
         <20220809025054.1626339-2-luke@ljones.dev>
         <CAHp75VfZeuuQjfM+CY4nxrFJQcfpdHVVzyj6GLjeweT3ycSn5A@mail.gmail.com>
         <AHBCGR.7I4U7CDRZ3J83@ljones.dev>
         <CAHp75VepmbLv1cx2cS6gbe_prs+cHZ0DYjJNkcuOXxeJaCqDGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-09 at 11:29 +0200, Andy Shevchenko wrote:
> On Tue, Aug 9, 2022 at 10:56 AM Luke Jones <luke@ljones.dev> wrote:
> > On Tue, Aug 9 2022 at 10:46:33 +0200, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev>
> > > wrote:
>=20
> ...
>=20
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D
> > > > asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
> > > > ASUS_WMI_DEVID_TUF_RGB_MODE,
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rgb->save | (rgb->mode << 8) =
|
> > > > (r
> > > > << 16) | (g << 24),
> > > > =C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (b) | (rgb->speed << 8),
> > >=20
> > > Too many parentheses.
> >=20
> > Uh, yeah. I was unable to find concrete info on this. I at one
> > point
> > experienced an issue where the order of operations *without*
> > parentheses ended up as "x | y << (8 | z) << 16". But now I'm not
> > even
> > sure if I remember that correctly. I see the order here
> > https://www.cs.uic.edu/~i109/Notes/COperatorPrecedenceTable.pdf
> >=20
> > I'll do as said and test it to be certain.
>=20
> I'm talking about the '(b)' part. The rest is okay to me.
>=20

Understood, thanks.

