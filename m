Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B334D5886C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiHCFbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHCFbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:31:05 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111AB7D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:31:01 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 123so26791016ybv.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 22:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gc/GWBXTcgXDv3mlcti2g4r6bOpFRJ0K7pSEn0fM2f0=;
        b=K1SHuXL2CAv+RCo8uPmCJjE649NXyjvR8lj19ydsdVWhkPnvyJM1UWO7KmPXkDECbA
         uiYYDX395ACsTeh90AhnfLjdggT2d0K2sCwFmhDkCYzVCxoANIZxW3jZOQlk1zUsLdwy
         Yk+t2s2oN5NxgG1pkePDT8YM2pzpZvCL2bK7Thbel2ZjPrnzbkFe6GcLvVa7n/XTmcPT
         hQqw8Tp1JYt4UBk4908sD0fEyj2XgUJ0awVThkz45w8KUByA9jYTZF5bMd2kwlgxIHT5
         ARpHH+sATWiIc8LEVDh0PRGCo/PN8GX0vb96EJc9jwUKHw/O2LzUE7Mp3foji+IwpjDZ
         9rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gc/GWBXTcgXDv3mlcti2g4r6bOpFRJ0K7pSEn0fM2f0=;
        b=fgqXa8BZkG6aZs7Ytq8XBuFXtkChrbrSWuJ7k+4mgDvb2zQaUcUa/hMYfHNw18zTwI
         S/WkuPK3vXzfIThYfnQLIazuMjODrfTza1VFODWiwc1PfpI/2HdWdrCLIpaOCImXzsuF
         B/39ELhGKTZh7xIzeNCYGl3ZIodFvDAMWfuy7whNAxDC8jVbsoLxt1rHOD+ALUzHoJiB
         IT/58VkJR4o1yD9AhNzzSaXb5BZ62qI5heI8rBpFf2m6Wx7KyLPgnAqAYVAISteJd1WA
         KLEKEGP9RagkpHVpgvLuapk121zQ8AwH1w2T1WvYTidU9OlI+6UEFZWpCKMF5Ohy5Ud8
         jO+A==
X-Gm-Message-State: ACgBeo2wUJ2celioTpPvGztv7jh0xW899w+S9KBdGctO21kk4ZVk8cIV
        5nC+All4+hK1mcBAFvSrUi6BixJNmR/BFQgB8mPxbA==
X-Google-Smtp-Source: AA6agR679JcQk1TINTXIalTO0xiYzdoAobppDNcGxzyByUGuvuwUFeI6Z9Pivf3irp7bpnB6iCN5T89IEqfM47km5xU=
X-Received: by 2002:a25:cc51:0:b0:676:ccba:875 with SMTP id
 l78-20020a25cc51000000b00676ccba0875mr16988362ybf.137.1659504660645; Tue, 02
 Aug 2022 22:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220724122424.2509021-4-bhupesh.sharma@linaro.org>
 <202207260755.tUajnfB4-lkp@intel.com> <f1e7ac3b-e3e3-4843-2a07-f9f05b49c2b9@linaro.org>
 <55ee862c-ab22-04e3-c24e-7c9d099bb4da@intel.com>
In-Reply-To: <55ee862c-ab22-04e3-c24e-7c9d099bb4da@intel.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 3 Aug 2022 11:00:49 +0530
Message-ID: <CAH=2Ntx09xUUgdTxbYL18M8J-A+8zUfKf9-B1Dt_CUOSPFnpgA@mail.gmail.com>
Subject: Re: [kbuild-all] Re: [PATCH v2 3/5] thermal: qcom: tsens: Add driver
 support for re-initialization quirk
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
        kbuild-all@lists.01.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 27 Jul 2022 at 13:01, Chen, Rong A <rong.a.chen@intel.com> wrote:
> On 7/26/2022 7:38 PM, Bhupesh Sharma wrote:
> > Hi,
> >
> > On 7/26/22 4:40 AM, kernel test robot wrote:
> >> Hi Bhupesh,
> >>
> >> Thank you for the patch! Yet something to improve:
> >>
> >> [auto build test ERROR on rafael-pm/thermal]
> >> [also build test ERROR on linus/master v5.19-rc8 next-20220725]
> >> [If your patch is applied to the wrong git tree, kindly drop us a note.
> >> And when submitting patch, we suggest to use '--base' as documented in
> >> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >>
> >> url:
> >> https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546
> >>
> >> base:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> >> thermal
> >> config: ia64-randconfig-r005-20220724
> >> (https://download.01.org/0day-ci/archive/20220726/202207260755.tUajnfB4-lkp@intel.com/config)
> >>
> >> compiler: ia64-linux-gcc (GCC) 12.1.0
> >> reproduce (this is a W=1 build):
> >>          wget
> >> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> >> -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          #
> >> https://github.com/intel-lab-lkp/linux/commit/2356630fadc0a622264bf292b6930f8c728b0709
> >>
> >>          git remote add linux-review
> >> https://github.com/intel-lab-lkp/linux
> >>          git fetch --no-tags linux-review
> >> Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546
> >>
> >>          git checkout 2356630fadc0a622264bf292b6930f8c728b0709
> >>          # save the config file
> >>          mkdir build_dir && cp config build_dir/.config
> >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> >> make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash
> >>
> >> If you fix the issue, kindly add following tag where applicable
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>     ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function
> >> `tsens_probe':
> >>>> tsens.c:(.text+0x6d2): undefined reference to `qcom_scm_is_available'
> >>     ia64-linux-ld: drivers/thermal/qcom/tsens.o: in function
> >> `tsens_health_check_and_reinit.constprop.0':
> >>>> tsens.c:(.text+0x10c2): undefined reference to `qcom_scm_tsens_reinit'
> >
> > It seems you have missed picking up [PATCH 1/5] firmware: qcom: scm: Add
> > support for tsens reinit workaround before running the checks on this
> > patch which is a part of this series itself (see [1]).
>
> Hi Bhupesh,
>
> Thanks for the feedback, the bot applied the full patch set to test,
> please see
>
>
> https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/Add-support-for-tsens-controller-reinit-via-trustzone/20220724-202546
>
>
> Maybe the bot chose a wrong base branch to apply which caused the
> unexpected issue.

Sure, no problem. Thanks for your email.

Regards,
Bhupesh

> > If I pick the PATCHes in the right order [PATCH 1/5], [PATCH 2/5]
> > followed by [PATCH 3/5], I don't see the compilation error being
> > reported (even with W=1 build options).
> >
> > [1].
> > https://lore.kernel.org/linux-arm-msm/20220724122424.2509021-2-bhupesh.sharma@linaro.org/
> >
> >
> > Thanks,
> > Bhupesh
> > _______________________________________________
> > kbuild-all mailing list -- kbuild-all@lists.01.org
> > To unsubscribe send an email to kbuild-all-leave@lists.01.org
