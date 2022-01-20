Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B794951DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376812AbiATP4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:56:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50898 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiATP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:56:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 835DFB81D83
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EEBC340E0;
        Thu, 20 Jan 2022 15:56:38 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, rppt@kernel.org,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     anshuman.khandual@arm.com, geert+renesas@glider.be,
        david@redhat.com, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org
Subject: Re: (subset) [PATCH 1/2] arm64: mm: apply __ro_after_init to memory_limit
Date:   Thu, 20 Jan 2022 15:56:36 +0000
Message-Id: <164269417315.2457156.15866873741014097353.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 14:45:58 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This variable is only set during initialization, so mark with
> __ro_after_init.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/2] arm64: mm: apply __ro_after_init to memory_limit
      https://git.kernel.org/arm64/c/bb425a759847

-- 
Catalin

