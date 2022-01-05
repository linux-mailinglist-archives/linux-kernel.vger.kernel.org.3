Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150DC4855D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbiAEP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:26:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:52446 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbiAEP0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641396394; x=1672932394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eSobkfWOC369+Z8sJ9Ior/sE6rWEK10SU8H0aMIdTC4=;
  b=PIPF+hAD4kIB65/d/VdpFlHK+Aea2k6DUnfCW9B0hNfYAbpaF0NvcZZu
   ncKHhye0HV4i+jGp3cJAmxilQKTi0S/lpa7ow3B4X6ati64kVh0cAkACx
   99x2aIztPEksBYUwlBkcPhUEpHXgENSZ2btFEU5mspgXSMIFH7d0L/eTP
   WspG3jYbQwtYv/PiZ4LeZx2PhjnWd6nHn2DwRtt1HbViI4ej8dEB34+C/
   dF8Q+RnioX1OUobTW+iZgZD/RNRKvkUVJEG/EXNdsSJxAcNVAlU2XdxXw
   pk8Ez4Q/g3fQdC6fxxsROw9Hk2kColGwR/+z7WFnoF1QBJNkfI+goytBJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="328810100"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="328810100"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 07:26:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="526573380"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 07:26:31 -0800
Date:   Wed, 5 Jan 2022 15:26:16 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] crypto: qat - Unsigned comparison with less than zero
Message-ID: <YdW4mNRVvQrBpslC@silpixa00400314>
References: <20220105152005.43305-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105152005.43305-1-jiapeng.chong@linux.alibaba.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 11:20:05PM +0800, Jiapeng Chong wrote:
> Fix coccicheck warning:
> 
> ./drivers/crypto/qat/qat_4xxx/adf_4xxx_hw_data.c:67:5-8: WARNING:
> Unsigned expression compared with zero: ret < 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
There is already a patch under review that fixes this:
https://marc.info/?l=linux-crypto-vger&m=164138836020725&w=2

Thanks,

-- 
Giovanni
