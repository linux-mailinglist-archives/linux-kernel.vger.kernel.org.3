Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EB056361C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbiGAOsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiGAOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:48:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0519613D78
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:48:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r133so2483553iod.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwnHVKpuUoSoXVCF1lKKK3GjSIrTJeRKu+Us3h8Q3ag=;
        b=d9MbkHqVYvRR4GV8BJLwFGJL52FX0K6LlXBnT1DuAxsz8q9iYl/78fB0bYpCjjKiiu
         lo59M1FjBQJXKreUsGH/XYLCcTMehBLMPDJ/nRM9OpKRuT1EnqF0ay/wvjDdWWgUviP8
         OtlmvLyd0BmxASW+aHatje5FY3Xrvia1XRzTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwnHVKpuUoSoXVCF1lKKK3GjSIrTJeRKu+Us3h8Q3ag=;
        b=iAtMIGHnfkVqvsF366/E8G1vXCipOC8rpFNwWWNNJtvCZrViGLnnM7pGaui8Naa1P5
         hOIzPim2qDgiMPINQvlzm7/mQNBQIBbhZcvzkO1nLAfLirl4XW611lS0LkKIwAKIJ93G
         Ag2HnIWB1Z5t7raEpADlNSvUqXYn3ynO96xBSGRrGWE3yol51P/35geZGsq4Um31QXa1
         65JT2dXuTsNWrzNHA14RHcH9ZS1Ry0oHsQABdLE4ghNcl9YCMMirP8EVVNPKwqGNpUF4
         2SaVMy6l9+mkMrpPjk9es1/E+2djsRBCkHbZ3S5Bt3e3Pqc2ULmoQZwnLGI/ssPpgUqd
         vZGg==
X-Gm-Message-State: AJIora9F1ZecyfNWkzFIntBIuP09LZKDE8wOuCzh/2afYCXyr+BRAIqt
        6EQ6YzUZoDccl+6+xS94iLhIKcklJGEKIw==
X-Google-Smtp-Source: AGRyM1u6oOUbaGYqbLkQvZ3X+2Cs1/BvXAhACtYr6ULnMfiWbLLjSLRUcAEobfjrk95df2W3U7mYHQ==
X-Received: by 2002:a05:6638:12ca:b0:33c:c664:64fe with SMTP id v10-20020a05663812ca00b0033cc66464femr9084174jas.67.1656686893371;
        Fri, 01 Jul 2022 07:48:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a11-20020a056e020e0b00b002da99df289fsm5401982ilk.48.2022.07.01.07.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:48:12 -0700 (PDT)
Subject: Re: [char-misc:char-misc-linus 3/3]
 drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used
 uninitialized whenever 'if' condition is true
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202207011658.rHJFVLWA-lkp@intel.com> <Yr63Zyvj49o8U/ti@kroah.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <67a09516-ec1f-d0b6-c027-fd52159318ed@linuxfoundation.org>
Date:   Fri, 1 Jul 2022 08:48:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Yr63Zyvj49o8U/ti@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 2:59 AM, Greg Kroah-Hartman wrote:
> On Fri, Jul 01, 2022 at 04:49:50PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-linus
>> head:   3776c78559853fd151be7c41e369fd076fb679d5
>> commit: 3776c78559853fd151be7c41e369fd076fb679d5 [3/3] misc: rtsx_usb: use separate command and response buffers
>> config: arm-buildonly-randconfig-r006-20220629 (https://download.01.org/0day-ci/archive/20220701/202207011658.rHJFVLWA-lkp@intel.com/config)
>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm cross compiling tool for clang build
>>          # apt-get install binutils-arm-linux-gnueabi
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=3776c78559853fd151be7c41e369fd076fb679d5
>>          git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>>          git fetch --no-tags char-misc char-misc-linus
>>          git checkout 3776c78559853fd151be7c41e369fd076fb679d5
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/misc/cardreader/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/misc/cardreader/rtsx_usb.c:639:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>>             if (!ucr->rsp_buf)
>>                 ^~~~~~~~~~~~~
>>     drivers/misc/cardreader/rtsx_usb.c:678:9: note: uninitialized use occurs here
>>             return ret;
>>                    ^~~
>>     drivers/misc/cardreader/rtsx_usb.c:639:2: note: remove the 'if' if its condition is always false
>>             if (!ucr->rsp_buf)
>>             ^~~~~~~~~~~~~~~~~~
>>     drivers/misc/cardreader/rtsx_usb.c:622:9: note: initialize the variable 'ret' to silence this warning
>>             int ret;
>>                    ^
>>                     = 0
>>     1 warning generated.
> 
> Odd, gcc doesn't show this for me.  Shuah, can you send a follow-on
> patch to fix this?  The warning does look correct.
> 

gcc didn't complain when I compiled either. I will send a follow-on patch.

thanks,
-- Shuah

