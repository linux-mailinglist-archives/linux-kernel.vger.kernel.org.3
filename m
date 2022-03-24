Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8254E6376
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350215AbiCXMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350250AbiCXMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:37:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4746A66C6;
        Thu, 24 Mar 2022 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648125386; x=1679661386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=081keNeSWcJNgz7CH/QLLv6qUi6siDSyFrabZBQkZBU=;
  b=ctirXGaQO871Z2CUgABC49kxzMeG41jHbAr0h1hRVEcxpQ6YRdLMM9dj
   KlVvI/vx2raV1xWO916hjyQHPJVyKl4pT5TP794mDraZ0jDpp2yXwLjFW
   UC61hvMNCFITlnen2mKlmCREnpWTnd5BViI9iFAtbC1B8Xe7DQIU+e2om
   /8XfLPeiZ+Dvr0OJlbnddpPHj8k/9dfskYYIp2nNpHZ7sc5e4BwFQr/Vj
   LT0yKyYBGp9YAMAdi+9saTwCWu3zJJGzQz2aTYre6TN/skMzi4+hqjibD
   9Z9Q+9waRyh21NJB4Drl3hEBdPgAD+85q/lQujRofAt2XzjsoSv7K6ql7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="240523145"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="240523145"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:36:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="561356418"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:36:24 -0700
Date:   Thu, 24 Mar 2022 12:36:10 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     =?utf-8?B?572X6bmP?= <wuhanluop@163.com>
Cc:     herbert@gondor.apana.org.au, salvatore.benedetto@intel.com,
        davem@davemloft.net, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A bug of QAT?
Message-ID: <YjxluoHM+FHWtaR0@silpixa00400314>
References: <7d3b3812.10d5.17fb9964788.Coremail.wuhanluop@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d3b3812.10d5.17fb9964788.Coremail.wuhanluop@163.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 09:41:48AM +0800, 罗鹏 wrote:
...
> But the request is not cached. And there is no time to rehandle the request
> later.
> 
> This may cause a problem?
Yes, this is a known problem.
I sent an RFC with a fix to the ML a few weeks ago:
https://patchwork.kernel.org/project/linux-crypto/patch/20220303180036.13475-3-giovanni.cabiddu@intel.com/

I'm going to send a final set early next week.

Regards,

-- 
Giovanni
