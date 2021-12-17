Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3D4795AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbhLQUoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:44:07 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.234]:23456 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237062AbhLQUoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:44:06 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Dec 2021 15:44:05 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 93090609C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:58:18 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id yJMwmZ6yBRnrryJMwmvLw6; Fri, 17 Dec 2021 13:58:18 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tLR3kyhWl3dztSJoHk8l7h6ld5ktjTJasCdXXqFHwvU=; b=GjYhP9o+MePPqsNBFdJu1fFK+i
        ZvfSlhdgknRwVgIJ/uM5b70OEAfhUN208IEUhRktj/EvVQ5siJPrGpv2bn6OEqula+OHItrjsm9hb
        0DuQWYVXVedyYUmv5MThgmBJTU1P220HjbWf7A4U+C8A/1oRl/WWp+UTGSf5yMs0us8YWeLvp6Ui5
        97wYgK51abPSGZ3E65J4B9HlduPY9zyPb6cBfjkH1mL9Mo4K3UE1L2bcIDmw4c7Ss76jXwWDb3M+L
        10q+zrDg+pDUFTuO6VIJxJ2JGEjhFxINoVKXRG5GuurtcB6S0UEwTYEQRz1h5UEe46z2iwwEmu3ws
        vcNKIAMg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:35662 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <garsilva@embeddedor.com>)
        id 1myJMv-0023aa-88; Fri, 17 Dec 2021 13:58:17 -0600
Subject: Re: Coverity Scan model file, license, public access
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        Dave Jones <davej@codemonkey.org.uk>
Cc:     Kroah-Hartman <greg@kroah.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org,
        Norbert Manthey <nmanthey@amazon.de>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com> <a41221c8-86e5-494d-68fd-0a0b87c99e83@amazon.de>
 <202107151111.23BA48F99@keescook>
 <1bce95f4-ddf8-2081-57c8-67cd9d4dd3d4@collabora.com>
From:   "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Message-ID: <c5c02c09-e210-fd81-2c95-74ba6e05e153@embeddedor.com>
Date:   Fri, 17 Dec 2021 14:03:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1bce95f4-ddf8-2081-57c8-67cd9d4dd3d4@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1myJMv-0023aa-88
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:35662
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

On 12/17/21 13:32, Muhammad Usama Anjum wrote:
>> As far as I know, the model was written originally by Dave Jones, with
>> further changes from myself and, I think, Colin Ian King.
>>
>> I thought it was visible through the Coverity dashboard, once you're
>> logged in:
>> https://scan.coverity.com/projects/linux-next-weekly-scan?tab=analysis_settings
>> (See 'Modeling file loaded [View]')
>>
> I've sent the request to join the dashboard. Who is the maintainer of
> this free Coverity dashboard? Can anyone use these results to fix the
> bugs without the permission of anyone?
> 

Your request has been approved now.

Thanks
--
Gustavo
