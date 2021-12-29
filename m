Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B20481767
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhL2W4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 17:56:45 -0500
Received: from vern.gendns.com ([98.142.107.122]:41976 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhL2W4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 17:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L4hri8P0QUAWZFiy0polNEsnd67ZTLv8cfRjkNUPHgY=; b=uUnkmUFqlH2TZq8kvlgaDKbeZ9
        jzKEt5xAcf7zsJDA5Vc1hRj8N1NFdPic2C1gVSP5SMQ1ufNyivQyS3Wp4X4ndfY3H6AFBvuEJjUav
        2OcTPXbypiD3QmCC4aU/OTIuKzxB5T6cbfuRXFYVqVVHt8HpmeUsZ40Ws+KDyh/IMISRQ5rCgEi2y
        v8OPrdAcLAPem7Et2qjdJffB6UTgIPGhSLZdbYGZsRlFwQHscRySR634NT2Mhk4y6pPW3iUyTBi4O
        Skm83DqMMH+iPVnE58B92+qV85m4pIq5tRlH4Qs2usRy1KObfgTP4C08k6fwKnwfIU5v/9o+Kt6GQ
        sM7OGsAA==;
Received: from [2600:1700:4830:1658::fb2] (port=56234)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1n2hrw-0007yy-KZ; Wed, 29 Dec 2021 17:56:37 -0500
Subject: Re: [PATCH v3 10/23] counter: ti-eqep: Convert to counter_priv()
 wrapper
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211229154441.38045-11-u.kleine-koenig@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <8ab59b1c-1762-1b55-34c1-97cd61783853@lechnology.com>
Date:   Wed, 29 Dec 2021 16:56:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211229154441.38045-11-u.kleine-koenig@pengutronix.de>
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
> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
Acked-by: David Lechner <david@lechnology.com>
