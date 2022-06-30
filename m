Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4309E5616A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiF3Jla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiF3JlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:41:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5364814006;
        Thu, 30 Jun 2022 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656582057; x=1688118057;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dwAueDKLQ5Wcmqhh92BjSYr6GZvEHvGnhzXkG3KxdNQ=;
  b=PDBwujgpfg8U/NFBlU6rfA/AByrfhFP3GlThcpAz3vnvh3cB1PL0dVAK
   dA1NZhM3BGQZSKa4EONFAt7gXcsGzFarPSsM7UBAYiRm7edIOvN2hxbQy
   xs8OO6BxZ49a034p3+S1zKnqGh4bzH2Fv0I1BMcCtBvwpCHt0paocaJq0
   AVoFjZA90Mk7W4EWhqEvs9oyBnAN33KL0p7wZv/XOoQzxBLf5f16UZI+b
   QJWVIkTR7gnKwdhlwAyIddvYLSud6xn5F5EMixsOLO6XFX5dW/FNo2RtM
   t5tSZaz3NOnZG1HbcOJAAkGA706k44bCfeMylwK8L8MjyXNRqqMn0I4H2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262706057"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="262706057"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:40:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647818956"
Received: from emontau-mobl2.ger.corp.intel.com ([10.249.42.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:40:55 -0700
Date:   Thu, 30 Jun 2022 12:40:53 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dw: Sort headers alphabetically
In-Reply-To: <20220630093816.28271-1-andriy.shevchenko@linux.intel.com>
Message-ID: <f5522869-8140-1362-442f-43605fb564@linux.intel.com>
References: <20220630093816.28271-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1638031143-1656582057=:1605"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1638031143-1656582057=:1605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 30 Jun 2022, Andy Shevchenko wrote:

> For the sake of better maintenance, sort included headers alphabetically.
> While at it, split the serial group of headers which makes clear the
> subsystem the driver belongs to.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1638031143-1656582057=:1605--
