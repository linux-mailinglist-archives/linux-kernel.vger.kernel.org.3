Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2608055AA42
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbiFYM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiFYM6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:58:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1028C625F;
        Sat, 25 Jun 2022 05:58:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k129so1304354wme.0;
        Sat, 25 Jun 2022 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VXxqGfTAwGEoTKZZyS43XiyUfLIB6wj1VPi8Dio+1sw=;
        b=i0KZIZ5BeV52JH2+V/f/W88LMsESh7sFUqS3QGdl6Nv8BDDyvPOZ66et76mLnGcHKP
         yPwxSmzdEI3sKZbKqtH8rD6DUb8nf1ayr8gPU5a7l+XIjj/FQbg3RiTJHQxVug/74JVs
         K6Sky/yoIlIjH++SQvGdAJEEvkS2JvzLuVhEh/XE8g2o2enS0Wnut1QQUaefPSRaMGqn
         PvUlamnUv9peOOi/LdyTG4VFjT6/jEfdiyu9N7k8cWlsktrh1a1xWH9KMlo6oRIlMkpA
         b+Hur4jIq8D9OQ9+UpEw9c8Op7Wa/G0HOnDgPRZf2BFw5cEjtfMDYwgwyrn0oYZxbcro
         Qlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VXxqGfTAwGEoTKZZyS43XiyUfLIB6wj1VPi8Dio+1sw=;
        b=0CRW+ow3Q+iP3wkyOv/rnfFl9xy/HYEIdVnGBeKyoWLc/jM77omRKk3TtukONb9Hje
         SJlHPMmyq+MAEXzm2AJGEefTmFx34Bel2LMu6335BlveMAZjU6TR645I1Nq2LCVJ+Mx+
         uy8G1mV+r37KzcrBQzkOsr5EQ8i/vF7aI1wDzwqxoxLUwztFllNt/2fDzw9J72KSuiI5
         VbJgjLMqNMHnT0JbwQA1wi0h6GxOJ3jWTKXhSQIObqvDQaTsmW/zj1ejwELuAP/ZmZdt
         84m3WXAIBs2dYty3J2FoSPajJYgVrOJSMUIbVD/4IXaOXTuXCydXpRoGbA++wJCSc2ze
         Dznw==
X-Gm-Message-State: AJIora+JQBMkrppq7cS1wZmyg7K0fVdXE4ZivBkBd+6s4vkmYFpGaV/Z
        N1XcqZHkmMMADNzWnEzEP0U3R8NKREg=
X-Google-Smtp-Source: AGRyM1v9OJRatM7bnhugR4L68+iGuv+FKrbQzDBZAhmL49d9Yp0JEJpDz0Qy5fbigyVorvlmFi8UTg==
X-Received: by 2002:a1c:4e03:0:b0:39c:5bbc:e0d2 with SMTP id g3-20020a1c4e03000000b0039c5bbce0d2mr8989750wmh.184.1656161884598;
        Sat, 25 Jun 2022 05:58:04 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a322.dip0.t-ipconnect.de. [217.229.163.34])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003971fc23185sm11099799wmq.20.2022.06.25.05.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 05:58:04 -0700 (PDT)
Message-ID: <e03bd763-a7a8-cb7c-6fc6-6001f2496729@gmail.com>
Date:   Sat, 25 Jun 2022 14:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] platform/surface: Add KIP/POS tablet-mode switch
 driver
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org, Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624183642.910893-3-luzmaximilian@gmail.com>
 <202206250711.yKiwV8qa-lkp@intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <202206250711.yKiwV8qa-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/25/22 04:59, kernel test robot wrote:
> Hi Maximilian,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on next-20220624]
> [cannot apply to linus/master platform-drivers-x86/for-next v5.19-rc3 v5.19-rc2 v5.19-rc1 v5.19-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Maximilian-Luz/platform-surface-Add-support-for-tablet-mode-switch-via-Surface-Aggregator-Module/20220625-023751
> base:    2f9cb3d3bd73fc2225d66aa8fcffb632ed3eb235
> config: i386-allyesconfig
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>          # https://github.com/intel-lab-lkp/linux/commit/190ffdd2194f4c5a5110d6a08f303c47e2da31ba
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Maximilian-Luz/platform-surface-Add-support-for-tablet-mode-switch-via-Surface-Aggregator-Module/20220625-023751
>          git checkout 190ffdd2194f4c5a5110d6a08f303c47e2da31ba
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/platform/surface/surface_aggregator_tabletsw.c: In function 'ssam_pos_get_sources_list':
>>> drivers/platform/surface/surface_aggregator_tabletsw.c:373:32: error: 'SSAM_SSH_TC_POS' undeclared (first use in this function); did you mean 'SSAM_SSH_TC_PoM'?
>       373 |         rqst.target_category = SSAM_SSH_TC_POS;
>           |                                ^~~~~~~~~~~~~~~
>           |                                SSAM_SSH_TC_PoM

Ah, I forgot to mention. This depends on "platform/surface: aggregator:
Reserve more event- and target-categories" which is already in
pdx86/review-hans as commit e244a46a529a. That commit adds the
`SSAM_SSH_TC_POS` symbol, so with it, this patch should compile.

Regards,
Max
