Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE6530E51
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiEWKlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiEWKk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:40:56 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B931E3CD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:40:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B812A5C0032;
        Mon, 23 May 2022 06:40:51 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Mon, 23 May 2022 06:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653302451; x=1653388851; bh=EMKXFj9LAr
        oXlQWTomXiFUA0HkfiFEu3HdfpfxJwXe0=; b=YCutD9VidSwmq0Il+rc29wDiTv
        I8M/Ilkhjmf9DOa/WSXL8bmILSh0ODY8lIJEp28yShx+PyKvciYbZycOEeZNiiS+
        3vAqjZ1odQVw8YdCsCCJI9qwZDH1sNhgIz34A4n00dzAoaC09zt0pLAs6Uy3RQr6
        w5MWPEiWFPYbx8rKA32a85BM14p9GXlVBjcrdrWv2Y4XUlbCOXDxL8PtCDjl2IFZ
        g46sMUOiqC7xVQQTzLdXJGB3J4P9KGpruIj3ngJqbzCeTWVteSHx6uXn3Qkl4Ahd
        TdPzH0+7OaBoRhGYUJRiZ/hIyKVhkfxK8Ckta/tTqVh2I146TbaKn9woUFFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653302451; x=1653388851; bh=EMKXFj9LAroXlQWTomXiFUA0Hkfi
        FEu3HdfpfxJwXe0=; b=jLFr6D6Aox9hSWvTJ5zcSXRdk8697XeStSQWk6gDHFPv
        TIU3Xck85n19GfhJXRSckrxt6rLE/SggR5joVEwbByVGjgjNM84O1ZwYeZJXfboZ
        OQjRvk0bLq+fBC1mLI7eXTi1uoj4PjfYzXrACLu4bTqNm6Epw66GXVMyq1ZsiD4R
        K86PGfUeCD62tyJpVEvozReo6M/bKOwj6nBgURD4L2P33giDiuToMQS91xgQat/Z
        2vKqFRrKCzep5QkMPmtYFXNHXYn1o7gD0v3O34fOxgM4orC0h38JiNpPTJMN42By
        BZDJ8KquYZ8cJ4RrZUTZ4lc4UTgVvAoCI5DaL643HA==
X-ME-Sender: <xms:smSLYibFVBL6bSw062rZZOP_57nyeIlWSauk4n8m8fGVfejOyzyCEQ>
    <xme:smSLYlYxNvKDdIQusJVC_htsiRXtAvJnTbTvS6DhIAVJRGA63XYfP07-oTe6fH7C_
    RR9DsThUevBm2-1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeduucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveholhhinhcu
    hggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeljeeuveeiffeuvdefhfekgfeuffejgfeuhfektdeuvdffvdegvedvgeet
    leelfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdho
    rhhg
X-ME-Proxy: <xmx:smSLYs-dDtgR84q_3psxH2Hy6-8C6qnjT6JQLYGsaKeOF5_UO_hfpg>
    <xmx:smSLYkqXuGGaotx2AxjErVaLNF793ycQCBbWSPS0xC-bDhSnGEfb3Q>
    <xmx:smSLYtqqAFRC3tUvpLMFrVZ5tq9LEuHbRk8Vl6inaigymwmuMaxleg>
    <xmx:s2SLYue_tZGygCsxqV2IuQPZ1cq1ri5bnl7eGbVLs3uwD58gaDIVcQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 95A082A2006C; Mon, 23 May 2022 06:40:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <7963aad6-203c-4da4-ba9f-cf716d350121@www.fastmail.com>
In-Reply-To: <20220519092343.2776414-3-javierm@redhat.com>
References: <20220519092343.2776414-1-javierm@redhat.com>
 <20220519092343.2776414-3-javierm@redhat.com>
Date:   Mon, 23 May 2022 06:40:30 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Javier Martinez Canillas" <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Peter Jones" <pjones@redhat.com>,
        "Alexander Larsson" <alexl@redhat.com>,
        "Alberto Ruiz" <aruiz@redhat.com>,
        "Christian Kellner" <ckellner@redhat.com>,
        "Lennart Poettering" <lennart@poettering.net>,
        "Chung-Chiang Cheng" <cccheng@synology.com>,
        "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Subject: Re: [RFC PATCH 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022, at 5:23 AM, Javier Martinez Canillas wrote:
> The renameat2 RENAME_EXCHANGE flag allows to atomically exchange two paths
> but is currently not supported by the Linux vfat filesystem driver.
>
> Add a vfat_rename_exchange() helper function that implements this support.
>
> The super block lock is acquired during the operation to ensure atomicity,
> and in the error path actions made are reversed also with the mutex held,
> making the whole operation transactional.

Transactional with respect to the mounted kernel, but AIUI because vfat does not have journaling, the semantics on hard failure are...unspecified?  Is it possible for example we could see no file at all in the destination path?

This relates to https://github.com/ostreedev/ostree/issues/1951

TL;DR I'd been thinking that in order to have things be maximally robust we need to:

1. Write new desired bootloader config
2. fsync it
3. fsync containing directory (I guess for vfat really, syncfs())
4. remove old config, syncfs()

And here the bootloader would know to prefer the "new" file if it exists, and to delete the old one if it's still present on the next boot.

(Now obviously this is a small patch which will surely be generally useful, e.g. for tools that operate on things like mounted USB sticks, being able to do an atomic exchange at least from the running kernel PoV is just as useful as it is on other "regular" (and journaled) mounted filesystems)

So assuming we have this, I guess the flow could be:

1. rename_exchange(old, new)
2. syncfs()

?  But that's assuming that the implementation of this doesn't e.g. have any "holes" where in theory we could flush an intermediate state.


