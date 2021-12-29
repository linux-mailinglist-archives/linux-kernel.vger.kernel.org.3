Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC91480F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhL2DuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhL2DuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:50:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41364C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 19:50:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9B796133A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 03:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BC0C36AE7;
        Wed, 29 Dec 2021 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640749811;
        bh=+dovNCfwC0M66Z/pqYa48ziKN3W6MFbpECtO162+6d8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MXtiE8r8nWpwbnD3VkdthoM+kkXPzxEfQ2flz0GnLla//ztBJdizYXllfGBhx9Glt
         B+K+ITD6TUQhizYRo+jUPjk5etjwXNx4Nc/Aan8dXPV89KNdHKf+xPEeD3co1PW0Zf
         j2/YNLJQjdGLH57ONjomhOn9V+9Qroxg0t6aGhpicBW/oHp4nq01gsyC4hw70Jv3hR
         A+R4fy/YjQi6tE7JIggyMZHv4gdKBBMOtC/iOxIRh+y7d0XrXVBLJg+b7pgSUmSctj
         nlHM2pfZCsBT+4pHBMTx3lNFJCy+dcVsZ1ZzvYD2yWpeDpRH47rfWCsGd9RoxfSbOu
         g1vz9JltqXTeg==
Subject: Re: [PATCH] arc: use swap() to make code cleaner
To:     Yihao Han <hanyihao@vivo.com>, Vineet Gupta <vgupta@kernel.org>,
        Jinchao Wang <wjc@cdjrlc.com>,
        "dean.yang_cp" <yangdianqing@yulong.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20211110030715.21681-1-hanyihao@vivo.com>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <e7d81e8e-bdf0-1b14-db53-c82a516c913a@kernel.org>
Date:   Tue, 28 Dec 2021 19:50:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211110030715.21681-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 7:07 PM, Yihao Han wrote:
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Signed-off-by: Yihao Han<hanyihao@vivo.com>

Added to ARC tree.

Thx,
-Vineet
