Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86D558958
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiFWTls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiFWTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864D4FC5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5BA2B82506
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E7EC341C7;
        Thu, 23 Jun 2022 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012729;
        bh=UHHSi8+HspVQrSh/U63hOVMtKvwTp18en9KTd4wJiX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9E051SbJxz+T+tJrhUx16w9r+Q7u70E094UguaT3P5U7+DKtQYpubZcy5Aj+ksR6
         B0JuAZNTs9AftjefqNKJE2K6I1stIOd1C6q+AWl5pT6jhTPmX+lOVwa57/82nGCzPY
         wsVpefbSVvpG/+9Xt/79i7aLFSE7+iPDNG3p+oy4bSOaf2YNtZdzbSDdLMAAgyS76p
         bG/u6wQV1KQ9+7CLJ5/z70+PUekr39OlcFrbzWihu/eCMMTjDjlvODGFlsMBMLU84o
         8KQiGCpha6QXPY0zQlUTZrvsw6R3QO2/CTkZCBp8jaTDqpOwrG2xcdiGIMEldf2dvg
         pZHRbtiXdowPg==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, keliu <liuke94@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] drivers/perf: Directly use ida_alloc()/free()
Date:   Thu, 23 Jun 2022 20:31:40 +0100
Message-Id: <165599548541.2982315.8203546473874552088.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220519080127.147030-1-liuke94@huawei.com>
References: <20220519080127.147030-1-liuke94@huawei.com>
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

On Thu, 19 May 2022 08:01:26 +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> 

Applied to will (for-next/perf), thanks!

[1/2] drivers/perf: Directly use ida_alloc()/free()
      https://git.kernel.org/will/c/49785a77780c
[2/2] drivers/perf:Directly use ida_alloc()/free()
      https://git.kernel.org/will/c/a336916b067c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
