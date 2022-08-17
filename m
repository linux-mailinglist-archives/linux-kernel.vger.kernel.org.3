Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10305972B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiHQPJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiHQPJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:09:49 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB69E110;
        Wed, 17 Aug 2022 08:09:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A625A580D61;
        Wed, 17 Aug 2022 11:09:47 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 17 Aug 2022 11:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1660748987; x=
        1660752587; bh=Khi/bs05TxCKfcNFvcfxvRz7OWau77FEzCskJB9DlNk=; b=K
        CnbBasmb5TNhSFnrDXDK4h/LIIXb3DDRyfAZ76Xaw7itkNSmT7BgFkBykO7oQ1UY
        Rek2tr2vhdGpplHlhKWW2/CqpClhfdY2HNWobG1xuvz+NIihnz/q6JpwIcmxg7Xm
        MlYC9Q/hd3JnVNghd/nlKRa+6CkPRbJZp6wh9q1AeAFWrih/qko4VJdEJYD/EDRf
        JEiEDhUa/NeD8ZLA72qnj+VaDgUn9YG8nimEiEm5soBO3BtltySLCDhZdJpC514G
        m2wgFIzIxHkxEQ0foSV9kyuipyNl7XavSx5NafMapZ+DxCpHc/Gky98IXXJ3x43c
        xgS+93ZkuxgymTFV+F5mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660748987; x=1660752587; bh=Khi/bs05TxCKfcNFvcfxvRz7OWau
        77FEzCskJB9DlNk=; b=ygRjiwT443ojTgeAPALaJC8noWRqKfejoFV7QjqXvlKs
        3c1aC16QQsGdmWhXxd6jW2tDV7rJRhQ3jfR71bTF9vtQdSrS3vrsvNL8DxldZR3j
        Gzv4r+rNwrdcpIa8XIM1aKGPrq2iAny3ZPuuZLrV1h6bjzMBxKIOjEFm2rJqaIuF
        IHPdsDwp4M+WpEVQOhUazCFQy1NxofoutfDZ7LYoecsmoptIuF9mKtZSzN4k3Kvo
        PPiMUXU8SYiBfkOasOvebGKWE8zms6v4M7yhP8yvGTa4G0uiyaz7U5zbb+GAz/Sh
        NYX9UKhzzrnAHCleE89z6JAeQkSxv8OT9roXHmCEPw==
X-ME-Sender: <xms:uwT9YnJ7eBRCnE85-_x1-9peHYIOeYntRl-JxsTyX-hz0VQr_wT4JQ>
    <xme:uwT9YrIXQ-csfrM7TplIVFZu2F6AtBJcQcF5gkHOyDo7zfV97tqH26galqbu7r_0H
    8CS4vkdcOs0FyUHqpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehiedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgvdeukedtfefgfefgtdelffdvieeltefgfedutdff
    leeuieevieevkeehtdehueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:uwT9YvtaU-qaEqUoeiFU9ui8sTOedymjpdblWxEmJWMilGXR-O7QkA>
    <xmx:uwT9YgargncjoXbwBhIOcKx7GyY1uxOraAf1qBd708tkhdiIRtu3pw>
    <xmx:uwT9Yub5FWKv7B0DcLmK6vlfc68LbTJfBgRjLolwdJ9afI5inPCmVg>
    <xmx:uwT9YjOho37Z662febgI30HnYQnAIhxF7h2IsXe6TacivY1c86dLvQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 44CB21700082; Wed, 17 Aug 2022 11:09:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
In-Reply-To: <20220817114933.66c4g4xjsi4df2tg@quack3>
References: <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
Date:   Wed, 17 Aug 2022 11:09:26 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Jan Kara" <jack@suse.cz>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     "Nikolay Borisov" <nborisov@suse.com>,
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



On Wed, Aug 17, 2022, at 7:49 AM, Jan Kara wrote:

>
> Another thing worth trying is to compile the kernel without
> CONFIG_BFQ_GROUP_IOSCHED. That will essentially disable cgroup support in
> BFQ so we will see whether the problem may be cgroup related or not.

The problem happens with a 5.12.0 kernel built without CONFIG_BFQ_GROUP_IOSCHED.


-- 
Chris Murphy
