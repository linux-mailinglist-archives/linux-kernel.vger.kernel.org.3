Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF3C524DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbiELNFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354123AbiELNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:05:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D782A24F0EC;
        Thu, 12 May 2022 06:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30CB061FBB;
        Thu, 12 May 2022 13:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AF3C34119;
        Thu, 12 May 2022 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652360716;
        bh=fpbMuzFSSEKE6clnkaj5tApbhUTpleh1BlcZWp+xI5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9bTsWtrIGr2fZ0/nrf5SoJ1amkYiCiLmXdVWcLjDYohWtvwHFR2gf4Cj9SQyNp2b
         pQzp5It/eVwcFfAr+lbHXC8sxIZhfgJ3nHzLVatj3KueDxllIOrbjShNbTaqPYMth9
         IK/JWnPB4IuRaAJ9tY/oQOAPvflWTAkw4998WtjLgft0oZDy+Bnfg+fkqbhbkx0u7y
         +5i9wTAB0zz55BYkzdnk3CdllrETZYd1Ymn2rYTlu4hdgLLHtvGIxGlmMWEwa08WdN
         cnOHcwZwaIE3eRdHeGNOR6oJY8oMLr3A4/ys6ygNwg3QujmMTATmhOpYsA1ZyL5Fs/
         f3ONV8ALoIPVw==
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shreyas K K <quic_shrekk@quicinc.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Prasanna Kumar <quic_kprasan@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V3] arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs
Date:   Thu, 12 May 2022 14:05:06 +0100
Message-Id: <165235773290.1834134.2218780460929548936.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220512110134.12179-1-quic_shrekk@quicinc.com>
References: <20220512110134.12179-1-quic_shrekk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 16:31:34 +0530, Shreyas K K wrote:
> Add KRYO4XX gold/big cores to the list of CPUs that need the
> repeat TLBI workaround. Apply this to the affected
> KRYO4XX cores (rcpe to rfpe).
> 
> The variant and revision bits are implementation defined and are
> different from the their Cortex CPU counterparts on which they are
> based on, i.e., (r0p0 to r3p0) is equivalent to (rcpe to rfpe).
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Enable repeat tlbi workaround on KRYO4XX gold CPUs
      https://git.kernel.org/arm64/c/51f559d66527

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
