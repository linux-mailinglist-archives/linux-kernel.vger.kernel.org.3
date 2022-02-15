Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB274B62BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiBOFak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:30:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiBOFa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E20123419;
        Mon, 14 Feb 2022 21:30:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6F1L1cz4y4h;
        Tue, 15 Feb 2022 16:30:13 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>, Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Nic Volanschi <eugene.volanschi@inria.fr>,
        kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
References: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] powerpc/spufs: adjust list element pointer type
Message-Id: <164490279736.270256.6555666963870570666.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:37 +1100
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

On Fri, 08 May 2020 09:12:56 +0000, Julia Lawall wrote:
> Other uses of &gang->aff_list_head, eg in spufs_assert_affinity, indicate
> that the list elements have type spu_context, not spu as used here.  Change
> the type of tmp accordingly.
> 
> This has no impact on the execution, because tmp is not used in the body of
> the loop.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/spufs: adjust list element pointer type
      https://git.kernel.org/powerpc/c/925f76c55784fdc17ab41aecde06b30439ceb73a

cheers
