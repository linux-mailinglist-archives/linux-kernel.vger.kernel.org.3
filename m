Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9744E361E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiCVBqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiCVBqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:46:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E313D28
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647913487; x=1679449487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3xQpy8OcUXHBr+agltF40I6tYOZmZNSpGKbvL4qlQ34=;
  b=YUeqc25W0OTXFJAwCiDEAmoViXG9RvuaiqNl1yppRejdQ/T1O9a+qP2y
   ercGjSldD4YXUsXbC0KQg5dnJ7szQf4O9PJSp+08Tlfpr1pnQPIC6brGP
   e/dB38VKvpVJ7LWY5CXu99HwCE2dJCl/MsAQK6Yn1kwMVium+WoA3yKKC
   asAy7fce9lMNYm6vF4jBsFn7x+7WFuDRYhkoQX76ONhbTY3nuKWcChO0D
   EFdWR21Iolc+0ANw+7x7ZLoOxiBrRFd31gdEqJzfKKLio4AZM6/ZwyUY3
   XM1R2tJPxRZNlp8D1snNWxdwLwHj/cltcrAT6lDvlQ0RaMjoh+sYIVyzK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="256514965"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="256514965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="636860076"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2022 18:44:45 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, radu.bacrau@intel.com,
        tien.sung.ang@intel.com
Subject: Re: [PATCH v2] firmware: stratix10-rsu: extend RSU driver to get DCMF status
Date:   Tue, 22 Mar 2022 17:44:28 +0800
Message-Id: <20220322094429.375237-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <238c6460-16a2-c630-9027-3fe31d0d59c5@kernel.org>
References: <238c6460-16a2-c630-9027-3fe31d0d59c5@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry folks. Made a mistake, miss spacing error in the checkpatch in header file. 
Will be more careful on the next upstream. 

Hi Dinh,
Do I continue with this v2 subject or re-send with another v3 patch subject ?
This version has the correct format check. 

Thanks. 
KJ

