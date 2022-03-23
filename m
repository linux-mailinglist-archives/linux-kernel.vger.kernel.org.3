Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB314E4ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiCWCYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiCWCYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:24:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E197005A;
        Tue, 22 Mar 2022 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/Lb1/WyPsA7fMTgF5A6Jux3cNUK0oP7V/t/r4QRdicM=; b=BU0c8AaPNPLJZiPHQ79bI7H0DI
        j7sWRsBhPnE2grYYMJsUPxpa+jRvcZm/RrEpZoGtjuIS8n/INHTjN7xl4lYijwLsgwEt5L3rdl3bJ
        BgLFDS5dT0IVpejjnJLnAbwQZ3xa410ta8T8IoQMPJ1oXy4t5YtKbOjS+nXDL/lxxL05QoRgGk/7N
        v/20hSBNsOgc/4oJllNPNVh0WoBop6W9rX/AKBhk6aT3twrwdWXTJasxpgT5V+ArROjK6tX+gwtTF
        hBKtInjAjgb901McdWsfyKn7qL/lDhNATdOfCPU2Lmb+LUcA6mHJOptdLGhR/DGvn6vUwcTEFBzMZ
        m6RJQlDg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWqeT-00C8Yy-Px; Wed, 23 Mar 2022 02:23:10 +0000
Message-ID: <bda6d230-90d8-fc0f-1c69-4eaf7ee67b89@infradead.org>
Date:   Tue, 22 Mar 2022 19:23:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Docs/admin: alphabetize some kernel-parameters
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220321054813.5059-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220321054813.5059-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon-
I'll send a v2 of this one also.

On 3/20/22 22:48, Randy Dunlap wrote:
> Move some out-of-place kernel parameters into their correct
> locations.
> Also add a HIBERNATION keyword in kernel-parameters.rst.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
> This is the first of several similar patches. Hopefully breaking
> them up will help with patch problems. If there are other suggestions,
> please let me know.
> 
> Alternate subject: Sorting is hard, let's go shopping
> 
>  Documentation/admin-guide/kernel-parameters.rst |    1 
>  Documentation/admin-guide/kernel-parameters.txt |  113 +++++++-------
>  2 files changed, 58 insertions(+), 56 deletions(-)


-- 
~Randy
