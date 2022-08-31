Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF15A8983
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiHaXc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiHaXcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:32:54 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4F6E68C9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:32:53 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so26999739fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ogeaj4/rQI298p/BADarmzrOcFA0fwNfK92i/ULTfFg=;
        b=ZweDwQk10QrYBEDjHiMYDmRQtjwYnUzgonUGz5ZR430VZk0hZdZAiXRKKtHlAIDehy
         +QJpvDrZkY32lifNAeVL2FcHl7JhtiFefL7uVQlLWKdoSyVVZxQX7vL7EB4J1GmaYgnc
         JPIwI7KWACD3udn2oJhkuNE2OAmA10FAcBEik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ogeaj4/rQI298p/BADarmzrOcFA0fwNfK92i/ULTfFg=;
        b=bfCRpjeWhca0fDE7fSvLnPcQ2GsfOP2asJpaH/gqivnqEbYyvB/nEdJC6IrtfOumU3
         C+NVIXgDKoM32RTVIqUUSWofA6o0bbp0+p4Fxkc/eNM00lgqmyrQlsabav0gm6PEQDEh
         +Ki3MAqjpXTsI3Mtrxbr06ggx6GN84QunDos2E8y7YmUe6uSH4OHn18fLdQsGJ8KEkVS
         yRaF4RmFm6nGamJWUBvJlseiwLYrE9NJBq2dR7S+puLGEI6zmuWONTXAyRfYWMapaFNz
         sN5ba564j3mHt/3XAEnKyqRBc5crC4dcH66DBN6l3MKoZ6k9pe74I4H2FS0x9vMAIDDc
         ojgQ==
X-Gm-Message-State: ACgBeo2LZp167zyyiRp0A13Z+v9P79iVpexFCxcm0IGxkbNcu0JUQghN
        MmoEoFVMCqkXbscS8SXjZDwEjw==
X-Google-Smtp-Source: AA6agR7gjrv4SZv6qQ6ra1AxQVJiB18C+lGX1hyTzmjgrLU98OFcAcEbkNAGyk+kxp8Lvv8Gdw5NwQ==
X-Received: by 2002:a05:6870:2046:b0:11e:525d:ef9f with SMTP id l6-20020a056870204600b0011e525def9fmr2641628oad.163.1661988772369;
        Wed, 31 Aug 2022 16:32:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c8-20020a544e88000000b0034536748843sm7976371oiy.3.2022.08.31.16.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 16:32:52 -0700 (PDT)
Message-ID: <61795f45-bc48-7be8-5787-cdf6ec4b761c@linuxfoundation.org>
Date:   Wed, 31 Aug 2022 17:32:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next 3/5] selftests/cpu-hotplug: Delete fault injection
 related code
Content-Language: en-US
To:     Zhao Gongyi <zhaogongyi@huawei.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        akinobu.mita@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220830083028.45504-1-zhaogongyi@huawei.com>
 <20220830083028.45504-4-zhaogongyi@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220830083028.45504-4-zhaogongyi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 02:30, Zhao Gongyi wrote:
> Delete fault injection related code since the module has been deleted.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>   tools/testing/selftests/cpu-hotplug/config    |   1 -
>   .../selftests/cpu-hotplug/cpu-on-off-test.sh  | 105 +-----------------
>   2 files changed, 2 insertions(+), 104 deletions(-)
>   delete mode 100644 tools/testing/selftests/cpu-hotplug/config
> 
> diff --git a/tools/testing/selftests/cpu-hotplug/config b/tools/testing/selftests/cpu-hotplug/config
> deleted file mode 100644
> index d4aca2ad5069..000000000000
> --- a/tools/testing/selftests/cpu-hotplug/config
> +++ /dev/null
> @@ -1 +0,0 @@
> -CONFIG_NOTIFIER_ERROR_INJECTION=y
> diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> index 19028c4c9758..ade75d920cd6 100755
> --- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> +++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
> @@ -110,19 +110,6 @@ online_cpu_expect_success()
>   	fi
>   }
> 
> -online_cpu_expect_fail()
> -{
> -	local cpu=$1
> -
> -	if online_cpu $cpu 2> /dev/null; then
> -		echo $FUNCNAME $cpu: unexpected success >&2
> -		exit 1
> -	elif ! cpu_is_offline $cpu; then
> -		echo $FUNCNAME $cpu: unexpected online >&2
> -		exit 1
> -	fi
> -}
> -

Keep this code - this could be useful to test the case of running
online test on cpu that is online and expect that to fail.

>   offline_cpu_expect_success()
>   {
>   	local cpu=$1
> @@ -136,22 +123,7 @@ offline_cpu_expect_success()
>   	fi
>   }
> 
> -offline_cpu_expect_fail()
> -{
> -	local cpu=$1
> -
> -	if offline_cpu $cpu 2> /dev/null; then
> -		echo $FUNCNAME $cpu: unexpected success >&2
> -		exit 1
> -	elif ! cpu_is_online $cpu; then
> -		echo $FUNCNAME $cpu: unexpected offline >&2
> -		exit 1
> -	fi
> -}
> -

Keep this code - this could be useful to test the case of running
offline test on cpu that is offline and expect that to fail.

Remove just the fault injection code and these aren't really specific
to fault injection even though they are currently being used by the
fault injection path.

thanks,
-- Shuah
