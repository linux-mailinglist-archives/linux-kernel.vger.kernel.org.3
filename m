Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC67B46E73F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbhLILKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhLILKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:10:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B2C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 03:07:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i5so9049875wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 03:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2VxkDMOundKBfIUdO/7UOYn5EnbqY0Ol39XKGZedyC4=;
        b=tnNyynQwyy8CoX/o/IVMWly/KprAat84CeBG88w/YJ64AUvSVmLNcVvA16LYXv891P
         Z64s+R9q/9Y7WOMV27YB3XK+1WNHGCgrqIeih7RDyy1SMQZOi+S+PSQ05t1BbFQA/8Ez
         MagONdiopnm/IM+c4ovGFpnsqQsi4oYfb3OV3BEhPsKl1pz6yF+EVyPfbTkYTUqF9UMj
         gkthsbC6manv1ILMKub7RJ/czljEZqLpV2RJ3hLk4zx3vl9WteDgBS+Oj7yKKVsC9rB3
         dnVMJE6zTO4XDTnyq6UYp6fVq3+JAUu4kl8pugg7py71dFZdBRruW2EXFmoW75WgeZ2Q
         I2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2VxkDMOundKBfIUdO/7UOYn5EnbqY0Ol39XKGZedyC4=;
        b=VfHCH7MzXRZLf4csDCd79gc9KQRD0f9QhV6NJdBr3jNHlD3/ZRU1nUcl1wHNGuoMh8
         PqEx2sd2L9ascVUv3kG0xry3IXHwfyzm0jxVG6XQDUQ4h++KUMEEtxVhHYgn8ENz0tdD
         FpPMnU/ea8OAJQ7a59Zs+POyFFyszfEpynZW5lfkVXL6vRZL6D7aGJT/MNEAX5v9kELi
         SMchGjY5I4qnwxq1VO6HLb4pcGvuAqRwwnVTGaezX+Jrz0YsWcYycbsbx8YpCQvIw88W
         2sJQ/Jb9y6azTvhDKIwnRYeAEWBxVUo7VfbySPuv4ToaHN/fFZv+dNZoiWRypg9d2ipU
         cwlw==
X-Gm-Message-State: AOAM530JUqYknHuPz+omStzWQaksPh5J+osQ98SgeF6Nzi3o4P4t6gGE
        tBQf8WkNbknbtmk3cvys27WJTw==
X-Google-Smtp-Source: ABdhPJxcwrCSoW/nJ0vnQG0t5jrG79KztA42Tcvn6rzPrj7zgjsH4fRzVtp8n1WMiyRFOAvlwoi5jA==
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr5443407wri.416.1639048026690;
        Thu, 09 Dec 2021 03:07:06 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d? ([2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d])
        by smtp.googlemail.com with ESMTPSA id y6sm5536382wrh.18.2021.12.09.03.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 03:07:06 -0800 (PST)
Subject: Re: include/linux/compiler_types.h:328:45: error: call to
 '__compiletime_assert_202' declared with attribute error: BUILD_BUG failed
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <202112071925.61r0Z8V1-lkp@intel.com>
 <87k0gg1rw6.wl-maz@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <23d2fdea-960e-9f2b-4d41-f57bc08c3045@linaro.org>
Date:   Thu, 9 Dec 2021 12:07:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87k0gg1rw6.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 14:11, Marc Zyngier wrote:
> + Will for the arm64 tree.
> 
> On Tue, 07 Dec 2021 11:53:09 +0000,
> kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   cd8c917a56f20f48748dd43d9ae3caff51d5b987
>> commit: 4775bc63f880001ee4fbd6456b12ab04674149e3 clocksource/arm_arch_timer: Add build-time guards for unhandled register accesses
>> date:   7 weeks ago
>> config: arm64-randconfig-r003-20211207 (https://download.01.org/0day-ci/archive/20211207/202112071925.61r0Z8V1-lkp@intel.com/config)
>> compiler: aarch64-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4775bc63f880001ee4fbd6456b12ab04674149e3
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout 4775bc63f880001ee4fbd6456b12ab04674149e3
>>         # save the config file to linux build tree
>>         mkdir build_dir
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from <command-line>:
>>    In function 'arch_timer_reg_read_cp15',
>>        inlined from 'arch_timer_reg_read' at drivers/clocksource/arm_arch_timer.c:166:9,
>>        inlined from 'erratum_set_next_event_tval_generic' at drivers/clocksource/arm_arch_timer.c:414:9:
>>>> include/linux/compiler_types.h:328:45: error: call to '__compiletime_assert_202' declared with attribute error: BUILD_BUG failed
> 
> [...]
> 
> This looks like another version of the inlining issue for which I have
> posted a fix[1] a while ago.
> 
> Daniel, can you please pick this one up for the next -rc?

Applied for next -rc



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
