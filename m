Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236CE4B87AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiBPMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:30:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBPMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:30:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E3A2A414F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:30:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNS5lqJz4xv1;
        Wed, 16 Feb 2022 23:30:16 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1630667612.git.christophe.leroy@csgroup.eu>
References: <cover.1630667612.git.christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH v1 00/11] powerpc/machdep: Remove dust and convert to static calls
Message-Id: <164501434429.521186.17328213393681621470.b4-ty@ellerman.id.au>
Date:   Wed, 16 Feb 2022 23:25:44 +1100
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

On Fri, 3 Sep 2021 11:18:34 +0000 (UTC), Christophe Leroy wrote:
> The purpose of this series is to convert machine dependent
> functions in structure ppc_md into static calls.
> 
> First part of the series remove some dust in and around machdep.h
> 
> Then some helpers are defined to abstract the access to ppc_md. structure.
> 
> [...]

Patches 3, 5, 7 and 8 applied to powerpc/next.

[03/11] powerpc/machdep: Remove CONFIG_PPC_HAS_FEATURE_CALLS
        https://git.kernel.org/powerpc/c/d6a6c725a20467f52a41270bdaad9565c66f3b7a
[05/11] powerpc/machdep: Move sys_ctrler_t definition into pmac.h
        https://git.kernel.org/powerpc/c/e6d03ac156db84422519aa8628efc210d24bf889
[07/11] powerpc/mpc86xx_hpcn: Remove obsolete statement
        https://git.kernel.org/powerpc/c/fae65a9ac8fd2221dbf034019fa18d72b2b0c8e9
[08/11] powerpc/corenet: Change criteria to set MPIC_ENABLE_COREINT
        https://git.kernel.org/powerpc/c/66ada2907864cafa4578b92926cb8bc0a4bc8c9c

cheers
