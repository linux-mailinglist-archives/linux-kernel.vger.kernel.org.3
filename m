Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1F551586
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbiFTKLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbiFTKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:11:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FB8A18B;
        Mon, 20 Jun 2022 03:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655719891; x=1687255891;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=3y8nDAKWBUlZ9K1j37HQS8U7bJfHwitl9vAtCp1vOyU=;
  b=RCAqntx1/fTtROJplSWXeeLgM4HtDXE2Fc63rFOyUZMtG5IUXEwGFqxc
   aqzTmjaqSCzEA14tZLVG5l+EZe0B3zcTHNPeLQpCnFImVEwWepQiJQE4P
   vAHBlgc2zjmqY2B2Zy2jfw9efwmF+oU3ISE4d4XlUbBAR+AmiAI36ymhn
   000GnloM54LrVmM4EbpH9Vf5CB8+IE3Oo/RHugRp8biMHW6ddwr4Db8e4
   hli34AZR/qJCjECn9AbVbYH/d9iqHIECEIL8hTR4jdhLKeKMqJKw9NAU3
   MOcoJCFTb7fhE6/VC38zu3hs4PFKlqFIBIiewSHnASgkUTsA+GqWYwc/U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268576888"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268576888"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:11:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584836507"
Received: from gna-nuc-dev34.igk.intel.com (HELO localhost) ([10.102.80.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:11:27 -0700
References: <85a6nq45uh.fsf@linux.intel.com>
 <20220620094907.4101274-1-maciej.kwapulinski@linux.intel.com>
 <YrBEP4P9JA60LeOB@kroah.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, corbet@lwn.net,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        guy.zadicario@intel.com, linus.walleij@linaro.org, olof@lixom.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 00/14] Driver of Intel(R) Gaussian & Neural Accelerator
Date:   Mon, 20 Jun 2022 12:08:34 +0200
In-reply-to: <YrBEP4P9JA60LeOB@kroah.com>
Message-ID: <86czf3wsrg.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, Jun 20, 2022 at 11:49:07AM +0200, maciej.kwapulinski@linux.intel.com wrote:
>> Please share your thoughts.
>
> No code here to share thoughts about :(

code will be published in comming weeks to dri-devel ML
