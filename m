Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5463C502016
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 03:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348397AbiDOBXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 21:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbiDOBXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:23:47 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC802A738;
        Thu, 14 Apr 2022 18:21:20 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 15 Apr
 2022 09:21:19 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 15 Apr
 2022 09:21:18 +0800
Message-ID: <413b9d1c-922e-43cf-b864-52b73622a53d@meizu.com>
Date:   Fri, 15 Apr 2022 09:21:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] iio: gp2ap020a00f: Fix signedness bug
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1649933135-14236-1-git-send-email-baihaowen@meizu.com>
 <CAHp75VfbZhMvs7dHwadvNs6maPsBVOY3Mk5wkKSwZ1RANQQHDA@mail.gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <CAHp75VfbZhMvs7dHwadvNs6maPsBVOY3Mk5wkKSwZ1RANQQHDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/14/22 9:47 PM, Andy Shevchenko 写道:
> On Thu, Apr 14, 2022 at 2:19 PM Haowen Bai <baihaowen@meizu.com> wrote:
>> function gp2ap020a00f_get_thresh_reg() is unsigned but returning -EINVAL
>> errcode, and thresh_reg_l is unsigned but receiving -EINVAL errcode. so
>> we have to change u8 -> s8.
> s8 is not enough to hold an (arbitrary) error code. To be on the safe
> side you need to use int.
>
Thank you for your suggestion.

-- 
Haowen Bai

