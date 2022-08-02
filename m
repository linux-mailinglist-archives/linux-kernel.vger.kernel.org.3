Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12165587DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbiHBOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiHBOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:07:33 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC94225C62
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:07:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6234B5C017F;
        Tue,  2 Aug 2022 10:07:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Aug 2022 10:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1659449248; x=
        1659535648; bh=Gyb5nJMvA2GRmM1/gEp/D59ZBZHso6846VeYTzgqqNs=; b=i
        ORaKtLZmPcj3DuTYTXE2fI52PeNvJH2xiFGFAzfIyFVakaIbqve7gjHswbfl4XFu
        KPxj+aF7t1dMuPM802jgzy/5K1wGMmMdEkLACRWgA3j4WB9ooyLlDVIL2xbYCnAA
        Nj/JyZ5161YPdiiDuH6/hXMJ1wLFFXJCZBnyac6seqOGY9Okz+QpLjL0gjDk0SqN
        dLcArPYFdi9gbJ1UcVbZv3078X7yS73PbCDDiW1hSzkKkG+JuGzQPCINIYkuEh0J
        c8+teSsnzaFByaYVCuwILTzrPIdVSVru0Wt6g5XMPY5WhfYio71FYEOVzHt+1Lvw
        Gp+3KZ/fLIq5DvT9Uvn6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1659449248; x=1659535648; bh=G
        yb5nJMvA2GRmM1/gEp/D59ZBZHso6846VeYTzgqqNs=; b=OTlvxejnAGFgrqWqd
        FIlsxh7vzbkIVqGhsBxMo1BFKYp0pTvPT3UAoEN5ILYD3QCuDSgWHBVklDrDhEyJ
        1GQciK58KHQKQxJqR88ee8yRpLzBNyoDoCEfo5f2N597DVewSqxiVALtQGzmpp9i
        KWyLMdct5oFH0ABGSlAYTnf8zHOjXN4fLur6hIiRVcHqjjNoNQfAdD5pr6JvSYcI
        NkARcHRRSWOvZxpvXTcPydBM4a9o7lp4IdOjs6sNbB6MpmzQtB2tqigFfkdvH1mL
        oIr2iOILhk1seJ9wCfYQ7AyzMVQWYQYEeWXHQFrVc6+dclFmz08hJD7bLiZvAZsN
        ZxusA==
X-ME-Sender: <xms:ny_pYiDTOFzHTcXLbdNKS5Q0TckPKrQiHG9vdgcRaJW3KdTH9RDPTg>
    <xme:ny_pYsjAVvsH0o2vlgFfCoOSi8kdRsboqUL7wtD5ZFtjk2PkJrxvKIYhOch6m0EWX
    bGyv1ZGJtdoDQ>
X-ME-Received: <xmr:ny_pYlkd5BRP-AL6pPExwXNJyqRyZQcSssVGrWgdic3KMs_ldmIg7FISNJbI1XNwDLYOVe7-kpOypzi5DylYy3ihbYVVAoL2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvhedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeefvd
    etkeeuieelieeluefhtdeuieelfffhtddvhfeikefhkeehueefveduffejnecuffhomhgr
    ihhnpeduhedrihhnpdhkvghrnhgvlhdrohhrghdplhgruhhntghhphgrugdrnhgvthenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvghes
    khhrohgrhhdrtghomh
X-ME-Proxy: <xmx:oC_pYgzhbVi4j6Dw1zXSMzOuaUgki-2SVark329SONXNqQcyBCmKZg>
    <xmx:oC_pYnReTXqZeWNmyiYb1jeXH0NWrkSBsaL6yuwP-fwdvilpu2-Nwg>
    <xmx:oC_pYrYLpMFhBM2kFvuHZ1XLjRX3NJEmh_dyZSFx1Hflij_YfN8_MA>
    <xmx:oC_pYiEOKfqOYWpbMVWbTtBqzzqyAgHBL9FXBo7dpvQJOnXDzn5uqw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 10:07:27 -0400 (EDT)
Date:   Tue, 2 Aug 2022 16:07:25 +0200
From:   Greg KH <greg@kroah.com>
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: The r8188eu kernel module does not depend on the
 rtlwifi/rtl8188eufw.bin firmware file
Message-ID: <YukvnVWuhUeOgRyZ@kroah.com>
References: <YukkBu3TNODO3or9@nx64de-df6d00>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YukkBu3TNODO3or9@nx64de-df6d00>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:17:58PM +0200, Grzegorz Szymaszek wrote:
> Dear r8188eu Maintainers,
> 
> The old rtl8188eu kernel module, removed in v5.15[1][2], indicated that
> it requires the rtlwifi/rtl8188eufw.bin firmware file[3]. The new
> r8188eu driver no longer does so.
> 
> I don’t know if it should be considered a regression or just a different
> behaviour of the two drivers. I’ve noticed it[4] when I tried to use an
> RTL8188EU‐based card in the initramfs of two different Ubuntu kernels:
> v5.4 and v5.15. In v5.4, the firmware would be automatically included
> when the (old) driver was included, whereas in v5.15 I would have to add
> it manually so that the card actually worked. (One can verify the active
> driver’s requirements using “modinfo -F firmware r8188eu”.)
> 
> If there are cards the new driver supports that do not need that
> firmware file, it makes sense to not automatically include it. In
> general, I don’t know the kernel policy on such dependencies.
> 
> [1]: commit 55dfa29b43d23bab37d98f087615ff46d38241df
> [2]: https://lore.kernel.org/all/20210731133809.196681-1-phil@philpotter.co.uk/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/rtl8188eu/os_dep/os_intfs.c?id=06889446a78fb9655332954a2288ecbacc7f0ff8#n22
> [4]: https://answers.launchpad.net/ubuntu/+source/linux-meta-hwe-5.15/+question/702611

Looks like someone needs to add a line to the driver that looks like:
	MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
so that the tools will automatically pick it up properly going forward.

Can you make a patch that does this?

thanks,

greg k-h
