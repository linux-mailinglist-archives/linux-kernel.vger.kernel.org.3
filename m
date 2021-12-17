Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639444796E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhLQWM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:12:27 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:45319 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhLQWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:12:26 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7744032007E8;
        Fri, 17 Dec 2021 17:12:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 17 Dec 2021 17:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=i
        72pxYgch0GKQxi1KRFw6/YrWp6fxCA2wazXup0+w90=; b=z3BYrw/kt8/7LtG9g
        Ms3+py9cW/VFt51s0Yonj+1GcesHcdlmt6SB97xzHOupjiHvp5wn1g40pQnPaMBk
        gEiiAhlMczahh9fTVi3h8ploSRB+Fw96H+UdYOYQ2NVaTyGol049nTQsfPToHL5Z
        CgNCxwDGP9UvZSZL9b+RryvOGiUAQCkZADrpGU88bDFeyrRBDnAf4cjeF8IUTdj6
        g0WOLKH/dpxLxtMujmnHEoK+CULLsprBMtVrHe3GObCkRMQdfgK8+2i5c3mxmZC7
        FXdSfCNTqa4VB9VoPCM2KbVNizAQRSO6wNQTbLzxW3fNkRE7nnl4s5zGF5T+dujG
        n4UVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=i72pxYgch0GKQxi1KRFw6/YrWp6fxCA2wazXup0+w
        90=; b=US0RSgjfJtR6lsT2/y2vlVaeLhoN6QLqep6K5e9D2TBM3bOxiomZ4fsoX
        83eO3XC7/2q7csm42NAXlFq1ZJeI6dv7Y8U5P7GXqodyCE4BcYbqGKTChNvQPrkY
        kmG/tVBgy1ZWUvxHKMDvRK1pRAZ4tGUkQvU/VZVaEsWSDVldkHhlFbHPfTfm4Vhc
        Ip57zP8W/2AGphj9I6WIBL3gKApkMP6z1djeUX6VIwGoSuLFSpEKhh5558LRaFpA
        zo4F/VMAast2R/3u+LGHWBy8I4onUm1+9bDxmWPaUTCN0GV0w5ZGRgwjWUFbnkW+
        8vlzbuE2i8JXfImcsXunroM0mVS7Q==
X-ME-Sender: <xms:SAu9YRWX4ecn-6ykZPWp4OvHe39vUnoYnI3d5Wvw9weK5GGYxsv1Wg>
    <xme:SAu9YRlOHC6GG3dqKz8u4fjKUOMOQUQruagLGvByV_OqsFmGKLy5T5zAMV3xp1mot
    Dp8YZTvcf54zEy4pT4>
X-ME-Received: <xmr:SAu9YdYOpLSaxHSHRCjgb4YLF8S6PzjhyrMRYiGrDRBS_hVIrkzUxAtHY9JyKDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehieduvdevhfekjeeftddtkeeitefhudekvdeiueeulefgleei
    jeeghedvkeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:SAu9YUUBWtUdcFIlf8lpWdbi_mBJIvhmanLG2OsFwmnP3DzyPA9ckA>
    <xmx:SAu9YblMVvK6c2pLSeYvCBCci3hj2I3i9wezCWDfeNB0lP_fcY-4hQ>
    <xmx:SAu9YRd9H2Hc40zg11l5oSjELedTd7oH6K928iNp9JkH6-PM1znP_A>
    <xmx:SAu9YUAmR8YVcOP62Uf9LhtJL_SSjXUOCHMtySQKZJDxFF-8q6FnBw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Dec 2021 17:12:23 -0500 (EST)
Message-ID: <dbff4beb-1982-1568-ab7e-2b12ad956a06@flygoat.com>
Date:   Fri, 17 Dec 2021 22:12:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] MIPS: generic: enable SMP on SMVP systems
To:     Sander Vanheule <sander@svanheule.net>, linux-mips@vger.kernel.org
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
References: <20211217183930.16192-1-sander@svanheule.net>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20211217183930.16192-1-sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/12/17 18:39, Sander Vanheule 写道:
> In addition to CPS SMP setups, also try to initialise MT SMP setups with
> multiple VPEs per CPU core. CMP SMP support is not provided as it is
> considered deprecated.
>
> Additionally, rework the code by dropping the err variable and make it
> similar to how other platforms perform this initialisation.
Hi,

Thanks for your patch :-)

However there is a probem that register_vsmp_smp_ops never returns error
if CONFIG_MIPS_MT_SMP is enabled. But generic kernel is supposed to
run on systems with & without MT.

So probably you need:

diff --git a/arch/mips/include/asm/smp-ops.h 
b/arch/mips/include/asm/smp-ops.h
index 65618ff1280c..864aea803984 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -101,6 +101,9 @@ static inline int register_vsmp_smp_ops(void)
  #ifdef CONFIG_MIPS_MT_SMP
         extern const struct plat_smp_ops vsmp_smp_ops;

+       if (!cpu_has_mipsmt)
+               return -ENODEV;
+
         register_smp_ops(&vsmp_smp_ops);

         return 0;

Thanks.

- Jiaxun
