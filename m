Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D4525084
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355555AbiELOq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355542AbiELOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:45:57 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB0B619036;
        Thu, 12 May 2022 07:45:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 144A01E80D22;
        Thu, 12 May 2022 22:40:19 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wvZOnFFbob1U; Thu, 12 May 2022 22:40:16 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3FFCF1E80D04;
        Thu, 12 May 2022 22:40:16 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     rostedt@goodmis.org
Cc:     agordeev@linux.ibm.com, aou@eecs.berkeley.edu,
        borntraeger@linux.ibm.com, bp@alien8.de,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        hpa@zytor.com, kunyu@nfschina.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, svens@linux.ibm.com, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH] kernel: Ftrace seems to have functions to improve performance through optimization
Date:   Thu, 12 May 2022 22:45:32 +0800
Message-Id: <20220512144533.58085-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20220512101229.7886a798@gandalf.local.home>
References: <20220512101229.7886a798@gandalf.local.home>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm glad you're willing to reply to me. 
My current English level is limited, and I may not describe it correctly. 
I consider that these functions may not be modified in a short time, which may bring advantages in function performance.
I could only submit it by inquiry.

Thanks.

