Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546FC46A2FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbhLFRc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241476AbhLFRcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:32:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3BC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:28:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C859FB811B1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 17:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F4C341C2;
        Mon,  6 Dec 2021 17:28:52 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: extable: remove unsed ex_handler_t definition
Date:   Mon,  6 Dec 2021 17:28:49 +0000
Message-Id: <163881168906.164288.3411740674265688831.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211119124608.3f03380b@xhacker>
References: <20211119124608.3f03380b@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 12:46:08 +0800, Jisheng Zhang wrote:
> The ex_handler_t type was introduced in commit d6e2cc564775 ("arm64:
> extable: add `type` and `data` fields"), but has never been used, and
> is unnecessary. Remove it.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: extable: remove unsed ex_handler_t definition
      https://git.kernel.org/arm64/c/fde046e07d33

-- 
Catalin

