Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790BD52C0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiERQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbiERQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:55:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC120139F;
        Wed, 18 May 2022 09:55:03 -0700 (PDT)
Received: from zn.tnic (p200300ea974657d0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57d0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D0B91EC0662;
        Wed, 18 May 2022 18:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652892898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VRqk2XIoU7DZRwVUIljwCiK2hOhwF82JGe05ccrqLHs=;
        b=VdStjWamEkAkYJl9mJxAmXz92e10LyHTx1AJvOom9HYGFhboLq6yvG9+uJUYYVvob0b2f1
        A0XLo/FtsIGFpVvLfJ0M0wlhZ1Uo1n1TxIYtflwCeDvSR3kKKM6lQwgKFKqLiPZuCuUjXh
        pGmFMe+pHPBi2c6jzQAW4WC0xP+HDn4=
Date:   Wed, 18 May 2022 18:54:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lin Yujun <linyujun809@huawei.com>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnny.chenyi@huawei.com, chenjiahao16@huawei.com,
        chenlifu@huawei.com, lizhengyu3@huawei.com, liaochang1@huawei.com,
        wangzhu9@huawei.com, xuyihang@huawei.com, chris.zjh@huawei.com,
        zouyipeng@huawei.com
Subject: Re: [PATCH -next] x86/events:Use struct_size() helper in kzalloc()
Message-ID: <YoUk3RSi7aSCnDyW@zn.tnic>
References: <20220518131626.109123-1-linyujun809@huawei.com>
 <20220518134920.GA8361@embeddedor>
 <YoT6tHWbBOchi29i@hirez.programming.kicks-ass.net>
 <20220518160345.GA43938@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518160345.GA43938@embeddedor>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:03:45AM -0500, Gustavo A. R. Silva wrote:
> Naming it flex_struct_size() would be more informative?

Not use it at all if it makes the code less readable.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
