Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446205483D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiFMKFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFMKF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:05:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39ADDBA;
        Mon, 13 Jun 2022 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655114725; x=1686650725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m172As3IWVYcn+TF8WEERe47LseaOb5+mE8bYw135yI=;
  b=Y797UceSDkbIky172FNxvqeKz+SCEjlemGimdPOM2YRBvhYONm3mCk+3
   aKL3arm++jaBfZv59IifzBpY8faxko5LhHfVTXaYJz2ExabVoz20z5zi9
   fIuvfYqBkPLkywa9/sSYiOEmSZJNdAu5XxakFfcmBEaqBvOr4Qssq04O3
   7C3XGrWrcNvyR0CFKILKH7uOjqmXfo6zLXe0DSfkrF9zwwgs3HzLU4gtO
   YiPSN/mg3T0Ui3p3X6zzYCNxmjl2+WiNM9dsnw9zu+mtsTfAynJAxjZnV
   whvzjC/TSAm1CuBS5c/58DviE7DT2tT99l0gYRN0G/8oJdW7iybL+7w3i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="275767614"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="275767614"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 03:05:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="726189170"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 13 Jun 2022 03:05:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 13 Jun 2022 13:05:20 +0300
Date:   Mon, 13 Jun 2022 13:05:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Message-ID: <YqcL4NyPD6JZkPxZ@kuha.fi.intel.com>
References: <20220309023404.1221453-1-xji@analogixsemi.com>
 <YqMaUroS87rjnCny@kroah.com>
 <YqMyxQGzPSs/HwVi@kuha.fi.intel.com>
 <20220613093948.GA1454902@anxtwsw-Precision-3640-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613093948.GA1454902@anxtwsw-Precision-3640-Tower>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 13, 2022 at 05:39:48PM +0800, Xin Ji wrote:
> Hi heikki, OK, I'll rebase on the latest code and resend.

Before you resend, please make sure you check the comments I made to
the patch 3/3.

thanks,

-- 
heikki
