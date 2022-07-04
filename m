Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB005653CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiGDLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbiGDLgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:36:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFC311453
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:36:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3fT6HrTz4xbw;
        Mon,  4 Jul 2022 21:36:17 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        benh@kernel.crashing.org, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
In-Reply-To: <20220520115229.147368-1-juergh@canonical.com>
References: <20220520115229.147368-1-juergh@canonical.com>
Subject: Re: [PATCH] powerpc/powernv: Kconfig: Replace single quotes
Message-Id: <165693444720.9954.12151077020209581120.b4-ty@ellerman.id.au>
Date:   Mon, 04 Jul 2022 21:34:07 +1000
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

On Fri, 20 May 2022 13:52:29 +0200, Juerg Haefliger wrote:
> Replace single quotes with double quotes which seems to be the convention
> for strings.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/powernv: Kconfig: Replace single quotes
      https://git.kernel.org/powerpc/c/1e2e5e82748aaf1fcc0e2a91e309793cd6cc5076

cheers
