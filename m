Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D64DA768
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352972AbiCPBgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbiCPBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:36:43 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BD4037015;
        Tue, 15 Mar 2022 18:35:29 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:58204.1505761779
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 3B5FB10023D;
        Wed, 16 Mar 2022 09:35:27 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-749df8664c-nmrf6 with ESMTP id 4a35a6f78a8e472e8eb0b786b74f24f8 for gregkh@linuxfoundation.org;
        Wed, 16 Mar 2022 09:35:28 CST
X-Transaction-ID: 4a35a6f78a8e472e8eb0b786b74f24f8
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <e3567bf5-242d-ecdc-2a51-22c4d7d6f356@189.cn>
Date:   Wed, 16 Mar 2022 09:35:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] staging: greybus: introduce pwm_ops::apply
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, elder@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        elder@ieee.org
References: <1646791174-30557-1-git-send-email-chensong_2000@189.cn>
 <Yi9ZTdcZsdDjecC3@kroah.com>
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <Yi9ZTdcZsdDjecC3@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/14 23:03, Greg KH 写道:
> On Wed, Mar 09, 2022 at 09:59:34AM +0800, Song Chen wrote:
>> Introduce newer .apply function in pwm_ops to
>> replace legacy operations,like enable, disable,
>> config and set_polarity.
> 
> You can use the full 72 columns please.

will do.

> 
>> This guarantees atomic changes of the pwm
>> controller configuration and also reduces the
>> size of the driver.
> 
> The driver is bigger (more lines) with this change, so why do you say it
> is smaller?

ohh, yes, you are right. I copied from another commit with similar 
function and didn't count lines carefully.

i will amend the commit message and submit a new one, many thanks.

> 
> thanks,
> 
> greg k-h
> 

BR

Song
