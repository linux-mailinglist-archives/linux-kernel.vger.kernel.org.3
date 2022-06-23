Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6CE558983
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiFWTqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiFWTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:46:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F22C4EA0A;
        Thu, 23 Jun 2022 12:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MX0kiPH31dynVTuH8Zp+4b3FVBpDuquUp03t7B9Kx3A=; b=WrkY02HyWdaSbCakCsv/60qak0
        cjF94QBw2meBWDpaVl+0OAQ9O5Cvp5UiuIA9Cuvh478rgwXlN1flPtYyT59D/JEgIBztA81jBc4aO
        JbjvrSbjjRhNy5zdhlaeU4v45lL1XIvjjikRlwaX2KcZ8ro63bezPCBEqQ0kJCwb0aIZgoiF9nU5R
        eHnfzUoamfYunCrZGuLR8ZAXwl17gx5/9hD6i3D5SLvHBDujM7ooqU6iEmikFtaHJtBhKnXndhO7d
        uKCZANgtfgyTrlYPnpZMoaGZqz9E1/6+dLjr9uRzVJENCRRPFcos8Fp3493y5TRVCnRM9opfwMu7W
        DxrMCAWw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4Se8-00Bt7E-Ll; Thu, 23 Jun 2022 19:37:45 +0000
Message-ID: <930cad70-917d-b929-704b-7e761c3f5eeb@infradead.org>
Date:   Thu, 23 Jun 2022 12:37:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] docs: driver-api: gpio: Fix some typos
Content-Language: en-US
To:     Tom Schwindl <schwindl@posteo.de>, corbet@lwn.net
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YrSnkBodv7TYvtMb@posteo.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YrSnkBodv7TYvtMb@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/22 10:49, Tom Schwindl wrote:
> Signed-off-by: Tom Schwindl <schwindl@posteo.de>
> ---
>  Documentation/driver-api/gpio/consumer.rst   | 2 +-
>  Documentation/driver-api/gpio/driver.rst     | 6 +++---
>  Documentation/driver-api/gpio/using-gpio.rst | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
