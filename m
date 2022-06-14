Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7C154B589
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356951AbiFNQKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiFNQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:10:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C723A3981C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:10:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so8115165plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mMFB6OVQbCnexTHZBSH2n20Xku7dT+S/35cKvzCOFv4=;
        b=nB+zb5dfqMDdXPwaH28U5oTKxSMzWhqag2MBRwoBosd1LxiIEL4XcVAH8kQ4F1SWWH
         AWYAu5vA7xAXklOOoXoPVzBZImlReX3YGnuqSmGgjXC8zPqA3qNKUAbQqp4EBb8SXPk5
         fJ2lls8M+8KrUnoGv+2akZ71DyzmDMWcjgxbwxqCh9kyfVD05MzDkhrF7EMi4FgaH92b
         sADrKmv2V61mjo4wiSWcKapWrSXSZOzPzSfhwWPbFsWGLn3ErMIdZdkCRTma4ne0me1A
         BChz5JBNAooSoT8H82QBBra7RMOPTHLbcrRWO2KZjhDf6gusLCMdpXEBw//IxajSBCZh
         IF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mMFB6OVQbCnexTHZBSH2n20Xku7dT+S/35cKvzCOFv4=;
        b=c5WlMbgKTpXg6cmdNb8biaX0T7ldZytNrZdTNXzL4J4NaOQBKl7MhkklqyZleBFAol
         Dbm35hnLFK84UT5gJCsEDaLuLoDtrwusw/Omy1HFEodO3y5lQ+SdNL+KVwSI8040ZN0F
         TbfskBcsJIgC7wSTkFo9LLV3PMrIxkwEp3eaTulaCuRJINI440pybwEwTX+2asljg0x5
         Le8lKMyL6V18gWNjISjyyEg7BrrRoOrpxzWo6BoqsLTpM/hKPg5MJpHZY0lmqcmovrT2
         CZwAxPITtqBMgucyLTfGbcjB+P1/vuDqrhXN8tdjcjMtQPBdKF24FBIW9Rh0bbcBz6rq
         jzhA==
X-Gm-Message-State: AJIora90kSj8CR+B8WzzCvGKM9sp7KHvjStu978oXPDbwWvd439ey3G7
        Q323cLY4TtHU63ybyj46O/kqMRPWEN4=
X-Google-Smtp-Source: AGRyM1u8o3lGxIAkcc5tHIuSMAVi5iXe+4OewkCWZ6gFhHNN6UJ2mFFEG3t8JLcEEI83KDMaCX46ZA==
X-Received: by 2002:a17:902:e0d1:b0:168:bedf:7146 with SMTP id e17-20020a170902e0d100b00168bedf7146mr5047391pla.107.1655223028190;
        Tue, 14 Jun 2022 09:10:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h129-20020a636c87000000b004052d642b6dsm6697784pgc.9.2022.06.14.09.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:10:27 -0700 (PDT)
Message-ID: <29fb688b-58a3-be66-3bab-3f8186396c6f@gmail.com>
Date:   Tue, 14 Jun 2022 09:10:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [broadcom-stblinux:devicetree/next 15/23] make[2]: *** No rule to
 make target 'arch/arm/boot/dts/bcm96855.dtb', needed by '__build'.
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202206141752.IB5xCdXS-lkp@intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <202206141752.IB5xCdXS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 02:32, kernel test robot wrote:
> tree:   https://github.com/Broadcom/stblinux devicetree/next
> head:   edb052f67bb9f245f9717b3c11b21022a02fae87
> commit: d2d847e696389916239c5521ca533261d0c0026f [15/23] ARM: dts: Add DTS files for bcmbca SoC BCM6855
> config: arm-randconfig-r035-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141752.IB5xCdXS-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/Broadcom/stblinux/commit/d2d847e696389916239c5521ca533261d0c0026f
>          git remote add broadcom-stblinux https://github.com/Broadcom/stblinux
>          git fetch --no-tags broadcom-stblinux devicetree/next
>          git checkout d2d847e696389916239c5521ca533261d0c0026f
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> make[2]: *** No rule to make target 'arch/arm/boot/dts/bcm96855.dtb', needed by '__build'.
>     make[2]: Target '__build' not remade because of errors.

Now fixed in place.
-- 
Florian
