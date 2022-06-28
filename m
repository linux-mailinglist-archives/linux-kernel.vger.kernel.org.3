Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9F55E046
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbiF1KcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbiF1KcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:32:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB6031DF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:32:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k129so5662596wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3APJSyQDW2CPdCYh4BrXZo+ifTGN0I3DidbMXQjqz5I=;
        b=vVasOXgDpS5a8pzCA0h/1ViYnXIdn7+NlAKEK3sUfVy51nbhCu0E9yEsleWytaC8sP
         Pkijhm3qUW+nnD7H0W+Z2rEae/Q2q8Fs68sR6TjxU4nk1/nQsetGr77azqSuIIvgVdM3
         l3t/UXdHlFz5LmVGg9dfiIc9aGKjNRHLiJKNFEj5rLPZZDNZEq+7RmB65n76qp7q9RZA
         vuT1f92PFP5+zzI12iQ0zrSlAFJzuJhO/L5ceh47zeOVQ19JVFcgIbXTxrxehHtt+MmT
         xx0rymcuZwPqB/rhO66rev47zZGIqBYFfU9kMeqy95jtLCS37vwQHi5NNJ1mX9HK6n0S
         9R7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3APJSyQDW2CPdCYh4BrXZo+ifTGN0I3DidbMXQjqz5I=;
        b=sJ1AxD+IHTLFx5lIVXlaTjqfHPxY2xTD+szIlqywR28xkZBoU6eIYFtVDkBvnejd5J
         cBPJGeGpXL++fhZge88KpAynGHX1F42nM1JWJyWjEFl/F5y3j7pL0RfM10TANoa113av
         69av0/bpfobuTKBrI8F+b9Zp3vIAZdpy1KZpWXJYWh8UES3Bl9hP6OdKFXDXmIFmO5TN
         JUrVTtrgWwrZS5Shmq4lGcQYyPbFiBIc3bMWF/PJ10ueyBQ4D9nRuAzOEYnYneYEh6Bv
         E5H5pfTNUH/C1LxiFg4oAwNOHWQrfsk0n4RRBvDShkmVRyjvFdpWOT+o6T2lHBfs81pq
         D0yA==
X-Gm-Message-State: AJIora9nq7dLbgfZzlmM7FciqF73CI5EmRvGqbTpzEOmrM2v33VcMOiS
        KplPmDdMlkqpwjAvf/XDzSrUgQ==
X-Google-Smtp-Source: AGRyM1s+JSkyq15GyyzT3xqY8Lc3g+1LuzQ7Glev3KcHkkBqiJAG558oaASpA9V5nhclnhGMPpDhog==
X-Received: by 2002:a7b:c24c:0:b0:3a0:4d4c:dc96 with SMTP id b12-20020a7bc24c000000b003a04d4cdc96mr8098122wmj.111.1656412334966;
        Tue, 28 Jun 2022 03:32:14 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c1c0d00b003a0484c069bsm10920284wms.41.2022.06.28.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 03:32:14 -0700 (PDT)
Message-ID: <0b8e357d-1d8b-843f-d8b6-72c760bcd6fb@linaro.org>
Date:   Tue, 28 Jun 2022 12:32:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Saravana Kannan <saravanak@google.com>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <b8ec04dc-f803-ee2c-29b7-b0311eb8c5fb@linaro.org>
 <CAJZ5v0jz=ee5TrvYs0_ovWn9sT06bcKDucmmocD8L-d9ZZ5DzQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJZ5v0jz=ee5TrvYs0_ovWn9sT06bcKDucmmocD8L-d9ZZ5DzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2022 15:33, Rafael J. Wysocki wrote:
> On Mon, Jun 27, 2022 at 3:08 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 27/06/2022 14:49, Michael Walle wrote:
>>> Hi,
>>>
>>> I tired to iterate over all child nodes, regardless if they are
>>> available
>>> or not. Now there is that handy fwnode_for_each_child_node() (and the
>>> fwnode_for_each_available_child_node()). The only thing is the OF
>>> backend
>>> already skips disabled nodes [1], making fwnode_for_each_child_node()
>>> and
>>> fwnode_for_each_available_child_node() behave the same with the OF
>>> backend.
>>>
>>> Doesn't seem to be noticed by anyone for now. I'm not sure how to fix
>>> that
>>> one. fwnode_for_each_child_node() and also fwnode_get_next_child_node()
>>> are
>>> used by a handful of drivers. I've looked at some, but couldn't decide
>>> whether they really want to iterate over all child nodes or just the
>>> enabled
>>> ones.
>>
>> If I get it correctly, this was introduced  by 8a0662d9ed29 ("Driver
>> core: Unified interface for firmware node properties")
>> .
> 
> Originally it was, but then it has been reworked a few times.
> 
> The backend callbacks were introduced by Sakari, in particular.

I see you as an author of 8a0662d9ed29 which adds
device_get_next_child_node() and uses of_get_next_available_child()
instead of of_get_next_child(). Although it was back in 2014, so maybe
it will be tricky to get original intention. :)

Which commit do you mean when you refer to Sakari's work?

> 
>> The question to Rafael - what was your intention when you added
>> device_get_next_child_node() looking only for available nodes?
> 
> That depends on the backend.

We talk about OF backend. In your commit device_get_next_child_node for
OF uses explicitly available node, not any node.

> fwnode_for_each_available_child_node() is more specific and IIRC it
> was introduced for fw_devlink (CC Saravana).
> 
>> My understanding is that this implementation should be consistent with
>> OF implementation, so fwnode_get_next_child_node=get any child.
> 
> IIUC, the OF implementation is not consistent with the
> fwnode_get_next_child_node=get any child thing.
> 
>> However maybe ACPI treats it somehow differently?
> 
> acpi_get_next_subnode() simply returns the next subnode it can find.


Best regards,
Krzysztof
