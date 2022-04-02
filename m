Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648D24F0301
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbiDBNyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiDBNyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:54:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207E5FF4;
        Sat,  2 Apr 2022 06:52:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A1AE15C0134;
        Sat,  2 Apr 2022 09:52:07 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 09:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=36fwwX5mmUYNyjISmlYXoRKFgt3R6w
        97RvAOP2q5fsk=; b=cUuNLTeleWise7MZASHJ6IlX3UrczALRQUBOL1BW44dcB2
        L/hBCFQzjUgFkI9YqLYga/ly177jgVktTyqjtfhewMAiryhg65zq55hpeD+Pt/OH
        JMFS3mC3zYsCY2upAgsfavDFVpj83O+E07vR7kBevcL/eSlE1kbQ4jtjVM2WAb2F
        x2YV4Seny+grOxRam/rHgj5PVunayPjSg1J12QgAUNNKygxXUu2TQkD9J0T0nL2k
        xNBEp5bC2Cr6DXEWjbVKZPAwDo+/S9ni2RVTgWxq/1flzVCbDWdsRvzsfDaE4Cxn
        QnMRT4VSZyKmsK/QUScRKcw3inEl9YH0lrUhLPEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=36fwwX5mmUYNyjISm
        lYXoRKFgt3R6w97RvAOP2q5fsk=; b=GvG9PTvkcxsekkVWwznmRdAMG6kL6aZJt
        gz7Oj6sR2KsFuYv9U5eZiCEBgdkT5vS5PIXm2UOWj2LLsdlSacHYX8Cf2zpExWy/
        6GH6oqgh/2jUKfEF3kB1NMp94hDL9A+J7iXMUsrt75RamS7aNCwjxpZctiHb0LIB
        kChPDXX7uEpXHLpe/x4MCYvhxL2FJjG98lmge2cmpwSyAa79nOETxLap4PhUnz3I
        dAYo+Nro40Ho4tGTGJlLVHVJ2cJ+/XIpda6gF6a+uK+g6rXmkFmbj2sib5DYuwVn
        LS22iLUAV8WsfGXocy0dxG7fepmHa7if98HmdNlEWaE+jpl5y6zSw==
X-ME-Sender: <xms:B1VIYhbXhwgAwvuFM98GzEnfsKQ8dOS8fkOyDHTC7tHUnZy21Bgmfg>
    <xme:B1VIYoZ0UlFGyHRWzEXrl7z_lkV3G5Dhhx9JhJqRggHwXMete47OPkpWmZkZhX7gB
    1UbW2O-nazEwz_ANUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:B1VIYj9ZtEtZ8CJowLn1UGImgyOPA2vXPYCg6e1--eZh_ja1dxtDrw>
    <xmx:B1VIYvoF8HAClmGI5-AakZMlbIiLdiuX64qGf6zqY7pBG0eGuoS94g>
    <xmx:B1VIYsrrTEbnpKYofNmYthJAmnf4GKZH2mwBkNT1O7prrUAbRNuW4Q>
    <xmx:B1VIYhSN9niLA87i-9d7f3ECFqVW5QH8kRaYbZ0X2B41PvY0MeQmeQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E83027402C7; Sat,  2 Apr 2022 09:52:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <35f5fdbf-faac-457b-a225-35d7141f6b2e@www.fastmail.com>
In-Reply-To: <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <5eed58a1-ee56-8aee-e73b-76b162d59873@kernel.org>
Date:   Sat, 02 Apr 2022 15:51:46 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Keith Busch" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Marc Zyngier" <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
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

On Wed, Mar 23, 2022, at 12:19, Krzysztof Kozlowski wrote:
> On 21/03/2022 17:50, Sven Peter wrote:
>> Apple SoCs such as the M1 come with multiple embedded co-processors
>> running proprietary firmware. Communication with those is established
>> over a simple mailbox using the RTKit IPC protocol.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  drivers/soc/apple/Kconfig          |  13 +
>>  drivers/soc/apple/Makefile         |   3 +
>>  drivers/soc/apple/rtkit-crashlog.c | 147 +++++
>>  drivers/soc/apple/rtkit-internal.h |  76 +++
>>  drivers/soc/apple/rtkit.c          | 842 +++++++++++++++++++++++++++++
>>  include/linux/soc/apple/rtkit.h    | 203 +++++++
>>  6 files changed, 1284 insertions(+)
>
> Isn't this some implementation of a mailbox? If so, it should be in
> drivers/mailbox. Please don't put all stuff in soc/apple, that's not how
> Linux is organized. To drivers/soc usually we put drivers which do not
> fit regular subsystems.
>

I put this into soc/apple because I don't think it fits within the mailbox
framework very well.
(It actually uses the mailbox framework for the actual communication
with the hardware with a driver that's already upstream.)

Essentially, the mailbox subsystem provides a common API to send and
receive messages over indepedent hardware channels and devicetree bindings
to describe the relationship between those channels and other drivers.

One of the features that doesn't really fit is that we need to be able
to start, shutdown and re-start these co-processors. The NVMe driver
actually doesn't need to send/receive any messages except those required
to setup the common syslog/crashlog/etc. interfaces.
The mailbox framework would have to be extended to support these specific
use cases.

Another thing that doesn't fit is the memory management: These co-processors
sometimes need shared memory buffers to e.g. send syslog messages.
They always request these buffers with an IPC message but then there are
different possibilities:

	- For some processor the DMA API can just be used and an IOVA must be
	  sent back. For NVMe these buffers must additionally be allowed in this
	  SART address filter.
	- At least one other processor (SMC) does not request such buffers but
	  instead just sends a pointer into MMIO space and the buffer must be
	  accessed using readl/writel. This MMIO memory region is used for
	  both the common buffers (syslog etc.) and for the actual shared buffers
	  used for communication, such that the resource would have to be shared
	  across drivers.
	- And yet another coprocessor (for the display controller) requests some
	  buffers with an already existing IOVA that than need to be mapped
	  specifically inside the IOMMU.

Each of these co-processors also provides a single function and most
of them don't even have different endpoints. And even those that do (DCP) will
just become a single driver since all those endpoints are very much related.

While it's not impossible to do all that by extending and forcing this into the
mailbox framework at lest I think that it doesn't fit very well and would just
create unneccesarry impedance.


Best,


Sven
