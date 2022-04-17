Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ED35048A0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiDQRsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 13:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiDQRsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 13:48:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7192736302;
        Sun, 17 Apr 2022 10:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EFF8B809E3;
        Sun, 17 Apr 2022 17:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A800BC385A4;
        Sun, 17 Apr 2022 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650217558;
        bh=VkPYYsr5x5r7c4+l7JlyJX/Yd5KqB5sSgJ/zXSaOseo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JCo6nyxiiUA2mR2upbI050ANjFm/PZqRuitD4XzsWQ62DVGmvDyU9lmz9oKwjG2ly
         +AtIeoriiNAQqQf4tvR+REkdHneBKmWe2oGcqpqMMNEUsQeWyyz0CJVsWXZSwjqs07
         zn8Tcc+5pf0ZBzF6vfRA6OszCn18n0NUFYI9C178YvncinZZ9tycRORNxmKUBwrI7A
         ZIuWzTgM1Sfjwn1SteNZhiLG1V1u1xOm2XWuIPyOWSUUye+zX6WvQVRoOTJFc+SdSb
         nWQQD+DR3SnSCSGB0nl2i4DWJKgIn/XQm2A99RYneN6pi6h/cJMXF5jhlv8FUT23Xb
         6iE6LAzUqB6yQ==
Message-ID: <ff0135dc-da30-18b5-f5f4-cefdb0455c6b@kernel.org>
Date:   Sun, 17 Apr 2022 19:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Dongjin Kim <tobetter@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220329094446.415219-1-tobetter@gmail.com>
 <20220329094446.415219-2-tobetter@gmail.com>
 <2a5f002f-8a61-e5b0-a574-ee99591c4c12@kernel.org>
 <CAMdYzYrCZtfDiB6O20Jtp56YQhHj3jMVhCt9aCYNLbD_xwFc3g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAMdYzYrCZtfDiB6O20Jtp56YQhHj3jMVhCt9aCYNLbD_xwFc3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2022 14:07, Peter Geis wrote:

>>> +     dc_12v: dc-12v {
>>
>> Generic node name, so "regulator" or "regulator-0"
> 
> Unfortunately, this advice breaks the regulator-fixed driver, which it
> seems cannot cope with a bunch of nodes all named "regulator".

What exactly cannot cope? You cannot have different device nodes with
the same name but this is not a limitation of regulator but devicetree spec.

> Setting the regulators as regulator-0 -1 -2 leads to fun issues where
> the regulator numbering in the kernel doesn't match the node numbers.

There are no "node numbers"... maybe you mean unit addresses? But there
are none here.

> It also makes it more fun when additional regulators need to be added
> and everything gets shuffled around.

Usually adding - in subsequent DTS files - means increasing the numbers
so if you have regulator-[012] then just use regulator-[345] in other
files. I see potential mess when you combine several DTSI files, each
defining regulators, so in such case "some-name-regulator" (or reversed)
is also popular approach.

> If naming these uniquely to avoid confusion and collisions is such an
> issue, why is it not caught by make W=1 dtbs_check?

Patches are welcome. :)

Best regards,
Krzysztof
