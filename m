Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63646566149
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiGECjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiGECju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:39:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F210FEA;
        Mon,  4 Jul 2022 19:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656988789; x=1688524789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CCB8wzxXaiRkktRWauC8bg5qF715DfQRF7bHyr2WoAE=;
  b=cUcfcUpk1OrKpW7P3lAMaKPNO7ISjqkPY35XMDAdpamUJ3YD0KbiOcPH
   VgFmBfDAktaYRDioVBE66a70Nqd76SiSBl4Z+6b3rQP8aa4nO4U40kX9l
   F7EKNckGWD1Ae4+ph5kgXHopPLaHMRJrrFJPl3p4Q3RZW+DOjeD/TYE3b
   mZ96qn4OUjMj53dJz782wsJIxrz0hos3lVxu2V8u83P6J/r9oOq3Ntyx1
   So2T/+u/GKo91PkxvK1Cf8K3pGH+HoqljUx81orc47LaEFq5nxFbe2KCb
   Ur3530Z+ewsjwhGuR+9+uQ0sm4+t2q4nySbCFdlze2hBI+DUhxulmAgOY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283963564"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283963564"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 19:39:49 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542768466"
Received: from zhoufuro-mobl.ccr.corp.intel.com (HELO [10.249.171.229]) ([10.249.171.229])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 19:39:45 -0700
Message-ID: <958a2e36-1aae-63aa-726f-98dc1ec5420f@linux.intel.com>
Date:   Tue, 5 Jul 2022 10:39:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] drivers: misc: Add Support for TMR Manager
Content-Language: en-US
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        Greg KH <gregkh@linuxfoundation.org>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
 <20220628054338.1631516-3-appana.durga.rao@xilinx.com>
 <Yr6uArBFOIMFpLUt@kroah.com>
From:   Zhou Furong <furong.zhou@linux.intel.com>
In-Reply-To: <Yr6uArBFOIMFpLUt@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static struct attribute *xtmr_manager_attrs[] = {
>> +	&dev_attr_dis_block_break.attr,
>> +	&dev_attr_status.attr,
>> +	&dev_attr_errcnt.attr,
>> +	NULL,
remove comma after NULL as it's last one


