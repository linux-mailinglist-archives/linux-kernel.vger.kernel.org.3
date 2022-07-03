Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5879564750
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 14:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiGCM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGCM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 08:57:56 -0400
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net [50.242.207.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F02C614A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 05:57:55 -0700 (PDT)
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
        by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 263CvaLU015974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 3 Jul 2022 08:57:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lancer.cnet.absolutedigital.net (8.17.1/8.17.1) with ESMTPS id 263Cvgo1027308
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 3 Jul 2022 08:57:42 -0400
Date:   Sun, 3 Jul 2022 08:57:42 -0400 (EDT)
From:   Cal Peake <cp@absolutedigital.net>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [RFC] vgaarb: Add a module parm to use the first VGA device for
 boot
In-Reply-To: <87b3e6f7-6272-aeb7-3588-b1527d2c66b6@infradead.org>
Message-ID: <7d6499e-56f0-5872-9ac4-2f2a0df66a@absolutedigital.net>
References: <5e3f182f-7b6e-5c7f-d9a9-7cd1417cc38d@absolutedigital.net> <87b3e6f7-6272-aeb7-3588-b1527d2c66b6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Jul 2022, Randy Dunlap wrote:

> So that's
>   vgaarb.use_first=1
> right?

Yep

> Seems worthy of some documentation in
> Documentation/admin-guide/kernel-parameters.txt, please.

Absolutely! This was just an RFC to see if others thought this was the 
right approach to take.

I can have a new pair of patches out later today.

Thanks, Randy.

-- 
Cal Peake

