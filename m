Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE85847F919
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhLZVyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:54:01 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:57163 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbhLZVx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:53:59 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JMZLs3B5Nz4xhj;
        Mon, 27 Dec 2021 08:53:57 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, maz@kernel.org, benh@kernel.crashing.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        paulus@samba.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <aa145f674e08044c98f13f1a985faa9cc29c3708.1639777976.git.christophe.jaillet@wanadoo.fr>
References: <aa145f674e08044c98f13f1a985faa9cc29c3708.1639777976.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] powerpc/mpic: Use bitmap_zalloc() when applicable
Message-Id: <164055552979.3187272.5056547935512472848.b4-ty@ellerman.id.au>
Date:   Mon, 27 Dec 2021 08:52:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 22:54:12 +0100, Christophe JAILLET wrote:
> 'mpic->protected' is a bitmap. So use 'bitmap_zalloc()' to simplify
> code and improve the semantic, instead of hand writing it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/mpic: Use bitmap_zalloc() when applicable
      https://git.kernel.org/powerpc/c/2fe4ca6ad7f6a0b98f97c498320051e5066e4b95

cheers
