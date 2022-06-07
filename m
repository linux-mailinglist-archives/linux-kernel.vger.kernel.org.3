Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21CD53FEFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiFGMhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbiFGMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D746DF8E41;
        Tue,  7 Jun 2022 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654605394; x=1686141394;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MxAWmJRI3ZKU9Ny1YrqmB59EfBq+v4Nj/ZOMTKnZcU0=;
  b=klbVSSySC5RuQ9PavFkHfuoi8w8vqibau51Rk5QFL8Jag383l19y4Uwc
   QEGaTxHGp/m4JzkdD8R64aPzHm7eljbS3xguObTpVbKKq+wfkiJeoWZEC
   reF+wCMXF7q6/mSToEHqRO1kQg9l75yEKAYbtxezML+Wygnk6n2uubcdQ
   pqCJY9H6frN2dsllI2fgdF6n+fba7SJjIlsw6mhFRb2LPdTnWmBUl89B4
   oSukVRiAvcr392uEZ7rfJgay4g2sXGzNwrFc+U1KegTFuPMRd9+L7iGP/
   4M27DGE+w1wWCpfFkPmNn9KkT0UMEEEafYm3M5j7aqWxNGnkyHVQAgDAF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275494814"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="275494814"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:36:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="584182087"
Received: from akmessan-mobl1.amr.corp.intel.com ([10.251.214.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:36:32 -0700
Date:   Tue, 7 Jun 2022 15:36:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/36] tty/vt: consolemap: use ARRAY_SIZE()
In-Reply-To: <20220607104946.18710-1-jslaby@suse.cz>
Message-ID: <594b4c3f-1ca3-9ff3-dfe5-bea02910f78e@linux.intel.com>
References: <20220607104946.18710-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-849965590-1654605394=:1622"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-849965590-1654605394=:1622
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 7 Jun 2022, Jiri Slaby wrote:

> The code uses constants as bounds in loops. Use ARRAY_SIZE() with
> appropriate parameters instead. This makes the loop bounds obvious.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-849965590-1654605394=:1622--
