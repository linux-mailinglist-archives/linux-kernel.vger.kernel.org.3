Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7357BD25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiGTRqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiGTRqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:46:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956343E51;
        Wed, 20 Jul 2022 10:45:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so27177903wrc.2;
        Wed, 20 Jul 2022 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2kl28+S6ry6c13j5cXgtm1d+IOWTpDAhjNj1zVliyOM=;
        b=JbRKm9olk7xWgCdpkxuLJGPyXrfprMMTzdirLPelQo7WtfHsX/Y+C7r9dzH1bXOCQ1
         luLVd18L3DO7zXva2nvU5xw0WtFM5Sbpt8BABc3pC2ZIq7/kBOZepHLli6zmo0of0DQ6
         fZZ+pcgd9yh1sQ4Ber+ZF+hLw0MiXC4kK3HZ2vH9oHRaICU/e8sSa0llFw1puGZFsQf9
         NTflBtzwKApsNAAuCvmoTrvhw+9uOSundT00GNQF5s6//oD77kuNKj6+AWp/kuqkNFr3
         4uxX4DZsJ/G8ca+sSg3GjaKgfJA4a/ucGK5SfOpORETL78ca0LtzalrfeYBCL7vylHa8
         eyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2kl28+S6ry6c13j5cXgtm1d+IOWTpDAhjNj1zVliyOM=;
        b=n6AooL3fUqqa2FnlpKv45r68AzAbdANgFu4CVd+2mAOyHX3Zy/26Psvc4eF+5nLMTb
         i9IPfKQ3/Us3viOk9LameYygFGYXZlKn7FpTIAFWohwshuCKcimBOaB6Cquitoi99gXm
         cYCfOz++r5QvPb+dYTDUFSUJmdpG9qi5MwnisDN/Tj1qsZw42k+lPXpkhNPfZtl+My5T
         GiyPqJ8PUneyFf67qrfSJzxnjsHzNhiFR7tvW07RN+S490kLkncTJPP/ZGWh/5yfke1R
         FOe5GnbzpEzqE5rXg+TUb0FD1U9G60Ki1xoteCihhUplG+Ap7JE2NkydCXoz+9eP8BSR
         /gCA==
X-Gm-Message-State: AJIora+b+KqJ5cSzXgzdYQeBrIcABRCqY+znyG+dBTog9uImBMCBTkBM
        Jj6WcbLqQg7FAFz3WL2Hn3Y=
X-Google-Smtp-Source: AGRyM1uU9BSa/FdbgSBo/vKBJpWCvH03e8JgHH+mbpSk3vY10CxOxYi/me77WItgM/Fn5Yrmqa/lzA==
X-Received: by 2002:adf:e187:0:b0:21d:64c6:74f0 with SMTP id az7-20020adfe187000000b0021d64c674f0mr30653939wrb.221.1658339157339;
        Wed, 20 Jul 2022 10:45:57 -0700 (PDT)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b0021e4c3b2967sm1807013wrt.65.2022.07.20.10.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:45:56 -0700 (PDT)
Message-ID: <47970684-1158-cee8-9ff5-d7dca70a54ae@gmail.com>
Date:   Wed, 20 Jul 2022 20:45:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] UCLogic: Filtering unsupported HUION tablets
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220718172953.6817-1-jose.exposito89@gmail.com>
 <5d4ef0df-083f-a00e-fb41-1ce1df6e9473@gmail.com>
 <20220720173656.GA3725@elementary>
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20220720173656.GA3725@elementary>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 20:36, José Expósito wrote:
> Hi Nikolai,
> 
> Thanks a lot for the quick response.
> 
> On Tue, Jul 19, 2022 at 12:57:09PM +0300, Nikolai Kondrashov wrote:
>> Hi José,
>>
>> First of all, thanks a lot for all the work you're doing with the tablets!
>>
>> Yes, this situation is unfortunate, but there's really not much we could do.
>> The tablet database at http://digimend.github.io/tablets/ hasn't been
>> updated in ages, and it has never been exhaustive to start with.
>>
>> There are tons of tablet modifications, including of the same (marketed)
>> model, and those can differ not only in the reported name, but probably even
>> the VID:PID, as could've happened when Huion switched from v1 to v2
>> protocol.
>>
>> So, I think a "whitelist" would be a maintenance nightmare.
>>
>> Moreover, I think it's better to disable the tablet completely in case we
>> failed initialization (e.g. got an invalid response to configuration, or
>> failed to find some interfaces and such), after producing a comprehensive
>> error message. Configuring a tablet partially, and then handing it over to
>> the generic driver could mess things up more.
>>
>> It's less confusing for the user, and stops them from trying to fix the
>> problem up the stack with various settings, often getting into a worse
>> situation. It's also much easier for the maintainer, since they don't need
>> to investigate all the higher layers.
>>
>> A "blacklist" would work better here, if you can find the tablets to include.
>>
>> Nick
> 
> That makes sense, thanks for the pointers.
> 
> It is unfortunate that we don't have the required information about the
> supported tablets. Excluding the unsupported tablets (when fixing them
> is not possible for reasons) seems like a reasonable approach.
> 
> I don't know about any broken device handled by the driver, so there is
> no need to add new code yet :)
> I'll try to keep an eye on DIGImend's issue tracker now that the code
> present in the upstream kernel is being released by many distros.

If you have the time, backporting your changes to digimend-kernel-drivers 
would get you feedback much faster :)

I can do a release once we get the code in.

Nick
