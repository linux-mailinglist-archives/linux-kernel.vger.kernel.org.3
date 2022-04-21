Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495E150AC0D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442610AbiDUXlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442595AbiDUXlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:41:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77E47044;
        Thu, 21 Apr 2022 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650584309; x=1682120309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DjXMRbtjLw+S9JnYi830vz4F6s8wNXvY9ygAQYuHgXw=;
  b=F8dtUVZknliZYVTP5SX5QPAW2WLCniy42nDxend9bX17Llkjpy8buUUQ
   ZQ2Or0yltQ365t077lRd4fhuzz1oM6ehaKiFeMWN+ssS9j89Tc5Tu1tqq
   oA1FMbEKyUT2mSdjgbSS3IVAeEAEsMeGLxDJZ+sJTjzZH3cp4QzQFns2W
   WmPE5FgVh5FIXFzKhBeqTO4xoyR4lvD/1Q3AL0ZUCfflqUzFifWRTF7RQ
   gvJu4tKLtnDrAwCb5eLxGNghhAN8eYTgGWnrJAv1EebWoUDchFzSGPc8v
   TBN7xKw2zGmA6w6eA8cetrAz0ZjFf8o0xivqMa7ubnPWnXPUPcMkpM7YY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289630438"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="289630438"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 16:38:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615150741"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 16:38:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 16:38:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 16:38:28 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Thu, 21 Apr 2022 16:38:28 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: [PATCH v2] topology/sysfs: Fix allnoconfig build breakage.
Thread-Topic: [PATCH v2] topology/sysfs: Fix allnoconfig build breakage.
Thread-Index: AQHYVZumjS/mts1RT0iukktE+gwEnqz7d42A//+OMjA=
Date:   Thu, 21 Apr 2022 23:38:28 +0000
Message-ID: <90d0e2c9b4a74c92bcdd5fc4313a7629@intel.com>
References: <20220421152645.3a849198@canb.auug.org.au>
        <YmD+geU9CmjoVnN9@kroah.com>    <YmF8Hrq5kgDdfvtS@agluck-desk3.sc.intel.com>
        <YmF+FTxgu2U4/oPA@kroah.com>    <YmGEL2klp4S97UiH@agluck-desk3.sc.intel.com>
 <20220422092247.5c638079@canb.auug.org.au>
In-Reply-To: <20220422092247.5c638079@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Fixes: c3702a746ff5 ("topology/sysfs: Hide PPIN on systems that do not s=
upport it.")
>
> This is actually commit aa63a74d4535.

Doh! I looked in my tree, not in Greg's.

Doesn't matter much, Greg is going to revert as I haven't come up with a go=
od[1]
way to fix this.

-Tony

[1] I found two bad ways. First one made Greg barf. This one breaks the bui=
ld for over
50% of supported architectures :-(
