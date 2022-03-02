Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587114CA526
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbiCBMrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241904AbiCBMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:47:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899AC249F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:46:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v5031kJz4xvK;
        Wed,  2 Mar 2022 23:46:44 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:LINUX FOR POWERPC 32-BIT AND 64-BIT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Russell Currey <ruscur@russell.cc>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Guo Zhengkui <guozhengkui@vivo.com>
Cc:     kernel@vivo.com
In-Reply-To: <20220223075426.20939-1-guozhengkui@vivo.com>
References: <20220223075426.20939-1-guozhengkui@vivo.com>
Subject: Re: [PATCH] powerpc/module_64: fix array_size.cocci warning
Message-Id: <164622488602.2052779.922464247956478447.b4-ty@ellerman.id.au>
Date:   Wed, 02 Mar 2022 23:41:26 +1100
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

On Wed, 23 Feb 2022 15:54:23 +0800, Guo Zhengkui wrote:
> Fix following coccicheck warning:
> ./arch/powerpc/kernel/module_64.c:432:40-41: WARNING: Use ARRAY_SIZE.
> 
> ARRAY_SIZE(arr) is a macro provided by the kernel. It makes sure that arr
> is an array, so it's safer than sizeof(arr) / sizeof(arr[0]) and more
> standard.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/module_64: fix array_size.cocci warning
      https://git.kernel.org/powerpc/c/8a0edc72bec25fa62450bfef1a150483558e1289

cheers
