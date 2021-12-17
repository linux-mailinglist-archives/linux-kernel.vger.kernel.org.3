Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5BE47963E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhLQVZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLQVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:25:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B248C061574;
        Fri, 17 Dec 2021 13:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=S7LXRSQEkoRerRyKuK4DAJnCEMjCVJDDgaO1V4T78uY=; b=P1roXXq4nnOui4pnY9nhlOZbvU
        uIrx2mlyHxL/qh/pgwAlIk7O0jQxKJ/K/k9W1RxNTLJAvO4zyBM8T1hScoULtK0A9GnoVFS443HGh
        2+RXvZI2TlJ7YwbzWzDeVxSocZNQR+P2nqiw3vJs0xrBqkBZjDkfqpQU3i4IW6MOT4sHJvtjk3NY7
        zF6YUKAnN/6usrtpfP+/Xp3L+D+va08D99w2cbdxCzd3tpCwxSlYDcSTqNP5Nb5M9g+s5s3HnMe8L
        fcvHBm8g+GvdV4apyn3hsZDcMJtU/id40K/hNUXWWpFOFYR3EYTZANCtYNKYOHqfIL2JAhp4XMjzN
        k7q3viyw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1myKjP-001xcR-Hw; Fri, 17 Dec 2021 21:25:35 +0000
Message-ID: <eff1f8d6-ec12-42c7-d869-8fbd9e3a560d@infradead.org>
Date:   Fri, 17 Dec 2021 13:25:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: Tree for Dec 17
 (drivers/reset/reset-starfive-jh7100.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20211218003339.0061dcb4@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211218003339.0061dcb4@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/21 05:33, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20211216:
> 

on i386:

../drivers/reset/reset-starfive-jh7100.c: In function ‘jh7100_reset_update’:
../drivers/reset/reset-starfive-jh7100.c:81:10: error: implicit declaration of function ‘readq’; did you mean ‘readl’? [-Werror=implicit-function-declaration]
  value = readq(reg_assert);
          ^~~~~
../drivers/reset/reset-starfive-jh7100.c:86:2: error: implicit declaration of function ‘writeq’; did you mean ‘writel’? [-Werror=implicit-function-declaration]
  writeq(value, reg_assert);
  ^~~~~~


-- 
~Randy
