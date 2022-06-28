Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29A755EDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiF1TnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiF1Tl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:41:57 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110A3B557;
        Tue, 28 Jun 2022 12:34:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h5so8848908ili.3;
        Tue, 28 Jun 2022 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NkSDg+lfWXixNOxx3cLuyU9hZDDj0D6UlVxzr8Nf8bk=;
        b=m6bA5mZmSq21hnMWGlbnaX2FzXtihBT8jEtxpZ5oS8Gxbi8H02gUXalh0Akn8oIvXt
         jMxGkEjqcBRdd2B8KSr1360aq0CnOLZJ2S4Q333HH39rJxKv36YJ9GAOXbteEs6TtMzM
         aLpV+4iwoEg8TyxyJSQVQDfR6YlQduhNV4IaoNI7ScwIXprAHf7HxiIW9Fh5xoFArvxf
         l3nIZoe6yqhIRq8GZsbTFpPj5GgsK2U+xgU1v6yh7iOCgiXmGohZ2+8CxBza4WBxx2tO
         bnJPBT1sCHyWsOGu0Nqnh0RsTrQ95KaNRZx0AZ7gDp91WgaLmwL6RbqLC2BxCwbIn50u
         wFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NkSDg+lfWXixNOxx3cLuyU9hZDDj0D6UlVxzr8Nf8bk=;
        b=i5ma0QBKfctFibW1X7xLpWECyhXZNB+mLZT1ZCMSHORMyTGR+g0ZxJNp5lgjwSjR4T
         lga2TqMSZUiqdJ+XTo7RSLRiql8Du+0wLYPlK5/wfUPiSetMXhyzMIqZgUiawqhiP0u9
         2BcBtSRXJB9CwyH/tkuNcj3VvCXnU4JWsMFG87T4lVye1uVu+neO7CW6k0eOge6i8rcZ
         k8OnAlm8nX6xZQkqp8jq4c84T3GQW3C/vF+M3rpU0RmTfn3yRvGw02v87xsCmlJr3kAm
         +UEER7v3NKFtE78i3RHrDXGi6vcPqyNVK+GwMLe64nt9n2U4r3n37ZQft5SHqKW7yTmQ
         YX6A==
X-Gm-Message-State: AJIora84F4W5CeSyGC0n/rl8E+Uh7mN94IXE5NH85b41rrp+F0bJbhGl
        zV47Mgi0Auc3upxjQybqEdA=
X-Google-Smtp-Source: AGRyM1vby4Jgopb5YEAsOIaRvMD94aL5SjFUjZUlNunvkcjragEb0l8hS4RjiTjoLJ7hHNEFb1ERSA==
X-Received: by 2002:a05:6e02:1c4b:b0:2d9:5706:7a50 with SMTP id d11-20020a056e021c4b00b002d957067a50mr11235672ilg.257.1656444897015;
        Tue, 28 Jun 2022 12:34:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:c1c4:e86e:486b:1642? ([2600:1700:2442:6db0:c1c4:e86e:486b:1642])
        by smtp.gmail.com with ESMTPSA id ay7-20020a056638410700b0033ca8eb3736sm2142885jab.167.2022.06.28.12.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 12:34:56 -0700 (PDT)
Message-ID: <db1e0e98-ba52-51ef-071d-bda49b8ae0b6@gmail.com>
Date:   Tue, 28 Jun 2022 14:34:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] of: unittest: treat missing of_root as error instead
 of fixing up
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
 <20220624034327.2542112-3-frowand.list@gmail.com>
 <20220628143659.GA424332-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220628143659.GA424332-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 10:36, Rob Herring wrote:
> On Thu, Jun 23, 2022 at 10:43:27PM -0500, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>>  setup_of() now ensures that of_root node is populated with the
>>  root of a default devicetree. Remove the unittest code that
>>  created of_root if it was missing.  Verify that of_root is
>>  valid before attempting to attach the testcase-data subtree.
> 
> What happened with the formatting here?

I'm guessing you are referring to the leading space?

I pasted the text from another file into the commit message in
my repo and failed to remove the leading blank. So a "typo"
on my part.

-Frank

> 
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/unittest.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 7f6bba18c515..9d106998c1f2 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1469,20 +1469,16 @@ static int __init unittest_data_add(void)
>>  		return -EINVAL;
>>  	}
>>  
>> -	if (!of_root) {
>> -		of_root = unittest_data_node;
>> -		for_each_of_allnodes(np)
>> -			__of_attach_node_sysfs(np);
>> -		of_aliases = of_find_node_by_path("/aliases");
>> -		of_chosen = of_find_node_by_path("/chosen");
>> -		of_overlay_mutex_unlock();
>> -		return 0;
>> -	}
>> -
>>  	EXPECT_BEGIN(KERN_INFO,
>>  		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>>  
>>  	/* attach the sub-tree to live tree */
>> +	if (!of_root) {
>> +		pr_warn("%s: no live tree to attach sub-tree\n", __func__);
>> +		kfree(unittest_data);
>> +		return -ENODEV;
>> +	}
>> +
>>  	np = unittest_data_node->child;
>>  	while (np) {
>>  		struct device_node *next = np->sibling;
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
>>
>>

