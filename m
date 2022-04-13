Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC284FF8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiDMOSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiDMOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:18:45 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25A060ABE;
        Wed, 13 Apr 2022 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649859380;
  x=1681395380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZPsuxCY0ww8JdRko+Z1ABDoedxav4avLT3WBpcD8hQg=;
  b=bET4vWOYEJ/QuFF1Z1D6Ka9UUdhAiHV6viY7T1fRx/fUIigK+wJLf2T1
   D0FNJSw/3er1MQz3gEWoTw91vjlQDAmELkm2SXFWP2iAnhWpcWxVQo6tf
   OqA3RtQpeNhpDk11D9L6r8jXX8WtC+sn+xnDeZeIJLOAV9cZMWrpfif0N
   KNiaHFa497Kerko82niq10/2icnG4niMwMBsT+W08ewwIvVD3ZfzaJEZl
   b9qny2fa3CyIVtfV9VAXYCOR8NLsImh8naHHfWrU98k+hwJPNwTj06sfs
   sbH6nObfeM9pJJd9QBd1Od+DYYd/x4Zqf4yPd1MeZsuJSCZfhGYg1LcHj
   w==;
Message-ID: <d399e1a0-1eeb-f4f5-024c-6b29546723e1@axis.com>
Date:   Wed, 13 Apr 2022 16:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Camel Guo <Camel.Guo@axis.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
References: <20220412135232.1943677-1-camel.guo@axis.com>
 <20220412135232.1943677-2-camel.guo@axis.com>
 <YlXwyKkkC1VoPpjU@robh.at.kernel.org>
 <77167ffd-5674-9f6f-df51-3233e67fe9a7@axis.com>
 <YlbRdCXnPPurC2wC@robh.at.kernel.org>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <YlbRdCXnPPurC2wC@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail06w.axis.com (10.20.40.12) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/22 15:34, Rob Herring wrote:
> On Wed, Apr 13, 2022 at 09:13:39AM +0000, Camel Guo wrote:
>> On 4/12/22 23:36, Rob Herring wrote:
>> > On Tue, Apr 12, 2022 at 03:52:31PM +0200, Camel Guo wrote:
>> >> Document the TMP401, TMP411 and TMP43x device devicetree bindings
>> >> 
>> >> +      maximum: 15
>> > 
>> > Drop 'items'. It is not an array.
>> 
>> Not sure if I understand correctly. Do you means it should be like this? 
>> If so, I guess ti,n-factor should also be changed like this. Am I right?
>> 
>>    ti,beta-compensation:
>>     description:
>>       value to select beta correction range.
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>       minimum: 0
>>       maximum: 15
> 
> Yes, except your indentation is off. As-is, it's all 'description'. It
> should be like this:
> 
>    ti,beta-compensation:
>      description:
>        value to select beta correction range.
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 15
> 
> Rob

Now v3 is out with fixes on Rob's comments. Please review v3 instead.
