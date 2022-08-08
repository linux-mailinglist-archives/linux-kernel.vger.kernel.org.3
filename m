Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D258C459
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiHHHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiHHHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:44:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4378112AC1;
        Mon,  8 Aug 2022 00:44:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h13so9889648wrf.6;
        Mon, 08 Aug 2022 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sf4wLGaCgzbbxoh829tsTcB7v9NtgcB/mEiDvk8sXgU=;
        b=pkJNBjUZfEfopdTEikMVR2I0gPkKay6eHwIjeMgFj7T5FYpGjJeEHl6mPJj6oYl8+S
         URg9JtRQ2zthx7IoO3e97xztpZyF3eweTUYX9/qATbMl+ZbU7vMCC2AekMMzXmmam6Wt
         kWhKYIQCT2katpcoW0gnd6p9WEmrySneC7yJ8zP8s1ZrYXov3fc2mrGbyVXsf3PfJ17B
         zHL4FUNJZVqNtut/ZE09c2aPxIHyHRF/44ad7MycSu5zpCMu08n2rUH+atf+KzEJK0Ar
         A6plYOAlp8inMDMuiEK2QViBiJJyAr59BMlTwQWWpYunVm2M9VkzwLo2Ev5hP29NjuZa
         tfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sf4wLGaCgzbbxoh829tsTcB7v9NtgcB/mEiDvk8sXgU=;
        b=xBfWRE6UZuMx+P7JxYl1oPzSsuOcU5ydrTfrQ0LOtv3ymFvIkpONkV12SizpJQ59lx
         Io7N2kLCllL26j0+ZbZV5WE2ihR7e1D+GwGkVu66deBa1T/BmKrwQYQO2GfHD/bNgcBt
         MB9NMcTg0U7UDFQ+rgjZkn6+zFK55vKQcXlg44mwwYo0EZ2a13G7VGiL22gQxnap6Ope
         XnyurR/1fr3KilxE/Jc5Ol7cp440e/9zsnsNqI2grmDaWHea8qVq9dEs/1bB7wiC9SQ4
         +Up1WBi7saqE8GIxlaw6UKlYO9/lhCHhyM8f6+PRvNszd5JTqMkfFELV4sp7DO7i/5D5
         it4w==
X-Gm-Message-State: ACgBeo0G+gdtJDSsr0sSHyj2not/ARI8djlxvxMp5291uipL5kUtRPh3
        ToOkYMAyK/leEQbjvb55OBY=
X-Google-Smtp-Source: AA6agR5pw41Hz6lN25sLb6EVDy9R13XQOeH5Z+FNSKWjGm/CtgDwV/YV8LXMLn9Y6qatMmfh4/Gutw==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr10435771wro.603.1659944671776;
        Mon, 08 Aug 2022 00:44:31 -0700 (PDT)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id k12-20020adfb34c000000b002205df9ce16sm10677495wrd.97.2022.08.08.00.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 00:44:30 -0700 (PDT)
Message-ID: <f05e0c92-a1c9-f517-e1b4-f753e362dfd4@gmail.com>
Date:   Mon, 8 Aug 2022 10:44:29 +0300
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
 <47970684-1158-cee8-9ff5-d7dca70a54ae@gmail.com>
 <20220720175444.GA10744@elementary>
 <3cdbcfe5-bb7e-2677-730f-f250e2d33f0c@gmail.com>
 <20220724110509.GA30492@elementary>
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <20220724110509.GA30492@elementary>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 14:05, José Expósito wrote:
> On Wed, Jul 20, 2022 at 09:13:39PM +0300, Nikolai Kondrashov wrote:
>> Could you send me an email once you got something ready for review?
>>
>> Thank you!
>> Nick
> 
> Sure, the PR is ready:
> https://github.com/DIGImend/digimend-kernel-drivers/pull/598
> 
> I included the patches present in "for-5.20/uclogic" but not the
> patches I sent during the last couple of weeks to the mailing list,
> just in case changes are requested.
> 
> In addition, I created another PR adding the XP-Pen Deco L tablet to
> the web:
> https://github.com/DIGImend/tablets/pull/52

Thank you, José!

I finally made the release:
https://github.com/DIGImend/digimend-kernel-drivers/releases/tag/v11

Nick
