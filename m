Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C804D4B13C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244988AbiBJRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbiBJRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:02:15 -0500
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF01B91
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:02:16 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id B1DF2968;
        Thu, 10 Feb 2022 17:02:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 11C1660016;
        Thu, 10 Feb 2022 17:01:44 +0000 (UTC)
Message-ID: <926e5c35d50ec5f6d7e789831be96744ca8d6423.camel@perches.com>
Subject: Re: [PATCH v5 01/13] module: Move all into module/
From:   Joe Perches <joe@perches.com>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Date:   Thu, 10 Feb 2022 09:02:09 -0800
In-Reply-To: <CANfR36jh3yg9nqXkpCUWPeHV+sSD6yne9j1=uA5vyUpYOC8t9g@mail.gmail.com>
References: <20220209170358.3266629-1-atomlin@redhat.com>
         <20220209170358.3266629-2-atomlin@redhat.com>
         <a22eb1b0-3fb5-a70e-cf6f-022571538efb@csgroup.eu>
         <CANfR36jh3yg9nqXkpCUWPeHV+sSD6yne9j1=uA5vyUpYOC8t9g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 11C1660016
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: iz1wokkybbs73un6ik5i8wgk4d48418d
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+axLrpIxj27ofZZzUZv90vffF51j0MMg0=
X-HE-Tag: 1644512504-437677
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-10 at 14:45 +0000, Aaron Tomlin wrote:
> On Thu 2022-02-10 11:11 +0000, Christophe Leroy wrote:
> > > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > > @@ -13001,7 +13001,7 @@ L:    linux-kernel@vger.kernel.org
> > >   S:    Maintained
> > >   T:    git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
> > >   F:    include/linux/module.h
> > > -F:    kernel/module.c
> > > +F:    kernel/module/main.c
> > 
> > Shouldn't it be the entire directory ?
> 
> Indeed it should. Moving forward: kernel/module/*

Better would be:

F:	kernel/module/

in case it ever gets subdirectories too.


