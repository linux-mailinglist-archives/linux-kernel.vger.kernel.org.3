Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16D476501
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhLOVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:54:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:17599 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhLOVyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639605284; x=1671141284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B0vqHfMyzR9vwKEdxmc/UrUPdTcJ6nMSGV+7f2d5s6o=;
  b=STRYoPYQaV7YDAtK/lLPY/wCyWzxBCwi8ACVE17XGfMcDXsV++epR0wz
   6jOuPx0s7ZPpq2jsvErvGSC4onwE9iP0rR9z2aqavowWye1J6y3GD5R2x
   7CbxIzc2Idj5ElTdkhrJhXGimf45kuFa4eAeleBIbx2I013J670QO9vWp
   OpiyXQGEomu68u3qxacfvLkihXxHk/u9bcgjW1RFUC7J0weVmOpakwGPv
   S+sGC2qjvVQ6W1zTt9Tg34XOr2l3xo5gUE+Rw6Be3kbWJBtMs+niXxjsj
   sr+qjY8xqjoHu7Wqj1zbCq8EAhXgSKWZEo4BVkeG2QQhBWEJFEr2WNA1B
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226626704"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="226626704"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 13:54:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="614883453"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 13:54:41 -0800
Date:   Wed, 15 Dec 2021 21:54:34 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        qat-linux <qat-linux@intel.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v2 12/18] crypto: dh - introduce support for ephemeral
 key generation to qat driver
Message-ID: <YbpkGtH6dYCXNOZu@silpixa00400314>
References: <20211209090358.28231-1-nstange@suse.de>
 <20211209090358.28231-13-nstange@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209090358.28231-13-nstange@suse.de>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:03:52AM +0000, Nicolai Stange wrote:
> A previous patch made the dh-generic implementation's ->set_secret() to
> generate an ephemeral key in case the input ->key_size is zero, just in
> analogy with ecdh. Make the qat crypto driver's DH implementation to
> behave consistently by doing the same.
I ran a few tests on QAT GEN2 HW and this patch/set does not causes
regressions.

On the headline of the commit, should this be crypto: qat - ... ?

> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
 Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

-- 
Giovanni
