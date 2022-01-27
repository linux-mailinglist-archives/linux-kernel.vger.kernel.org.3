Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD3349E0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiA0L34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiA0L3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:29:55 -0500
Received: from biche.re (biche.re [IPv6:2607:5300:201:3100::6c88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D95CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:29:55 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:29:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 biche.re 0AE2E40F64
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=biche.re; s=biche;
        t=1643282991; bh=qt2OQlf2eNHyy4Rr7O8K2qYNm+v84dIqyVBhQttppkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHgz6mbJvYlDHdFTCC4BSz9S6lpP3+3Y8z3pQK36ASM/CWaxmgYUpURcBFdZaIER8
         qnL2HYrWQbFEhv7v+ib31Yu47mHSD9CF5EA0RAxi+oWn5tv0cahs89tRVt1+5Yzvz7
         7IxObd8Ue8J7RIFWdKozjHwPVJQDiuL8CTSuvnrZpWBShWZWU8N0AgcbBYKV5C2rs/
         TeiNxeX9DMJJVn2h7XK7J4sGKPpOyM2chtA19I1xBMC0dHZT6s0exAmlq7ZxgZWCmS
         4V/Buhtv+j/Eaza95P82lvaX+DeY9RFFF/PRga+jNScuZsy+pPpDNmBCyXKM12MD+S
         pfufrZzrqQrgQ==
From:   Victorien Molle <biche@biche.re>
To:     linux-kernel@vger.kernel.org
Cc:     Victorien Molle <biche@biche.re>
Subject: Re: [PATCH] KVM: x86: Add support for basic RAPL (Running Average
 Power Limit) metrics
Message-ID: <YfKCLAdwh0LZXIDz@ultrahax>
References: <20220109182317.1075762-1-biche@biche.re>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109182317.1075762-1-biche@biche.re>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping https://lore.kernel.org/all/20220109182317.1075762-1-biche@biche.re/T/#u
