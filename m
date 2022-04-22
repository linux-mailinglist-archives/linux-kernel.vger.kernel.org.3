Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3435550B4FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446520AbiDVK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446519AbiDVK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:29:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27D654BEE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43739CE289F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AD8C385A0;
        Fri, 22 Apr 2022 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650623195;
        bh=O6cnWZomKWY0R3n0zfJ/w697Hqcc5JnGdrY9secTFIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOsa4fvgmILacdoHTy7wQU5JBRlbfJ4Qi+BpKSP63mY5BTDwYLHFftdPxKUo4QmPx
         VBDl68Z0zGAxoFD9RxgMIdacRZ7yRs2n1sex6P8jpE3xb0Ghth9IC4J77dZHHqB5Ut
         CpCWsXUXSR9lOmZBNfU69E5GMlCPOTNDleVrATIixQ01HC5GZmqFKYNeZ7A5+qvCIQ
         cIhMd6tzaccgD2cafFxv6KhfG7hZ5aZPbatFwoOwgcm2oj7sZwj3e6Zc71XXwIctvJ
         Hvg+vWqubDaa9oqGZ7AX1AUKa6VDEZ/uHFME1lb5djMq+gJCh7GBKNDc2weYsuL6gB
         g6yDpEoacivfQ==
Date:   Fri, 22 Apr 2022 11:26:30 +0100
From:   Will Deacon <will@kernel.org>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: make SCHED_CLUSTER depend on ACPI
Message-ID: <20220422102629.GA9315@willie-the-truck>
References: <1650006268-3782-1-git-send-email-wangqing@vivo.com>
 <SL2PR06MB3082B7CCDC47E2E9CAF64F08BDF79@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB3082B7CCDC47E2E9CAF64F08BDF79@SL2PR06MB3082.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:58:00AM +0000, 王擎 wrote:
> What's your opinion on this patch, and I sent another patch 
> "Add complex scheduler level for arm64" yesterday,
> 
> Can someone make some comments so things can move forward.
>
> >cls is made up of sd through cluster_sibling, which is set by cluster_id,
> >cluster_id is only provided by ACPI, DT just provide package_id.

I don't understand the commit message at all, I'm afraid.

Will
