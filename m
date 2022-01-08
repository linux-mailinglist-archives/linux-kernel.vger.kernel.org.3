Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7F488698
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 23:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiAHWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 17:20:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37554 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiAHWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:20:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C49B80972;
        Sat,  8 Jan 2022 22:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6FEC36AE5;
        Sat,  8 Jan 2022 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641680398;
        bh=TBTt3hE/KZ9v5ndvZ4vfqicjjwpNk1pdk8pSOSaqnXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRpE+tEbssFWP425Ity0MEdxzb7QQ3egNNEPLIKODVEosoY18lPtkeDtIkg4ed/xa
         /q474mGUh8sa79+6cTTb8ZWyAi4MNeIGm5ZkvC0MKiVhxPzCMMwaEVbAzC/flEVINE
         J8+Dbngq9bZSr01nSuRk3ZD3CYlmCn6rf9/UI+z9AvxCBkrXAimzb/S77fRTPigneg
         oRIhiuyICILvasHIY8EbrWS4L1am23FXqazkbUybcfbvwKyZTehDRaOmzwEm/LIYWI
         HKV1JgzD6FajTc7q08QhtbxSyn/EKCHBWSVv57VRRp04oBRORc5b0ZYQVOqih/gI3H
         svlUN6oE0wf0Q==
Date:   Sun, 9 Jan 2022 00:19:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tpmdd tree
Message-ID: <YdoOBgztQad4VSvj@iki.fi>
References: <20220107083804.1a053153@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107083804.1a053153@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:38:04AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   1268950cc152 ("tools/certs: Add print-cert-tbs-hash.sh")
> 
> is missing a Signed-off-by from its committer.
> 
> -- 
> Cheers,
> Stephen Rothwell

Sorry about that. It's now fixed.

BR, Jarkko
