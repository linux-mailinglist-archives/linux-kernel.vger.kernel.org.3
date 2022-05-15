Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A9C5276EE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiEOKbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 06:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiEOKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 06:31:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF264E7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 03:31:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZF1TVkz4xY4;
        Sun, 15 May 2022 20:31:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a2bae89b280e7a7cb87889635d9911d6a245e780.1648833388.git.christophe.leroy@csgroup.eu>
References: <a2bae89b280e7a7cb87889635d9911d6a245e780.1648833388.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] cxl/ocxl: Prepare cleanup of powerpc's asm/prom.h
Message-Id: <165261053892.1047019.3920240317648654638.b4-ty@ellerman.id.au>
Date:   Sun, 15 May 2022 20:28:58 +1000
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

On Sat, 2 Apr 2022 11:52:33 +0200, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> 
> [...]

Applied to powerpc/next.

[1/1] cxl/ocxl: Prepare cleanup of powerpc's asm/prom.h
      https://git.kernel.org/powerpc/c/d8d2af70b98109418bb16ff6638d7c1c4336f7fe

cheers
