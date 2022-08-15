Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA2592B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiHOIQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiHOIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:15:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AFE639C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:15:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7573D5C0093;
        Mon, 15 Aug 2022 04:15:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Aug 2022 04:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660551329; x=1660637729; bh=u4/Jj2z6xT
        pFpq+OkeTvo+MsK9KolKRKREU4Ridr0TY=; b=LTpRihqIH8Qlk1MQJT4EBSc5AX
        Yg/5U9QHiZ8H0Lq2kWRLDQZXox/+JpYNuUuJa3qC/qXQa8XARZyWuF3z5gQ7qKRb
        wxJA1x0NXHjiLGWGCGtY5C2ZzApR1s4gAZWUt68+rgpmfsZkaPlXp/yV0CZ51E4V
        ivhcGQP4GTGgfylHAfu0IP8d8wkUzi6LfBluqwDS/PPbLk9od89CYpCXX+JAbOI/
        VVoE6W1hoiUliNduOvhe2pxsQX7Z9hO3GILnEEzJbAQoPK6LgiZyeOUw8RT9q6xH
        sAcywphnWj8zFvHu6WQ/B4BDpx+bMYzjZJkV1dDafEmaC/jgCanzjqZPacFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660551329; x=1660637729; bh=u4/Jj2z6xTpFpq+OkeTvo+MsK9Ko
        lKRKREU4Ridr0TY=; b=eYNnL/hSgRXBppMWRFTog6dEk27ZQIIAPAALKIQMnn3c
        lbAsPIS0Dz4Cvmt7O/v1Ngd2lK7bGwj9iUurumF4BMyK3jm5r9kZWWLrfmCHJKQ8
        8NOKr++/7VRoh7/6hOvRur8VsRhN+28UK/ZLAuCl+Dkr+sV70EiTpb/VjCpOCiwa
        9YVCmnecI62+rhCdL8jri/JZ0KDl34LNgEqxQ7lHEsrdmBgI3+90pTb6MoEbFCBz
        fz+MvaEhfwwWniaYNa3NXoxG+aB9SVnzP2v3S8Dzq7jiBIVBFExGCZhxWrzeWgdz
        gSvJPsVLxC+Ge6Z7ajQYgz4FsVRhIsFTAHGCg11BZg==
X-ME-Sender: <xms:oQD6YsqWaKR1RK76UZHC639k-EUmw1Z1itHqjsFfOl4AIEtIOq1nEg>
    <xme:oQD6YirML24RnjHRaFCArwBGksEH9mi3AGSIeCksf0iD3e4MDuhWJptpkHX8WoUPh
    3A_cRCClkklhFBBWQ>
X-ME-Received: <xmr:oQD6YhMC4HXFEDu-Y6PX3J_yfx13yOmaddlT2S84gL5V4MS-7L0b_o19mnpO1LEEIA-cjH83jK9B_qFI7J5_fJbOpbB4_JVnsb1eMy83b-1lg3_EKQ7cfFGoUwk6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepvdfffeevhfetveffgeeiteefhfdtvdffjeevhfeuteegleduheetvedu
    ieettddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:oQD6Yj5gpRqhjgQf0yxKj0PiT9HNflR24xnrLkZ1fLYNAG_PdjbIdQ>
    <xmx:oQD6Yr5yTaaLG9WA0sTt5Dm6qQiPIxgfA2ojtIl9ZyjLBonUK17bEA>
    <xmx:oQD6YjgrH3B4SqFS_BX0TrQF9HN9k5gdTkIlYztrKz4vRqrKylxwcw>
    <xmx:oQD6YotCsU5lRl10NQr6QLMn1KrboGpdWR4bowB8tevP9wW0nkc8wQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 04:15:28 -0400 (EDT)
Date:   Mon, 15 Aug 2022 01:15:27 -0700
From:   Andres Freund <andres@anarazel.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815034532-mutt-send-email-mst@kernel.org>
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

On 2022-08-15 03:51:34 -0400, Michael S. Tsirkin wrote:
> It is possible that GCP gets confused if ring size is smaller than the
> device maximum simply because no one did it in the past.
> 
> So I pushed just the revert of 762faee5a267 to the test branch.
> Could you give it a spin?

Seems to fix the issue, at least to the extent I can determine at 1am... :)

Greetings,

Andres Freund
