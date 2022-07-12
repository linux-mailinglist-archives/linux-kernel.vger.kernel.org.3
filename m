Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853AE5728D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiGLVzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiGLVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:54:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A60045F63;
        Tue, 12 Jul 2022 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657662894; x=1689198894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HhwEjN2ERwxDUrhvzVEgnEFaPTQUKvOj+QMZ2916s+s=;
  b=T2DAap0fgbVM9AmNpyc+PPHIy4YWOT1Y45FgeOJ9LnwwF55eQUWXkVkE
   0KJAAONOg3JXgj7FpCJiuCgwGh8J94ZyO2DgcPjRskeXXLuZlblpwlpeC
   Ze00uALAhaSXNIuZLVMx8hUvEgjwIqT2W1jW3Y9QKCP/dLQ0rdmtAokMA
   KWzG96sY8JO4+JT9mL7biWi5ngyCRb8QaKv5OHR2qE826v7NxkKAlfp6A
   rFaEEZTF3PLmr9aE8v2XjThs0GbukP2CeczHfHNOb8aQtVNn1rP8CDJ7O
   6Noh1yOfSBysE/Aj8wSaoCKNluhDSPbeapxXi5ydepzu2httBaBpuHsEJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="371363578"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="371363578"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 14:54:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="772026699"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 14:54:51 -0700
Date:   Tue, 12 Jul 2022 22:54:44 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, Adam Guerin <adam.guerin@intel.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] Documentation: qat: rewrite description
Message-ID: <Ys3tpPBUS+ujnaoy@silpixa00400314>
References: <20220712092954.142027-1-bagasdotme@gmail.com>
 <20220712092954.142027-3-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712092954.142027-3-bagasdotme@gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:29:53PM +0700, Bagas Sanjaya wrote:
> The sysfs description contains redundancy on returned and allowed values
> list, due to the described sysfs is read-write. Rewrite.
> 
> Cc: Adam Guerin <adam.guerin@intel.com>
> Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
> Cc: Fiona Trahe <fiona.trahe@intel.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-qat | 34 +++++++---------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
> index 43e081ec22cc4a..be6c200abd783c 100644
> --- a/Documentation/ABI/testing/sysfs-driver-qat
> +++ b/Documentation/ABI/testing/sysfs-driver-qat
> @@ -2,18 +2,14 @@ What:		/sys/bus/pci/devices/<BDF>/qat/state
>  Date:		June 2022
>  KernelVersion:	5.20
>  Contact:	qat-linux@intel.com
> -Description:	Reports the current state of the QAT device and allows to
> -		change it.
> +Description:	(RW) Reports the current state of the QAT device. Write to
> +		the file to initalize and start the device or to stop it.
                            ^^^^^^^^^
Typo: initalize.
It is possible just to say: "Write to the file to start or stop the
device".

Regards,

-- 
Giovanni
