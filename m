Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948BB5A897C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiHaXYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHaXYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:24:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57B4E0A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:24:46 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z72so13236473iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8cRj+wC2SekV3g/lnG7OaUo/IWIUcAUM42NCJCbEaVU=;
        b=SEtJIjyCH/OQa4i3YC29am3HN/68LbFFcD8vT8/EgqO7o/yoqct/Ln6fk4qC3798Fx
         5ztkrHm3A1FboO+14txXalKKEuSSxOzdiErfBgd2jU1l0EqOoiPC3wUMhQScId2Va1sK
         NuEAUpvc6YxwuZOjsNsdCt71L3tNBatIKZ8FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8cRj+wC2SekV3g/lnG7OaUo/IWIUcAUM42NCJCbEaVU=;
        b=rzVx6QYRPvX0HAdsXF9tnKbhvartoaIh+SCuUDAx1C/wNkGZSnbPlKV16SFmEyMxx/
         hRH+RQVY/zK4CRgSrx6aGan/KGy63Hq1OROGq+0dyFiKnkWNeGE1E/lY8hdmOmn2cH8V
         VqLBWKDpdXckKl6lFHSGstnV/7fgLR9nILQHT9SpFQhOn3BbVxnhwzpraB4KSinZS85H
         Ul+PdTsxTLMCIaBd6FeASJFR/4XBhU7EUKCJRaWTW5i9KOcutFu457a0BFkstMbQtr0S
         lR+D0WSfdYa0Tlm2nORkDQcCuqAjtdsNmJjPVegbGzQnLxPDI8tQni+1lfEJZKcqwQ+D
         72xQ==
X-Gm-Message-State: ACgBeo0BbY8aGwESLwcCkE3ApsnxeM9u4c2QY5JCYeRJbCjVtN+RU/ab
        MUBIAbd0KLEe/YiyLOEgKXHDZUEWR75cGg==
X-Google-Smtp-Source: AA6agR6BSPk7/+YsbbZIlw+OGbPqkbKXQL4XEMzHSTuIGuf6xHGdNRGueexsToUvLpKCm9bGe4r6YQ==
X-Received: by 2002:a05:6638:4197:b0:349:fc58:d66a with SMTP id az23-20020a056638419700b00349fc58d66amr15951690jab.101.1661988286255;
        Wed, 31 Aug 2022 16:24:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u190-20020a0223c7000000b00343617e8368sm7417114jau.99.2022.08.31.16.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 16:24:45 -0700 (PDT)
Message-ID: <8552fc36-305f-d365-a2a0-b341bee14323@linuxfoundation.org>
Date:   Wed, 31 Aug 2022 17:24:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next 2/5] selftests/cpu-hotplug: Replace exit with return
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        akinobu.mita@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220830083028.45504-1-zhaogongyi@huawei.com>
 <20220830083028.45504-3-zhaogongyi@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220830083028.45504-3-zhaogongyi@huawei.com>
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

On 8/30/22 02:30, Zhao Gongyi wrote:
> Replace exit with return to avoid some offline cpu
> left when offline cpus fail.
> 

Some cpus will be left in offline state when online
function exits ...

Can you state this clearly in the change log.

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   .../selftests/cpu-hotplug/cpu-on-off-test.sh        | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> index 1169ef82b55e..19028c4c9758 100755
> --- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> +++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> @@ -4,6 +4,7 @@
>   SYSFS=
>   # Kselftest framework requirement - SKIP code is 4.
>   ksft_skip=4
> +retval=0
> 
>   prerequisite()
>   {
> @@ -102,10 +103,10 @@ online_cpu_expect_success()
> 
>   	if ! online_cpu $cpu; then
>   		echo $FUNCNAME $cpu: unexpected fail >&2
> -		exit 1
> +		let retval=$retval+1
>   	elif ! cpu_is_online $cpu; then
>   		echo $FUNCNAME $cpu: unexpected offline >&2
> -		exit 1
> +		let retval=$retval+1
>   	fi
>   }
> 
> @@ -128,10 +129,10 @@ offline_cpu_expect_success()
> 
>   	if ! offline_cpu $cpu; then
>   		echo $FUNCNAME $cpu: unexpected fail >&2
> -		exit 1
> +		let retval=$retval+1
>   	elif ! cpu_is_offline $cpu; then
>   		echo $FUNCNAME $cpu: unexpected offline >&2
> -		exit 1
> +		let retval=$retval+1
>   	fi
>   }
> 
> @@ -201,7 +202,7 @@ if [ $allcpus -eq 0 ]; then
>   		offline_cpu_expect_success $present_max
>   		online_cpu $present_max
>   	fi
> -	exit 0
> +	exit $retval
>   else
>   	echo "Full scope test: all hotplug cpus"
>   	echo -e "\t online all offline cpus"
> @@ -291,3 +292,5 @@ done
> 
>   echo 0 > $NOTIFIER_ERR_INJECT_DIR/actions/CPU_DOWN_PREPARE/error
>   /sbin/modprobe -q -r cpu-notifier-error-inject
> +
> +exit $retval

This retval can be ksft_skip value if 4 of them fail. The test
result will be incorrect in this case and will be reported as
a skip. Let's avoid that case.

thanks,
-- Shuah
