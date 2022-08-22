Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28A59B700
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 02:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiHVAXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 20:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiHVAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 20:23:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD503AF;
        Sun, 21 Aug 2022 17:23:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 63E205C0183;
        Sun, 21 Aug 2022 20:23:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 21 Aug 2022 20:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1661127792; x=1661214192; bh=+zNgsAGmXbExkylqMIpidshfU
        kOgsclf/BPqr+bOrXo=; b=a5OXRJjCxp1SgQnWJ2bvPslnliwdjuQPaASjuNMqd
        CkOt7Xx0bTXA+KYWLfibAgTdiA74GeokttfReUm5rrV8tPLKxpExU6SUKavhFf2y
        XiOdcKkseNhER2oJtONeO0uJm5Sck1r1A0+zjpvX3GAYOwgAxyAZMLRkC4r3oLQM
        EuOus2gL+n9/hsXTNQuVPV8CKoGsziagYfaWB/IHNw1GOZoFvRxev6JsJ1UWsYl5
        QMfYAYKMLYf3JmPPxp223u/bgKvLn9R61jEMHG/3iGYrDvmTmZIrtlvLe+Qz14bo
        MOIzDceDw4K2fgXcrFrLcAvCkgGvQu1LBYg8+ddG1JfgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1661127792; x=1661214192; bh=+
        zNgsAGmXbExkylqMIpidshfUkOgsclf/BPqr+bOrXo=; b=see+EMnXNoWKlmNDx
        mLWp9rJq5bv0hnA62mQr0zhTrRQgjc16G7bZmzUxs51tnDFAy3ojA4bMCNzQI6mo
        NG4DFlvAb6fKZZkKLI82FiDwoF4nLjsfCe3n0VfT0cFM8Tv2Nnf64P1szZ04mO5j
        XDLWlimrh7fIt8IKb1WfhUFRkufChPADPLEE7MXRxk/vL8+SNlwU0lqVkHKc3x8F
        o5c7Yrh5RmQkPmF0rTjrknlzVNPfskHk3CJhUTlU097AKmT57imgAsrweDwzIOjs
        vfAdNyP0sUEMd8dAiAFQ70s4LxzH/eW1guQVK0mIXabbBfa0necrYVdzQnoU29DX
        qEkxg==
X-ME-Sender: <xms:cMwCY-CkUuFf4OHfFiveFnV9iBpH2QTT3-xXJ9lH7szRCR4nOkGg9A>
    <xme:cMwCY4iPx7apyDWRxdEmLaovjqxI9JdZvli6aVWiuc4RIY_bszcRhkMmyKpPBp5Tj
    nn4UzsUqDmDZala0w>
X-ME-Received: <xmr:cMwCYxmlrFbmSC_zSrojVfhhCgzlWAl7RMG8QN7VJ5Bjcz8Dn-pyOb81k-buSx0l7AKmIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeiiedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfuvfhfhfgjtgfgsehtke
    ertddtfeejnecuhfhrohhmpefvohhmucfhihhtiihhvghnrhihuceothhomhesthhomhdq
    fhhithiihhgvnhhrhidrmhgvrdhukheqnecuggftrfgrthhtvghrnhepiedtleelgeelje
    egvdeuleeguedtvefhtdeujeektddvleffjefhleethfeufedunecuffhomhgrihhnpehr
    rggugigrrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:cMwCY8wtxinZO_rEoKDKlgdQEhiXgayHjSbzVrMox-uJvwAXuXVFXw>
    <xmx:cMwCYzSM2jJzLmrYAeyFnzcqCqga4lOxJd2-dxsAtYhrN6IUDSFuQQ>
    <xmx:cMwCY3YG29l3_9QJlOrsyP6HmyS4awvxXf7WXTh5KTmBC0eO-UOzlg>
    <xmx:cMwCY_qsnWxDwhg7Tm3CwyeejiKEL_tdydgnZYyZC-pNDgehX73ejg>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Aug 2022 20:23:10 -0400 (EDT)
Message-ID: <bb241882-a8c9-c2ea-a315-43d4929d4d96@tom-fitzhenry.me.uk>
Date:   Mon, 22 Aug 2022 10:23:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815123004.252014-1-tom@tom-fitzhenry.me.uk>
 <20220815123004.252014-3-tom@tom-fitzhenry.me.uk>
 <20220818030547.eblbmchutmnn6jih@notapiano>
 <20220821090005.tshf7z2kklaet7ll@core>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20220821090005.tshf7z2kklaet7ll@core>
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

On 21/8/22 19:00, Ondřej Jirman wrote:

> Max voltages in OPP table are irreleavant for Pinephone Pro DT, because the CPU
> regulators in the PMIC are capable of setting the preferred voltage or very
> close to it.
>
> The actual min/max limits that are enforced by the kernel for the board are set
> on the CPU regulator, which are actually wrongly set in this DT. See:
>
> https://dl.radxa.com/rockpi4/docs/hw/datasheets/Rockchip%20RK3399-T%20Datasheet%20V1.0-20210818.pdf

Good spot, I will fix these in v4.

