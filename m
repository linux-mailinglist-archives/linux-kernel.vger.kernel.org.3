Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058CA4D38F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiCISiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiCISiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:38:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B18116F973;
        Wed,  9 Mar 2022 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646851026; x=1678387026;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=42SHLVdUmbF7Yr5x/SNRc33O12UExbadboJ1PcWDHxo=;
  b=FC4iCcUno3qtMeks06VbhLBQ4WfeV/+K7T0HYy4y/GZAloof7Ye+BB1E
   Xb+mbuu23X92GWJvH0OkdCotQwDidHHo0xJ/Ow7yPoufGfyl3o3vQn/cz
   oCzQf+zptjoQ3P8frTelZDJ9/L2QjIdiSjXf9ZRiiU+SniF3cMWdoyiA6
   N5dgjnDoHV3k0ow/TXiHoJyGkisOVqk76hBpte5VABDdDyCM9FUljzx3E
   gUe8DrxoQZy8+SczXzEAnMHLS08msomYpFxuv0nYSiqoIRhzWxv2OZ7jQ
   Yqp0XWpQJjLXnpNCZFhQIRw9M5EhqqDVztes0el4wmPVckJtG5mjsmABI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242503664"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="242503664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 10:37:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642257474"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 10:36:59 -0800
Message-ID: <42641969-c958-847c-4d6e-baa14d847545@intel.com>
Date:   Wed, 9 Mar 2022 10:36:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, "Raj, Ashok" <ashok.raj@intel.com>
References: <20220309175805.1298503-1-alexander.deucher@amd.com>
 <20220309175805.1298503-2-alexander.deucher@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/2] Documentation: x86: Clarify Intel IOMMU documenation
In-Reply-To: <20220309175805.1298503-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -ACPI enumerates and lists the different DMA engines in the platform, and
> -device scope relationships between PCI devices and which DMA engine  controls
> +ACPI enumerates and lists the different IOMMUs in the platform, and
> +device scope relationships between PCI devices and which IOMMU controls
>  them.

Isn't this just a really long-winded way of saying:

	ACPI enumerates both the IOMMUs in the platform and which IOMMU
	controls a specific PCI device.

?
