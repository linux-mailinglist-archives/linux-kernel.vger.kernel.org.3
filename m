Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB54AF3DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiBIOOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiBIOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:14:20 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09534C06157B;
        Wed,  9 Feb 2022 06:14:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3FFF758016B;
        Wed,  9 Feb 2022 09:14:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 09 Feb 2022 09:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=TmJou/XbDJVWvQ
        v3YSL4bJUa/8221zv0DCH0YWYGppc=; b=m39aEsSTG/1rlyyX/TTWu51ZBaV5Ck
        iH8lf2grpzH46I2MRjyxDK6ggRR3JX3U/KYcHlXHddLSbDiLMtJ+gJtzCTZ/tmtx
        16SoijoR4OZY7tGgWIj2D4bL31Gw6fjb8uYIZjm5QY+eJCFz3jnjb7Br1nJwbvEs
        xreO2Onm+kwRHdnOMpJvAznTpJvv6zdIv7fXyGoNAIBXd+sErrp8xS1lVW3eu7NY
        yl/zQbU4iAsRr7uYGxQjNkl9f6X2y7e3eoZLrTbhFdy+aY6zZJEC9zogc/cBHnAO
        yFiR8N3feNYgCFvPe985vxVJLfH0+9S8VMyAJzSss0yxR2ayissJt9sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=TmJou/XbDJVWvQv3YSL4bJUa/8221zv0DCH0YWYGp
        pc=; b=D24s8NWFBRzM/pqaYTJ5dgrv5WmZp8+CL5gUVnY5vemFm6blxtabCM2z5
        1xHR60MUWH3LZUU63D2HCpc9xKVDl9ZwEhXs+X38cL1raKxJsPecnlJxLJ53HoJG
        cJVUEcIkYlohx5oWqPiJZtAJopC2t4hFGXjb3Io0g1NWRojt+x0Kx/uZllNP+UnF
        IWt2k7vx9sI8TBOEWvYZr8VTE43eRLv+1ArqAQJIminD3LV7T7ZJZoEu/n85zwGM
        M5rI64c0z6uIvGEx6Dvt2m1aiv0lN93LhOpd4XKtcRqY/ILe97xK1CUJVbqrtXCT
        iByuGQ5O79sKzOkhYkWxqtwyT49OQ==
X-ME-Sender: <xms:PcwDYiK6kPG53do9P_Gn6W23_zqbHMhJSeUPX3wh8Fq9Px1FW6hh3A>
    <xme:PcwDYqLoJz0bqEHGTll7Auwj9Qa_L-XnjNNi4yu8YO6Za7vYS0b-wzCn6IiyVBySD
    gMwc4YUA3cHclhX96s>
X-ME-Received: <xmr:PcwDYivxt82yjsVv18xnviNK9JIcqKQdFoYLiYus3KiebZ_PziM2ly3Y-g9S2pk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:PcwDYna9hbyhGdns6SPNJMM9H-bTDsrIv5AZq6a8-5xBw4-1S3_D1g>
    <xmx:PcwDYpZzNaa2Mo9hCvqBa-kS1ltnGYjDc9dEfMucsOoealvXpBNG8w>
    <xmx:PcwDYjCXye1iP4QturoMSL2SpUWrkHxMnxTyvUzhodsIlJaJg2bBZQ>
    <xmx:PswDYmQRm74ad1tLNDH7JH_IveGrad8mtvtVvmyOKS-pmOjtumVkwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 09:14:19 -0500 (EST)
Message-ID: <3133a629-eebf-928e-d6b0-72867d96d2b5@flygoat.com>
Date:   Wed, 9 Feb 2022 14:14:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <57805e19-285a-76d3-16e3-09a3eb7a9540@189.cn>
 <20220209085215.65qbdsgwtnvujdng@houat>
 <8e7f7946-b9e5-7c4d-f5c9-e091bf5f814b@flygoat.com>
 <20220209140432.ekqszxbtitmacpk5@houat>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220209140432.ekqszxbtitmacpk5@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/9 14:04, Maxime Ripard 写道:
> On Wed, Feb 09, 2022 at 11:56:48AM +0000, Jiaxun Yang wrote:
>>
>> 在 2022/2/9 8:52, Maxime Ripard 写道:
>>> On Thu, Feb 03, 2022 at 11:47:16PM +0800, Sui Jingfeng wrote:
>> [...]
>>> DT isn't really a solution either. Let's take the distribution
>>> perspective there. Suppose you're a Fedora or Debian developer, and want
>>> to make a single kernel image, and ship a DT to the user for their board
>>> without any modification. How is either the Kconfig solution or DT flags
>>> solution any good there? It doesn't help them at all.
>> We are working in another way. As we can tell model of the board by strings
>> passed from the firmware, we just built-in all poosible DTs into the kernel
>> and then tell which DT to load at boot time. So we can ensure users has
>> smmoth experience.
> It's not really for you to say though. Once your driver is in a release,
> distros are going to use it. That's the whole point of you asking us to
> merge it.

Ah I was meant to say we can determine which type of memory is best for a
type of board and then hardcode it into ST accroading to the model.

Though personally I want a knob in cmdline to override it at runtime.

Thanks.
- Jiaxun

>
> Maxime

