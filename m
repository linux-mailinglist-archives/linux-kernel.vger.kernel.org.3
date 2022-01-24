Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E21497C78
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiAXJ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiAXJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:56:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ABAC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 01:56:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20DDA61251
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 09:56:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F97C340E1;
        Mon, 24 Jan 2022 09:56:08 +0000 (UTC)
Date:   Mon, 24 Jan 2022 09:56:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: extable: fix null deref in load_unaligned_zeropad.
Message-ID: <Ye53tbiEt9Z1Jf9/@arm.com>
References: <20220122023447.1480995-1-eugenis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122023447.1480995-1-eugenis@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 06:34:47PM -0800, Evgenii Stepanov wrote:
> ex_handler_load_unaligned_zeropad extracts the source and data register
> numbers from the wrong field of the exception table.

Could you please also include the stack dump if you get one from the
null pointer dereference?

> Fixes: 753b3236

This should be expanded:

Fixes: 753b32368705 ("arm64: extable: add load_unaligned_zeropad() handler")
Cc: <stable@vger.kernel.org> # 5.16.x

Thanks.

-- 
Catalin
