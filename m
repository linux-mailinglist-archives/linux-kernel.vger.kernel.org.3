Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCE152F3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353261AbiETTcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353229AbiETTcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:32:05 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54267193239;
        Fri, 20 May 2022 12:32:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AD8845C0164;
        Fri, 20 May 2022 15:32:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 20 May 2022 15:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653075123; x=1653161523; bh=cqQSed8XRQ
        7quGXTmZG7RLWpQtZBLF7WVLzBsujlnyM=; b=gRZUUSOFsuPiBr24KzABbt2bcj
        CFXq/Ek6joLhQzxI0jX4tk8uw3937rE5OmyEXfcPC/4Ox7VtHlnGOh/gq2jFjSQ0
        4J8q6RKDKONPUa3zBGxvpWU0id8ou1xIf/RUonbkWajgfCLaGjRPBgNQKls+9j2o
        +dt5CtOldICJLbGQIElirOraW2y2DaPIRKpTi8EfKHSizyvMERjCHW8bWeB4xnIC
        mj11CHF2RKeRHrgSWMynxAodt7pFWD9Jo8yeEXCnS9VfGR18vrVGF2Zv2Zy9HSeP
        J0iilV5II6QMZlDnCL7OLarZjTFaoNFkGVyhQ6l9nanMpRsEkgzQjO66E6Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653075123; x=1653161523; bh=cqQSed8XRQ7quGXTmZG7RLWpQtZB
        LF7WVLzBsujlnyM=; b=hLE0wHjbuUQxnvrQCE/+XMrXaX91/+u9f+vM7HW3uUHk
        ewHDM1xFoG2aKlJmrf9CWZlQ8q7VwB3cT+Kf09mYrVpqs7QFrfglvapzXmXuHh59
        KDVezepwQlK7ZtBt9vnQ2awNreI4lvVq7lD8jSoJsno46b5fZaWy1sUVV+yaY6my
        g2UaVbwhy8eqZxdZW6ce6qzxzd7WwKEPQTmSNfb9LK22nA1AlsWfwUaPWyw9YZLb
        GGN6yEgvNmVJs5+gJ6DEVjH/KyZB5gW7tLD8BGa8SjHngaCiKE0ihVtFFEhxp2hW
        1iNbjWvBMRgk3P01SMyBObqRrq0ctPhaGGUiJ2EI1A==
X-ME-Sender: <xms:s-yHYr8sbt_ahioDM-gteqI-lLSXBeBZCGxmRlankpuIEgRv_O2dvw>
    <xme:s-yHYnvDJkgfWvUl1w2GEz_IyABmpWN2oDIsaClq5lI0TYw7ubfM-Oc8r3qYhx_PI
    hP5kV_iFgKsdA>
X-ME-Received: <xmr:s-yHYpAV5mKyAyk6RqN8nzzu4d3oEfJQMB5rkYLuliL8h5P6iuvvwy8kCA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieefgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:s-yHYnf6-djJmDCIYHVyBWqL9OIapmAZUu4VtSf2IqVqZ2H7C95fSg>
    <xmx:s-yHYgNTbk2wWbyxEpb1NP9HbBOoI61lCBS3ZgCCdLHuU7ULYTfB7A>
    <xmx:s-yHYpmmOLid0Ywfqw8q58a1aQef-Y8DdxdUj6iVlg2pyynD49Vmcg>
    <xmx:s-yHYhiCheU7ddNTgOwYBiLekJkYuabep5fGSuMlhjtaNPgkS2Ldrw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 May 2022 15:32:02 -0400 (EDT)
Date:   Fri, 20 May 2022 21:21:29 +0200
From:   Greg KH <greg@kroah.com>
To:     Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org
Subject: Re: [PATCH] siphash: add SPDX tags as sole licensing authority
Message-ID: <YofqOfHNKKRoTds5@kroah.com>
References: <20220518132345.40615-1-Jason@zx2c4.com>
 <87v8u0i0vq.ffs@tglx>
 <CAG_66ZSHrHpXu7mJ_-67QgdL2Ubrxg2BAtn3n3YECdHYDHtSDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_66ZSHrHpXu7mJ_-67QgdL2Ubrxg2BAtn3n3YECdHYDHtSDg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:53:50PM -0500, Kate Stewart wrote:
> Thanks for this bit of cleanup Jason!   Much appreciated.
> 
> On Fri, May 20, 2022 at 12:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Wed, May 18 2022 at 15:23, Jason A. Donenfeld wrote:
> > > The text "dual BSD/GPLv2 license" is somewhat ambiguous, and moving this
> > > over to SPDX is overdue. This commit adds SPDX tags to the relevant
> > > files and clarifies that it's GPLv2 only and 3-clause BSD. It also
> > > removes the old text, so that the SPDX tags are the only source of the
> > > information.
> > >
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>

Thanks all, I queued this up before the additional review comments, next
time I'll be slower :)

greg k-h
