Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC9587B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiHBLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiHBLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:02:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900AE33E09
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:02:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LxsXT0B3Tz4x1L;
        Tue,  2 Aug 2022 21:02:49 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220605065129.63906-1-linmq006@gmail.com>
References: <20220605065129.63906-1-linmq006@gmail.com>
Subject: Re: [PATCH] powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
Message-Id: <165943814479.1061647.2007889797474531468.b4-ty@ellerman.id.au>
Date:   Tue, 02 Aug 2022 21:02:24 +1000
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

On Sun, 5 Jun 2022 10:51:29 +0400, Miaoqian Lin wrote:
> of_get_next_parent() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() in the error path to avoid refcount leak.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/cell/axon_msi: Fix refcount leak in setup_msi_msg_address
      https://git.kernel.org/powerpc/c/df5d4b616ee76abc97e5bd348e22659c2b095b1c

cheers
