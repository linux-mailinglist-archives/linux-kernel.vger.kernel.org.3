Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDBE5AD472
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiIEOAC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Sep 2022 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbiIEN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:59:55 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3566521B3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:59:53 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id EABB5120266;
        Mon,  5 Sep 2022 13:59:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id A845D20027;
        Mon,  5 Sep 2022 13:59:50 +0000 (UTC)
Message-ID: <d5ab81794ef1c666e947ed1f23570c175bf7d9d4.camel@perches.com>
Subject: Re: [PATCH] checkpatch: move duplicate sign off to separate warning
 type
From:   Joe Perches <joe@perches.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>
Date:   Mon, 05 Sep 2022 06:59:49 -0700
In-Reply-To: <20220905104542.2368950-1-dmitry.baryshkov@linaro.org>
References: <20220905104542.2368950-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A845D20027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 5o1ptdx137rjsguzjw7imkwkbs19c6gc
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18ay7l8iVabQgw/zrilqkrP6Fwl9uebvVo=
X-HE-Tag: 1662386390-961837
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-05 at 13:45 +0300, Dmitry Baryshkov wrote:
> Some maintainers prefer to allow duplicate signatures if that provides
> additional details about the patch flow. E.g. if the original patch
> author pulls the patch from the patchwork into the kernel branch, this
> can result in duplicate SOB tags from him, however this reflects the
> patch flow (one SOB for being the author, one SOB for pulling the patch,
> adding (and maybe fixing) tags and pushing the patch further.

I think that's poor process, but whatever...

> 
> To facilitate easily handling this kind of warnings, separate duplicate
> SOBs into the separate warning class ('DUPLICATE_SIGN_OFF').
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 79e759aac543..f95d4ac19901 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3115,7 +3115,7 @@ sub process {
>  			$sig_nospace =~ s/\s//g;
>  			$sig_nospace = lc($sig_nospace);
>  			if (defined $signatures{$sig_nospace}) {
> -				WARN("BAD_SIGN_OFF",
> +				WARN("DUPLICATE_SIGN_OFF",
>  				     "Duplicate signature\n" . $herecurr);
>  			} else {
>  				$signatures{$sig_nospace} = 1;

