Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018C1581232
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiGZLiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiGZLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:38:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA520186
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:38:19 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id jw17so814049pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XTF9StjWQgJHRYSsdEBaY0u7FK5LEOTiY3Wa3FW8upA=;
        b=TLFyf1icSzxwEqZFgiNFj+NH0oc2LeCm2i+1GPfLwQsbPaxEkWlm/4EBrhhInLtQPw
         u3/ozFrowbHBdp71NaSNqTRIhbErIS9QFOjocwO1iezZUoqN4B8LZIP8zqKInMdvd3FI
         NryLkQXfpEML/kSzYS9hcCJ2km1CAA/VhMZtq3110kXsIVBz+dUgzYxmgK/BQAgOChl5
         xesqwjfqeT7kzDbsXzCMqGZOR1P8x3W4Sa2tyE5dWH30cu4T0tGGS7LIwi5BIatEQQko
         w3JSlcPvo4RywWZM/+O9hpzpH8jcxvOB/3zqnYb4LZlgquujR1/ruaCvq/FOi3LhIbRL
         silw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XTF9StjWQgJHRYSsdEBaY0u7FK5LEOTiY3Wa3FW8upA=;
        b=dxGA/0NDrr7AaqZ8UVis7neRRa9oc37k0+YWWRbOGJw5ps74gdJ+WGltd/R7v9fuIN
         uiBbLDLrm67MRhICuREf6R4edOD1Y7eLjFc3VNucjSNTfi9QPj7DUoDZAbVaHVHYtA9P
         0CWLb3SSrd3jGJ8lwzznagu5iFaSb1ZJMdLF0UPo175oCZySSkk1Z5BedVH/uYaO4LaF
         5nlQawo09zkATcp7U4oaH7NuF2/ZmDmHwns1s+GQ5o5f/SUbjZv7P6XFgdtoFTDbv6FJ
         N1BRAy4LjNlc1dpfAoRmdl291JTDAE2nYSNEViFCX/MDbefuO6mwqreviaaR5n92z7QQ
         2u2A==
X-Gm-Message-State: AJIora+AOmn8H3hOl9MyhXs1R3RLauhxPt51/FBLdSvfXH+zcFWJNZMc
        CXK46rRsxrLEPfsTDUuwAW0Slg==
X-Google-Smtp-Source: AGRyM1ulwVBWC7IEP9x51nKsFgud3Ul3Aq9AtQOtio5lc+hdM4Z3shGl0x9Vb55oMjyM/xBcu6aW8Q==
X-Received: by 2002:a17:90b:4b8a:b0:1ef:9e43:3791 with SMTP id lr10-20020a17090b4b8a00b001ef9e433791mr19021753pjb.38.1658835499196;
        Tue, 26 Jul 2022 04:38:19 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0? ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b0016c1b178628sm11489113plg.269.2022.07.26.04.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 04:38:18 -0700 (PDT)
Message-ID: <f1e7ac3b-e3e3-4843-2a07-f9f05b49c2b9@linaro.org>
Date:   Tue, 26 Jul 2022 17:08:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/5] thermal: qcom: tsens: Add driver support for
 re-initialization quirk
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220724122424.2509021-4-bhupesh.sharma@linaro.org>
 <202207260755.tUajnfB4-lkp@intel.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <202207260755.tUajnfB4-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/26/22 4:40 AM, kernel test robot wrote:
> Hi Bhupesh,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on rafael-pm/thermal]
> [also build test ERROR on linus/master v5.19-rc8 next-20220725]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
> config: ia64-randconfig-r005-20220724 (https://download.01.org/0day-ci/archive/20220726/202207260755.tUajnfB4-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/2356630fadc0a622264bf292b6930f8c728b0709
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546
>          git checkout 2356630fadc0a622264bf292b6930f8c728b0709
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function `tsens_probe':
>>> tsens.c:(.text+0x6d2): undefined reference to `qcom_scm_is_available'
>     ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function `tsens_health_check_and_reinit.constprop.0':
>>> tsens.c:(.text+0x10c2): undefined reference to `qcom_scm_tsens_reinit'

It seems you have missed picking up [PATCH 1/5] firmware: qcom: scm: Add 
support for tsens reinit workaround before running the checks on this 
patch which is a part of this series itself (see [1]).

If I pick the PATCHes in the right order [PATCH 1/5], [PATCH 2/5] 
followed by [PATCH 3/5], I don't see the compilation error being 
reported (even with W=1 build options).

[1]. 
https://lore.kernel.org/linux-arm-msm/20220724122424.2509021-2-bhupesh.sharma@linaro.org/

Thanks,
Bhupesh
