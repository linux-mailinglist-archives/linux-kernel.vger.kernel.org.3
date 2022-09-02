Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A35ABA98
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiIBWDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIBWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:03:15 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B50F63F7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:02:45 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f4e634072so7961945fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=T6EMhbfIUzDMCCm1rXtBGAayubxBVsYC4rjYrJq/4Bk=;
        b=FH4E70ysVhZXDgRNfFw/2A+J1AlUn1ufx96ai82Eozo9guhIEzAOGvIiqnpgMU9P5T
         sCNna2a7YAeKC4jRyVqK2rAmdil013LziY3eLn3O0j7ghll0fjPrLWulG9JBNSxZfMLP
         zEfEt2R+wk/01qzgUarmAOw9y5cRCDrE6CCKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=T6EMhbfIUzDMCCm1rXtBGAayubxBVsYC4rjYrJq/4Bk=;
        b=tpt84OO0RObQBASSGispXfO4tBkP9L6JK1zJTDv22g2rjFvJBJidAqNjXBv6K7FCZk
         wP14m45kMFQLUoxuWJtVzorg08rBppqLJObBgss5NFyfO0QJIHFi+iAwQCHyXWCSkSn2
         c5cbamXKhx07EyEyuhvXKQyNPB4/ian364MEc9Al7syNtbaBiKY+ii50FJjgcHATxRs6
         aHSJeTQQRo6uEPruWAR38s0v0M3CNzrShSpL9XxBY1TaI91gVPJVJnHEEXYnay60Irfe
         gmfa/nVshKi37RcvITGuHAFRg3MBuoBhJyEq0a7YYgLoyZoJHCsvcDyugbu+gcXFDSg4
         VsYg==
X-Gm-Message-State: ACgBeo0D4mMcReZApLO+ehuT7iijIFNk6fUwn5exIG/11zc4Hl3u5rvd
        x6zEk8UmDKeWgLF1DjTFx6m8kg==
X-Google-Smtp-Source: AA6agR5aA3yMZUtNAQsnLqbS2uKbFG1k0od5KEzCOAECPpe5YDcmlcZ3PY8yvE4AY0qdRqktr9h3lA==
X-Received: by 2002:a05:6870:ac0e:b0:122:4181:6862 with SMTP id kw14-20020a056870ac0e00b0012241816862mr3236165oab.32.1662156114952;
        Fri, 02 Sep 2022 15:01:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x14-20020a056870a78e00b0011bde9f5745sm1662301oao.23.2022.09.02.15.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 15:01:54 -0700 (PDT)
Message-ID: <dbcbd29b-bbcd-3f6f-469c-fccd2594fc4e@linuxfoundation.org>
Date:   Fri, 2 Sep 2022 16:01:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.19 00/72] 5.19.7-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220902121404.772492078@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220902121404.772492078@linuxfoundation.org>
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

On 9/2/22 06:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.19.7 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 04 Sep 2022 12:13:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.19.7-rc1.gz
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

