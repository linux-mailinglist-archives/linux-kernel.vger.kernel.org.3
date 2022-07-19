Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7C57A49D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiGSRHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiGSRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:06:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6E65A45D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:06:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so22622091wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PPoKfBGkXXxmGl6O1Gk3RK4S8Nhp870sCocHUBEXJII=;
        b=ggzcS2a91OOnHLScrhNTeWz1TSdg4gFtX5yMfeZLPwtfcqOyOmobVOPjLQZ4rlE+xR
         Bq6B/cR1Z/y0nPj/9OrvBKy7LM8B3LMPhZ7YZfY4WeYacZKpAwJfrLaU3523tNLoAKI8
         mtmsrrw+zMsiBfHZ3umy8xolYJw8A7vTKzk0bQ3lYL4jNDVSXCKm54iIAeON1J+Q+z3I
         aEYI4IAd2bLqJ+t508ju7MZmlpyruWaxCOFmfk1+BXh+pQYSd1azpYc8EHQr4B/GAKwh
         xgANz7Ab/4Kk9/2tNFr5wD6TITAfzK0JxWh5w/Rv6+zA7uZHhOGTFGcPLcqAHKBLhzrU
         TSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PPoKfBGkXXxmGl6O1Gk3RK4S8Nhp870sCocHUBEXJII=;
        b=dmzugFVPRkzKIaqAip2PQqLjZQtytGTS8YZ8pIaEIXo1tdRnNXyoz9sKmc1FmsbnIP
         qKzOEtd9JjIUQMLwQ5Tp8q8tiuPUE8KmSnuTePZE7Bu3GXaR1zMdNqhx+oOGWD67RQtw
         rdauxz0+yDsg6q+5j9HYclMy3rExwi2trE+YtxIj3wpUNSseJp7iJCvT5+GmdNXOlZby
         HAVUkLqdRR2Y114eJQOR15MGaF+f3mD1SfliU+BczDgrCs92NaCADi4tXQQZNF5IUUwA
         MAhduSEZrizv818VjNaxnnBzQu2j3K8RPUby0XeHxvokph+V2BgmM2XtB8hTVKYcwYim
         1t+g==
X-Gm-Message-State: AJIora8/CW9Viaz99sMuTo4dhbIcQoi7LKFC/XUJ3oL7ZDtjodtZPRyc
        RC6+XioHuHxYXGR/S7eYEdpNOw==
X-Google-Smtp-Source: AGRyM1vL+bLH1TV5rnrlHM7im1g77qgAlj+SscRCiKMGDazhRA+LaVuI+eN5qQuPFJBsUL48zgM5hw==
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id m14-20020a056000008e00b0021d7e9767edmr26686956wrx.343.1658250402825;
        Tue, 19 Jul 2022 10:06:42 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b579:e7b5:219d:267c? ([2a05:6e02:1041:c10:b579:e7b5:219d:267c])
        by smtp.googlemail.com with ESMTPSA id p10-20020a05600c1d8a00b003a30af0ec83sm17505000wms.25.2022.07.19.10.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 10:06:42 -0700 (PDT)
Message-ID: <bbef10b1-7595-df6c-8fe7-6e75bfe0dc2d@linaro.org>
Date:   Tue, 19 Jul 2022 19:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND] tools/thermal: tmon: include pthread and time
 headers in tmon.h
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        =?UTF-8?Q?Alejandro_Gonz=c3=a1lez?= 
        <alejandro.gonzalez.correo@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <20220718031040.44714-1-f.fainelli@gmail.com>
 <a78473a8-d4f9-d525-104d-2d08f92a1873@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a78473a8-d4f9-d525-104d-2d08f92a1873@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 18:11, Florian Fainelli wrote:
> 
> 
> On 7/17/2022 8:10 PM, Florian Fainelli wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> Include sys/time.h and pthread.h in tmon.h, so that types
>> "pthread_mutex_t" and "struct timeval tv" are known when tmon.h
>> references them.
>>
>> Without these headers, compiling tmon against musl-libc will fail with
>> these errors:
>>
>> In file included from sysfs.c:31:0:
>> tmon.h:47:8: error: unknown type name 'pthread_mutex_t'
>>   extern pthread_mutex_t input_lock;
>>          ^~~~~~~~~~~~~~~
>> make[3]: *** [<builtin>: sysfs.o] Error 1
>> make[3]: *** Waiting for unfinished jobs....
>> In file included from tui.c:31:0:
>> tmon.h:54:17: error: field 'tv' has incomplete type
>>    struct timeval tv;
>>                   ^~
>> make[3]: *** [<builtin>: tui.o] Error 1
>> make[2]: *** [Makefile:83: tmon] Error 2
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> Reviewed-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
>> Acked-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
>> Tested-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
>> ---
>> This patch was first submitted here:
>>
>> https://lore.kernel.org/all/20200617235809.6817-1-mmayer@broadcom.com/
>>
>> but never applied, meanwhile the issue is still present
> 
> Daniel, Rafael, any chance to get that into v5.19-rc7? I should probably 
> also have added:
> 
> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal 
> subsystem")

Yes, I'll pick it up

Thanks for resending


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
