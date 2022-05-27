Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E77535F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244684AbiE0LVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiE0LVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:21:00 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01DD1269A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:20:59 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id uY1Znrm7w26JCuY1ZnnwBY; Fri, 27 May 2022 13:20:58 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 27 May 2022 13:20:58 +0200
X-ME-IP: 90.11.191.102
Message-ID: <e09439a8-d628-9074-7691-3d83a6d20267@wanadoo.fr>
Date:   Fri, 27 May 2022 13:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIXSBkcml2ZXJzOiBpbnB1dDogRGlyZWN0?=
 =?UTF-8?Q?ly_use_ida=5falloc=28=29/free=28=29?=
Content-Language: en-US
To:     "liuke (AQ)" <liuke94@huawei.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "marcoshalano@gmail.com" <marcoshalano@gmail.com>,
        "michael@michaelcullen.name" <michael@michaelcullen.name>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220527103740.3442548-1-liuke94@huawei.com>
 <159368be-82fa-f42c-9658-88cd0e1f1882@wanadoo.fr>
 <9c53080c64424a5ba9d33e789dbd1180@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9c53080c64424a5ba9d33e789dbd1180@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/05/2022 à 12:39, liuke (AQ) a écrit :
> Sorry ,  I'll be careful next time .
> 

NP for me. It's nice to have someone work on these clean-ups.

Definitively, coccinelle would help you a lot for this kind of patches.

CJ
