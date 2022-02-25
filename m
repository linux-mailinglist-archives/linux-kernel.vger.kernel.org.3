Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A774C4995
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbiBYPvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbiBYPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:51:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60056BDD7;
        Fri, 25 Feb 2022 07:50:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75D65B83273;
        Fri, 25 Feb 2022 15:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFBFC340F3;
        Fri, 25 Feb 2022 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645804228;
        bh=d0igNZb3rq+qjUus0DIv+K7xgzdKHc9djeRmXZtOURA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJ3dUAfSNRUDUTKIi6sXkZOIYB/2h3qfayy0xGUwd26hIgXS3GNFUHhBgSaLOE2jM
         nKggG0l1546wnfpkP/i3zb/fH+HiYqE2w2dnAjEj2RZ10qEPRJOdmFDrvZmFxLxFOT
         45hu1QeKM5ix5IRrY2z/RWF4qKDOHpdJ5gKg1Vec7agdOaJoT3vA/3YJGKuIXMtwNb
         dSUoTaC3rLZnHBq5XMik5fwfOBMV0ZZnXPqGUhvU1NRX5imf9o40hafJdchdwDC1IC
         2BBicXw2TGiFihEpY0zQl8UjGaR0cJVMgFYh7EOPSzBaFi+DrqMRSU9hnRmRqSvSdG
         NfM2msJGZYN2Q==
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA iterator
Date:   Fri, 25 Feb 2022 15:50:14 +0000
Message-Id: <164579275059.2849601.5773490330369594969.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220218023650.672072-1-Liam.Howlett@oracle.com>
References: <20220218014642.lop2ohx4ov6fekyl@revolver> <20220218023650.672072-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 02:37:04 +0000, Liam Howlett wrote:
> This is an untested fix for the merge conflict of maple tree next and
> arm64 next.
> 
> Instead of using the linked list, use the vma iterator.
> 
> 

Applied to arm64 (for-next/coredump), thanks!

[1/1] arm64: Change elfcore for_each_mte_vma() to use VMA iterator
      https://git.kernel.org/arm64/c/3a4f7ef4bed5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
