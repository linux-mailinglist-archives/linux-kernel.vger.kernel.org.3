Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2337B56C5B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGIB2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGIB2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:28:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3CD70987
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 18:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657330132; x=1688866132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WPMT7+XkQ1Cb5gnwqIrpjwjk9WPhmGeHFwld+4HX9NY=;
  b=ZP0Aqn4W6lSC2zqmoFibKIcoWaL8eYFbh2kbbbCNp2LJz2d0IccIox2c
   XHsMf7pomSfUZsX/NqTtdL0ZI494I3cIxX2UDo2fVBFxRyfvidiuFi75l
   rqyiNiceZS5vuBCx+B4k0uzpKiGgR3KjeMLg/Sq6hLwoYb3Z8QdGUAhyC
   mYot7HaZMcB4xECUHMVpnrQ5hE11sp3kC2oAo1B2IK7ER8gy4FZq3xKav
   pzGRrqcuVpBpJAHqu6Y+xnRFAGzOCrI5M3ZDzQ76pm0lM5dEMAyvzNQ5e
   FNsmNh9mNEsSM6ybm+T3wDhJcVTB6J5h+j4t5tSZXIEEpSIO9NtAaILRr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264175310"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264175310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 18:28:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="621436292"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.212.241.130]) ([10.212.241.130])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 18:28:51 -0700
Message-ID: <9f94800b-6c32-3fc0-97c4-728fc4641aef@linux.intel.com>
Date:   Fri, 8 Jul 2022 18:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [pdx86-platform-drivers-x86:review-hans 66/68]
 drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for
 'intel_vsec_pci_resume'
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <202207041814.S03OvoFK-lkp@intel.com>
 <c3982024-3351-956f-605f-ef8453848ff7@redhat.com>
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <c3982024-3351-956f-605f-ef8453848ff7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/2022 7:44 AM, Hans de Goede wrote:

> Hi,
>
> On 7/4/22 12:51, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
>> head:   530ef2a6e81c74c19f918713e519e85652e53a83
>> commit: 1039bb2698ab299a1fc30a4fc2df237867c089e0 [66/68] platform/x86/intel/vsec: Add PCI error recovery support to Intel PMT
>> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220704/202207041814.S03OvoFK-lkp@intel.com/config)
>> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=1039bb2698ab299a1fc30a4fc2df237867c089e0
>>          git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>>          git fetch --no-tags pdx86-platform-drivers-x86 review-hans
>>          git checkout 1039bb2698ab299a1fc30a4fc2df237867c089e0
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/intel/
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/platform/x86/intel/vsec.c:475:6: warning: no previous prototype for 'intel_vsec_pci_resume' [-Wmissing-prototypes]
>>       475 | void intel_vsec_pci_resume(struct pci_dev *pdev)
>>           |      ^~~~~~~~~~~~~~~~~~~~~
>>
>>
>> vim +/intel_vsec_pci_resume +475 drivers/platform/x86/intel/vsec.c
>>
>>     474	
>>   > 475	void intel_vsec_pci_resume(struct pci_dev *pdev)
>>     476	{
>>     477		dev_info(&pdev->dev, "Done resuming PCI device\n");
>>     478	}
>>     479	
>>
>
> I've squashed a patch marking intel_vsec_pci_resume() as static into my
> review-hans branch.
Thank you Hans!
>
> Regards,
>
> Hans
>
