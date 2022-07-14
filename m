Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB555757F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiGNXRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiGNXRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:17:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792F871BFE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:16:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C7B05C0089;
        Thu, 14 Jul 2022 19:16:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 14 Jul 2022 19:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657840616; x=
        1657927016; bh=FONg2bGJtmJ1Xycx7o6dOlmZb1WdDxtKAAFomE5W5C8=; b=K
        KFOv3s+MSUYK5qq9x5uY42bcGtNalZYRAYl3imZDKHc5TA0DSEHlXwc2pYpgS2mP
        bVsJCX2Ec27KD5QJiijJO4VX7b+IET2LDhHlquMCNRL59o78IwQ3FdPtkIlgvAkm
        9di0JTExG47PcdaAzfHS7rrOfT51IiY4BWH3LxSq/09/pqZyZPUf9PF1PBPtW+8x
        Ewlx+oS7EUoBf4W5oJMvlUSyVGjQ7V4W3LaysyCIFYUffMoxZlv6uX1WTraT41ol
        GiKyn78/OuN011wlL3g2z3kV6jxMWjkuQsSu6uH4PRiziAixTSXadGOl0MbRZPle
        vhZjy6qnVKBplOwWFMH9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657840616; x=
        1657927016; bh=FONg2bGJtmJ1Xycx7o6dOlmZb1WdDxtKAAFomE5W5C8=; b=E
        MAGFxeIMibG+L2v3RG8GE5TpSspc4ZloRNbBNOAE/RlXQ4EtQj3k/h0GqxjL7DZK
        msPftkQ1w4yY2SZdTg9SUU7niC8GNUJy2gVTfyj6vunjrjCYiWag8IOBgTg7pAQR
        NFKrItEF6CNjOdhWImpMZSINdYlWz6A4uPVBOFWPDeCUBpDVTxmhRmshlpBFVhT/
        KbzZxAcfMQPth3V9S/3BI7nytpIVLn9tvF1KDIINatveWvWiyMA6e2O58fYiz3OC
        aymkZaLhqWYGnWT41TYZwWRj9wmODBUCFXj9k3P0WT2qkcOT8IZNKVuYmiOM791h
        aY0OEYU7QnfnQ8Sq/u1VQ==
X-ME-Sender: <xms:56PQYkmAVfffG4i6IOUndK5-wImCYA0RiWBN8eaIcH_GgWa_XTz5oQ>
    <xme:56PQYj1R6_nXllY2HOkGZGA0k_CxjbNoGrLrHNNZg1GbVH1UzlDCtRtCDLHPgPy0L
    Xosu6iYcOeTB24wJg>
X-ME-Received: <xmr:56PQYiq9ypVOFjSD4RlGkgfumLYEk2RmrmcEPP3lvv6_CG0-kfrB9Pq99utcrjOjG0bRn4w1ALEj-D5ktkoFHyRv_GQXpmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudektddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredt
    tderjeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruh
    hsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnheptdevfeetfffghffgveekieellefh
    vdefudektdelueeiueffhedvhfeltdevieefnecuffhomhgrihhnpehfrhgvvgguvghskh
    htohhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:56PQYgmz4QBCawDKxRWW3OZ6uoVhHop-56nSLu-27i6YDNlT7T5COA>
    <xmx:56PQYi0Vgz0qZHjVi5sC2slmAanUzTM_cUrXkew-gSlwLi5Ef3o2-A>
    <xmx:56PQYnsOOQIKIZhWMucU_guDUlnmHGs2NX0z4c9TRLka0EoLl2Sauw>
    <xmx:6KPQYoOBCrD7XIHiFxVYj45fi25eBcMbm_wo9U9CqkLQVU4NJ-PgnQ>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Jul 2022 19:16:50 -0400 (EDT)
Message-ID: <9d18166d534dc30d83f2255d4512619aa6b3b517.camel@russell.cc>
Subject: Re: Linux 5.19-rc6
From:   Russell Currey <ruscur@russell.cc>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Leo Li <sunpeng.li@amd.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Axtens <dja@axtens.net>
Date:   Fri, 15 Jul 2022 09:16:47 +1000
In-Reply-To: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
         <20220713050724.GA2471738@roeck-us.net>
         <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
         <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
         <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
         <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 2022-07-13 at 14:32 -0700, Linus Torvalds wrote:
> On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com>
> wrote:
> >=20
> > If you want to apply Guenter's patch original patch:
> > https://patchwork.freedesktop.org/patch/490184/
> > That's fine with me.
>=20
> Honestly, by this time I feel that it's too little, too late.
>=20
> The ppc people apparently didn't care at all about the fact that this
> driver didn't compile.
>=20
> At least Michael Ellerman and Daniel Axtens were cc'd on that thread
> with the proposed fix originally.
>=20
> I don't see any replies from ppc people as to why it happened, even
> though apparently a bog-standard "make allmodconfig" just doesn't
> build.

I believe Michael Ellerman has been on holiday for some time, and
Daniel Axtens no longer works on powerpc (and wasn't the one that
submitted the patch, it was submitted by Paul Mackerras, who wasn't on
CC).

The proposed fix didn't get sent to linuxppc-dev either, so it's
unlikely many ppc people knew about it.

We certainly should have noticed allmodconfig was broken, and should
have more than just Michael keeping an eye on all his automated builds.

I would count this case as ignorance rather than apathy.

- ruscur
