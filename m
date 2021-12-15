Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7C7474F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhLOA0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:26:54 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:53265 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbhLOA0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:26:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJl0MPbz4xhn;
        Wed, 15 Dec 2021 11:26:47 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, cp <carlojpisani@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <89b5f974a7fa5011206682cd092e2c905530ff46.1632755552.git.christophe.leroy@csgroup.eu>
References: <89b5f974a7fa5011206682cd092e2c905530ff46.1632755552.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/40x: Map 32Mbytes of memory at startup
Message-Id: <163952785919.919625.1254284989261185773.b4-ty@ellerman.id.au>
Date:   Wed, 15 Dec 2021 11:24:19 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 17:12:39 +0200, Christophe Leroy wrote:
> As reported by Carlo, 16Mbytes is not enough with modern kernels
> that tend to be a bit big, so map another 16M page at boot.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/40x: Map 32Mbytes of memory at startup
      https://git.kernel.org/powerpc/c/06e7cbc29e97b4713b4ea6def04ae8501a7d1a59

cheers
