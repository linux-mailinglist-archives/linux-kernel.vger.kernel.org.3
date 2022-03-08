Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864AA4D1716
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbiCHMTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346766AbiCHMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:18:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684413207B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:17:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCZ8z4PxKz4xcl;
        Tue,  8 Mar 2022 23:17:55 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20220228142434.576226-1-jakobkoschel@gmail.com>
References: <20220228142434.576226-1-jakobkoschel@gmail.com>
Subject: Re: [PATCH] powerpc/sysdev: fix incorrect use to determine if list is empty
Message-Id: <164674126479.3322453.5888213344645127953.b4-ty@ellerman.id.au>
Date:   Tue, 08 Mar 2022 23:07:44 +1100
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

On Mon, 28 Feb 2022 15:24:33 +0100, Jakob Koschel wrote:
> 'gtm' will *always* be set by list_for_each_entry().
> It is incorrect to assume that the iterator value will be NULL if the
> list is empty.
> 
> Instead of checking the pointer it should be checked if
> the list is empty.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/sysdev: fix incorrect use to determine if list is empty
      https://git.kernel.org/powerpc/c/fa1321b11bd01752f5be2415e74a0e1a7c378262

cheers
