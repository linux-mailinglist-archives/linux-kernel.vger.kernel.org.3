Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C450D418
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiDXSLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiDXSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:11:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E073B369DE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650823691; x=1682359691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AWtFWNWK20rKxdYE5nHFKPNJ4lyRcKgjnS2sfz6sMyg=;
  b=nknhG9Vo4cwDLIpcVj+lfjJ8dt2GTLTnRMHryKjf02vytlRhVHXd9nBl
   ez3IGLaNHSijwawVsrR4fi7SKbf5HUd2QSfhG+Bi+2oYi+CUr+2SEeFSp
   /pd2W1LSfJV4Q7UL20qn6x0PYGPnGscuoyeZh4gz6L5iAao+8HfJXyD6o
   +oWTcmVABpPr0FM0l2lslprPmiNMUUPj5rSzZQZc1p5q3GhfdXp9k6UzD
   yt6RWyrDEUnMphC72H8QzKd1sh0ecLHCLlDoK6rUiEWjP4fFx+tJGt5iF
   nugs6U2Zq4iZAyPFg3wkceSlFlmlKs8HAjVdrdDO4QsM47FpsVckMK3uP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264579639"
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="264579639"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 11:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,286,1643702400"; 
   d="scan'208";a="729372907"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2022 11:08:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 24 Apr 2022 11:08:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 24 Apr 2022 11:08:09 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Sun, 24 Apr 2022 11:08:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH] topology: Fix up build warning in topology_is_visible()
Thread-Topic: [PATCH] topology: Fix up build warning in topology_is_visible()
Thread-Index: AQHYVhH/FWvB4gnQMk+S/KmH7ENg3az9yc8AgAGWL4A=
Date:   Sun, 24 Apr 2022 18:08:09 +0000
Message-ID: <bbe4472b8ba54b259f011c6ed9808d6a@intel.com>
References: <20220422062653.3899972-1-gregkh@linuxfoundation.org>
 <YmPajtfsCL8Idw4h@kroah.com>
In-Reply-To: <YmPajtfsCL8Idw4h@kroah.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Given no comments that this is a bad idea, I'll go apply this now.

FWIW (very little) 0-day didn't find issues with changing from macro to
static inline. But your fix is much neater.

-Tony
