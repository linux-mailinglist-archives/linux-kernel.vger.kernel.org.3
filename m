Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B138491E81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 05:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiAREZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 23:25:25 -0500
Received: from relay027.a.hostedemail.com ([64.99.140.27]:15689 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233044AbiAREZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:25:17 -0500
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 2DCB320475;
        Tue, 18 Jan 2022 04:25:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id E7F432001C;
        Tue, 18 Jan 2022 04:24:59 +0000 (UTC)
Message-ID: <fccc29846e7fc65caca8d72c30f998fbcc9ef0bb.camel@perches.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 17 Jan 2022 20:25:14 -0800
In-Reply-To: <CANiq72nyGijSO8ShcDx5eg=O1+_hO9-gOgrqmoDYhc9K0Mojow@mail.gmail.com>
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
         <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
         <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
         <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
         <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
         <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
         <e67388e4bdd25ca5ccb4cf20df0527d82ba31277.camel@perches.com>
         <CANiq72nyGijSO8ShcDx5eg=O1+_hO9-gOgrqmoDYhc9K0Mojow@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E7F432001C
X-Spam-Status: No, score=1.34
X-Stat-Signature: qi4ktfquwo79jr8fu3z4ogbpuxg67bdp
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18BhtU6qcDvG3gHGdeUH/1IdGuOT3+Qt/c=
X-HE-Tag: 1642479899-135833
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-17 at 22:41 +0100, Miguel Ojeda wrote:
> Yeah, for `clang-format` I tried to be conservative having only
> `include/`, but we could change that.

There are more #defines outside of include/ than inside:

$ git grep -P '^\s*#\s*define\s+\w*for_each\w*\(' -- '*.[ch]' | \
  grep -P -v '^(?:include|tools)/' | wc -l
613

$ git grep -P '^\s*#\s*define\s+\w*for_each\w*\(' -- 'include/*.[ch]' | \
  wc -l
469



