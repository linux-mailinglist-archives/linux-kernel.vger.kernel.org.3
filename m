Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555C4F01FB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355097AbiDBNMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355083AbiDBNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:12:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5C136663;
        Sat,  2 Apr 2022 06:10:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 330645C010D;
        Sat,  2 Apr 2022 09:10:56 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 09:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=uQ8Ojma+yInShcILYo+mLtzhqnSh9b
        MS9txCFbqe7Rc=; b=Rx5AiT285BmD1NR36x2quZ4Ky5uw+aXPrUGeGyuyrDbZ39
        +e5MovBblY6YxBESEc/SCOB6CnzI0H0J90R7jF9gqGbRpu6o9mm49ua5cALpaUh2
        kWaacSt25ocKa6j4a4UVQruq1AwCnSxBD82X3wseqIhzG28iTjMcCLkNbvcQwp0Q
        dqQuXOpOtkvfMkyPWGAntmZEvDy9uXXCRGLMtefF5cgmj0LvB/SUQ5RMx2u96Q+A
        GywHPDtrYTHEVTbvfBB9WhdlzpnRNtxul7oK+3bSZRof/JFGEwBAGAYPO/D5RURT
        jhWpYPnmElgCs131EyFzKi8MV+/0ih/fYewQRYzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uQ8Ojma+yInShcILY
        o+mLtzhqnSh9bMS9txCFbqe7Rc=; b=DaHEwqIsdFgckFEc4sCL/Or4XueRC6gxn
        dVUvg1XIqmUZ+IyeTF4lZfREgZWi17+XK7O1on5FGWeg8PeCXAW9w4WDYRq1Pg5J
        SKsiUPmPrRKgI05z/ws7vJ5ybxX47DtlVik2JmaUeLeQRlyiFL85ECmqhO8hf+O0
        u/Uumfl+D1WbAmvFd7CQigfp4HaJnqfrqIhTwoWLhxDK7wFo6K4voHp8AWpbtvvl
        mSnfXXsev8lxDj8H3aCg6ialNx5118+9ov0mFboVuw7/GvusoFxTZ4kyrxR72BqK
        zmijXvFtNaaRjwKIcxIG52mGAztePeaNYepF/5KuSQgr42Azm2H8A==
X-ME-Sender: <xms:X0tIYvrG13BUSK4hwe3b_ZI8h2EViVGgvOcNzsFka7OEgafNOCYkNA>
    <xme:X0tIYppwEmso6_-_BQdcInOq2mnXAn_NYhOQxiB-bU4Z1oy9vbr9_hifLSvk1MzTV
    qZwa33LB4XZaXmfS44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:X0tIYsOlXHn_Xrx1iu-WHxRG2mghS1-75TzsPPe0lkylO7GyLyt8Jg>
    <xmx:X0tIYi4yBxgV9poVLrsmT6AKQroVAJQb-FJUA-CoRUXfCRi576mIcA>
    <xmx:X0tIYu510RQjuDBzFjI2HXcnzyTARyLHsVI4EGxqFdyIFCCCzqU0Eg>
    <xmx:YEtIYrxfWSxCPA1pw8FlUdD8AV2DP-ie6vxMmHuFSAArD803Rd7JRw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9E07027404A0; Sat,  2 Apr 2022 09:10:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <96fcc1ec-888a-4ff2-a41b-8cc352d4f2b1@www.fastmail.com>
In-Reply-To: <Yjivcz4BlCMfJBkM@C02CK6Q3MD6M>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <Yjivcz4BlCMfJBkM@C02CK6Q3MD6M>
Date:   Sat, 02 Apr 2022 15:10:34 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Keith Busch" <kbusch@kernel.org>
Cc:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Marc Zyngier" <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
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

On Mon, Mar 21, 2022, at 18:01, Keith Busch wrote:
> On Mon, Mar 21, 2022 at 05:50:46PM +0100, Sven Peter wrote:
>> +static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>> +			       struct io_comp_batch *iob)
>> +{
>> +	bool found = false;
>> +
>> +	while (apple_nvme_cqe_pending(q)) {
>> +		found = true;
>> +
>> +		/*
>> +		 * load-load control dependency between phase and the rest of
>> +		 * the cqe requires a full read memory barrier
>> +		 */
>> +		dma_rmb();
>> +		apple_nvme_handle_cqe(q, iob, q->cq_head);
>> +		apple_nvme_update_cq_head(q);
>> +	}
>> +
>> +	if (found)
>> +		writel_relaxed(q->cq_head, q->cq_db);
>
> Doesn't a relaxed write mean that a subsequent write can bypass the previous?
> If so, that sounds like it can corrupt the cq head.

No, writel_relaxed just means there's no synchronization barrier for writes to
normal memory and that those could bypass the store to device memory and only
become visible later.
The underlying memory (q->cq_db) is still mapped as Device-nGnRnE which prevents
reordering of writes to the same endpoint such that the N-th CQ update is still
guaranteed to be visible to the device before the N+1-th CQ update.

I'll either add a comment why it's okay to use _relaxed here or just use writel
instead since there doesn't seem to be any performance difference.



Sven
