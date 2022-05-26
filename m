Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA053495F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiEZDmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEZDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:42:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10991F3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A06BB81F12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEFEC385B8;
        Thu, 26 May 2022 03:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653536526;
        bh=RrhNZhtBDnr6UOm6hFKuTF/8JJ6tOZBvoXAfc/j3kSk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N9Gw56R1UpYOSlMvipw5r+Hsdx5wZ6RZCguKsEY1n0n7aLSbDAdXFACGT1cTQYuGa
         QVZWGDotXuOzt1/bvzyWp8XMqYIXQr03/kQBHyvCBefy5bISLpLQHZVMLLNE7pUWza
         YBSca12TJ4ZHXhrq/Cu9tfk3PmM5PsDhWm8gFIsY5fNnYOYhcIP9XpDbyVYt0rAIQE
         7rJ+DvwED/qmHibALLme0+ioundJCJTT5qwQkBS5NWDZNpxzc9X3f5Ue+pqwSoNssK
         oduWEbZoiJUzWGgzZmwOw5LZ/dIG9fqrFi5AY+PZWAQuL+8lSgegyQuD/8WXlgjzO8
         O5hu7NYVLT12A==
Message-ID: <17bdbca6-8352-50a8-0a3e-49ffe09422a2@kernel.org>
Date:   Wed, 25 May 2022 20:42:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] ARC: bitops: Change __fls to return unsigned long
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-snps-arc@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20220525144844.1571705-1-amadeuszx.slawinski@linux.intel.com>
 <20220525144844.1571705-2-amadeuszx.slawinski@linux.intel.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220525144844.1571705-2-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/25/22 07:48, Amadeusz Sławiński wrote:
> As per asm-generic definition and other architectures __fls should
> return unsigned long.
>
> No functional change is expected as return value should fit in unsigned
> long.
>
> Signed-off-by: Amadeusz Sławiński<amadeuszx.slawinski@linux.intel.com>

Applied to for-curr.

Thx,
-Vineet
