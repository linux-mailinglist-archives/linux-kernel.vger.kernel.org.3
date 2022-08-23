Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234CF59E512
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiHWOX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbiHWOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:23:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE54E161F05;
        Tue, 23 Aug 2022 04:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0F45B81CDE;
        Tue, 23 Aug 2022 11:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF2FC43141;
        Tue, 23 Aug 2022 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661254477;
        bh=dbVWDldCY4YzubCVafQgz4jun7QPRpofSS5e63+/k1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6ASJqWDkzWRgVDFV55SAHo9P7Ljs0Aj91OH+zpkBXNJXhHLrMar0t3vffGzH7Frz
         knpC+6vpSk9eGxbnG3vXwvh19w+giIxPbRA7+l6CHNRniF/+OW3dfLKYvb23ecPnZG
         h3ckewL4yWOijMwbZmCW6Vek25DIt+qmDjmfYBtqYepMOQrq2sx3JR+oxeDR6TdOID
         OhjDIOMHOIixsriuwViWnq2WmC/sDi2f1bs5eogpNC2kygK1Xwooy6uf3kQFyCvFRq
         vvQjhWUx8/Q2g0qstpDywkcDo46ZgzYsrLkd7vDqpYwe2MmGwaodupTJ8YxhbI0T6f
         xfOzn4DP/UvZQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Subject: Re: [PATCH v3] docs/arm64: elf_hwcaps: unify newlines in HWCAP lists
Date:   Tue, 23 Aug 2022 12:34:21 +0100
Message-Id: <166124752070.3122203.12566494356867876740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <84e3d6cc-75cf-d6f3-9bb8-be02075aaf6d@suse.cz>
References: <Yv50RxlDf0qpK9v8@sirena.org.uk> <84e3d6cc-75cf-d6f3-9bb8-be02075aaf6d@suse.cz>
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

On Thu, 18 Aug 2022 22:31:57 +0200, Martin Liška wrote:
> Unify horizontal spacing (remove extra newlines) which
> are sensitive to visual presentation by Sphinx.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] docs/arm64: elf_hwcaps: unify newlines in HWCAP lists
      https://git.kernel.org/arm64/c/0b52f76351bf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
