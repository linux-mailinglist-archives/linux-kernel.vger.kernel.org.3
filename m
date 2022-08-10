Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97158F238
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiHJSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:18:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E86078BCC;
        Wed, 10 Aug 2022 11:18:47 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q16so15038646pgq.6;
        Wed, 10 Aug 2022 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=4Qe7pkOfTkIyBMN77CscNdL9fHPyjbZahG4sCTgRDro=;
        b=NAXMZLDYFMah87mFGFNrcsSjybO35Sl6jtbdplfqpavTsUj3ercqV92jpwqr04Csir
         RiPLjxRoP81ns+VmzbymOLhXLs59bQUsuf6yOoB9rftTas9cRILF+cKY40ZmHMkbRrFU
         BVML7yoSAEzK63V8JUVY65MZtEa8LpKWdeKlSlg0tDwsCifGSl4JVnPSqxVWc7E4M40/
         Rzv/XYE9NEFenugR4twTvUEvELN1qwLQ8vxZF7e5O0lxjdNsuyZxyeG46u5sl7W0vpmv
         cYPo+zwNu8A/8NMYXZof84nPYrU3e1qIw+125i4czCZlwKqevpeH/GDce1BVx1Fwv2Dq
         B3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=4Qe7pkOfTkIyBMN77CscNdL9fHPyjbZahG4sCTgRDro=;
        b=MsFVXMsawhBBOocsD2S3eoTO0z8yfqP8mPg0TbWQllW4xRHCGmaa9rBNT8LdO4Lsc0
         KC03YdFdA8NdrUpBg48MrxbVoXlb0pwZwgGuiAC2RkF9ftqDrFVpMcCMKXetY42v/v7U
         ZI0vBN8PEZQXG0yVOewv8QdXmOxt1NwZUNP7leBZgNwjww1cWUyPuPMf5dz/abOEVj5B
         R5zM36c2PO8bw0WWVqrnO/yRzMaGxPfFQAArNQaakUQeJcJplC6qJqiezIThb+fRcx82
         ejXVUCgUs39lduv3KyeZWVCEVUZG1OIWENSNm/tXe044/g9ErW+3ZNJiMZmPSDgVSyxh
         Vq7A==
X-Gm-Message-State: ACgBeo2Hn5IABDRAjT1UKHAO2AvAgid3WdXcJNjpzQkn/T5ikhb6u4Fe
        3UrGrzvgnd8ZfzFza6rafsI=
X-Google-Smtp-Source: AA6agR5529r19hXJr6ZZ9dsKEgjCH86e1dZqXk/IGrQW8jIgv16b9SNY7Xv51e1ta5Y3O0td/Dm4fg==
X-Received: by 2002:a63:8348:0:b0:41d:b224:c541 with SMTP id h69-20020a638348000000b0041db224c541mr9213899pge.143.1660155526528;
        Wed, 10 Aug 2022 11:18:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6-20020aa79846000000b0052e6c073a3csm2398088pfq.142.2022.08.10.11.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 11:18:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <275071f0-d00b-daf5-8232-a0a6a46d685b@roeck-us.net>
Date:   Wed, 10 Aug 2022 11:18:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] hwmon: corsair-psu: add reporting of rail mode via
 debugfs
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <YvN4SbnAp3jl+Vzo@monster.localdomain>
 <20220810133012.GB274220@roeck-us.net> <20220810193541.29f95ec5@posteo.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220810193541.29f95ec5@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 10:35, Wilken Gottwalt wrote:
> On Wed, 10 Aug 2022 06:30:12 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> +static int ocpmode_show(struct seq_file *seqf, void *unused)
>>> +{
>>> +	struct corsairpsu_data *priv = seqf->private;
>>> +	long val;
>>> +	int ret;
>>> +
>>> +	ret = corsairpsu_get_value(priv, PSU_CMD_OCPMODE, 0, &val);
>>> +	if (ret < 0)
>>> +		seq_puts(seqf, "N/A\n");
>>> +	else
>>> +		seq_printf(seqf, "%s\n", (val == 0x02) ? "multi rail" : "single rail");
>>
>> If this is not always available, would it be better not to create the file
>> in the first place ? If that is not feasible, it should at least be
>> documented that the value is not always available to ensure that no one
>> complains about it (or at least no one who read the documentation).
>>
>> Also, is the value strictly 0x02 for multi-rail configurations, or
>> is that possibly just a bit or the number of rails ?
> 
> The mode is actually switchable on fly, similar to the fan. I do not want to
> provide the switching functionality, because also similar to the fan controls,
> it can be used to damage the PSU. It is part of the over current protection
> system (hence the name ocpmode) and people use the RAW interface to switch the
> fans and the ocpmode. This is also the reason I made it that way, because you
> could poll the information right in the process of switching, which can result
> in bogus values. 0x02 is the value for "switching to multi rail was successful",
> every other value is considered "single rail mode". Or you get a malformed
> message which results in "N/A" or unknown. So yes, you are right, I could at
> least add a define for the value and be more clear in the documentation. Would
> that be okay for you?
> 

Define or not is up to you, but it would be nice if at least some of the explanation
above would be documented in the driver.

Guenter
