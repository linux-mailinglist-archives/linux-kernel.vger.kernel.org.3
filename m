Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308554A51F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiAaWDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:03:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:31632 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbiAaWDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643666582; x=1675202582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2hBfv68g/bsbEA/EkV8e5vXXCiFkl03znizEdtVRQzc=;
  b=EPp6VcJGZAf24IsiV3JSizyu+isNElDWZxPEtiQEUji2CYBoBxlsNG6m
   cD22VU0YxBI75jKy3uCUESUfSqSIeTmS+1DM5tSSGiV43/myS9rOh747l
   OArvcZ3SEYYRl1+SRRGJ9aCia8ALmtFV0S0U3o8g5cQXPPiHTXRFwv64j
   aObyGr9sxVVZEOBXpEAvUzJ01Ebz2GmY5+4Zrc9HsioIkmj88MyIbPbrX
   r7x5/M0aFmKxeOFZ6lmXL5uOokdART3PGe8x4HekCyrzk4qpPRv38lTGY
   dh6eRdkKhQpefIIBcJ9qfp1m/lL2RH/M9OlcNmf4mWcTDHtyV9qdSAvbs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247328985"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247328985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:03:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="675873215"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2022 14:03:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 14:03:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 14:03:00 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.020;
 Mon, 31 Jan 2022 14:03:00 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v2 0/6] PPIN (Protected Processor Inventory Number)
 updates
Thread-Topic: [PATCH v2 0/6] PPIN (Protected Processor Inventory Number)
 updates
Thread-Index: AQHYDu8D4O0fiLdYEEuSQ7RARvcUdqx9pUeA///LWoCAAJWVAP//goCAgACL84D//32JIAAWLoaAABCt/PA=
Date:   Mon, 31 Jan 2022 22:03:00 +0000
Message-ID: <1d42e9edfb56449c82083ddf59e847e0@intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com> <YffWtTq2y6K8+gHF@zn.tnic>
 <YfgbCFNeNEkypCmC@agluck-desk2.amr.corp.intel.com> <YfgoBgwgfoiKkPa9@zn.tnic>
 <YfgvPD6AUPIwQgyf@agluck-desk2.amr.corp.intel.com> <Yfg0JauShcFw1WPc@zn.tnic>
 <30cc529e01b64ca7aa8efe0c89eb5ed0@intel.com> <Yfhbj7Q99dqRIYaL@zn.tnic>
In-Reply-To: <Yfhbj7Q99dqRIYaL@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPayB0aGVuLiBJIGd1ZXNzIEkgY2FuIHF1ZXVlIHlvdXIgbmV4dCB2ZXJzaW9uIGFuZCB3ZSds
bCBzZWUgd2hhdA0KPiBoYXBwZW5zLg0KDQpUaGFua3MuIEknbGwgbW92ZSB0aG9zZSBib2d1cyBp
bml0aWFsaXphdGlvbnMgb2YgLm1zcl9wcGluIHRvIHRoZSByaWdodA0KcGF0Y2guIEFkZCBHcmVn
J3MgQWNrJ3MgYW5kIHJlcG9zdCBhIG5ldyB2ZXJzaW9uIGFmdGVyIHJlLXRlc3RpbmcuDQoNCi1U
b255DQo=
