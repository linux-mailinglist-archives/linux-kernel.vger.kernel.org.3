Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC05A51689A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 00:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355646AbiEAWRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 18:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344849AbiEAWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 18:17:39 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CD422DFC;
        Sun,  1 May 2022 15:14:12 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 56A5692009C; Mon,  2 May 2022 00:14:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 48B0F92009B;
        Sun,  1 May 2022 23:14:11 +0100 (BST)
Date:   Sun, 1 May 2022 23:14:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Joshua Kinard <kumba@gentoo.org>,
        Stephen Zhang <starzhangzsd@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] MIPS: Remove incorrect `cpu_has_fpu' overrides
Message-ID: <alpine.DEB.2.21.2205012307310.9383@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Forcing `cpu_has_fpu' to 1 is unsupported as it breaks the `nofpu' kernel 
parameter and more recently also the CONFIG_MIPS_FP_SUPPORT configuration 
option.  Remove the broken `cpu_has_fpu' overrides then for IP27 and IP30 
systems.

 This v3 of the series adds credit to Stephen for reporting the issue,
which I forgot on previous iterations.

 Please apply.

  Maciej
