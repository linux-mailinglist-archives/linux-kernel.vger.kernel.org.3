Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0F84AF146
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiBIMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiBIMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:17:23 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B652C002B5C;
        Wed,  9 Feb 2022 04:06:01 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id B10325801E7;
        Wed,  9 Feb 2022 06:56:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 09 Feb 2022 06:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=sSoaJ00tNxOqOU
        g8CEfFUrCk7rxbGJHvq0gr3bBADKY=; b=TtUBXU1CqcfqNeznPZk2WxfjhYiTNs
        gMNqvDZWJN38DDEDERlnSUs9S18c55f6UIynjxuoVkEf8fH6Rg207EcxI6ty4SV3
        ACAuuaZtZpLm9qWU5/v25nIGfMzgzXesCi/TWxrKw+kC90hYIAqZPtC+erttQ4UJ
        lChn0v67/k+FInJz4kdPf2T/uNqP6xzYyYVaJJXgDYmdZGYrL02KBb6wHMLeCkLB
        qBa6wVNSHBiGEeebzOrEQhmrj7PhWCHPFBe+/o6/LFWH55pP7FJx424PRkVQ/6jQ
        B5dpgH3SoxQBoddzzBil3MkbTnFrNDZ5AGQP50LZtWwLZfYOsNNu2dPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=sSoaJ00tNxOqOUg8CEfFUrCk7rxbGJHvq0gr3bBAD
        KY=; b=V3ydhjnSDw12XaizGu576ElTKKtFuGCl5+Iq2cYUJ6YRk29dhASK4u8yG
        78xoxVtDAqKJYVODzEnhKgoeWxQCmip9KyO3g8M2aA6Sq66FRuc3KJifp752qQIF
        n3SJF4gytcrfLbMGtxSOJ7RSk0sKWNZ1sOkV/ImZ4Do5gYUEUllY9LVr3NTWkVm0
        XFCWnR/txmwFFL/NUKkT8eJ7Rr9ljf00cY5hquBz5PYOG04d52UuRyemp9q73vdL
        S3WK/P3+Q6JsfmUwR07/4CS36qlNPrCUj5BXVpM1ADsGvF/FyZizSnlvLiVOiQZD
        LxIROXLJXQ2/MGQq3uNhjhviTnq+g==
X-ME-Sender: <xms:A6wDYllVhj4Jcdf8XA97PwG2ut--DXQ_hlqlHlngkj8qtWCYMlBoDQ>
    <xme:A6wDYg1p4nMD4nUgg_zoRLWxqyazVMKZRjYEeTbn3Afoys7mcUYc5dYQE9minibj_
    K6C7N6UF_xlWWHh7UU>
X-ME-Received: <xmr:A6wDYrrAJNdU8a2J1EPQLJZgdkiR3s_EM8B-mAhcdr-6kLpqo0JsLIej7Ja9__o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:A6wDYlmXKNw9LxuBm1uBQMJNqUZ5zxIU5aNIex0LI-Hd0h0y0_7-hA>
    <xmx:A6wDYj0rkiXLRM76CGJN3qEdLXnfX5bklk_oizUINjmMsTZ4jSPzUg>
    <xmx:A6wDYkvTN5Wa9-7U0i_KAl0-maH4ohQ-7diZYVTw4097_tWOUvrnxg>
    <xmx:BKwDYqvmkj0AfU5uCgbqM4dT0U2_7kqWqSFoMx81RDeCnbAHrJI7fg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 06:56:49 -0500 (EST)
Message-ID: <8e7f7946-b9e5-7c4d-f5c9-e091bf5f814b@flygoat.com>
Date:   Wed, 9 Feb 2022 11:56:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
To:     Maxime Ripard <maxime@cerno.tech>,
        Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
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
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220209085215.65qbdsgwtnvujdng@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/2/9 8:52, Maxime Ripard 写道:
> On Thu, Feb 03, 2022 at 11:47:16PM +0800, Sui Jingfeng wrote:
[...]
> DT isn't really a solution either. Let's take the distribution
> perspective there. Suppose you're a Fedora or Debian developer, and want
> to make a single kernel image, and ship a DT to the user for their board
> without any modification. How is either the Kconfig solution or DT flags
> solution any good there? It doesn't help them at all.
We are working in another way. As we can tell model of the board by strings
passed from the firmware, we just built-in all poosible DTs into the kernel
and then tell which DT to load at boot time. So we can ensure users has
smmoth experience.

Thanks.
- Jiaxun

>
> Maxime

