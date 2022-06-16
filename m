Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38C54E9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377665AbiFPSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378036AbiFPSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:45:36 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460682CDC5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:45:34 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1uUgoKVZMQKua1uUgoCzF2; Thu, 16 Jun 2022 20:45:31 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 16 Jun 2022 20:45:31 +0200
X-ME-IP: 90.11.190.129
Message-ID: <1285751d-c4af-23ec-148c-88b0e3867e6a@wanadoo.fr>
Date:   Thu, 16 Jun 2022 20:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drivers: soc: sifive: Add missing of_node_put() in
 sifive_l2_cache.c
Content-Language: en-US
To:     Liang He <windhl@126.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220615122315.3965435-1-windhl@126.com>
 <a5f6f76d-efc1-b421-7623-ad46996f5b94@wanadoo.fr>
 <7321db1e.3902.1816b00e5e6.Coremail.windhl@126.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <7321db1e.3902.1816b00e5e6.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2022 à 07:33, Liang He a écrit :

> 
> Sorry for my troubles. I will check my patch more carefully.

No problem, you seem to be knew on the lists so you have to learn the 
tricks, coding-style, tools...

Happy patching :)

CJ
