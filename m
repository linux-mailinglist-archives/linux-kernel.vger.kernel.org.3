Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2198B4F01A1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354760AbiDBMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354750AbiDBMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:49:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12C93EF0E;
        Sat,  2 Apr 2022 05:48:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 55B435C015C;
        Sat,  2 Apr 2022 08:48:02 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 02 Apr 2022 08:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=F1G7MAN3XjEeRj
        SELWEKW2o5UMZe0NatNffQWEI3lu0=; b=OHw2USsW2ISE+49T5S7RqLyRraE0DT
        Y1JRXPXWJRIsb4uIl0Q/SeLnjeghbj5RUU9jYALgTto76oXuPYQGiynX2Xgakvev
        hPMnJ0A0kG8Vnk7sYr760TNw4xJnmoA6T//cez0a+3/GMQdiyjRU9D7/s3R4HMK3
        SuoCTjvgPfGEMKFEe4JmVlFjDLaS5g+blti0o3aDeXZ09PXLhCqPF5EZvz0cmhsE
        GTqXgL5BXDnYm3shZkUwbJ6AkZNvMhUERgDsc8pxU59luiubBAfdX9JCxL/thMQG
        hO3THEo/QxSKzvYmWGMaQbd3q1hSuztnO8ilFaGKPrllVIT+SMfKhdfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=F1G7MAN3XjEeRjSELWEKW2o5UMZe0NatNffQWEI3l
        u0=; b=IKUfMzOu6WEJOXdgdPPMWcMtpJtHKfA9URXSipevmN8omSFZ1KEoDbGLz
        3FOhBOaAtwJqeX2fsh5EO6NjyEzfxaZJlKlDpy2VTpjuP5F3o/aKSbSHA4hOu4db
        L+DTgdDcKJ7qEDvpkudcQ6uv0KraU0e1MLmvApwbpNDYz1dBO8NSl9POgV3GKdsw
        8SQe0MjbDNaJF3Gyjyaoge6Pjp10e6p15UTgZU56qAabumYbFlPsUtPz8Rt5vXFo
        0oJza4eMn+u8xvFf7lfxoTSh8Aem0OPNM7RtVNtXEBU8iCycVUVsIs4oPRXZAybd
        smi3qUSKX66S2nq8+KgmaloGRr3RA==
X-ME-Sender: <xms:AkZIYgqyztkZDAPS2Bgta2fD0_ezCYD3ghxx-kpsG3AwfoXuP-L2KA>
    <xme:AkZIYmrmJIaPW1TWZ9XjAksJE_9y33EGkZScyhSXeIC7fqDKedp7KlkbluGeIEwmz
    PmZ2mxYR6rYsFsqI2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeikedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepteeuudelteefueelvdelheehieevvdfhkeehjeejudfhieelffffudfh
    keeileegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:AkZIYlOv0ZFsmv1krGdmscbs_03S0v6bCQd-Te8vLpoFPCkIEH0QxQ>
    <xmx:AkZIYn6kM1mro4aAuYoyVW2K_ifJwGzm-muynDsLwZA0S5eUdlsiqA>
    <xmx:AkZIYv4BMoW3KbxHAbXGiWbpIMEjYGQxpsHl5yrI3hENqYJcJHpdbw>
    <xmx:AkZIYswPNe2uMx7cUrSbErB9_GkYGRuYF68GOteYI_Xh4H6_yoOLbw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 249A927402C7; Sat,  2 Apr 2022 08:48:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-382-g88b93171a9-fm-20220330.001-g88b93171
Mime-Version: 1.0
Message-Id: <bd8d9596-6f04-48c1-b72b-b3ba1d45e891@www.fastmail.com>
In-Reply-To: <20220324061620.GA12330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
Date:   Sat, 02 Apr 2022 14:47:41 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "hch@lst.de" <hch@lst.de>
Cc:     "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Marc Zyngier" <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Thanks for the review!

On Thu, Mar 24, 2022, at 07:16, Christoph Hellwig wrote:
>> +
>> +//#define DEBUG
>
> This should not leak into the driver=E1=B9=A1

Agreed, I'll remove it.

>
>> +#include <linux/blk-integrity.h>
>
> As far as I can tell this driver does not support metadata or PI,
> so why is this include needed?

Yup, you're right, it's not required at all. It's a left-over from
when I hadn't realized that this controller doesn't support metadata
and still had it implemented.

>
>> +/* NVM Express NVM Command Set Specification, Revision 1.0a, Figure =
18 */
>> +#define NVME_OPCODE_DATA_XFER_HOST_TO_CTRL BIT(0)
>> +#define NVME_OPCODE_DATA_XFER_CTRL_TO_HOST BIT(1)
>
> Please just use the nvme_is_write helper where you are using these.

I didn't realize that helper exists, will use it!


>
>> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtki=
t_shmem *bfr,
>
> Please avoid > 80 character lines.

Will fix it.

>
>> +static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
>> +{
>> +}
>
> So where are the apple specific resources free?  ->free_ctrl is
> the callback from the struct device release callback, so without
> one the resource release can't be tried to the device release.

The resources are all devres managed but I only just realized that
the nvme_ctrl creates its own struct device that has to be tied to
the platform device. I think I'll at least need a get_device in _probe
and a put_device here just like in pci.c to tie those two together.
I'll also double check to make sure that all resources are indeed
devres-managed.


Thanks,


Sven

