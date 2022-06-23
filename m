Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0B558B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 00:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiFWV74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:59:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3C42E0A6;
        Thu, 23 Jun 2022 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Nx26xqoD/wg7rXmn86PrLNvRleEHYYDjYy2HD6LgoXA=; b=b1f/WsmQc9anpr5LcVTEGlX8kd
        LxV/iEe+N2noR2nT+unDhhhqH1tUwzqDGK2txyNY3a3oqdtZm6BAyAF1NdnXwfA6qeFv8PlLDC0mZ
        8f9P3XbKqTP5oqv7sOIq3T0SatzcENzUQZkuctu6GFW1btgNOBEVzQHsM32LTGVK4is9e98v4KuvM
        MlgPcNDoQ5VNOPJIyv74GZQDu69YZODZwvurjbZ5FUuqytM4jT5IO9JnL4M5/V5l3sIiVS8VdkmtE
        FTrvftKQx2gjfm/V6IC+oDv4piyM+a1WXxASghPyE4TA0pxMPwchIqfhDS25VsjBoZCcc8n792dQJ
        Kb+iIQTA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Urb-00Gvyd-LB; Thu, 23 Jun 2022 21:59:47 +0000
Message-ID: <bfb37ecf-75b9-8aa4-ec1c-18708c0c673f@infradead.org>
Date:   Thu, 23 Jun 2022 14:59:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] docs: driver-api: gpio: Fix some typos
Content-Language: en-US
To:     Tom Schwindl <schwindl@posteo.de>, corbet@lwn.net
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YrTdAv3YPlCiDr2u@posteo.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YrTdAv3YPlCiDr2u@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/22 14:37, Tom Schwindl wrote:
> Correct some simple spelling mistakes in consumer.rst, driver.rst
> and using-gpio.rst.
> 
> Signed-off-by: Tom Schwindl <schwindl@posteo.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
(still)

Thanks.

> ---
>  Documentation/driver-api/gpio/consumer.rst   | 2 +-
>  Documentation/driver-api/gpio/driver.rst     | 6 +++---
>  Documentation/driver-api/gpio/using-gpio.rst | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 


-- 
~Randy
