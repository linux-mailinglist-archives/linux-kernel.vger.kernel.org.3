Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7114A5716
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiBAFxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:53:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51946 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiBAFxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:53:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0C34B82D07;
        Tue,  1 Feb 2022 05:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE96BC340EB;
        Tue,  1 Feb 2022 05:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643694822;
        bh=ZoytDPkKD14QwCTczaXWYX/vNshkmokgjkgFwGkR63Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OceOpkERYjDdHvkMxiQDtNY4B3qw3cQMTTmPyAQ03wzL6/p5q5xJIvsrEg+ieFLWy
         Spfjmcd6dMKyYVUuRke7qjlyHv80u8JK32bzIPWkGuVtjWkWzJvZBCcKS8M87W1otu
         Sl2/69EJ3/v1+mP6LkZeoaHm/cJCGvXIZvq9aMaTsuPUuGYcVGb3d/S8DI4mZk0sqt
         cwyGqL43p/04r1e7nknejQFZJlevkJNUoVuxl2NoEUVfu0Hty4eJqeSKZrRkrz1XqV
         8Ndpgo4Q4oY0zNTdxnYylSUeP+f0KSgya1lfxolElTXaQzSld0hmGEQpqdF3+fX8tW
         CO27LvOH/BbuA==
Date:   Tue, 1 Feb 2022 11:23:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: spmi: convert Qualcomm SPMI PMIC ARB to
 dtschema
Message-ID: <YfjK4gZaYY3Yrdzt@matsya>
References: <20220131172450.2528065-1-vkoul@kernel.org>
 <20220131172450.2528065-2-vkoul@kernel.org>
 <ec54ccc7-ae27-f19c-bb4c-db3d207f4182@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec54ccc7-ae27-f19c-bb4c-db3d207f4182@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-01-22, 15:02, Subbaraman Narayanamurthy wrote:
> On 1/31/22 9:24 AM, Vinod Koul wrote:
> > Convert Qualcomm SPMI PMIC  arb binding to dtschema format.
> 
> No concerns but, there are many patches going around for this.
> 
> Fenglin Wu had it in his v4 series [1] which he had dropped in his v5
> series [2] as this one [3] from David H got a "Reviewed-by".

Ah I missed these :(

> So, wondering if this can be dropped off?
> 
> [1] https://lore.kernel.org/linux-arm-msm/1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com/
> [2] https://lore.kernel.org/linux-arm-msm/1643178713-17178-1-git-send-email-quic_fenglinw@quicinc.com/
> [3] https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/

Sure lets get these picked up, that would be better, I will rebase patch
2 on top of this...

-- 
~Vinod
