Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743B453D693
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbiFDLl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFDLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 07:41:52 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57D338A;
        Sat,  4 Jun 2022 04:41:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D2525C00EE;
        Sat,  4 Jun 2022 07:41:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 04 Jun 2022 07:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654342907; x=
        1654429307; bh=RBuggEGkGl6KrQneDZnBPmW9/bKWHPYv+xdHJioDFGY=; b=2
        eERrEKY0qwuefVCBxzafKkzzMS8qDQn4NNcvHsW0mDCVAHf7gBW8LFj6ZIzGF1t4
        uKerdAFzOARWhygja2imd65LxTNjnTyNztYQgwuLqMSukRoSSTqqpQkKwuUJkKDu
        dq8pycI04wmZ4yTP3a9+9BdmVaq4nXAOkpQsYzO9TBCWuRAwYdin+LEhTJTn0QcF
        /wEzlZrMgrCcl9qbiIWoBtqnnPcttDpTEM9GKVPnBefvbi0/vRiEOEIXOCfK8ILY
        0MWBIzsQojKajMBpWDauZdnJTjTLqMU0wSCItOAnuhIStkjkQKGraFo5aAjTBsTY
        epgjuJferPpdHvjNUeHrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654342907; x=
        1654429307; bh=RBuggEGkGl6KrQneDZnBPmW9/bKWHPYv+xdHJioDFGY=; b=f
        RayLOyvD0NZQ+gQn+d60XInBRcxLNsLYn817IdTp9uE7ac3kPDXzmsjC8bqmIKhD
        tqZEzykmSqFeNMaroxBVtk98mVxTqnqIC6DqZxr3eRpOtmJ4Tdr22aO0y+0ODUwN
        7jY3J+/DdceQtSwfCNPzg4KySAL+2crIPpIlg4eCS90MSCoYReUjEyb3PmOvAJx6
        q3v9fYomx/Z2D3ywsId5Y0OYBw0QLwxsygcqjkL4V0P2NdiWFbHWkDB+Xeak5KLO
        LvWxMZjACf66N+y9Z3olqkqiyx3xYgS0tl8ymJABphqxnnWZ+qOdC8mO8+CGlWnq
        gj/5C+zNncg6qSUqzCS1w==
X-ME-Sender: <xms:-kSbYhSLJ-NwctzAJDu2_5_SQ8vRy1pBMatD4UvcDhm0Uexw9nkHuA>
    <xme:-kSbYqxLMBUjMd4yCiPEEfrAS-SMRd2xbwMTMmIRZJWlH83OhMGbmwGmTQ-sHc965
    vW39acJdyacjMeoI8Y>
X-ME-Received: <xmr:-kSbYm0YfUsTeh-OvEEF0dLxCMlntR0Wp4PXi3KaBRE8P7_StzcsQ2lTxXYMdwxDp2Xbkdtx2262bTyXdKTMY4qV_Ci1AxZ-IhbeMRHdKbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:-kSbYpDAlNdTz2dQ5OkhCHMx32j8oYzkQourIOfmIsX1WbCWyslQQA>
    <xmx:-kSbYqghWxAHsDD8OsY7X9RMp5Dms6g2G4AtN-43aWv5jP6Q0w7XlQ>
    <xmx:-kSbYtrg0A4QcXk2vjcSI2bqTPmO75-G3b2a3ZcRrR5BT4VJ4eP61Q>
    <xmx:-0SbYlXdnSzb5kpKWOwTFyrBhS_M_bQ5JeDGvhbK2G5boEyo5MGuUA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jun 2022 07:41:45 -0400 (EDT)
Message-ID: <3ff0b2af-033f-f9d5-f6d7-c53c3e6c0858@flygoat.com>
Date:   Sat, 4 Jun 2022 12:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: mainline build failure due to fa84f89395e0
 ("irqchip/loongson-liointc: Fix build error for LoongArch")
Content-Language: en-GB
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, WANG Xuerui <git@xen0n.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
References: <Yps1Jw6PJdLBya1W@debian>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <Yps1Jw6PJdLBya1W@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/4 11:34, Sudip Mukherjee 写道:
> Hi All,
>
> The latest mainline kernel branch fails to build for "mips loongson2k_defconfig"
> with the error:
>
> drivers/irqchip/irq-loongson-liointc.c: In function 'liointc_chained_handle_irq':
> drivers/irqchip/irq-loongson-liointc.c:60:20: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
>     60 |         int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
>
>
> git bisect pointed to fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for LoongArch")
>
> And, reverting it on top of mainline branch has fixed the build failure.
Thanks for the reminder.
I'll prepare a patch for it.

Thanks
- Jiaxun

>
> --
> Regards
> Sudip

