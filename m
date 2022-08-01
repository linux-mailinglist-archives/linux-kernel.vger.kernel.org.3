Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C9586DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiHAPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiHAPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:20:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63AFB49A;
        Mon,  1 Aug 2022 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659367243; x=1690903243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2DXcIe7hUnldJ+7bWfHGOv4iXtFwQUzM3UzzWrBzOUs=;
  b=tI8cjlW8Dnw6seHPjRh0QMTaVhs4p0V1EPvNf57/SbmeXPMSF4vgSoFK
   vgwjo0/jF3+Ll8ne42heV07x6cq2lOH47r3Jj1hgr6ohm+laI8rXLjQae
   7EELxaMcb8KwJoqrziw0K4iu7duZhMjTzvYUDHWyTqxdkb07taFoCKKG6
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 08:20:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 08:20:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 08:20:42 -0700
Received: from [10.216.14.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 08:20:35 -0700
Message-ID: <b3c5dec2-6d73-4d7a-8a2f-194672f2c675@quicinc.com>
Date:   Mon, 1 Aug 2022 20:50:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH 2/5] clk: qcom: Allow custom reset ops
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     <kbuild-all@lists.01.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Douglas Anderson <dianders@chromium.org>,
        <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20220730144713.2.I4b69f984a97535179acd9637426a1331f84f6646@changeid>
 <202207302137.mPbHPaHz-lkp@intel.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <202207302137.mPbHPaHz-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/2022 6:40 PM, kernel test robot wrote:
> Hi Akhil,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on clk/clk-next]
> [also build test WARNING on robh/for-next drm-misc/drm-misc-next drm-tip/drm-tip linus/master v5.19-rc8 next-20220728]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Akhil-P-Oommen/clk-qcom-Support-gdsc-collapse-polling-using-reset-inteface/20220730-171922
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: ia64-randconfig-r031-20220729 (https://download.01.org/0day-ci/archive/20220730/202207302137.mPbHPaHz-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/971a03493e9854ff4a227ee4d80b533997959891
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Akhil-P-Oommen/clk-qcom-Support-gdsc-collapse-polling-using-reset-inteface/20220730-171922
>          git checkout 971a03493e9854ff4a227ee4d80b533997959891
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/clk/qcom/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     drivers/clk/qcom/reset.c: In function 'qcom_reset':
>>> drivers/clk/qcom/reset.c:17:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>        17 |         const struct qcom_reset_map *map = &rst->reset_map[id];
>           |         ^~~~~
>
>
> vim +17 drivers/clk/qcom/reset.c
>
>      13	
>      14	static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
>      15	{
>      16		struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
>    > 17		const struct qcom_reset_map *map = &rst->reset_map[id];
>      18	
>      19		if (map->op)
>      20			return map->op(map);
>      21	
>      22		rcdev->ops->assert(rcdev, id);
>      23		udelay(1);
>      24		rcdev->ops->deassert(rcdev, id);
>      25		return 0;
>      26	}
>      27	
>
Will fix this and send another version of this patch. Please let me know 
if there is any feedback to the whole series.

-Akhil.
