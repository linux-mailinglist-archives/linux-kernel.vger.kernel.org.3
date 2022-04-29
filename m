Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4D3514E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378071AbiD2PA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378062AbiD2PA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:00:27 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8691EB0A54;
        Fri, 29 Apr 2022 07:57:07 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A2CDF92009C; Fri, 29 Apr 2022 16:57:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9E56892009B;
        Fri, 29 Apr 2022 15:57:06 +0100 (BST)
Date:   Fri, 29 Apr 2022 15:57:06 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Joshua Kinard <kumba@gentoo.org>,
        Stephen Zhang <starzhangzsd@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MIPS: Remove incorrect `cpu_has_fpu' overrides
Message-ID: <alpine.DEB.2.21.2204291523460.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Forcing `cpu_has_fpu' to 1 is unsupported as it breaks the `nofpu' kernel 
parameter and more recently also the CONFIG_MIPS_FP_SUPPORT configuration 
option.  Remove the broken `cpu_has_fpu' overrides then for IP27 and IP30 
systems.  Please apply.

  Maciej
