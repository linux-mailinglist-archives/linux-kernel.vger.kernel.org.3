Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2251C4B39D2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 07:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiBMGUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:20:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBMGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:20:33 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636895E779;
        Sat, 12 Feb 2022 22:20:28 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t36so12869953pfg.0;
        Sat, 12 Feb 2022 22:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EwOpItHmF01MRhvNotlE3+35KDc7jISQ9MeSkbZhiOM=;
        b=jFkzqbzVYCGR07q38l2myBRsFboBfEy1n5EqKEWhBOblY+JDTc6uMJv5M/0Yqh6Gf+
         ODoZsbCQwgYHjxO16stXyYoLX12N1QtHH0UzC60uu6c0mRPHIBdLQzsZJQFoL6Y4sXgE
         nuBluOgd/6qypgU/Kq4YN4W0DsYGdpF0+4Tt/I4vJ5LyWNjJ8q/nYeXxfbiZWinvgWxh
         mU2OSQ36r92ioqBcEzIexkjpSr7ODrUvBP3nhW19An2Rp+4AmACnwhFoI3WNIznh1Nj9
         RcR25Zzuj5HApqb1UQvGv5Gz8Yep1AK08ir0bz6X4uBShX3n4t/98k6V5gm4LXn9NK5V
         Goeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EwOpItHmF01MRhvNotlE3+35KDc7jISQ9MeSkbZhiOM=;
        b=hzX7d1WbPMklTfu3vgHEd556T2sWQLoTjzqupd1RyrMXGgI4ex0sN+HMKdYvckF1Gw
         IdshqoY6vWBnNCy8gYU5opXTBguT1Tr9nQBja+TeL3NqS8qKJ4jpIHoIcY9VKaNMO6nD
         X7gOrv2aUTCs4UgiBVCUYNIYiYoZw55zQKsUIuqW65/28ZfLbJLQctAD7+MAJh/M63pI
         T4fCQX3bdo/Ue1hobeiDPgkp9U+yauhwmygqsXrk3RmdbQjpv72Tf37Pa1assypqW8Ho
         eYUGMov+dD2zVdwjlaOlz+25li3CXGvqN5pHboNkN5HfM4M7T1k8oe/18pDI1QwjfFf/
         1FSQ==
X-Gm-Message-State: AOAM532/gNtZbPR/clrFvOxx3LTCoiiDH/IVDkbgNrEbNi2QATrzdtlR
        oIOaHTL85lGCshOlb3/vQbP2E1fsVnAPXpXgRHI=
X-Google-Smtp-Source: ABdhPJyIa4ReGsnAxEehoelR5HySECXMzkGRdqA9JyAmIqI3eKSGS9Lt7cWdJym49MgU/EgFiH22cw==
X-Received: by 2002:a63:b50:: with SMTP id a16mr7314657pgl.185.1644733227672;
        Sat, 12 Feb 2022 22:20:27 -0800 (PST)
Received: from [192.168.18.53] ([117.194.171.90])
        by smtp.gmail.com with ESMTPSA id j8sm33954273pfc.48.2022.02.12.22.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Feb 2022 22:20:27 -0800 (PST)
Message-ID: <3a944e41-b599-eb89-3da7-0067af60c731@gmail.com>
Date:   Sun, 13 Feb 2022 11:50:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] asus-wmi: Use led multicolor class for keyboard
 backlight
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "Luke D. Jones" <luke@ljones.dev>
References: <20220211200122.9821-2-abhijeetviswa@gmail.com>
 <202202130255.uwrbJQfB-lkp@intel.com>
From:   Abhijeet Viswa <abhijeetviswa@gmail.com>
In-Reply-To: <202202130255.uwrbJQfB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not sure if this email is monitored. But since you asked me to, here ya go.

On 13/02/22 00:38, kernel test robot wrote:
> Hi Abhijeet,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.17-rc3 next-20220211]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 

Base is intended to be the linux-next/master tree (commit 6d9bd4ad4ca08b1114e814c2c42383b8b13be631).

> url:    https://github.com/0day-ci/linux/commits/Abhijeet-V/asus-wmi-Keyboard-rgb-led-multicolor-support/20220212-040427
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f1baf68e1383f6ed93eb9cff2866d46562607a43
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220213/202202130255.uwrbJQfB-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f6685f774697c85d6a352dcea013f46a99f9fe31)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/860e9e7427b00b9dbd0c35851cecda00be1968f2
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Abhijeet-V/asus-wmi-Keyboard-rgb-led-multicolor-support/20220212-040427
>         git checkout 860e9e7427b00b9dbd0c35851cecda00be1968f2
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/platform/x86/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/platform/x86/asus-wmi.c:958:5: warning: no previous prototype for function 'kbd_led_classdev_init' [-Wmissing-prototypes]
>    int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
>        ^
>    drivers/platform/x86/asus-wmi.c:958:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
>    ^
>    static 
>    1 warning generated.
> 
> 
> vim +/kbd_led_classdev_init +958 drivers/platform/x86/asus-wmi.c
> 
>    957	
>  > 958	int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
>    959	{
>    960		int rv;
>    961	
>    962		asus->kbd_led_wk = brightness;
>    963		asus->kbd_led_mc.led_cdev.name = "asus::kbd_backlight";
>    964		asus->kbd_led_mc.led_cdev.flags = LED_BRIGHT_HW_CHANGED;
>    965		asus->kbd_led_mc.led_cdev.brightness_set = kbd_led_brightness_set;
>    966		asus->kbd_led_mc.led_cdev.brightness_get = kbd_led_brightness_get;
>    967		asus->kbd_led_mc.led_cdev.max_brightness = 3;
>    968	
>    969		asus->kbd_led_mc.num_colors = ASUS_KBD_SUBLED_COUNT;
>    970	
>    971		rv = led_classdev_multicolor_register(&asus->platform_device->dev,
>    972						&asus->kbd_led_mc);
>    973		return rv;
>    974	}
>    975	

Bot or not, thanks for the report.
I'll fix these in a v2 after others get a chance to review v1.

Thanks,
Abhijeet

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
