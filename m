Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E642476A58
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhLPGZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhLPGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:25:50 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6210C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 22:25:49 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9FC4EC01D; Thu, 16 Dec 2021 07:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639635947; bh=G7/h/q2M+jNsAkaxCIUPRJ0ZLteZm6BldoJyWM2m9Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wbHwvOoXAfav81BcAHf7RE0Zomgt3gCn0whh5OWzdNgyc+5wZOt/gdtUSsQEykxx2
         GeDjyzCDtD2oiaxTjAMo/NZdfUNx9jMl+bjuOWdWRarRMS+LKOPYjrQ7gVr6y3L0uc
         WcB18nMrODo0LgF5ZZdtq28rRZiFW7kxOAfZdvMv8oAiPj9H4DnLrBhmSenWFA8XLd
         gVEzfsrkQYghHdA6ZfAEWgUNHA/gObQiOXPvFAioJYXCP477LznfbdfHctuK+qDYu8
         ueH4CWPNKMo2b3p+ILPDWIe+T5uBxG/HlRFURVT4zt1wmaPdZJELmi1K8JSvCSTnNJ
         3JB1a9eQIrRkA==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id F15A4C009;
        Thu, 16 Dec 2021 07:25:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639635947; bh=G7/h/q2M+jNsAkaxCIUPRJ0ZLteZm6BldoJyWM2m9Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wbHwvOoXAfav81BcAHf7RE0Zomgt3gCn0whh5OWzdNgyc+5wZOt/gdtUSsQEykxx2
         GeDjyzCDtD2oiaxTjAMo/NZdfUNx9jMl+bjuOWdWRarRMS+LKOPYjrQ7gVr6y3L0uc
         WcB18nMrODo0LgF5ZZdtq28rRZiFW7kxOAfZdvMv8oAiPj9H4DnLrBhmSenWFA8XLd
         gVEzfsrkQYghHdA6ZfAEWgUNHA/gObQiOXPvFAioJYXCP477LznfbdfHctuK+qDYu8
         ueH4CWPNKMo2b3p+ILPDWIe+T5uBxG/HlRFURVT4zt1wmaPdZJELmi1K8JSvCSTnNJ
         3JB1a9eQIrRkA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id d04c076f;
        Thu, 16 Dec 2021 06:25:41 +0000 (UTC)
Date:   Thu, 16 Dec 2021 15:25:26 +0900
From:   asmadeus@codewreck.org
To:     zhuxinran <zhuran@mail.ustc.edu.cn>
Cc:     ericvh@gmail.com, lucho@ionkov.net, davem@davemloft.net,
        kuba@kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] 9p/trans_virtio: Fix typo in the comment for
 p9_virtio_create()
Message-ID: <Ybrb1pTnWYsoc4wX@codewreck.org>
References: <20211216061439.4186-1-zhuran@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216061439.4186-1-zhuran@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [PATCH V2]

Next time, please try to set the in-reply-to.
for example, with your first mail, it would be something like this:

git send-email --to xx --cc yy \
   --in-reply-to 20211216030836.81989-1-zhuran@mail.ustc.edu.cn \
   0001-9p-trans_virtio-Fix...patch


zhuxinran wrote on Thu, Dec 16, 2021 at 02:14:39PM +0800:
> Fix typo in the comment for p9_virtio_create()

Both the subject line and this line are displayed in the git log so we
don't really need this either, I'll remove this line and apply.

Thanks!
-- 
Dominique
