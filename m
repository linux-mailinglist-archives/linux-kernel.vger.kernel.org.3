Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0205A56DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiH2WNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 18:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiH2WNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 18:13:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A27D791
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:13:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s11so3448505ilt.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=kDv1Wdc30xWBR5Q0HuYAotIhWz3t+ru73XnAdWghxwI=;
        b=Gq4sUZurjYGuE+u5O3j2RPt3kH6sF9BEFst5+Qd9srQfDIQgEvvWP9MdWR0k1+2/fj
         OJdW/koxBPgaPsvyuXDEy2ur/Z6xGvlGjaG1lYjtyk9ndTDNZrVjPLrd8/ASoneSfmsk
         zlHfh0jGvDHVFmNSzEM+0xCDN7pWnAmvm5E00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=kDv1Wdc30xWBR5Q0HuYAotIhWz3t+ru73XnAdWghxwI=;
        b=3Bpm9BQglBPSnZSLVlNjYkoBZrps92uPJAyJvoB2qpqWW07GFMWGaGvq+hMX13G5yV
         X4W5epFyzuzlCNp2pKFiCQYKTmWiYezKNatceijaHNBPeROmbZkpZpNGXNRK5wlU8zDh
         Qoefz3OdN13MXl5z4KlkrpWSC5MjDo96oNcDtS4f1F8etCCVtOG9XZqk7tfnsbANF/Hq
         OO0kbLuddgAEgHhI9mbgPHyyvAoFPL8U/dxrRlLe6W5jk2jt5OmaA/ifq0D3iJ7moLqO
         6rmWB07wVQs/bYieI31WAMED6fgTwzm5qzOIjUWFj0iUmXIA5OIrPz9/+vZPYtNzSghC
         l9ng==
X-Gm-Message-State: ACgBeo1Jt8tAvTIz8pOT28lSGvjnlc3BzBwAjqi44sQAJaHzK0Fgdou/
        aXio1K3r7Hl6NH39P6i6zoa6nA==
X-Google-Smtp-Source: AA6agR6OiMbT9QS5vUvJpCSlESqGYBg7bCf4i7bAop9yLFf0rMnFMiz16VoN5lw2AS5k+N1aDyQQrg==
X-Received: by 2002:a05:6e02:1347:b0:2ea:e939:fef1 with SMTP id k7-20020a056e02134700b002eae939fef1mr5127804ilr.114.1661811221915;
        Mon, 29 Aug 2022 15:13:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q5-20020a027b05000000b0034a58cd5718sm379644jac.175.2022.08.29.15.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 15:13:41 -0700 (PDT)
Message-ID: <c06c35e2-f811-088e-2a93-45b2cae45f5f@linuxfoundation.org>
Date:   Mon, 29 Aug 2022 16:13:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.19 000/158] 5.19.6-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220829105808.828227973@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220829105808.828227973@linuxfoundation.org>
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

On 8/29/22 04:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.6 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Aug 2022 10:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
