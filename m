Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB54B62C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbiBOFaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:30:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiBOFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0E12858C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6925QHz4y46;
        Tue, 15 Feb 2022 16:30:09 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <38b1ffefd2146fa56bf8aa605d476ad9736bbb37.1643613296.git.christophe.leroy@csgroup.eu>
References: <38b1ffefd2146fa56bf8aa605d476ad9736bbb37.1643613296.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/603: Remove outdated comment
Message-Id: <164490280309.270256.3144743824144221109.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 07:15:12 +0000, Christophe Leroy wrote:
> Since commit 84de6ab0e904 ("powerpc/603: don't handle PAGE_ACCESSED
> in TLB miss handlers.") page table is not updated anymore by
> TLB miss handlers.
> 
> Remove the comment.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/603: Remove outdated comment
      https://git.kernel.org/powerpc/c/9872cbfb4558bf68219c5a8a65fd5c29b593323d

cheers
