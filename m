Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97257585091
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiG2NMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiG2NKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4832E3AE69
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:10:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSZ35wn0z4xG2;
        Fri, 29 Jul 2022 23:10:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20c0ee7f99dbf0dbf8658df6b39f84753e6db1ef.1657204631.git.christophe.leroy@csgroup.eu>
References: <20c0ee7f99dbf0dbf8658df6b39f84753e6db1ef.1657204631.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v5 1/2] powerpc/perf: Use PVR rather than oprofile field to determine CPU version
Message-Id: <165909975658.253830.11461450313523332819.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 16:37:17 +0200, Christophe Leroy wrote:
> From: Rashmica Gupta <rashmica.g@gmail.com>
> 
> Currently the perf CPU backend drivers detect what CPU they're on using
> cur_cpu_spec->oprofile_cpu_type.
> 
> Although that works, it's a bit crufty to be using oprofile related fields,
> especially seeing as oprofile is more or less unused these days.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/perf: Use PVR rather than oprofile field to determine CPU version
      https://git.kernel.org/powerpc/c/ec3eb9d941a98f4c0dac263110729680a734279b
[2/2] powerpc: Remove remaining parts of oprofile
      https://git.kernel.org/powerpc/c/62ccae78820b25a0ac64bb0f648388ec834fcb3c

cheers
