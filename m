Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147EA4D0A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbiCGWFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbiCGWFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:05:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523744133C;
        Mon,  7 Mar 2022 14:04:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED510B81730;
        Mon,  7 Mar 2022 22:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7548C340E9;
        Mon,  7 Mar 2022 22:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690649;
        bh=80sSZy0v9CGIexq/sLoM7qKCulVTxrOS+c2Ba+rXYTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsuN6EJexJRxbOKjVSaxFYl5qHCCp+6djLMUd3LDpk3lFLljU+RGdwNI/YF5XXbzs
         Yc0xTjkxTVLo8WoHqSUWushKx8AmvMymmVcdey7DMFgZFlooOfbREFaPM5jYTypHtg
         M3QR+q2A6qJXnBp4Hw1t7ONitxvzAzagxT7ErLE9JUCuztgccwu6hrp6jirJCXx5LB
         561dxjjSN84Y3hd+YrpdJ6PAa2Vb9B+jedjhxpp7Ifbuzlym94abeHroB2qSx2vj2z
         M428PY5i7got8K755jPVll/qc+QMWSFOhidy+lOWFLjK2TwMJsFZMdyw/F6wiLh1ut
         h1st+/oUCBxTg==
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <shijie@os.amperecomputing.com>,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        vgoyal@redhat.com, darren@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, dyoung@redhat.com,
        zwang@amperecomputing.com, kexec@lists.infradead.org,
        bhe@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, linux-doc@vger.kernel.org
Subject: Re: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ranges
Date:   Mon,  7 Mar 2022 22:03:35 +0000
Message-Id: <164668834766.3268493.2965341441709965895.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220209092642.9181-1-shijie@os.amperecomputing.com>
References: <20220209092642.9181-1-shijie@os.amperecomputing.com>
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

On Wed, 9 Feb 2022 09:26:42 +0000, Huang Shijie wrote:
> The following interrelated ranges are needed by the kdump crash tool:
> 	MODULES_VADDR ~ MODULES_END,
> 	VMALLOC_START ~ VMALLOC_END,
> 	VMEMMAP_START ~ VMEMMAP_END
> 
> Since these values change from time to time, it is preferable to export
> them via vmcoreinfo than to change the crash's code frequently.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ranges
      https://git.kernel.org/arm64/c/2369f171d5c5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
