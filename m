Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2EC4B7B21
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiBOXTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:19:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241821AbiBOXTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:19:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D6F8B92
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:18:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E899CE242C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF94C340F1;
        Tue, 15 Feb 2022 23:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644967135;
        bh=Dm0P7y+08Aps5ktTuadTxa8ZMMt7zPUMnP7pGirqCw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoT2LSIeZ6DkfdOQLkq1kuJKH4imO0Vly0nCP+4qd7pYoPFWynV/2LcfoxS8I5Q3W
         wYdakPr4RcVs0pWB1+HuyvsuKAznm+keaoU7V1Oq5GPmAwtNoWlSj+uE2nPUFAKnsl
         tgcMxfjihJERemjhqxFsiO41zLkByuWkP3/7bEzuFhDOQQtDnHHKuoD5WnFmeXwnaa
         vkehf8Wk2hEjMZ3iowyDBgL5TRJ7Ig+YQGoP9ZODMwyISZUmtHGnRtWbx3kd9zys3w
         QvnaNXmSlmEK0DYPIn7iJaluX+uOPhQhQzrIBh/zyUJZZrukam2WSa0/1JsEQNLwkf
         xH2h1MFl0JNGA==
From:   Will Deacon <will@kernel.org>
To:     joey.gouly@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        He Ying <heying24@huawei.com>, pcc@google.com,
        mark.rutland@arm.com, marcan@marcan.st
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: entry: Save some nops when CONFIG_ARM64_PSEUDO_NMI is not set
Date:   Tue, 15 Feb 2022 23:18:28 +0000
Message-Id: <164493810686.322628.15452410391635355969.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220112032410.29231-1-heying24@huawei.com>
References: <20220107085536.214501-1-heying24@huawei.com> <20220112032410.29231-1-heying24@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 22:24:10 -0500, He Ying wrote:
> Arm64 pseudo-NMI feature code brings some additional nops
> when CONFIG_ARM64_PSEUDO_NMI is not set, which is not
> necessary. So add necessary ifdeffery to avoid it.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: entry: Save some nops when CONFIG_ARM64_PSEUDO_NMI is not set
      https://git.kernel.org/arm64/c/3352a5556f52

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
