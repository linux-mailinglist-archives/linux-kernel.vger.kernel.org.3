Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0447F91D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhLZVyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:54:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:36757 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhLZVyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:54:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JMZLv5f0Vz4xmx;
        Mon, 27 Dec 2021 08:53:59 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org, davidcomponentone@gmail.com
Cc:     mpe@ellerman.id.au, yang.guang5@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <71a702c2189b16c152affd8a8cda1d84ce32741c.1639792543.git.yang.guang5@zte.com.cn>
References: <71a702c2189b16c152affd8a8cda1d84ce32741c.1639792543.git.yang.guang5@zte.com.cn>
Subject: Re: [PATCH] powerpc: use swap() to make code cleaner
Message-Id: <164055553057.3187272.3605630723670438648.b4-ty@ellerman.id.au>
Date:   Mon, 27 Dec 2021 08:52:10 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2021 09:59:17 +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: use swap() to make code cleaner
      https://git.kernel.org/powerpc/c/a605b39e8ef703828b9e26750ea1925a6a5ef848

cheers
