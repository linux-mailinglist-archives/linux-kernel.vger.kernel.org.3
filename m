Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236104BF98A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiBVNhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiBVNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:37:39 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net (p3plsmtpa07-06.prod.phx3.secureserver.net [173.201.192.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACD2192BA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:37:10 -0800 (PST)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id MVLonjBopdsXDMVLpnM6Jf; Tue, 22 Feb 2022 06:37:10 -0700
X-CMAE-Analysis: v=2.4 cv=ZLASJV3b c=1 sm=1 tr=0 ts=6214e706
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=20KFwNOVAAAA:8 a=j-GoWnyPFWeJtNoJgLoA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Tue, 22 Feb 2022 13:37:08 +0000
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v7 05/13] module: Move latched RB-tree support to a
 separate file
Message-ID: <20220222133708.tew4wxhkf5hpkg2u@ava.usersys.com>
References: <20220222130911.1348513-1-atomlin@redhat.com>
 <20220222130911.1348513-6-atomlin@redhat.com>
 <8ed19f41-625a-154f-096c-ae7ea19a9649@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ed19f41-625a-154f-096c-ae7ea19a9649@csgroup.eu>
X-CMAE-Envelope: MS4xfH8N2fumSewoTMn9SJibgCg3aysMctgxzFqQ0FzPkDdCexLi5prNkq9ZxW8LQvuNr9W0hZTqRUOIvOuTVrBRkjd84KNOVluyHcTLuWkiDbgLIObPT5PY
 Eo45c5/nKDApOLEQMD5uDSYNISMNXaLM/QSJmNbPmeFZUOwCaTgtOvV43/NaHkMNyZkHorNjCwm0x6/JNQuUtcoiGd8rdZq/W7VlAAjA0lGZvtvhEAp8cphP
 jOKhOH5Lz+54qf30GP9O5uDWMw1lNyDVnIvvELlHF85TZ9NPkVfsker4g12wG6A5IXY5qXGqNuwr5OqSnLJXbXM5rmQ4ymyW5gsvDZfM4mEbjEFyCaBJjy7C
 0Ybl1asxwjhrSb6kxKzZMHwCAuljUdW2vOgPEx05bLTZ6ZE7p4+Ub8W1adlgEyfUumk0RJdBwnS3p7PWLOlxXYsh9a/xp8esdceOiqUIg8JsfqC8ZmhmQ564
 lLPYmGWO0ltHmetZ67ktaQWAIMoMB1Z/9g3d9QqrhYVOk4FOL9pNTUYZmVLAYMJ0R6nnN7PknMxPjJIDhnbk29IuweH4NJyQqpF/4R6PKkSStrJEAwf4bxb8
 fkwZD0rJ1HxlSuKxuEMf4lOqnGD6OTINVFN1fgFWD7AkcQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-22 13:32 +0000, Christophe Leroy wrote:
> Le 22/02/2022 à 14:09, Aaron Tomlin a écrit :
> > No functional change.
> > 
> > This patch migrates module latched RB-tree support
> > (e.g. see __module_address()) from core module code
> > into kernel/module/tree_lookup.c.
> > 
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >   kernel/module/Makefile      |   3 +
> >   kernel/module/internal.h    |  33 +++++++++
> >   kernel/module/main.c        | 130 ++----------------------------------
> >   kernel/module/tree_lookup.c | 109 ++++++++++++++++++++++++++++++
> >   4 files changed, 149 insertions(+), 126 deletions(-)
> >   create mode 100644 kernel/module/tree_lookup.c
> > 
> > diff --git a/kernel/module/Makefile b/kernel/module/Makefile
> > index ed3aacb04f17..e8413975bf1d 100644
> > --- a/kernel/module/Makefile
> > +++ b/kernel/module/Makefile
> > @@ -11,3 +11,6 @@ obj-y += main.o
> >   obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
> >   obj-$(CONFIG_MODULE_SIG) += signing.o
> >   obj-$(CONFIG_LIVEPATCH) += livepatch.o
> > +ifdef CONFIG_MODULES
> 
> This ifdef is not needed anymore.
> 
> > +obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
> > +endif

Oops! Apologies this was an oversight.

-- 
Aaron Tomlin
