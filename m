Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561BD481A14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhL3G55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhL3G54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:57:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 22:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3B4AB81AA9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6EC36AEA;
        Thu, 30 Dec 2021 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640847473;
        bh=7yCEFaye12lacfWq1rQcm1e7Rwy/HamcbeXfDiIxuWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiZT5HF8ubExAG2r5jkflnbBWl86tM2NRdqcH23aCeQYlVxNRcWdnXdiLVQAVZwYJ
         0mZdD/ghl/4DfuZdNpTg8SB4Pl8Fb4u5E8ziRS0dp/LfYoepeZ6M6pelF4INc7LHHK
         CfxLRJP47hs/WWfPAmjBRZy0koLPG1ctDEtEpcY8=
Date:   Thu, 30 Dec 2021 07:57:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ryan Cai <ycaibb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [Resource Leak] Missing closing files
Message-ID: <Yc1YbthVqjBIAOyC@kroah.com>
References: <5C277DBF-B1EF-4193-9983-63105E5BC053@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5C277DBF-B1EF-4193-9983-63105E5BC053@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:04:58AM +0800, Ryan Cai wrote:
> Dear Kernel maintainers,
>  
>            In linux/drivers/zorro/gen-devlist.c, the file opened at Line 39 may not closed when going to Line 65. 
>  
>           I think, return 1 at Line 65 should be goto error. Should it be a bug? I can send a patch.
>  
> Location: https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4772966/drivers/zorro/gen-devlist.c#L39-L65

Do you use this program / file?

If so, and you can duplicate the problem, sure, send a patch after
testing it.

thanks,

greg k-h
