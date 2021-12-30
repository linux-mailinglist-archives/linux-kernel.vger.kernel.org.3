Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAF7481E08
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhL3QTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:19:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:51044 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241226AbhL3QTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:19:23 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2650B4FA;
        Thu, 30 Dec 2021 16:19:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2650B4FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1640881162; bh=5fkNZwcPwkX/k+UpJY6BR4GKe9HLM6dwHni88myZJHo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i0mlkRDfXE6554+exm8Xocq0w+7pAlXEnebo+MdEQMIYXfX9LkxYb5ycYwXy54p+X
         PRqwARI+7MsVMvTWTsQhVTN1kmDCcT3cRzGHt4wLdPkzw7oiPT6docAATgxs1SANsh
         Jk28fQgUb7PbMlQ4DrfD+JL9cLrxYsogtpLTg0+M+4hxFEwjgYRYUYjtfAyKHF69y+
         tYh+DMPutsc9FuGafgS+GZTKLF6bQ476qNy9hFnwfZoaMEDmzsabebbSX9w3dPATSx
         wUDdmclBvti1rRgRXdOPUVFV6qFwBRceWiqSz+Xo/03Af6F+GgX+fOnjIHkG/ZlYJf
         4QQ2q8y9r3mRg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "elana.copperman@mobileye.com" <elana.copperman@mobileye.com>
Subject: Re: Removing the deprecated htmldocs for good?
In-Reply-To: <CAKXUXMw-Tg7WcfVHaWZ-sK+WFnedL+S-jA_UnsdTR=HFwxAXSw@mail.gmail.com>
References: <CAKXUXMw-Tg7WcfVHaWZ-sK+WFnedL+S-jA_UnsdTR=HFwxAXSw@mail.gmail.com>
Date:   Thu, 30 Dec 2021 09:19:21 -0700
Message-ID: <87wnjm9iba.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Hi Jonathan, hi Konstantin,
>
> While scanning through the internet for kernel documentation, I
> stumbled upon the old deprecated htmldocs under
> https://www.kernel.org/doc/htmldocs/. I see that on
> https://www.kernel.org/doc/, we already point out that 'htmldocs -
> Kernel Documentation in docbook format (deprecated).' is deprecated.
> If I am not mistaken, all the content from htmldocs has now been
> transformed into .rst and has potentially evolved further and hence
> all relevant information should also already be available somewhere in
> https://www.kernel.org/doc/html/latest/.
>
> Is it now time to delete the content under
> https://www.kernel.org/doc/htmldocs/ for good?

I think that time may have come, yes; perhaps just have it redirect to
https://www.kernel.org/doc/html/latest/ instead?

Thanks,

jon
