Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6249250A985
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392090AbiDUTxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiDUTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:53:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC73BA5C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650570657; x=1682106657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7/w8MsIcZLo2lJmkyQFjiaISKuW2sUqjsz8QBgfLdf0=;
  b=bDdC9aTg+ymnAHca6NuMecF5xZ+nCIxLOpiGjw8lJ6WZetZGPFosKWNH
   r6jAA25o26LqA32QGCRj2WJbmNTzHG4kW+DTQ8sEDuqM4hr430g+ObmP9
   JJgHuidSpnSg+ISLCydS6rPYhVNrRG9SaRsj8JEzzoxOF4F5LgdmuCpEp
   mhQTxUj1Utc6b1LNQ+RI5D8XFo9nz/lMgVXxnIijcOWmiWP+zgcgBe6R1
   BjAcEXB9ewBnfhZem5Fa0MK73UveL51GxeJcdZ3baneRY4XCrkxkYar4s
   hsBelGFB1kyUtiQC4rb65aV6V2H8nNrV0bACvgkZ75IZXFFJ9cz0Z++Nr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244386652"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="244386652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 12:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="533571695"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2022 12:50:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 12:50:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 12:50:55 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Thu, 21 Apr 2022 12:50:55 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     lkp <lkp@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: drivers/base/topology.c:158:45: error: 'boot_cpu_data'
 undeclared; did you mean 'boot_cpu_init'?
Thread-Topic: drivers/base/topology.c:158:45: error: 'boot_cpu_data'
 undeclared; did you mean 'boot_cpu_init'?
Thread-Index: AQHYVbVwPmXabAdzUE6ImoF9s88jyKz6xbRA
Date:   Thu, 21 Apr 2022 19:50:55 +0000
Message-ID: <4401b87816cd40b9aea30b6eca5d21a4@intel.com>
References: <202204220317.dri1BV0q-lkp@intel.com>
In-Reply-To: <202204220317.dri1BV0q-lkp@intel.com>
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
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> compiler: microblaze-linux-gcc (GCC) 11.2.0

Greg,

Ignore v2 patch. It seems that only arm64, ia64, mips, parisc, sh, um, and =
x86 have "boot_cpu_data".

LKP just found it breaks microblaze ... but it's going to break alpha, arc,=
 arm. ... too :-(

Revert the ppin patch for now while I think harder on whether this can be d=
one.

-Tony
