Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A54EEBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbiDAKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbiDAKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:53:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE44C796
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648810277; x=1680346277;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TyVT+WjrsnNzGE/O8TBVzv7J/PJ+lB7TDwLm8MQk4cM=;
  b=dQz5+NOfzRmjIk5NNOhOAmyEusEpACbdTztzWq/XWpzM+Mm4xoWW8BiR
   71h2ESZBfts89OcfEFJPPpJZs04oeU69tajvlBS2jNqV59WJAJ3WSoBnO
   YDjL8oYzAomNEJ/lXZjuJYV1OpChSnS6bX2RmhpS6qjQIeHjvagrs+N49
   RFa3MVmLMfaS1F6AbFCKc8oMXfgDMh231ma3JkODNiSnm39u+bbTZbSKO
   gfUC0YIoRfyoJiQA6mMqDu3FAlUnXAJQbZZPuq3xjAopt4lWpt5SCEAg9
   q+oyDa6trUYWU4Ohruw+iKzQMIDZyln0eCIZ00yQQMMUyldETaQSiAMdx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="259806989"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="259806989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 03:51:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="567386650"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.168.167]) ([10.249.168.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 03:51:14 -0700
Subject: Re: dtbs_check: ERROR: dtschema minimum version is v2022.3
To:     kernel test robot <lkp@intel.com>, Rob Herring <robh@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202204011633.0XlAbzBd-lkp@intel.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <bc9be279-a130-d5e7-4397-bbb389d14403@intel.com>
Date:   Fri, 1 Apr 2022 18:51:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202204011633.0XlAbzBd-lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Sorry for the inconvenience, please ignore this false positive.

Best Regards,
Rong Chen

On 4/1/2022 4:50 PM, kernel test robot wrote:
> Hi Rob,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e8b767f5e04097aaedcd6e06e2270f9fe5282696
> commit: 2783a7f56f9980f61ca809b826bcd14dc77eb7b9 dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
> date:   3 weeks ago
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20220401/202204011633.0XlAbzBd-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce: make ARCH=arm dtbs_check
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     sort: -:2: disorder: 2022.1
>>> ERROR: dtschema minimum version is v2022.3
> 
