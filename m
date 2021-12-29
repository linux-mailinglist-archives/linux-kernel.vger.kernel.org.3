Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F39481765
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 23:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhL2W41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 17:56:27 -0500
Received: from vern.gendns.com ([98.142.107.122]:41936 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhL2W40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 17:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=747RlGTGEaJosLze/FDMrypuI+B9jB981gse+D0gXs8=; b=xLL9Y1ZGkhSUWdurmWpRARDdIh
        bD8sy6dw8jwcjxGHWtF9Uno2bJV1HJXAiLzdlApUMDyPOj9xqJAIKoSKSnqwfQQ93/y1hix5CDhPR
        aE1fDhj4O1KY6UzM97SEQcAFuUO5R1novXHg5YibMPm34VYgpwhi8AYXAMv0MQ5GBRI8Oy68mXpXL
        3eVggxnI44IS/klKQz8c/JWUy8iHxQoIjpTEeHVsX6XiHYG3ZdxckoqRmGxE+P3BtTeSSYNEy2z4g
        UJnzAYV1i+WriJWj6zO3Mzh95jJumce6HEWtQsymiS0sdOrB+EL7vjHJ8P4tef8FCO3mf66bdc33o
        3svlj3Tw==;
Received: from [2600:1700:4830:1658::fb2] (port=56232)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1n2hri-0007Av-II; Wed, 29 Dec 2021 17:56:23 -0500
Subject: Re: [PATCH v3 22/23] counter: ti-eqep: Convert to new counter
 registration
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211229154441.38045-23-u.kleine-koenig@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <926c6589-93c2-9115-6098-80926417ca57@lechnology.com>
Date:   Wed, 29 Dec 2021 16:56:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211229154441.38045-23-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 9:44 AM, Uwe Kleine-König wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: f213729f6796 ("counter: new TI eQEP driver")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: David Lechner <david@lechnology.com>

