Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D344755B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbhLOKDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:03:30 -0500
Received: from ixit.cz ([94.230.151.217]:57026 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241372AbhLOKD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:03:28 -0500
Received: from [192.168.1.138] (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 264072243C;
        Wed, 15 Dec 2021 11:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639562605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yK6VD0ue2rafgoh9oAL+37D2PjeWCPZ5IRm8FP261NM=;
        b=MO0wjzFL27tjSrbZ8XQldlvd4H9NccPUeUFdC6C7HTyZC4uxoFN06CYPA6zoKbkJTKMaCS
        kG21/4tgzFb9WsKGtKIbRtX/qNfRCtdmuSW369TipuMGi7ycuA4wsK4XAb87JPW2sBazXD
        76JwmUlwXZRl+AoHsWw9qlm8HiYsYRo=
Date:   Wed, 15 Dec 2021 11:03:19 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: reset: document deprecated HiSilicon
 property
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
        ~okias/devicetree@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <JLI54R.VHYJ34M8SSAB3@ixit.cz>
In-Reply-To: <e013e672b500f88872b008cba7c2ddd5b4483d27.camel@pengutronix.de>
References: <20211208184149.99537-1-david@ixit.cz>
        <e013e672b500f88872b008cba7c2ddd5b4483d27.camel@pengutronix.de>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

In "[PATCH] arm64: dts: hisilicon: update deprecated property name" 
(v1) I was reffered to 
https://www.spinics.net/lists/arm-kernel/msg887577.html
David

On Wed, Dec 15 2021 at 10:52:15 +0100, Philipp Zabel 
<p.zabel@pengutronix.de> wrote:
> Hi David,
> 
> On Wed, 2021-12-08 at 19:41 +0100, David Heidelberg wrote:
>>  Documenting deprecated property prevents dt-schema validation 
>> errors.
>> 
>>  Signed-off-by: David Heidelberg <david@ixit.cz>
>>  ---
>>  v2:
>>   - document deprecated property instead of changing hi36[67]0.dtsi
> 
> Sorry if I'm missing context, I haven't seen the v1 for this. Is this
> really what we want? I would have expected the deprecated usage in the
> .dtsi files to be replaced.
> 
> regards
> Philipp


