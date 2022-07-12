Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803985719AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiGLMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiGLMQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:16:28 -0400
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 05:16:06 PDT
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C56AE558;
        Tue, 12 Jul 2022 05:16:06 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 2A613201AE;
        Tue, 12 Jul 2022 11:57:56 +0000 (UTC)
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 5CE24206D3;
        Tue, 12 Jul 2022 11:57:53 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 01CD73ECD9;
        Tue, 12 Jul 2022 13:57:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 565912A37A;
        Tue, 12 Jul 2022 11:57:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M5DJ4iuCCZiA; Tue, 12 Jul 2022 11:57:49 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Tue, 12 Jul 2022 11:57:49 +0000 (UTC)
Received: from edelgard.icenowy.me (unknown [59.41.160.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 42D17401CE;
        Tue, 12 Jul 2022 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1657627068; bh=ngIZLTuVH9bK77KIsBS8/RQadlTRO2EmRZFRx9q6pic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=legNVkDF7C6eeEdfhizFOZu6xr38rsC6eHTxb8EoeQJZFlO5hbwJXtVo71Q6znPff
         GlcbGVi35E7LcHRbnqH5JEmuc55DX567CisvB0fDIhE8yWpU14AZmtGFt2P1lnyo00
         x12JEgzd3uzbPPieUjRTJBMJh/HgFomrIp2e3Kc8=
Message-ID: <4fc9873e87c11dce23099a24be34465f09f3a9a4.camel@aosc.io>
Subject: Re: [PATCH 06/12] clk: sunxi=ng: add support for R329 CCUs
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 19:57:29 +0800
In-Reply-To: <c858b944-d72f-4e59-6a1a-329b5b8949c4@sholland.org>
References: <20220422140902.1058101-1-icenowy@aosc.io>
         <BYAPR20MB2472930AAFFBDC0ACB9A7487BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
         <c858b944-d72f-4e59-6a1a-329b5b8949c4@sholland.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-04-23星期六的 21:12 -0500，Samuel Holland写道：
> On 4/22/22 10:41 AM, icenowy@outlook.com wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > Allwinner R329 has two CCUs, one in CPUX and another in PRCM.
> > 
> > Add support for them.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> There is a typo in your commit title. = should be -.
> 
> Thanks for updating the driver to use .fw_name and be loadable as a
> module. All
> of those changes look good.
> 
> There are still some missing clocks here compared to the BSP, and a
> couple of
> other minor issues. Please see my earlier review:
> 
> https://lore.kernel.org/linux-sunxi/99a74950-fdc0-ecfe-e5f0-ba4a7d8751f0@sholland.org/
> 
> So far it's been consistent that any settable bits in the CCU
> registers actually
> do something. So I would expect all of those bits to have an index
> reserved in
> the binding, even if we do not model them. I want to avoid having to

Sorry but I don't think it proper to reserve unclear bits, because
we're just allocating the numbers as a random sequence (in fact it's
the sequence that it gets implemented).

Or consider a structural number scheme, in which a value can be
uniquely predicted by its name?

> go back and
> add gates to the binding out-of-order later, like we are doing for
> H6.
> 
> Regards,
> Samuel


