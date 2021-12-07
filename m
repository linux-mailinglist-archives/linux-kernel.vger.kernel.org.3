Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01246B6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhLGJPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:15:44 -0500
Received: from ns.iliad.fr ([212.27.33.1]:33826 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhLGJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:15:42 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 04:15:42 EST
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 878432029F;
        Tue,  7 Dec 2021 10:07:02 +0100 (CET)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 6EDD72022B;
        Tue,  7 Dec 2021 10:07:02 +0100 (CET)
Message-ID: <33c5d1ae4d8e27a66e542c244a39ce94eb4d3d75.camel@freebox.fr>
Subject: Re: [PATCH] powerpc/fixmap: Fix VM debug warning on unmap
From:   Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date:   Tue, 07 Dec 2021 10:07:02 +0100
In-Reply-To: <b0b752f6f6ecc60653e873f385c6f0dce4e9ab6a.1638789098.git.christophe.leroy@csgroup.eu>
References: <b0b752f6f6ecc60653e873f385c6f0dce4e9ab6a.1638789098.git.christophe.leroy@csgroup.eu>
Organization: Freebox
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Dec  7 10:07:02 2021 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2021-12-06 at 11:11 +0000, Christophe Leroy wrote:
> 
> Reported-by: Maxime Bizon <mbizon@freebox.fr>

Tested-by: Maxime Bizon <mbizon@freebox.fr>

maybe stable ? I had this on 5.15

Thanks !

-- 
Maxime



