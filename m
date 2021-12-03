Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522A3467BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382191AbhLCQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:54:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41328 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382181AbhLCQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:54:03 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id 541c385309b5ff86; Fri, 3 Dec 2021 17:50:38 +0100
Received: from kreacher.localnet (unknown [213.134.175.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 494F866AD69;
        Fri,  3 Dec 2021 17:50:37 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Date:   Fri, 03 Dec 2021 17:50:36 +0100
Message-ID: <1902790.PYKUYFuaPT@kreacher>
In-Reply-To: <f6e96a47-01a3-96f3-1ed7-e9a42c2b26bf@linaro.org>
References: <20211202102814.793d2f67@canb.auug.org.au> <f6e96a47-01a3-96f3-1ed7-e9a42c2b26bf@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.202
X-CLIENT-HOSTNAME: 213.134.175.202
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddujeehrddvtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrvddtvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehsfhhrsegtrghnsgdrrghuuhhgrdhorhhgrdgruhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhgvgihtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 2, 2021 11:04:45 AM CET Daniel Lezcano wrote:
> 
> On 02/12/2021 00:28, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > drivers/powercap/dtpm.c: In function 'init_dtpm':
> > drivers/powercap/dtpm.c:466:21: error: unused variable 'dtpm_descr' [-Werror=unused-variable]
> >   466 |  struct dtpm_descr *dtpm_descr;
> >       |                     ^~~~~~~~~~
> > cc1: all warnings being treated as errors
> > 
> > Caused by commit
> > 
> >   f751db8adaea ("powercap/drivers/dtpm: Disable DTPM at boot time")
> 
> Rafael, will you drop the patch from your tree and I send a new one with
> the local variable also, or shall I send a change on top of?

I'll fix this.



