Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7C50B5B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446950AbiDVK6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387929AbiDVK6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7C40A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A66061F2B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F232C385AB;
        Fri, 22 Apr 2022 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650624946;
        bh=8dhJUSWgR9eQPsq2L2S1sI+avwacAbr78BShjB5vQgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLl/Id4xSGjLdCK7+/d/QX86oI+qI17Xpid3nziSF9OZN3IG6oGNzZIxAgIFvsMRi
         Cn4kPzrIHl1w4lvbfC3IQHjnHg2l49dqxia2t09KDpkaOYGRT4lnOdR6kIi0Rk/ob9
         zQ4j/kZlKC9SqkRq9ZGWd0ZTIL6F3q1BVkULzA5StCaWVKq7mZOGYO6YgK9rGFDeT1
         mjKyXJDY8e63o6AJ451f3FqH3BC2bMSbNriggPYafcAykklcTPm43LbxnSQwH/8Qu8
         4cl4FcnbQ54yJFwVVKcplVEcw7d9riEXYus/d2ycmL//PTAFUCLLUvVI5gpceJEoQh
         n79XCs77ZwsmQ==
From:   Will Deacon <will@kernel.org>
To:     anshuman.khandual@arm.com, aneesh.kumar@linux.ibm.com,
        Muchun Song <songmuchun@bytedance.com>,
        akpm@linux-foundation.org, quic_qiancai@quicinc.com,
        catalin.marinas@arm.com, arnd@arndb.de, steven.price@arm.com,
        lengxujun2007@126.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        smuchun@gmail.com, duanxiongchun@bytedance.com
Subject: Re: [PATCH v3] arm64: mm: fix p?d_leaf()
Date:   Fri, 22 Apr 2022 11:55:36 +0100
Message-Id: <165062331697.1074493.4942347933010219912.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220422060033.48711-1-songmuchun@bytedance.com>
References: <20220422060033.48711-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 14:00:33 +0800, Muchun Song wrote:
> The pmd_leaf() is used to test a leaf mapped PMD, however, it misses
> the PROT_NONE mapped PMD on arm64.  Fix it.  A real world issue [1]
> caused by this was reported by Qian Cai. Also fix pud_leaf().
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: fix p?d_leaf()
      https://git.kernel.org/arm64/c/23bc8f69f0ec

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
