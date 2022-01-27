Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305E749E426
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiA0OGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbiA0OGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:06:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669EEC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tVGl82lcXyFV9s04FlWzhlTJBxai33XseO7lujvtpdA=; b=MrNSfOFQqxnxTi5IPrFw+7D7Tn
        LsFVgz9uqWKW/mHuZHFjWXfS0G1DEVvFy8W0hCnO17MNin2IMsH60rYOrNvcvaqVOdY3+Q79lD+lC
        1ou7fRBYijLzDXDX/JaCXSfUfxqsuwuyimVBwuETmRfvsk3+hF2rfT/kRL5te1kcxssNJ37+K4dCU
        KHLsbEOH3ctV/oL4WUWniioJmJk0R+hEhWi6g5EwFAyrY2Rolgw+nO7cNE5Ly9STkyEKO15Hje62M
        CKzhaQOACD2LnpV426FMk273KxxublmWgc7jJ4OozqMbvxc7+7WYjeQFZo4bXwpVCrCeM1GV57kV6
        OO3nRkDg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD5Pe-005IW3-Dw; Thu, 27 Jan 2022 14:06:10 +0000
Date:   Thu, 27 Jan 2022 14:06:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] memblock tests: Add skeleton of the memblock
 simulator
Message-ID: <YfKm0sx1JT+7IRSJ@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <92442409bbc72476509a2ceb2e182473ac69612b.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92442409bbc72476509a2ceb2e182473ac69612b.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:28PM +0100, Karolina Drobnik wrote:
> +# Memblock simulator requires AddressSanitizer (libasan) and liburcu libraries

Stale comment?  You don't seem to actually use liburcu.
