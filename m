Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C32F4787C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhLQJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:35:11 -0500
Received: from ns.iliad.fr ([212.27.33.1]:42494 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhLQJfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:35:10 -0500
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 04:35:10 EST
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 05EB621340;
        Fri, 17 Dec 2021 10:25:06 +0100 (CET)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E08FA2061E;
        Fri, 17 Dec 2021 10:25:05 +0100 (CET)
Message-ID: <526e92dfc491b34d20a66e1432d7cd58e97700e9.camel@freebox.fr>
Subject: Re: [PATCH v2 1/2] powerpc/set_memory: Avoid spinlock recursion in
 change_page_attr()
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>
Date:   Fri, 17 Dec 2021 10:25:05 +0100
In-Reply-To: <112b55c5fe019fefc284e3361772b00345fa0967.1639676816.git.christophe.leroy@csgroup.eu>
References: <112b55c5fe019fefc284e3361772b00345fa0967.1639676816.git.christophe.leroy@csgroup.eu>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Dec 17 10:25:06 2021 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2021-12-16 at 17:47 +0000, Christophe Leroy wrote:

Tested-by: Maxime Bizon <mbizon@freebox.fr>

Now running fine with every CONFIG_DEBUG_xxx enabled, thanks!

-- 
Maxime



