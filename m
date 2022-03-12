Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CF34D6E22
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 11:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiCLKb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 05:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiCLKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 05:31:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E215823B4F1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 02:30:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbV61prz4xLY;
        Sat, 12 Mar 2022 21:30:46 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     jing yangyang <cgel.zte@gmail.com>,
        Geoff Levand <geoff@infradead.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
In-Reply-To: <01647102607ce9640c9f27786d976109a3c4ea7e.1629197153.git.jing.yangyang@zte.com.cn>
References: <01647102607ce9640c9f27786d976109a3c4ea7e.1629197153.git.jing.yangyang@zte.com.cn>
Subject: Re: [PATCH linux-next] ps3: remove unneeded semicolon
Message-Id: <164708098933.827774.6685079426471019476.b4-ty@ellerman.id.au>
Date:   Sat, 12 Mar 2022 21:29:49 +1100
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

On Thu, 19 Aug 2021 19:49:01 -0700, jing yangyang wrote:
> Eliminate the following coccicheck warning:
> 
> ./arch/powerpc/platforms/ps3/system-bus.c:606:2-3: Unneeded semicolon
> ./arch/powerpc/platforms/ps3/system-bus.c:765:2-3: Unneeded semicolon
> 
> 

Applied to powerpc/next.

[1/1] ps3: remove unneeded semicolon
      https://git.kernel.org/powerpc/c/9f5196065eeb96fee1a15f2eae31fe1fc7623ade

cheers
