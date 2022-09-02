Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062B5AB645
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiIBQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiIBQLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:11:19 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB3D83E5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:05:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-12566bc8e52so2539843fac.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8dCdssbHxdmRg9kpNW1ckRyuV7LDGfaqP/6/uKsyA1k=;
        b=fH+pptMq+fzJaMfs68XlpqPxyFpFVU5P+jgfcIrvSKlqXkGr2og+zut6xQy1B8HKtT
         FlknUkaqp8FLsUPDCaZcJJSWNR98iC9ADZFCL+hlNCmWQqcippLqfqQC9MBXs1UWOpT2
         qJpVMLKofbgE37SZf8SHZM4txDIxvQHAbuc6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8dCdssbHxdmRg9kpNW1ckRyuV7LDGfaqP/6/uKsyA1k=;
        b=ihcfrHUjyg0huS+fn7DNSqs1CBFtHXt4YckVHeFVyPXabfmsrtdTHdWpXfwLYJ0r7d
         TNRcucJlNwhlZ2vbXiaaGZUeVb5KwqiLMuqg7nkw30c98XAdx3xE2GAIAo6Y0LPZ3M76
         BZvecwDRX4VCYQYhV6YrVB02sBNKqPcDhbk63tZ/Em2BC8jH1X3VhOyXXclnS79CP12a
         UfODLPpy7xA0uPnZGfVWZGlKrXHx8IADswkQTbI5hkzkL8gf79JdolBypo6YgUMCUF2e
         2YhaBbM2h7pt6ZIiR4eRiq9cBjAExEtuymnd0i0ySw9YmGr5C1EcoHT+/gmxUMr73Rxo
         BJLQ==
X-Gm-Message-State: ACgBeo2cq3mlP/oJrzwEWZow5dtZ/0xvaXZzFGRcEQY7ckLpVn1T4HJc
        EH/IIBkKep9+dtE8wA+Ox0M7KA==
X-Google-Smtp-Source: AA6agR66E1bSPsaHYaDn0YGw+zMoKwav/GR23CH3g9BlJpDKjnsPtKUuIGRmWLldPjfWxdVoiI3ggw==
X-Received: by 2002:a05:6870:a7a5:b0:125:76da:1bc1 with SMTP id x37-20020a056870a7a500b0012576da1bc1mr81319oao.272.1662134737084;
        Fri, 02 Sep 2022 09:05:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x5-20020a9d4585000000b0063711d42df5sm1196165ote.30.2022.09.02.09.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 09:05:36 -0700 (PDT)
Message-ID: <270dc10d-bc25-0b88-7eaf-b97fb68fc010@linuxfoundation.org>
Date:   Fri, 2 Sep 2022 10:05:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] docs: update mediator information in CoC docs
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, gregkh@linuxfoundation.org,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        joanna.lee@gesmer.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220901212319.56644-1-skhan@linuxfoundation.org>
 <110faf8f-2578-67f3-741c-02182b485769@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <110faf8f-2578-67f3-741c-02182b485769@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 01:57, Bagas Sanjaya wrote:
> On 9/2/22 04:23, Shuah Khan wrote:
>> @@ -51,7 +51,7 @@ the Technical Advisory Board (TAB) or other maintainers if you're
>>   uncertain how to handle situations that come up.  It will not be
>>   considered a violation report unless you want it to be.  If you are
>>   uncertain about approaching the TAB or any other maintainers, please
>> -reach out to our conflict mediator, Mishi Choudhary <mishi@linux.com>.
>> +reach out to our conflict mediator, Joanna Lee <joanna.lee@gesmer.com>.
>>   
> 
> Why had Mishi be replaced with Joanna?
> 

Mishi is unable to continue to serve on the committee due
to her current commitments.

thanks,
-- Shuah
