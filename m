Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C171471911
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhLLHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhLLHWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:22:07 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301CAC061714;
        Sat, 11 Dec 2021 23:22:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7A9C2424CD;
        Sun, 12 Dec 2021 07:22:02 +0000 (UTC)
Subject: Re: [PATCH v2 3/8] irqchip/apple-aic: Add cpumasks for E and P cores
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-4-maz@kernel.org> <Yaed7VAlwwCBcP13@FVFF77S0Q05N>
 <87zgphlkdx.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <d350f759-17de-907f-531b-127d2493d056@marcan.st>
Date:   Sun, 12 Dec 2021 16:22:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87zgphlkdx.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2021 01.32, Marc Zyngier wrote:
> On Wed, 01 Dec 2021 16:08:13 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> On Wed, Dec 01, 2021 at 01:49:04PM +0000, Marc Zyngier wrote:
>>> In order to be able to tell the core IRQ code about the affinity
>>> of the PMU interrupt in later patches, compute the cpumasks of the
>>> P and E cores at boot time.
>>>
>>> This relies on the affinity scheme used by the vendor, which seems
>>> to work for the couple of SoCs that are out in the wild.
>>
>> ... but may change at any arbitrary point in future?
> 
> Crystal balls are in short supply, sorry! ;-)

Considering Apple seem to rely on this all over the place, I think they 
probably won't be changing the meaning of Aff2 at least until they 
decide to come up with SoCs that have 3 types of cores, or something 
like that :)

But yeah, ultimately this is a guess.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
