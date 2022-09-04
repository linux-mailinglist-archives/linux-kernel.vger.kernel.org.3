Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9025AC425
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiIDLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 07:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIDLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 07:45:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38713FA0D;
        Sun,  4 Sep 2022 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662291934; x=1693827934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=77ht/KHIDDl1w0O/JksmRcRIg/55sUgNvVkXVvRucq0=;
  b=SRgpFrc1E+3oK6pjaUImetJ0wpvpZKCgr4SsUa1L5HAGx0S2EXGG+h1s
   V9Sln6Ybo1GgJR+DkS/vtrczXpAYUzDd2d23r3WJQRSLdu4/5K386+fHe
   8NDDzmo7/8GB2Qrk6cEsKZxattg9wt/t6QPf7pvb2RLOMZc9+/NhjK+Du
   ofTNz9gcg6KseVmBI7x2gG7BESRSt0loIAJzwvG2tKyiUU2wXuk+D4HKm
   zrchNpcfrIA+p97hYw+CGUPceQAGAlJB5aXyjEshvrnMQ9n8nh15SG2IJ
   JsuZJXfEfA0Wydp9zIFFk3AKryNJIMLBqdLj4XZfrX2u+NqNaezpvJnbA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="296238009"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="296238009"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 04:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="739316884"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 04 Sep 2022 04:45:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0777486; Sun,  4 Sep 2022 14:45:46 +0300 (EEST)
Date:   Sun, 4 Sep 2022 14:45:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v8 0/3] thunderbolt: add vendor's NVM formats
Message-ID: <YxSP6pxh99Ewgnvo@black.fi.intel.com>
References: <20220902094010.2170-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902094010.2170-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Szuying Chen,

On Fri, Sep 02, 2022 at 05:40:07PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch series for vendors to extend their NVM format.
> 
> v7->v8: The nvm_read() defined in tb.h. Modify
> tb_switch_nvm_validate() return value and no_nvm_upgrade bit setting.
> 
> Szuying Chen (3):
>   thunderbolt: Add vendor's specific operations of NVM
>   thunderbolt: Modify tb_nvm major and minor size.
>   thunderbolt: To extend ASMedia NVM formats.

Thanks for the patches. There are a couple of things I would still like
to change in this series but I can do those myself, and then I need to
run some testing to make sure Intel NVM formats still work.

No need to send a new version. Once I've done my modifications I will
post the updated series for review and perhaps you can then try on your
side that it still works on ASMedia hardware.

Thanks!
