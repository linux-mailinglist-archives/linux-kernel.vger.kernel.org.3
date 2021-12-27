Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D17347FB51
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbhL0J1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhL0J1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:27:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CBCC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCA1760F28
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 09:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9689AC36AE9;
        Mon, 27 Dec 2021 09:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640597269;
        bh=ZYe2X1dnTM2Sb6ALXDJ0Quk9Jz6fWFXWwrTXW3qql/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjCu4eSZtVB6lOpLMmtsB4Jh8sxnpNwTviS896OuYdYHDEzpR/OeUA4BvUb1IdNFR
         rEKyborZ12xVKWXSNvSC7N9eDz5HOb/Cw1QIROGZZKLpNgz8W+dbfcDDtCQ+acYZkG
         w9VFXIVUaNX7HfMtV9suiHBLz8ALJMHoryF0iRzg=
Date:   Mon, 27 Dec 2021 10:27:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chanwoo@kernel.org,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.17
Message-ID: <YcmHChfwmIAhVsBG@kroah.com>
References: <CGME20211224061310epcas1p310f2caefe84f949a6764d2b0868611dd@epcas1p3.samsung.com>
 <bbf20e51-ffff-4b19-478e-739a0a011218@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf20e51-ffff-4b19-478e-739a0a011218@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 03:36:22PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.17. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:
> 
>   Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.17

Pulled and pushed out, thanks.

greg k-h
