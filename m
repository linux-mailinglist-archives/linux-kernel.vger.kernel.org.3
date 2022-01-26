Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351D49D127
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbiAZRwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:52:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53342 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiAZRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:52:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74049B81F8A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B71CC340E3;
        Wed, 26 Jan 2022 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643219552;
        bh=TNmijEjzsdm5HaYBJpRUIueKs+GHjoKGDHeTbddU1ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rX/ZVXFKr56MLTyr0QVNlqELVUXaE8pz3sMlzJ3HC01AQ27+UvI2s007B10E175oA
         uk7kfI/AA/pXAr+fdkEdph/us6uXwwbRyio3J3KvBn8uOal8K5J4ExIF6jl7dfow1x
         I3DhMHmZM+dx63h4m791BgXnTktxklgo0roZLG6E=
Date:   Wed, 26 Jan 2022 18:52:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers: dio: fixed spaces to tabs coding style issue
Message-ID: <YfGKXeHFSn+NK6fK@kroah.com>
References: <20220125103310.13893-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125103310.13893-1-aleksav013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:33:07AM +0100, Aleksa Vučković wrote:
> Converting spaces to tabs.
> 
> Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
> ---
>  drivers/dio/dio.c | 120 +++++++++++++++++++++++-----------------------
>  1 file changed, 60 insertions(+), 60 deletions(-)

Your patches add coding style issues, not a good idea when trying to do
code cleanup.

Always run checkpatch on your patches before submitting them.  As-is, I
can not take these.

thanks,

greg k-h
