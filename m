Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A32588111
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiHBRca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiHBRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:32:26 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7613D46;
        Tue,  2 Aug 2022 10:32:25 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id f11-20020a17090a4a8b00b001f2f7e32d03so1998446pjh.0;
        Tue, 02 Aug 2022 10:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hQdFNNSZIS0UXH5mX4zMb5LlYpQDpBhKMVn8uxRhbMo=;
        b=6kjGl/TBSODgQj+Rd64zpVtC2CCXPfHM2Hy82MbnIcjjzUQL7Zh+xb9jdVJdP8QEnx
         p7fVqG+BIqKLGPSAb7LS+kq6phlAWOqf5JYfn85bz/5Ybx85QeTjoJGbpvbBmJGQK9S1
         nueE/NQjfLZmi7ecbV2MzjoD+9ymvkqYOl+MTMlIsHtZNOT4R4dwP/bGfZJ/oAsnAa2D
         ocqPr5NCFYxBhB4jzFoB4E6kMmAXW9WE0PqHd8l25V4zgxpxekMZJJc3dJWb/n3KG5hP
         ogh9HXfq+E1bvUK5t0q8SxZpOD1CrC/xxrVwJ58lA/W1UBCZC1IzxBgHVn4/863d6Tey
         j/MQ==
X-Gm-Message-State: ACgBeo1ThqwifQj0o0ene+kz/eYnBbf3FDIagNZyowYcWyHPpk0jxQAW
        L4ZJLCz7xiD1VesrJeds4Cw=
X-Google-Smtp-Source: AA6agR6cj4zMaUIGkgIgEbmD7+/rnsnZp6/rUNcmSKtSZG4r5I2Vtli545RhBV3QP349G6CDTl6bVg==
X-Received: by 2002:a17:90b:4f8d:b0:1f5:835:1b19 with SMTP id qe13-20020a17090b4f8d00b001f508351b19mr538171pjb.63.1659461544415;
        Tue, 02 Aug 2022 10:32:24 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5297:9162:3271:e5df? ([2620:15c:211:201:5297:9162:3271:e5df])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b0016bfafffa0esm12099648plx.227.2022.08.02.10.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 10:32:23 -0700 (PDT)
Message-ID: <438a9c4c-e601-ec22-0d05-5cec697d06a1@acm.org>
Date:   Tue, 2 Aug 2022 10:32:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] ufs: core: print UFSHCD capabilities in controller's
 sysfs node
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220802103643.v5.1.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <c4acb34f-7bba-336f-ddfc-a9c098f2c95f@acm.org>
 <CAONX=-cAW5UX__xu5y7NdtHkZq-YWmh_k=iFa5witdxw3xXkYA@mail.gmail.com>
 <d06d9625-8ef9-f385-a9c9-75c306a959ed@acm.org>
 <CAONX=-fpMBSgMzdY9AnV3iJftv2+0UTiruMiR+Dt_dfwKEd6gA@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAONX=-fpMBSgMzdY9AnV3iJftv2+0UTiruMiR+Dt_dfwKEd6gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 21:12, Daniil Lunev wrote:
>> Calling this the effective capabilities of the controller-device pair
>> sounds good to me. But please do not refer to hba->caps. I'd like to
>> rework hba->caps such that it only includes controller capabilities and
>> no information related to the WriteBooster. Additionally, several UFS
>> device capabilities that may be exported in the future are not
>> represented in hba->caps.
 >
> So can you clarify where specifically do you want me to mention that?
> Should I name the directory "effective_capabilities" or the commit
> message?

I'm fine with the name "capabilities" since "effective_capabilities" is 
a bit long.

How about adding the above explanation in the source code close to the 
definition of the capabilities group since it is more likely that it 
will be noticed there by software developers compared to Documentation/ABI/?

Thanks,

Bart.
