Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F753569EFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiGGJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiGGJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:58:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A304F19A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:58:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 33A553200901;
        Thu,  7 Jul 2022 05:58:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Jul 2022 05:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657187896; x=
        1657274296; bh=blIZCyCRaX2Kykl2XYQhF1kcXz91lm/t4KZgjyH+ZSU=; b=U
        jWvfp3BGT724u6qaVZOepvcwjgDtug4sqsJGq7/sCMaBVbNaY8dKYhwUUCqGlgzW
        yKbrVoLvr/yBH7tMxOaBxGnArfmgCM01YWSunZjDCk4QA4gmXelihCT8qzA4h7tO
        fbwBogSGdHwWGQpc2vDO4FYtM9t1LhpTbYO47n4ul/3ebDUPjn8YoJhGGXMS1p1n
        uPynTK2HtNt1UTcNvs1bVR7MZzOrnk0eBw5DyVKoxxGJl74Sds/ScU6uWwdQYL2S
        i9pZ5nMh0HavCCe5YszT4Xb+plfg/O7ezCxn/UBVMMYfavl2g1UlhU43gPdP2feA
        5RsGL+WmgCCzpEuoPeEpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657187896; x=
        1657274296; bh=blIZCyCRaX2Kykl2XYQhF1kcXz91lm/t4KZgjyH+ZSU=; b=f
        f2K2vPEEaVg45MA5zpZZ6E6RtM0VZRK3uni3dVVA498kXQqr/M2LQ/plFWsw2s7q
        cJ6gMDlrX+mMf/ixkOQdbncGcV72IS7KF2KZn4P1ClMbpOkYyj+xLHJ6kxCQtpXi
        +sKeZwXVEd8SM/nvvNPc3Dlh8uv2J6dTq2k9pVtwrfI0jL9h7yZDtRFWzOLZPuYd
        +8Po+bLlxdBuHYos+iYwxbiuofaZGN5h+cFXMNzaDUOLe4Ngcob2VPMKwHLRWM2h
        EzjiOOti1MWmbNI7X6KtRzF6t0eomwnvVtGnNswRgRNdiQPoVxIEmL5dOxA5+lh7
        wyXvcMMJ4GRQE+9NLGTQw==
X-ME-Sender: <xms:OK7GYicSPJdA3n6VN9QQiZvc115LX9eCMcCRWo6v4-yaelBXmZlF3w>
    <xme:OK7GYsPgzDLT_xunQDkncSVu2EdX76G7oeShBPUWqSgMwtKeAaSVw0vjmWFc-59Tg
    JfEVGpTrUaP5UiLtdI>
X-ME-Received: <xmr:OK7GYjg9T_jcYBz2iivNqw6Zc991v1rMtyeIJFawv1iFRsPDM_4I5NuJ4sBGRgavD7cuW2TJQrurDy10TDPxU7WOaat-eei73ssbddcIwNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeihedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepudfhkeevvddtueekfeefgfetlefgueegueeltddtieejgeei
    heevgfehgfdvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:OK7GYv_MQC8eTz6hABoOIOlQlYSrEVS7o2CrmNTl1wS2rnfvQcaJtw>
    <xmx:OK7GYusmHLDClTO6gpmZaLqU0uyENVdxtiy-8TrkXFBEVZ0uAjZA7Q>
    <xmx:OK7GYmFQfnL6allvSrvn-H_Xq-OrcdXFq67SYeNYTe_BT9FoLrJnUQ>
    <xmx:OK7GYiIB4vjqPLaA5Y93IKg6Ij3_YN091oKDp-ZBYp8dM3JxhVMxKQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Jul 2022 05:58:15 -0400 (EDT)
Message-ID: <bf9d6c87-1264-6d14-bf67-154ee7795bdd@flygoat.com>
Date:   Thu, 7 Jul 2022 10:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] LoongArch: Remove vcsr in loongarch_fpu
Content-Language: en-GB
To:     WANG Xuerui <kernel@xen0n.name>, Qi Hu <huqi@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20220706112937.1218573-1-huqi@loongson.cn>
 <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
 <8a9cd14a-54ed-cd2b-88ad-647a43b09d0e@loongson.cn>
 <2e0bb05b-cd85-4eb0-bf8f-f90156196a63@www.fastmail.com>
 <0125879d-7452-17bc-8b46-3d4ae21648d1@xen0n.name>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <0125879d-7452-17bc-8b46-3d4ae21648d1@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/7/7 9:56, WANG Xuerui 写道:
>
> However, the experiment result is counter-intuitive to me after all; 
> are you aware that perhaps *some* 3A5000's in the wild actually have 
> functional VCSR? If so, the state obviously needs isolation 
> (saving/restoring simply becoming no-ops on later steppings), but 
> otherwise this cleanup should be correct.
^ Yep, my concern was 3A5000 with VCSR enabled can be vulnerable.

Thanks
- Jiaxun

