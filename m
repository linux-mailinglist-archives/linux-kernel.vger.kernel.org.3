Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6090587B37
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiHBLB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiHBLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:01:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A926BE08
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:01:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LxsWJ26Ddz4x1N;
        Tue,  2 Aug 2022 21:01:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Juergen Gross <jgross@suse.com>,
        Paul Mackerras <paulus@samba.org>, mopsfelder@gmail.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20220711223617.63625-1-muriloo@linux.ibm.com>
References: <20220711223617.63625-1-muriloo@linux.ibm.com>
Subject: Re: [PATCH 0/2] KVM: PPC: Book3s HV: Cleanup unused function and declarations
Message-Id: <165943809123.1060517.15281363723578421276.b4-ty@ellerman.id.au>
Date:   Tue, 02 Aug 2022 21:01:31 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 19:36:15 -0300, Murilo Opsfelder Araujo wrote:
> Minor cleanup to remove unused function and declarations.
> 
> Murilo Opsfelder Araujo (2):
>   KVM: PPC: Book3S HV: Remove kvmhv_p9_[set,restore]_lpcr declarations
>   KVM: PPC: Book3s HV: Remove unused function kvmppc_bad_interrupt
> 
> arch/powerpc/include/asm/kvm_book3s.h |  3 ---
>  arch/powerpc/kvm/book3s_hv_builtin.c  | 18 ------------------
>  2 files changed, 21 deletions(-)
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/2] KVM: PPC: Book3S HV: Remove kvmhv_p9_[set,restore]_lpcr declarations
      https://git.kernel.org/powerpc/c/4c9da83011c455c0791b1f5e4e84d454d4f4ae3c
[2/2] KVM: PPC: Book3s HV: Remove unused function kvmppc_bad_interrupt
      https://git.kernel.org/powerpc/c/b8c7ee79b1a37442a910b8a313045fb9aa639911

cheers
