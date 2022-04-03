Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445F4F07F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbiDCFud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 01:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiDCFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 01:50:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B374BA4;
        Sat,  2 Apr 2022 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8OckaxcOSZ2k2xdkU7ZKW69myxxJJjtrXFwWLiZFBdA=; b=tELY8MshI7tydJIGuvWsNTnZxl
        qYIsCZzijU+t/q2OmxmN8IBVBtAS0m89bK4W3aB+oPJVNEqjhvRJCQeEMaj1VPcSs3XweDbwXv5Zp
        KrQDiSX+1ZMj/PGjVlBvn+Gm06KbxD8BxTDRA9FxCidtPqL7PdrgSEVj7SWNSZvhyrRtaNU6dVjVT
        KrXy8KAvQbLWDniUb4RsvoHal5WCjbV0WBg774pivTVHeKtujlzAXH4bem33SJ250iHc/LLHPWyZo
        p6ePO8smQeqXjm4OkrRR06lknz0JUPw/vJ+K9FTiP6J6+12qTqUElDkAvK9eZ35+tkt4n21jK9ksg
        v1w1OTpA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nat67-00Amnh-Rp; Sun, 03 Apr 2022 05:48:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 0/3 v3] Documentation: kernel-parameters: alphabetize and misc. fixes
Date:   Sat,  2 Apr 2022 22:48:19 -0700
Message-Id: <20220403054822.16868-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alphabetize parts of kernel-parameters.txt. Alphabetize the "legends"
in kernel-parameters.rst. Add a few and drop a few outdated legends.


 [PATCH 1/3 v3] Docs: admin/kernel-parameters: edit a few boot options
 [PATCH 2/3 v3] Docs/admin: alphabetize some kernel-parameters (part 1)
 [PATCH 3/3 v3] docs/admin: alphabetize parts of kernel-parameters.txt (part 2)

 Documentation/admin-guide/kernel-parameters.rst |   11 
 Documentation/admin-guide/kernel-parameters.txt |  326 +++++++-------
 2 files changed, 180 insertions(+), 157 deletions(-)


Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ia64@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
