Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138F855E300
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiF0NCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiF0NBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:01:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43F11C2E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 000A261261
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94154C341CD;
        Mon, 27 Jun 2022 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656334852;
        bh=NvsXPSEn0GyIx+tB8Ah/KXXYDbydpolKGcoM/qyUbRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aH0zN7+08xGRTtGPqTCl6bKBTo1kvsIiax3+MQ+l/YscGj5sFITuckDbsErkqpWfJ
         7VzxLmhL1RufpKgrIwCtbRKKJXtgKZdfciKeeRgrIKOhpFau3fPdabylLKq9Q1Ttk6
         jtlzqC9/0ps+RyzSjyhm+Cz3A1P4NpPNHKNvcHQEwUKSsekzNQCS/Jomn/syWsWBLk
         V8R/R5urGomZRjFwgR6rT3lrbbk0DqUzgY1s0PUakfBMhtFHWOOB2hD4gOx9DnSCZR
         9iQlcq+wJV1k4lg0H5RgnZcIdyfy9JGX6sEN8j4mMbNqAWTM6GLcHQDTHiAvUJWB2a
         xAuTKNCqSeKKA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, zhangshaokun@hisilicon.com,
        Chen Jun <chenjun102@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, xuqiang36@huawei.com
Subject: Re: [PATCH 1/1] perf: hisi: Extract hisi_pmu_init
Date:   Mon, 27 Jun 2022 14:00:42 +0100
Message-Id: <165632489472.2211970.18392089709892363501.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516131601.48383-1-chenjun102@huawei.com>
References: <20220516131601.48383-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 13:16:01 +0000, Chen Jun wrote:
> Extract the initialization code of hisi_pmu->pmu into a function
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: hisi: Extract hisi_pmu_init
      https://git.kernel.org/will/c/e500405dd15d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
