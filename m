Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15147D44D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbhLVPfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhLVPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:35:10 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7582EC061574;
        Wed, 22 Dec 2021 07:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h5i8KRIE8OYinv9bsFSJNG/XPwR7FEMtMz3XKW3+hSQ=; b=SshfVUbtz9+IGFncIYN6ul9FxD
        7LhKdU2vjy5pkti8aS3YyKWlSTKXzL915GApT8MOIosXl08VBY7y7TDzK+FM2mcQzPkkPXwASDqVv
        vWkEUoBec8MLEOtldC1SFAKz49N8oZ16itrjbgntrVlBWJbmIIpy0IyYkvcQBraCIDig=;
Received: from p54ae97a7.dip0.t-ipconnect.de ([84.174.151.167] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1n03dv-0002Wy-Bl; Wed, 22 Dec 2021 16:35:03 +0100
Message-ID: <7ae0494f-438e-f147-913f-e0f28eb5b3bf@nbd.name>
Date:   Wed, 22 Dec 2021 16:35:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v8 07/14] clk: en7523: Add clock driver for Airoha EN7523
 SoC
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Crispin <john@phrozen.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20211220211854.89452-1-nbd@nbd.name>
 <20211220211854.89452-8-nbd@nbd.name>
 <CAK8P3a3Qy8FJpACTqt85Enm72aJ=vzUfiEMZ4=dRqFmunyOm1Q@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <CAK8P3a3Qy8FJpACTqt85Enm72aJ=vzUfiEMZ4=dRqFmunyOm1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-21 15:06, Arnd Bergmann wrote:
> On Mon, Dec 20, 2021 at 10:18 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> This driver only registers fixed rate clocks, since the clocks are fully
>> initialized by the boot loader and should not be changed later, according
>> to Airoha.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> I don't have any particular comments on the driver itself. I'm happy
> to merge it through
> the soc tree for the initial support of the clk maintainers are ok
> with it and have reviewed
> the actual code.
> 
>>  drivers/clk/Kconfig      |   9 +
>>  drivers/clk/Makefile     |   1 +
>>  drivers/clk/clk-en7523.c | 350 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 360 insertions(+)
>>  create mode 100644 drivers/clk/clk-en7523.c
> 
> I think this should go into drivers/clk/mediatek, as it probably shares
> some of the logic with the mt762x drivers in there. I'd suggest adding the
> maintainers for those drivers to Cc for additional review.
I don't think it shares any logic with the other drivers, but since 
Airoha is a subsidiary of Mediatek, I guess it makes sense to move it there.

- Felix
