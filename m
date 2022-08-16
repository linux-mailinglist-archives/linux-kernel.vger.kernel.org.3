Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021EE5954C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiHPIOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiHPINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:13:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E952BB682;
        Mon, 15 Aug 2022 23:23:23 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E20055C01BF;
        Tue, 16 Aug 2022 02:23:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 Aug 2022 02:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660631002; x=
        1660717402; bh=VuiWkrx0WjSNrdBUNlnlS2OD/zEWL0zC5/S13h+8Guk=; b=Z
        K/u0Gv6QyA0G7Im/MUYjWujaE6FWzgsjX134N54yWursw9wQQGfPeY3XSQCJk2Vs
        NKhGC+/7olLQZrRb/TQmPtj7n4PoHk8dqn32iC6qOyyHAFXGM6Y1PZK7hMtxHyvv
        dxYNyzImlIvPJwQQm8sEdRuHn+D8vV2zpy85YwQ5koLWBPalLsOaGVADV02CrB/h
        t1gNFnqCbTOGl5WLRmxA6DTUnDOB69lnIvGlxKP5Q43UmPmJ1PKpxe/+PFLPTsko
        2q5EL6BgG8ehrrd297cqVQaGXKUEMUSKicYj/Tgf16MZ57Ba7QHTDyCdLn5RV+1t
        ZuaVWtjkgZBiYpg1cdkcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660631002; x=
        1660717402; bh=VuiWkrx0WjSNrdBUNlnlS2OD/zEWL0zC5/S13h+8Guk=; b=r
        y15Pzl98naqAJIa+zfs5IXlw4hqmnb/smRxFK6dnO+Es6kE4Himp48XoN4Svs+Ha
        aXOo6R8TW9AoE3h3R8UvavJ5VsJYLHUEXANkFHKWhjY87mkqlZrNliaZDECRpXxZ
        e8xwm53qTlLH0vGYZ32wqMmKDwi2hFJlgRPz1RpLzNVJ9mDTlYf8moCw58TB2DSe
        XwonI+mZKa3oYkrs1zNce326CpcMYG7H7qKLqsBrTuC93Au3rhAuytS3HNBSpxVK
        frN8rWOV4wVTkkFM8m3wiDGYVIHdT0HfiB0dLvC49oXfNtEqQ08x1JAFzhwprjdb
        D0SJrZ54WXN1iPIyuRbwA==
X-ME-Sender: <xms:2jf7Ys4TH7Ts6rW_1mkCgl6jV0ml5XrOQGJ_jB4QvYaMaPGqdwYhxg>
    <xme:2jf7Yt6e5MoUpiuqmVkkph7HThJXUQ4PVGrwdlMvPSNBWrjWWvRvgfsS2w945Vpzi
    lGPCcinLpOhG-8WFrk>
X-ME-Received: <xmr:2jf7YrdwG7rrmDT972ceWNnPVidIkgltvU0w2dcDFhERTybpDO5dDJFt19YimXn5MoguwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepnfhu
    khgvucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepkeefffeujeevueejueegleelhedtgedvledukedttdffhfeifeelvdduheefjeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:2jf7YhLUisQKKUdBxzpOIC6QaRdP0BC4RMD6b8xOAe2vziSkfWCf1w>
    <xmx:2jf7YgI8gMK8R7WK0bUssh4c-bKzfhJ-92BzjNgrPscXgz_aB_Uoug>
    <xmx:2jf7Yiz1QZWtpPGMD4H73fsCtq2Msjt-4dE5c7SzqYmSyf4TitYTsA>
    <xmx:2jf7YqiPjX8q5JA9dEk-u6vPGG6KwSxvCITLr0wvkVWvuYo_1reCBA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 02:23:20 -0400 (EDT)
Message-ID: <14bed619e6a884f37403ec58aead34ff86525f26.camel@ljones.dev>
Subject: Re: [PATCH 1/6] Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable
 method")
From:   Luke Jones <luke@ljones.dev>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Aug 2022 18:23:13 +1200
In-Reply-To: <657998b3-0f26-9a66-8191-713715622c01@redhat.com>
References: <20220812222509.292692-1-luke@ljones.dev>
         <20220812222509.292692-2-luke@ljones.dev>
         <fc250b82-c7c7-9215-f3dd-be87e0a72edd@redhat.com>
         <657998b3-0f26-9a66-8191-713715622c01@redhat.com>
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

On Mon, 2022-08-15 at 15:40 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 8/15/22 15:25, Hans de Goede wrote:
> > Hi Luke,
> >=20
> > On 8/13/22 00:25, Luke D. Jones wrote:
> > > The dgpu_disable attribute was not documented, this adds the
> > > required documentation.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> >=20
> > Thanks for the patch. Note that the Fixes tag should be above your
> > signed-off-by and then the patch should otherwise have a normal
> > subject + body. I've changed the commit msg to the following
> > while merging this:
> >=20
> > """
> > platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute
> > =C2=A0=C2=A0=C2=A0=20
> > The dgpu_disable attribute was not documented, this adds the
> > required documentation.
> > =C2=A0=C2=A0=C2=A0=20
> > Fixes 98829e84dc67 ("asus-wmi: Add dgpu disable method")
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > """
>=20
> While merging this I noticed that this is also using spaces
> instead of tabs for indentation, where as the rest of
> the file is using tabs.
>=20
> I've also fixed this up while merging, but next time
> please make sure to use spaces.
>=20
> I will make similar spaces -> tabs changes to patch 2/6 and 3/6
>=20

I ran these through ./scripts/checkpatch.pl... I'm really not sure what
happened. I'll triple-check that in future.

> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
> > > ---
> > > =C2=A0Documentation/ABI/testing/sysfs-platform-asus-wmi | 9 +++++++++
> > > =C2=A01 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > index 04885738cf15..0f932fd60f4a 100644
> > > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > @@ -57,3 +57,12 @@ Description:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
* 0 - default,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
* 1 - overboost,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
* 2 - silent
> > > +
> > > +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys/dev=
ices/platform/<platform>/dgpu_disable
> > > +Date:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Aug 2022
> > > +KernelVersion: 5.17
> > > +Contact:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Luke Jones" <luke@ljon=
es.dev>
> > > +Description:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Disable discrete GPU:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 0 - En=
able dGPU,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1 - Di=
sable dGPU,
> > > \ No newline at end of file
> >=20
> > Next time please make sure the file always ends with a newline
> > even in intermediate patches.
> >=20
> > Regards,
> >=20
> > Hans
> >=20
> >=20
>=20

