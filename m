Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5654C6F39
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiB1OWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiB1OWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:22:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D57EB05
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:21:37 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so879934wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1m78nP9MPOTO37Tbcq5yI1vtpVIuvuvJ5OfyBvjoqkg=;
        b=wCw1bXU6AAkC+gFr+q2QzxfOyv6q/twq01W/I9vw843fCB/xWP3nxw/gY7kNP1AkO+
         1wHuPbkKsHxu4I74DcMm4Sehoa7kJq/EbymTAlP7osXbqTYQD4L/9wBwBiWSTGyqQHO7
         14beVV4RiGKnINIQEQ6ZvhGifoK94CnWy8tCHYnRDX9FaU4QXBObc6cvofs3bKtu/i63
         kROCnuxAqjFKSRFg2Xc/48atydjLGF6aceSdxtpcnDnuNEFUw9QTCDHG7yskeHBsKsv7
         112qFrjOVI/Ca3Bis5kjbvMEU9C/a5V2fwqXJx0sI1pM4AHNrl9dKixM/cVOycOdYbA3
         Cokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1m78nP9MPOTO37Tbcq5yI1vtpVIuvuvJ5OfyBvjoqkg=;
        b=v8wRxH+FgykV+yPaeWO+gIG2AEoDplV8MXAPRacNfwuxfQfZrb42XwqvF9waV5l4Wu
         oin+w3CwY0ZNAhWqC6oVS6qFeWXU5ZBGreoTWnSBN59aRxVScaPM/Ytlt/sDJEs4ceGG
         Ko82BsC971qyOJA4R8FTNMGCX6nch8hUFoa/R7hSNjjlfV4HQafrZp6d4gDnTsa41rxg
         07nSLv1AC0pYmDPfWPnDs7j7JLTce4sWS/TSExtTkK0F7OYX3oW2Q3sqtqPndpcSpksS
         5Nut2GPy9RRFakmJZPWSicOs0qA8o+7i9KgFYtL8FK4AZJjjEpqcyau3o5P8Kpx9VjY4
         E9IA==
X-Gm-Message-State: AOAM531pvtbxVsq5gPjoYcGcKHDQtWgFCB+/Yy1Ujjjp7ANjPqzFw32Q
        2/Xh5LsMfCqy44ct00M5q/xVpQ==
X-Google-Smtp-Source: ABdhPJzHJSlUWIjmaXDwkIUbazIKOklj7/OQCNP7ZG75E9gOJkTqR6bqM8iew35ergN06xRfXjOBYA==
X-Received: by 2002:a05:600c:418b:b0:380:e493:660a with SMTP id p11-20020a05600c418b00b00380e493660amr13352509wmh.189.1646058096132;
        Mon, 28 Feb 2022 06:21:36 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id l5-20020adff485000000b001e322a6ba79sm10848450wro.86.2022.02.28.06.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 06:21:35 -0800 (PST)
Message-ID: <39abefa3-9f41-8688-964c-5e6d04084ab0@linaro.org>
Date:   Mon, 28 Feb 2022 14:21:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] ASoC: codecs: wsa881x: add runtime pm support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
 <YhzPFJabTS5UZd7v@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YhzPFJabTS5UZd7v@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 28/02/2022 13:33, Mark Brown wrote:
> On Fri, Feb 25, 2022 at 06:07:16PM +0000, Srinivas Kandagatla wrote:
>> WSA SoundWire Controller does not support Clock stop and performs a soft reset
>> on suspend  resume path. Its recommended that WSA881x codecs connected to this
>> are also reset using a hard reset during suspend resume.
>>
>> So this codec driver performs a hard reset during suspend resume cycle.
>> ---
> 
> You've not provided a Signed-off-by for this so I can't do anything with
> it, please see Documentation/process/submitting-patches.rst for details
> on what this is and why it's important.
Hm..
Am not sure why was this missing in first place.. Let me resend a new 
version with proper sign off.

--srini
