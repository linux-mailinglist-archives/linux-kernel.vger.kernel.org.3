Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4008C5653C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiGDLgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbiGDLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:35:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6E10574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:35:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3f23kJnz4xZb;
        Mon,  4 Jul 2022 21:35:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <9f1a47de80f78d3dd270a7a72f69f55f581c4054.1652859593.git.christophe.leroy@csgroup.eu>
References: <9f1a47de80f78d3dd270a7a72f69f55f581c4054.1652859593.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/irq: Split irq.c
Message-Id: <165693439157.9954.12569794251184438782.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:33:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 09:40:15 +0200, Christophe Leroy wrote:
> More than half of irq.c is dedicated to PPC64.
> 
> Move PPC64 code out of irq.c into irq_64.c
> 
> 

Applied to powerpc/next.

[1/2] powerpc/irq: Split irq.c
      https://git.kernel.org/powerpc/c/7d7b28b302085e1ec2815bc9f5205af28394c5db
[2/2] powerpc/irq64: Remove get_irq_happened()
      https://git.kernel.org/powerpc/c/98552307e3a72d480e72744bf5da2a865822f496

cheers
