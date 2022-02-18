Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6A4BB1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiBRGDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:03:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBRGDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:03:11 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7A313FAB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645164175; x=1676700175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cEdSq1VCGIoL8pyAKhGDmHjsdUHu9+AtQsrVbpad9kA=;
  b=apmSMuaW/xSN/pYzoibyyUNli57kOcXz4WA9yrOrV2ogQpbDnBIKzcXl
   RT4qGoJSB1jlPgAiyveTZZBZGXhA79sFebuRulArylaCUa/b5UqVAp0Jo
   cDXlQnKPZ1KzVjWaFT3MWnUlTpzoZMvaSZFV+VglW6cokeADE/sUt5YrD
   nDTtEJh4Yj9oi6Yihm2mQ6PhMNpHRPwY2cIhvES1Z3XR+AN96qP0ZXGr8
   c/UG5ZrjQfCsFb3pvKi1GVQyMu+t6GjiFOerueZshw4JdIrbzh+YGj25t
   KVV7te1xUoYRQoB4HaQAaW/Va2Z/HAFkKiMvG/Fn3bOeiN9/pjoHY243i
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231042555"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231042555"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:02:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="626511159"
Received: from rbfawkes-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.127.120])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:02:55 -0800
Date:   Thu, 17 Feb 2022 22:02:54 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Message-ID: <Yg82jhb/R8Dh9AUw@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-21-ira.weiny@intel.com>
 <da79f69a41925f26d810f42f34dd149f5ea69d5c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da79f69a41925f26d810f42f34dd149f5ea69d5c.camel@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:47:14AM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> >  lib/pks/pks_test.c                     |  74 +++++++++++
> 
> Since this only tests a specific operation of pks, should it be named
> more specifically? Or it might be handy if it ran all the PKS tests,
> even though the others can be run directly.

I've been thinking the same thing too.  I have just not gotten around to it
yet.

Ira
