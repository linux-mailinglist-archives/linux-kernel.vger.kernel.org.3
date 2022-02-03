Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0D4A7C88
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348403AbiBCAOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348407AbiBCAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:14:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010BC06173B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:14:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D4AD60C70
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 00:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A92C004E1;
        Thu,  3 Feb 2022 00:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643847277;
        bh=ts0gBDf++Kle0FbihZliZrbel98An15Zy4Hwi9Y3z7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpd9OXDDuHrHyQGQnlR/4XTsR2OiztFHxe8znavTSfgYbgSgK+Q5jChfFuUkSpJcE
         bSCNqYCgx8NaA2/SHvU84WQUolH+p7DsIBl0/wZzOia+NbbJmhYWoe9x4doGqo/eXS
         AaOkQ42kl7kgZn0eIWri1/z18ehidGvNm++tTW5xBCJFvn4S6uq/ujD1UbneBXjAvw
         1WXUsdJl3bT30GLDX3RI23aL3MqDRqRXyqScGpsiO5u8QPjwRx8L3b6d3UPgecrStD
         y5dIla1x/7MPaiSaQWKJTg9vbrl2egaH54hMzpn+gV7qsxSqIyVrw2k3LJcylMWc4V
         5/jrIZ3sAZGlg==
Date:   Thu, 3 Feb 2022 05:44:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add support for skipping
 configuration
Message-ID: <YfseaJADVocxqnOu@matsya>
References: <20220128072642.29188-1-a-govindraju@ti.com>
 <YfqT444YoGBIturt@matsya>
 <1d5c41a8-24aa-3cfb-fff0-c2695102aa91@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d5c41a8-24aa-3cfb-fff0-c2695102aa91@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-22, 20:14, Aswath Govindraju wrote:
> Hi Vinod,
> 
> On 02/02/22 7:53 pm, Vinod Koul wrote:
> > On 28-01-22, 12:56, Aswath Govindraju wrote:
> >> In some cases, a single SerDes instance can be shared between two different
> >> processors, each using a separate link. In these cases, the SerDes
> >> configuration is done in an earlier boot stage. Therefore, add support to
> >> skip reconfiguring, if it is was already configured beforehand.
> > 
> > This fails to apply, pls rebase and resend
> > 
> 
> On rebasing, I am seeing no difference in the patch and I am able to
> apply it on top of linux-next/master commit 6abab1b81b65. May I know if
> there is any other branch that I would need to rebase this patch on top of?

It should be based on phy-next which is at
1f1b0c105b19ac0d90975e2569040da1216489b7 now

-- 
~Vinod
