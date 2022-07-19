Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D054457A7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbiGST6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiGST5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:57:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229B15E83F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 403DEB81D11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62453C341C6;
        Tue, 19 Jul 2022 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658260623;
        bh=0LdJDeKmLGj/324jjiLM9SuzvDLxxgCGFD7G+jss8QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kJYbXVSVglndlPjADLUpFOMiRDB+09uHK3VdLb5JLNKz/FVWHK8KBVf48jt07+qm3
         49vAlIsumDiQmLUcUF/yDu23VxwXWpIakubCq7WHK3LWOzxtOB1I3wxV7Ly2YVF9SS
         We4hIuS2S3Qb4sNt4OPgBHR1/Q1ICNdiMwG6LYzCYoFW0T/QapqPFInsIdxC6Aew+Z
         IvLhoA7H+lAv1MKJI/NBWOz2m4mZaMhqQJihycrgo7wVvP9Zx8zFW6Mi8ttzaVCOf7
         ve037xZQRJAEeCg2ZZ84QfiMisDw5bOGHCICa6/2ujAup4NJLtLFaDMsZT2PzSL2tw
         3K6Ffy+Lc3z7Q==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: numa: Don't check node against MAX_NUMNODES
Date:   Tue, 19 Jul 2022 20:56:50 +0100
Message-Id: <165825422834.2955486.1780309800387091075.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220718064232.3464373-1-gshan@redhat.com>
References: <20220718064232.3464373-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 14:42:32 +0800, Gavin Shan wrote:
> When the NUMA nodes are sorted by checking ACPI SRAT (GICC AFFINITY)
> sub-table, it's impossible for acpi_map_pxm_to_node() to return
> any value, which is greater than or equal to MAX_NUMNODES. Lets drop
> the unnecessary check in acpi_numa_gicc_affinity_init().
> 
> No functional change intended.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: numa: Don't check node against MAX_NUMNODES
      https://git.kernel.org/arm64/c/9e26cac5f82b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
