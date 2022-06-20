Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B49550EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiFTDRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiFTDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:17:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF9DB7E4;
        Sun, 19 Jun 2022 20:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655695068; x=1687231068;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HtnVNnCFeWuLegFWoyC4DW3f9gm1/vIoPOy+u1841pc=;
  b=SztMylHtEuWl4ZEmNcr6mQsYsi8ZINNra7H+uq0gi6cXjDJ55aFFCpI/
   aBl8zxQVVR+86GWzR0c5Bztm0DGiqCh5H79xvsp/VFND5HHiIQ5uQJ2nQ
   oAWZRQjYjnIcZ0slv+wN3Ek1tMBbspves/YleyE6G4NvEGGnooG+iwTdt
   TSyd06+4c47w5MrKI5/aFLqvmXE+97sIJPbDVjttBxzGYWVNjUeRpdO4J
   CKNaHPE0kpQ7UuUS8/IOdKmClteQsEkIlg+KxJBs7L7mSKlJ+CLCV5T1n
   IPKnawBv2etkEZns0OlwE0Z+jfl+iGBUlFB/Iw3pf+9IJQfLhDzcmnJ/j
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280848311"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280848311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 20:17:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642902088"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.150]) ([10.255.30.150])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 20:17:45 -0700
Subject: Re: [kbuild-all] Re: [PATCH] MAINTAINERS: Update DW 8250 UART
 maintainership
To:     Joe Perches <joe@perches.com>, kernel test robot <lkp@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, Jiri Slaby <jirislaby@kernel.org>
References: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
 <202206180451.ZfYLcA43-lkp@intel.com>
 <7690845ccf9597e8cdc560a674a1b8e79a10f680.camel@perches.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <7c01c4f8-1826-8769-c3d3-309a9d23f113@intel.com>
Date:   Mon, 20 Jun 2022 11:17:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7690845ccf9597e8cdc560a674a1b8e79a10f680.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2022 4:17 AM, Joe Perches wrote:
> On Sat, 2022-06-18 at 04:09 +0800, kernel test robot wrote:
>> Hi "Ilpo,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v5.19-rc2 next-20220617]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Ilpo-J-rvinen/MAINTAINERS-Update-DW-8250-UART-maintainership/20220617-174145
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 47700948a4abb4a5ae13ef943ff682a7f327547a
>> reproduce: make htmldocs
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> 'utf-8' codec can't decode byte 0xe4 in position 1396: invalid continuation byte
> 
> ?
> 
> false positive?

Hi,

I tried to apply the patch, and I can reproduce the error by 'make 
htmldocs':

$ wget -q -O - 
https://lore.kernel.org/lkml/be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com/raw 
| git apply -v
$ git --no-pager diff
diff --git a/MAINTAINERS b/MAINTAINERS
index f52543aedd61e..3d64756814f09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19247,8 +19247,9 @@ F: 
Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
  F:     drivers/gpio/gpio-creg-snps.c

  SYNOPSYS DESIGNWARE 8250 UART DRIVER
+M:     Ilpo Jrvinen <ilpo.jarvinen@linux.intel.com>
  R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-S:     Maintained
+S:     Supported
  F:     drivers/tty/serial/8250/8250_dw.c
  F:     drivers/tty/serial/8250/8250_dwlib.*
  F:     drivers/tty/serial/8250/8250_lpss.c

It seems the special character 'ä' in name 'Ilpo Järvinen' was parsed 
wrongly.

Best Regards,
Rong Chen
