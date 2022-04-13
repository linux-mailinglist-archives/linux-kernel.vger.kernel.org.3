Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AAE4FF4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiDMKYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDMKYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C065640C;
        Wed, 13 Apr 2022 03:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766D261D2D;
        Wed, 13 Apr 2022 10:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C468C385A4;
        Wed, 13 Apr 2022 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649845334;
        bh=WkWz5MkjiuAA8gGAG2uM+XkeWqraNIKMu2kBxG+E2Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLL4tle5Doriw4yMhQWIHHzUyEJTRxfcFDsei/9Filjn6v/Eby404zt2t92Ak2gd4
         Hfd2Mk1dycQ4ir8Nij6eOWYfwIbJXCMw/DU4xVWsoux519rIiTrMtnckHnLTIkqnop
         YiE18jsNW6p6lIJmDq74vdCQZP/q1QOqUHitIYf/bnIK15tTRoH8JSd02kUmWTT2da
         0lipni9BL+pHEyYYh8U4migDtnjqVJr9zj+zYidUcT/muZkWg+DeJE5VIU1/3K80/z
         aBiVICrqx87JKqvOEVn9fE2pCWXKT6KoInMuWpcu3TodV4BOi1HYOdp5L6wMd2tVD/
         aTbZRoIzU9csQ==
Date:   Wed, 13 Apr 2022 11:22:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: arm64/sm4 - Fix wrong dependency of NEON/CE
 implementation
Message-ID: <20220413102209.GB1229@willie-the-truck>
References: <20220411031313.35449-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411031313.35449-1-tianjia.zhang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:13:13AM +0800, Tianjia Zhang wrote:
> Commit d2825fa9365d ("crypto: sm3,sm4 - move into crypto directory")
> moved the sm4 library implementation from the lib/crypto directory to
> the crypto directory and configured the name as CRYPTO_SM4. The arm64
> SM4 NEON/CE implementation depends on this and needs to be modified
> uniformly.

d2825fa9365d doesn't appear in my tree -- is this something in linux-next?

Will
