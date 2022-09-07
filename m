Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDA5B0F5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIGVn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIGVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:43:51 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310BEB6562;
        Wed,  7 Sep 2022 14:43:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id d1so11788299qvs.0;
        Wed, 07 Sep 2022 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=19EtCFA5s8dlvMjTCYlt8bRgViJnvOmLBpnbxYbIks0=;
        b=SCjK0rr97dJdDcG1xA2fT4a5g3Z0WQcpohVAn4ncqszVFmy0+4pJJ0J5aL6/0fL6Qg
         73VzSNcGuM0EePwwVCQR3hDyIPRHWgO1twzA8Fw0quzubHd61KaMTTGpH+9L8VA5OvmT
         SgdZTpx1N5cNDPK4mM5vRWrTvjelPGMA8e4iMCrAl/nkrTY6NXENsLjnybXR93ICFmNy
         JBq0a+/Qt3GcO0xdR4w6eWM7Zt7ZTeRAoZ80qZOiR12ydsLaQ8+SqbtfYBLSBOGI4OZd
         s8eaGgYnMuJHfL/hA6lBkjbtbNhz9fd44flddM8vgXg17pBwfzuVkwdd4uosDhQHQen6
         4nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=19EtCFA5s8dlvMjTCYlt8bRgViJnvOmLBpnbxYbIks0=;
        b=uWNrAP9enMpkYj7vZtoIgeSdKTwUHZameEgXEQH0vtibactBUL0uzTVQd2kZIg7T38
         tCtwRMw1jEEN0NCiLtwrVv7eZq5GixxEsV2iPewqtf9Wje7LiPs567fnC3ypAmABh9Qx
         6PhGJFMkT6WPfNBn6Gzf7fqBC44qFmL63NLq4K+kImQkLaW2BMygo7O2xqgveWNVC5ml
         o/XclWPb/N/RLk3t9Igb8NWlvF1845kInSZwTf3uBdJpZhF5Avc0JPr9NnuH6ynoLdu8
         aw13GjI/gDhbCpN1JyQ65VaV5CNBMsjujB4LR1SEuMSATUWc1IhCuG58uZZ8tUw0a4fN
         Ta5w==
X-Gm-Message-State: ACgBeo0t//2AMjECRPIh/BUXdY54/r70l2kEo229O1tnUE1PeHxPFxRo
        xViKGNNdvMQr62KjLr9idR8=
X-Google-Smtp-Source: AA6agR4Wlof4Aw4KP2Br5u8ULITmo0xIRzW7RLjWxPAI4Oks3A1rGJ3jXiRv6IMBXLC7n6uClfo3wA==
X-Received: by 2002:a0c:aa9e:0:b0:4a0:4909:6742 with SMTP id f30-20020a0caa9e000000b004a049096742mr5236515qvb.100.1662587029324;
        Wed, 07 Sep 2022 14:43:49 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a2-20020ac81082000000b0034454aff529sm13131611qtj.80.2022.09.07.14.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 14:43:48 -0700 (PDT)
Message-ID: <fb03a0f3-8e0e-3b04-b68f-d586e21f72fd@gmail.com>
Date:   Wed, 7 Sep 2022 14:43:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] leds: bcm63138: refer to ARCH_BCMBCA instead of
 ARCH_BCM4908
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     William Zhang <william.zhang@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907070001.19867-1-lukas.bulwahn@gmail.com>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220907070001.19867-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 12:00 AM, Lukas Bulwahn wrote:
> Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
> removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.
> 
> Probably due to concurrent development, commit a0ba692072d8 ("leds:
> bcm63138: add support for BCM63138 controller") introduces 'LED Support
> for Broadcom BCM63138 SoC' that depends on ARCH_BCM4908, but this use was
> not visible during the config refactoring from the commit above. Hence,
> these two changes create a reference to a non-existing config symbol.
> 
> Adjust the LEDS_BCM63138 definition to refer to ARCH_BCMBCA instead of
> ARCH_BCM4908 to remove the reference to the non-existing config symbol
> ARCH_BCM4908.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
