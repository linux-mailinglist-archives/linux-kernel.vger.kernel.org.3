Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D649F83F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiA1LYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:24:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35040 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiA1LYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:24:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 8F8FB1F45E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643369081;
        bh=0k7m4FzJK9kWdB+O7Oupf24TMSbU+LrZcmczneKKqYw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=foypQJZUcowKwZvoWoFVnS8Pa0v1JsBVzCKMZXvhFJDtP6otexkH5mcoNNTbg8x11
         PudWzCMVB96QIsy7XcuQ0zAQtXef27XJjk4k/ZRI0PrGIJPrzMQmmk38vf/oA7CWuz
         y3wWars4VIPLSLLt1vdzyIajv1QLKFuEWtm/LEU4Fe4g1Tq+xZ5kgBeoqMwmnZfMYP
         J/r6Q46Ipb1QWpNf+QO4nTb/f+OeV/SjaYiGutjXnJEKPIjVBUja1AvBXovBpU3xti
         8FY5IwILZLUcBMRQ0WuwCOGHalqP2AwwfUIqHUcpDU0ZqA83k4mf8TxXtbohhth5LS
         WuzqTfwgBUOIg==
Message-ID: <71662f4c-2b76-31d6-be3b-2ac267e9ea82@collabora.com>
Date:   Fri, 28 Jan 2022 16:24:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rt8188eu: Remove dead code
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20220128111954.1028121-1-usama.anjum@collabora.com>
 <20220128112315.GF1951@kadam>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220128112315.GF1951@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 1/28/22 4:23 PM, Dan Carpenter wrote:
> On Fri, Jan 28, 2022 at 04:19:54PM +0500, Muhammad Usama Anjum wrote:
>> rtStatus is _SUCCESS when the execution reaches this if condition.
>> Remove the dead code.
>>
>> Fixes: 67396d2dfef3 ("staging: r8188eu: merge ODM_ConfigBBWithHeaderFile with its callers")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> What checker warned about this?
Coverity
