Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5844546942
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiFJPR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiFJPRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:17:21 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B36A3190A;
        Fri, 10 Jun 2022 08:17:17 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id D63741E80D6E;
        Fri, 10 Jun 2022 23:16:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qUBS2U_TeEmX; Fri, 10 Jun 2022 23:16:27 +0800 (CST)
Received: from localhost.localdomain (unknown [111.193.129.231])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 207871E80D24;
        Fri, 10 Jun 2022 23:16:27 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     dave.hansen@intel.com
Cc:     bp@alien8.de, chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, kunyu@nfschina.com, len.brown@intel.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, pavel@ucw.cz,
        rafael@kernel.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] x86: Change the return type of acpi_map_cpu2node to void
Date:   Fri, 10 Jun 2022 23:17:04 +0800
Message-Id: <20220610151705.8383-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <7eb4762e-723b-51e8-3d70-1c28568ac4f5@intel.com>
References: <7eb4762e-723b-51e8-3d70-1c28568ac4f5@intel.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm really sorry, Dave. My email prompted abnormal sending (when I sent patch before), so I sent it three times, but there was no abnormal message for the third time.

Static functions are called from the current source file, and their basic functions are similar to global functions (perhaps I don't fully understand).

In addition, the x86 architecture is EAX in the IA64 architecture did not pay much attention, which is my oversight.

