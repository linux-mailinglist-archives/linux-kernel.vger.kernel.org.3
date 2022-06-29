Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157CC55FC98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiF2Jq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiF2Jqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:46:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA83D1EB;
        Wed, 29 Jun 2022 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656495991; x=1688031991;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BZIWPTloMf8AQuGqC8ag9Fykg2gG+rYk+IvJyAXbHZE=;
  b=E2TmSKDVIfPMyRC7Zf+D8bVWpLvkL0fvus/jtqZMNpPvO+nq1i8Tiakv
   F+lystgpXB+jrhn8QvdFC2ROMlcTYPeVlEKS8yJgIsHwPBr+GoE4U95oH
   Oo+r/9/PkdVokEH7FYxG3Q5UCacv7KCiELCE5gqZJ7M9O8h1TCjLkHv4m
   5+4uEJ7aJNDbtRJiPX3HXwz8s34dC25kvNIB91QuL7qfPqGBpI7dJFxI3
   8Fq4XEXeLMFajoDXOTC4Rsa9hkp32BAMYezu+8kZL2UJo6UF8A1JntWW9
   +Wg2Nq2WnTH/tVMPb2Bwa56p7ZwyvvPml4qA8446QVymtUtaQEmelNKC5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282022064"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="282022064"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:46:23 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="647321786"
Received: from dsummer-mobl.ger.corp.intel.com ([10.252.38.121])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:46:20 -0700
Date:   Wed, 29 Jun 2022 12:46:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Zhang Jiaming <jiaming@nfschina.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, liqiong@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] serial: Fix spelling mistake
In-Reply-To: <20220629094411.39066-1-jiaming@nfschina.com>
Message-ID: <f1a9358-8e77-f65b-8d46-d9c93985a1@linux.intel.com>
References: <20220629094411.39066-1-jiaming@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-560738371-1656495983=:1529"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-560738371-1656495983=:1529
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jun 2022, Zhang Jiaming wrote:

> Change 'timeing' to 'timing'.
> Change 'Characteres' to 'Characters'.
> 
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-560738371-1656495983=:1529--
