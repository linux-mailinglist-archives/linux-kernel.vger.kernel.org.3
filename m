Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0184F55FCAB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiF2Jzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiF2Jzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC85B3DA49
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5764061EAC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE1C34114;
        Wed, 29 Jun 2022 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656496536;
        bh=gDkvwgproFA++tZEnwIYUsM00Ubsr2qR4KYSkQ7n7c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EknSvZOmZ9tLvQOHhXyIgyZtM9T3cLB4zKu9eCyyK0Xxmymjb9HO48pr1JqnVNSfQ
         M1DTHAOG+djPDKjXKcdfhqfX5li4UKcK+UUWy6l+8SWkN0547bLvX/OvvBu2h6bjkf
         /lWAHiF9SUn3OswLwH7w6QqSAMFz9Tw7+na6Z+8BEa7p3VoO/fFaXm6PZctK6B+rQV
         YEZM/HWEpjWkp6Db6xjjoNDx4ro8WkTgi7ANUZI9zIIMNxxQBG6xB9TmPBm5oLy34a
         7fycrKO1VYnCnMQZlggksgES2nijRN6cqsT49B/Rfa7nF1ODkspw2O8exWlQB4jRf2
         K/JmTAIHbdKZQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o6UQ2-0041wx-Bs;
        Wed, 29 Jun 2022 10:55:34 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kvmarm@lists.cs.columbia.edu,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Fuad Tabba <tabba@google.com>
Subject: Re: [PATCH 1/2] KVM: arm64: nvhe: rename confusing obj-y
Date:   Wed, 29 Jun 2022 10:55:31 +0100
Message-Id: <165649651581.296235.5516198259738952242.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220613092026.1705630-1-masahiroy@kernel.org>
References: <20220613092026.1705630-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: james.morse@arm.com, linux-arm-kernel@lists.infradead.org, alexandru.elisei@arm.com, masahiroy@kernel.org, kvmarm@lists.cs.columbia.edu, suzuki.poulose@arm.com, wangkefeng.wang@huawei.com, will@kernel.org, catalin.marinas@arm.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, keirf@google.com, drjones@redhat.com, tabba@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 18:20:25 +0900, Masahiro Yamada wrote:
> This Makefile appends several objects to obj-y from line 15, but none
> of them is linked to vmlinux in an ordinary way.
> 
> obj-y is overwritten at line 30:
> 
>   obj-y := kvm_nvhe.o
> 
> [...]

Applied to next, thanks!

[1/2] KVM: arm64: nvhe: rename confusing obj-y
      commit: 3d5697f95e492899d0bf813cbab2af03dde77fa2
[2/2] KVM: arm64: nvhe: add intermediates to 'targets' instead of extra-y
      commit: 40c56bd8e1aea7929a09f1d4d68ac3221bb142c4

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

