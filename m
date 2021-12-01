Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC84465818
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbhLAVDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:03:44 -0500
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:45662 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343835AbhLAVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:01:52 -0500
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 82218182CF66F;
        Wed,  1 Dec 2021 20:58:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 8D62924;
        Wed,  1 Dec 2021 20:58:23 +0000 (UTC)
Message-ID: <188beacbe6fd9ba022e18a330a60dbab7f94db7f.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Removing Ohad from remoteproc/rpmsg
 maintenance
From:   Joe Perches <joe@perches.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Dec 2021 12:58:22 -0800
In-Reply-To: <20211201175345.865408-1-mathieu.poirier@linaro.org>
References: <20211201175345.865408-1-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8D62924
X-Spam-Status: No, score=-4.13
X-Stat-Signature: dyw88gc1o7h48k33kmm5o8knh6zqanms
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX198sUxWwux73H408PkE8Vfw4O3rR38VPeU=
X-HE-Tag: 1638392303-955910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-01 at 10:53 -0700, Mathieu Poirier wrote:
> Ohad has not reviewed patches in the remoteproc and rpmsg subsystems for
> several years now:
> 
> $ git log --no-merges --format=email drivers/remoteproc/ drivers/rpmsg/ | \
> grep -Pi "^Subject:|^Date:|^\w+-by:.*ohad*" | grep -B2 ohad
[]
> ---
> Credits to Joe Perches for the script [1].
> 
> [1]. https://www.spinics.net/lists/kernel/msg4163272.html

Oops.  bad script.

It needs to have a - in the grep to include "Signed-off-by:"

$ git log --no-merges --format=email drivers/remoteproc/ drivers/rpmsg/ | \
  grep -Pi "^Subject:|^Date:|^[\w\-]+-by:.*ohad*" | grep -B2 ohad


