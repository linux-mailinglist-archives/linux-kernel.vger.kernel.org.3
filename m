Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7EE496A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 06:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiAVFje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 00:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiAVFjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 00:39:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AF7C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 21:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=bfUYcDrWFOMZoBayDIiSGMYUnMjTXrd1vwYUxhrHz4Y=; b=NqykCQ2/a0LkF4Uk35ELv+9MxO
        WyBBHR6KEUXmtaEH24Pi0wnbTtIFy8U9dmAGYV8+QSXHrw7D+bIqIBXiD7BOiTMHe/O5TLbmv+4jz
        mXPKZEDK6xnGP4SQQZ5squjrLAcGQYjZqlJgYqgkg7xCSto8emZCGgP3g6NELEbH1LAkai23P6UWs
        /GDJGu5mDcneIDlNeiXwok8h0yJd9nHXo2fIq2U95IYAKPIbLzsDkcglhXTVeFCAckt10S2RVDbJ9
        tFYCXuGCQS1lKdkMrpSJP/e7Iy54+F1TEj0vO9j0BnZbLMAjdT4bQ76WMHtsWa6jCNLLsnBScKRKb
        /y9YdMuQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nB97Z-00GB1m-UR; Sat, 22 Jan 2022 05:39:30 +0000
Message-ID: <bda6130a-8e19-0e8a-fbfe-c6e6fd962411@infradead.org>
Date:   Fri, 21 Jan 2022 21:39:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: lore certificate error in browsers for past 2 days
Content-Language: en-US
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YeuXV0Qv0NUZ0l84@Gentoo>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YeuXV0Qv0NUZ0l84@Gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/22 21:34, Bhaskar Chowdhury wrote:
>  Hey,
> 
>  Not sure who needs to fix the damn thing ...but I am seeing the certificate
>  expiration on various browsers ....namely, Firefox, Vimb, Nyxt
> 
> 
>  Can someone kindly look in?
> 
>  ~Bhaskar


Hi,

Have you read/tried any of these?

https://letsencrypt.org/2019/04/15/transitioning-to-isrg-root.html

https://letsencrypt.org/docs/dst-root-ca-x3-expiration-september-2021/

https://www.openssl.org/blog/blog/2021/09/13/LetsEncryptRootCertExpire/


cheers.
-- 
~Randy
