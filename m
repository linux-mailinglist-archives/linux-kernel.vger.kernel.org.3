Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3BF4718F3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 07:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhLLG7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 01:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLLG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:59:12 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDD3C061714;
        Sat, 11 Dec 2021 22:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=GvGABmN1IzmAjQz5YBl62ziV04ZyJd0OtjQy7W4FVyw=; b=gQkGGePENixu3PJ1t98MyuGZ5F
        wUzTbb8ka3jGSxUgLqb2jKOjSuxoIU2oX79NFHkUd22/EAvK/5+SPZRA7u+uMUBrMitTWNBL+HuXt
        ySKt6Qnv2iULLoYC9hHSldZ1qOEqS9xeNTgI7oWXS63XbfrFySm0peyOX2p+ueG6LcpA=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mwIp9-0006eA-1J; Sun, 12 Dec 2021 07:59:07 +0100
Message-ID: <964e56b6-1245-c870-ac86-844c69eac29f@nbd.name>
Date:   Sun, 12 Dec 2021 07:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, john@phrozen.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20211129153330.37719-1-nbd@nbd.name>
 <20211129153330.37719-13-nbd@nbd.name>
 <CACRpkdacgoT-K4qZoBpMx8RiPcvOf=YmrTP36LKyizcQk+VyUQ@mail.gmail.com>
 <c42f4ea0-2879-01cf-1db8-ed39844959fc@nbd.name>
 <CACRpkdbekZsKvoMmCtDV2Ui=ZyZA3ymZJL459Y0WgD=-mNyd=w@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v5 12/13] gpio: Add support for Airoha EN7523 GPIO
 controller
In-Reply-To: <CACRpkdbekZsKvoMmCtDV2Ui=ZyZA3ymZJL459Y0WgD=-mNyd=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-12-05 00:57, Linus Walleij wrote:
> On Thu, Dec 2, 2021 at 6:59 PM Felix Fietkau <nbd@nbd.name> wrote:
> 
>> I just looked at the datasheet and the driver code again, and I think
>> EN7523 is too strange for proper generic GPIO support.
> 
> Yup I see that John explained it to me in the past, no problem.
> Let's do it like this then, but just drop select GPIO_GENERIC
> from KConfig since it's not used.
> 
> With that oneliner change:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
The generic GPIO API is still used for the data register. The driver 
calls bgpio_init(), so you suggested oneliner change won't work.

- Felix
