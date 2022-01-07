Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD8487A65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348267AbiAGQdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:33:40 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:51543 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbiAGQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:33:38 -0500
Received: (Authenticated sender: n@nfraprado.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 92956200008;
        Fri,  7 Jan 2022 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1641573212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHdZgPYW9rFfoT+k2DpyMR90GZCLDdAlv6cFmdVm01Y=;
        b=P73W5p5QxMUTaNnxtmdWJZQ+WmuG/i3ztLIgIlo4j88hCkDY9TAh2CzsRyXmtFVD6abqS1
        VUJwqJ3csLCDxYOs88ynsGF2M4EGvWgtcwZbx5e7Usu4osbuKfJRfwHcaJL8KJffHvYZO+
        /mvmZyQasbT8fpd4UL6jlPBFDe2uarGUwCEJfgOuF3s/+EgN91BWQzqZgPSLVFGTQRFoFt
        Ax5D22qLsn+NGaVLkw97MtFpxd6MZ1Z1Kmk5EfbLLyPdR81hfyt/sxYIwjn/KNqDlx7Y/R
        2xNhTX1pMqSEyKJly+HspNeY/E89ujuP8pqG9jXxahjgLWRY0NApb6UL5I32Eg==
Date:   Fri, 7 Jan 2022 11:33:27 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <n@nfraprado.net>
To:     James Clark <james.clark@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, mchehab+huawei@kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@protonmail.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] docs: automarkup.py: Fix invalid HTML link output
 and broken URI fragments
Message-ID: <20220107163327.hf26hfinbhhyike3@notapiano>
References: <20220105143640.330602-1-james.clark@arm.com>
 <20220105143640.330602-2-james.clark@arm.com>
 <87h7agpkn4.fsf@meer.lwn.net>
 <0fce859e-4ac5-3e41-a4cf-ec1c22f2c3cc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fce859e-4ac5-3e41-a4cf-ec1c22f2c3cc@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:04:44AM +0000, James Clark wrote:
> 
> 
> On 06/01/2022 22:25, Jonathan Corbet wrote:
> > James Clark <james.clark@arm.com> writes:
> > 
> >> Since commit d18b01789ae5 ("docs: Add automatic cross-reference for
> >> documentation pages"), references that were already explicitly defined
> >> with "ref:" and referred to other pages with a path have been doubled.
> >> This is reported as the following error by Firefox:
> > [...]
> >> The fix is to check that nodes in the document to be modified are not
> >> already references. A reference is counted as any text that is a
> >> descendant of a reference type node. Only plain text should be converted
> >> to new references, otherwise the doubling occurs.
> > 
> > This seems like a good fix.  Applied, thanks.
> > 
> > jon
> > 
> 
> Thanks Jonathan. Do you have a git repo that these get applied to?
> I wasn't able to find it on https://git.kernel.org/

Yeah, it's not listed there. His tree lives at git://git.lwn.net/linux . I can
see your patch in the docs-next branch.
