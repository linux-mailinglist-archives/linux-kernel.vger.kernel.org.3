Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199C246BC8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhLGNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:32:19 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:36883 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbhLGNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:32:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7h2R0c6qz4xh5;
        Wed,  8 Dec 2021 00:28:31 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211118203604.1288379-1-keescook@chromium.org>
References: <20211118203604.1288379-1-keescook@chromium.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Message-Id: <163888363674.3690807.16904122616287532498.b4-ty@ellerman.id.au>
Date:   Wed, 08 Dec 2021 00:27:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 12:36:04 -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add a struct_group() for the spe registers so that memset() can correctly reason
> about the size:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/signal32: Use struct_group() to zero spe regs
      https://git.kernel.org/powerpc/c/62ea67e31981bca95ec16c37e2a1fba68f3dd8c5

cheers
