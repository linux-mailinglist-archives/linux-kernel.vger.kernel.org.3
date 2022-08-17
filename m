Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ACB5975A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiHQSSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiHQSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:18:33 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AEB25C79;
        Wed, 17 Aug 2022 11:18:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7124A580F8C;
        Wed, 17 Aug 2022 14:18:32 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 14:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660760312; x=
        1660763912; bh=GTnimwUywZDBseYTSOsg41R9INlAe7lXIxbkXU7vY1s=; b=r
        bdxUS2VrJ6gpO0Z28L+c5OAHuCB1ceXz1gqGsVC5IldclpPrwj6TpjZuEy/Zrwjy
        aXT2KJpxK1fkxIUevzBWnXaAMFS7tfHyV3pC8as9YZjREVzT/SHNVRqUEynBZhJW
        mUdMNWj1+LniYUUzD0Br+0vf+QLUfbv3VxcCTbtJE+VdnuWuGtdrL3Rs/YoyXGgq
        Q2AORZbGfywgYKpFCrSXy3OcfPMTmFshW3kEIDpposIlvTFS9h6APUxNwI8oTPzj
        LfWoJTwRH/qAM8IiqOOmSb00xrPx2EsRMEpT/ze0M6+aw8W9pXEx70zpe7lk5b4k
        L6B0qNSfQxImQr55t+e9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660760312; x=1660763912; bh=GTnimwUywZDBseYTSOsg41R9INlA
        e7lXIxbkXU7vY1s=; b=2Rl7zFXmWgn0czl5UPtrtnH+aANzKZgVzCLaMyCYcgjm
        Lz8MDxaenLZq7NyKm+HSw4hsCZttZDHaPwdBRtfJEpOJm0qXG8LCOx7p0Sp4CsGf
        7raw1v7OFOCBNCjI+sehEC95oER8tjydKRiZTAOv1s5sPYvNyUbIJyvuSwedawFz
        fsTWkmWN2ggPq5HVPyOQiFSWVxzZWZkENpe0t39rmNJJGeAzdUg/wOefrI6eDlQF
        /hgWliitU5nwPPqiyscmaQogoG0KlzuuRwm6he9fsl3YZDuUaYGRpfCmPNqVmrvc
        E8xq7VldKuBqHNns2UZyci0rgVNam7tcukVDh2F3YA==
X-ME-Sender: <xms:-DD9Yg9sNxzKCMPe7l6Um1kdwVHX0sKOAeL9op3vi4iP-RmojigHcA>
    <xme:-DD9YouYeLbHfKAOSr1uPd1Ipv5PUjBngFwoXbfrFNWH1qGbmRCiE-24qRJmjy9Mu
    _cfx_XiM8j0FhSp5Vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    hhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtg
    homheqnecuggftrfgrthhtvghrnhepgfdvueektdefgfefgfdtleffvdeileetgfefuddt
    ffelueeiveeiveekhedtheeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:-DD9YmAt6ivivrL6LPVu4JaEycUJKuFd_nS-fbqH1Ax9gxXpH-XBtg>
    <xmx:-DD9Ygf-3HDX4UNi0jzWuYHNbjMcZVmkti0TuMwjHtGMrQv_oi8fJQ>
    <xmx:-DD9YlM3ChdRbmo4vvcwtaLXHPN5ySyeucR7qp8D1DdA4I7xRjBq_g>
    <xmx:-DD9YhDzI9sU9KMNE9KG27QrngZxtQXM7cRnWGvzdvoINCnJwRAAEQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 24D4A1700083; Wed, 17 Aug 2022 14:18:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <e4c260da-2df7-49a3-a8dc-1d3fc7ca12a0@www.fastmail.com>
In-Reply-To: <20220817181554.znqljc6mmci45ukd@quack3>
References: <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
 <20220817163059.kigrvdfmxfswmhls@quack3>
 <f6f899a5-97e2-460f-ad73-73d4b5e38eb6@www.fastmail.com>
 <51cd43f9-ab6b-4dd6-814f-e0c1ace3143c@www.fastmail.com>
 <20220817181554.znqljc6mmci45ukd@quack3>
Date:   Wed, 17 Aug 2022 14:18:01 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Jan Kara" <jack@suse.cz>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        "Nikolay Borisov" <nborisov@suse.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Paolo Valente" <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 17, 2022, at 2:15 PM, Jan Kara wrote:

> OK, if this indeed passes then b6e68ee82585 ("blk-mq: Improve performance
> of non-mq IO schedulers with multiple HW queues") might be what's causing
> issues (although I don't know how yet...).

I can revert it from 5.12.0 and try. Let me know which next test is preferred :)


-- 
Chris Murphy
