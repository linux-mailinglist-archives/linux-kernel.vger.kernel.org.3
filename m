Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5145F4D1A14
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347352AbiCHOMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiCHOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:12:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882D4AE14;
        Tue,  8 Mar 2022 06:11:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E775C61328;
        Tue,  8 Mar 2022 14:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38284C340EB;
        Tue,  8 Mar 2022 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646748681;
        bh=ZrUA6nrdR/8oeAEl079SCCbVe8IbdFIRolvVvTFqyTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgUYMgTeIqtuwLx0mpKjRetwXfGSxMMugbQ6+Eq3PK3Cokh7SFZ6lRHzJNDMe4r7W
         HdfyenVz/QD4iJsu40ZgbCIDaNXFu0iSCecKFr1BFH+WmC5pN65+0ks7qTIlABE1VT
         uDl6VLGweiqtwGmTuADz6P7XMcHjJ/luo8JOvq42C12506bQR9KLDWT+tFjNu8aCSS
         1pzNTqwPRBwILty74OzGbfinqF3IupC8K/wEJsz8hE3bUdu2jEO8WICSRAp/toM9d7
         0lMsLpjaV4j+JiDE1TUy/RRidJe7Rymvh3b9w0CEViyQFw6cdXs4GbDgkFSxAYVQzF
         WEjpQY5JYtnMQ==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, sgoutham@marvell.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Bharat Bhushan <bbhushan2@marvell.com>, bbudiredla@marvell.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 0/4] cn10k DDR Performance monitor support
Date:   Tue,  8 Mar 2022 14:11:09 +0000
Message-Id: <164673825754.1681008.8324027520511694988.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220211045346.17894-1-bbhushan2@marvell.com>
References: <20220211045346.17894-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 10:23:42 +0530, Bharat Bhushan wrote:
> This patch series adds DDR performance monitor support on Marvell cn10k series of processor.
> 
> First patch adds device tree binding changes.
> Second patch add basic support (without overflow and event ownership). Third and fourth patch adds overflow and event ownership respectively.
> 
> Seems like 4th patch can be merged in second patch, For easy review it is currently separate
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/4] dt-bindings: perf: marvell: cn10k ddr performance monitor
      https://git.kernel.org/will/c/805bbdf28b27
[2/4] perf/marvell: CN10k DDR performance monitor support
      https://git.kernel.org/will/c/7cf83e222bce
[3/4] perf/marvell: cn10k DDR perfmon event overflow handling
      https://git.kernel.org/will/c/35a43326a9e3
[4/4] perf/marvell: cn10k DDR perf event core ownership
      https://git.kernel.org/will/c/68fa55f0e05c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
