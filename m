Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6E47F88D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhLZTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:17:55 -0500
Received: from one.firstfloor.org ([193.170.194.197]:43512 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhLZTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:17:54 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Dec 2021 14:17:53 EST
Received: by one.firstfloor.org (Postfix, from userid 503)
        id D421B86B6E; Sun, 26 Dec 2021 20:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1640545935;
        bh=0dWyh2sW6dIoFoQCSqfEM4+VUJrMsivjlNlryC5g5MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlTgWthTje6R7AcrqWm006Vjsc3BM4nKp6QzOa2ABIBrc4JIkSY0iqrz5lUwHFZdD
         5VXZnciAn8nF7KgM4Zzvcx99bwCD1TFOU2nGFPua2Jpv1KKSRHrC7hVlMb8UN2R9yA
         wh2K20wVY7MzxVwTZKCEwdD+vouNDxWd42gq6jvo=
Date:   Sun, 26 Dec 2021 11:12:15 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, zhengjun.xing@intel.com
Subject: Re: JSON typos Re: [PATCH] perf: fix typos of "its" and "reponse"
Message-ID: <20211226191214.kydxqvndon2vhm32@two.firstfloor.org>
References: <20211226025215.22866-1-rdunlap@infradead.org>
 <YchjPcUlOH4tUB5M@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YchjPcUlOH4tUB5M@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 09:42:37AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Dec 25, 2021 at 06:52:15PM -0800, Randy Dunlap escreveu:
> > Use the possessive "its" instead of the contraction of "it is" ("it's")
> > where needed in user-viewable messages.
> > 
> > Correct typos of "reponse" to "response" (reported by checkpatch).
> 
> These files are made from other files, Andi?

I forwarded the patches.  Thanks.

BTW for Intel event list related questions please always copy Zhengjun

-Andi
