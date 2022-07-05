Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264AF56627D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiGEEps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGEEpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:45:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA8F12A8A;
        Mon,  4 Jul 2022 21:45:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CE7795C0063;
        Tue,  5 Jul 2022 00:45:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 05 Jul 2022 00:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656996344; x=
        1657082744; bh=tPQtmorrl9dWM4HSSLWqz6EkyqIHzsJgk0qOy0pW3Wo=; b=B
        lmkub46x7P/tkFEO3jInh/UFYaz8ZEb8ijxRY/G1w24621vO8VrSMyxiqghjo8Eh
        FFWoyFiHLSFaTcdMi2IAfeiGst/jrCGYNUCb3LEStq0J2PN08NrXcqXtoIA1kbK5
        4oWPiOAU2qRXTtBFEHD7WE8Bz2ThRb/QvB11whLjGH3Wxut+5bwLp/i68RPLmU51
        AKt3tpui1vcKCO2FfVBXdbvJph0n5X/uqwDsTIMUgJw5hnkqh4xm/7d4oM5YwxYj
        3Y1BMp+mgi+KUTRtIwScuSr1v3DfGgC92B+uRU1x+29RGYGoC7wNMld5zsk2j5PS
        NwRCMm5j3YXr2bAG2Nufg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656996344; x=
        1657082744; bh=tPQtmorrl9dWM4HSSLWqz6EkyqIHzsJgk0qOy0pW3Wo=; b=w
        EFxY+kg4TH65Kbozw2xxEf/c7YsoMiQzDckHBTWgm4MzRkokC8W66srO+u/Vnelv
        Ef9PykPkiyrSdxGkJFJH5tjBQomotd0nK994Jna17Ky2aafC62lVXdI2aLXjz2Dh
        hU7ov3KuPusliXhksGC5qOlwGzWfkkS3bjEt6ZPackXaAkjCB78DmtVcBlLxonZh
        hjjgRYdostD8jdXExbi2wkR75K0b1XqDxLSONS1AE5mCfyaEiup7TnjnIcZmuqY7
        WOPqSIgq9BDPVxg/hA9KNhsC0mFqGDLdvFoHy8AQmPKaM3L0HrcmN4w6W8TrWnqa
        gL4iU9KcV9L44+Z+ej4zg==
X-ME-Sender: <xms:-MHDYuBCgD2y8IHGI9TGPnFAK-DYV0UrAE1PbwcZFK-MgfUhal2dzg>
    <xme:-MHDYojVJ5ooz1rDhRskC4WLMFbt-cZp19Em34SngsgfZGIiFkuIUFrzoE9LKblnD
    xu8PZG5q2EcVhniiQ>
X-ME-Received: <xmr:-MHDYhlzji3P5u9sEoREquUfWCKvzTts9LXxsQpWU_8-_KirE2Oxq-KgBN1dPoOeph1KLWpkjaBYkvcBGlkhZR8H4O5AYQZCUy5zaRDCH8RCXq4Zx7Gkc3bqMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeitddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:-MHDYszj_m70wRzvucgF6-655LpTGUs3ZsZyXDsVmPgU-WzYhFwD4A>
    <xmx:-MHDYjQKhGeDsl5_19R57G7TXtzq_eHKgGQRn5R0346mHjqIvgUWCg>
    <xmx:-MHDYnasObXryWHCL6imNlX6O_A9csWUmp3hD6dT123_j3ZHVC1Yag>
    <xmx:-MHDYoKRkQAL-jPimyNl5eb0cOUJomdl8uYKyn2h-w_Xv-kYcDEoyA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Jul 2022 00:45:43 -0400 (EDT)
Subject: Re: [PATCH v5 1/3] ARM: dts: sun8i-r40: Add "cpu-supply" node for
 sun8i-r40 based board
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220517013607.2252-1-qianfanguijin@163.com>
 <20220517013607.2252-2-qianfanguijin@163.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <a5e44108-3f47-c995-fe6f-22ee5af144de@sholland.org>
Date:   Mon, 4 Jul 2022 23:45:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220517013607.2252-2-qianfanguijin@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 8:36 PM, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> The CPU of sun8i-r40 is powered by PMIC, let's add "cpu-supply" node.
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>
