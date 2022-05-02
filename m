Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED0951726E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiEBP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiEBP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:27:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B88B13CCF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:23:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 169243200999;
        Mon,  2 May 2022 11:23:34 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Mon, 02 May 2022 11:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1651505014; x=1651591414; bh=j3
        oztXfiiTixSHUSE4nMfba+UoAMiIb0UBPpgppAZF8=; b=JVXOWOnT9nOTpZZ8g9
        Pzwhtiw3h5UVMarY9Ztfd4jI9lF8wfo8imbsRHIy1tlWfOBKihrxmP1bCVwmGwLl
        n6TmrgXXQ9q2QdBHEppAymCjQJfJUPZGOrzWZmsV0hQJspLENnmjORijEFcICdFa
        hat4Bg7dL8ecMiK2OCHCie9ahWp2hraAuKYaylvMMTwwyWhRR3Pt1xX4qwnA49O6
        RLxwufFjfpkcNv0SF8cVvNRySDzOxnAmXIkAxWk3U9RWe8Q8OOrTFrw3E9y2hbK5
        QQsZh7RgALmFIvJjiPuXjdcBETfp60qNmBxT5BDh2uvFvfQX4PetOAsFc+D9aQu3
        CIuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651505014; x=
        1651591414; bh=j3oztXfiiTixSHUSE4nMfba+UoAMiIb0UBPpgppAZF8=; b=I
        iWhGgMtgZiNuk5tUlfpYB5YIpVB4uKcJVrRsARRpw6iMZJlCkFytVVzsx9zXQmlS
        V+CQEiPI9/9D0j4GyiEa5qf9f79bkNZxAOxFUlQk0Ihjt+YQv30KCRZMddHBWoxh
        k4mhDNH6C5rb+9GAV6iQozaHQW9k4w4uNSfs1GGBje8AzejevxXnHk5NFs7Dy46z
        McHngw/9f7lASeUKT2lE3upNLl6PJTjB5Isjke54WUkaeTMpw9/nCkYIr5vixaF9
        KZdqD+uAzHalUPMMSYWboaj118jFeLoxk3CGJyJeEL9FgZg9GsWUlFD4+zUoPS3y
        mW3j1FaSKKF4CQbFDaSyA==
X-ME-Sender: <xms:dfdvYh3f1NqxGT3aNfT1NrbvS9Dakn6wg9Gn2eD0_kRIisqHxT3PTw>
    <xme:dfdvYoEpyYkvvd_KlxSVOL8TWizGC8gNwNgAC6-UmOueQyDG-Hkbn5C8TNbpj4Rxk
    PSEfVKMB3BB-NRpz3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:dvdvYh7qPH6er5JU0BFHVwdHS1vjgGCkwFkIzkLh-apI-SophSKHYQ>
    <xmx:dvdvYu0O0pYyoRy6c7ZYDAOIr7Y3pJBoGoX-MvD86K-EBGCZS5hOTQ>
    <xmx:dvdvYkENmXUMqtLpZrydrXkqYxtIxLhRFs7XHr5IM1w8dd5wz1nZSw>
    <xmx:dvdvYoBN1hM4SPd7BlzjXHoMKEhqgsVkoM_OTH4jmHLR37tFKRXFEA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DE5C7A60063; Mon,  2 May 2022 11:23:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <373887e4-2012-462c-82a9-10c70f39dd9f@www.fastmail.com>
In-Reply-To: <20220502092238.30486-1-marcan@marcan.st>
References: <20220502092238.30486-1-marcan@marcan.st>
Date:   Mon, 02 May 2022 17:23:13 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Sven Peter" <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: dart: Add missing module owner to ops structure
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022, at 11:22, Hector Martin wrote:
> This is required to make loading this as a module work.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

this could probably use a 
Fixes: 46d1fb072e76 ("iommu/dart: Add DART iommu driver")

but otherwise
Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,

Sven
