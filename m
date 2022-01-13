Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B944848D12B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiAMD73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:59:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:54628 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232377AbiAMD72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642046368; x=1673582368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DW3f6fd/VZT08Cjoo7DFtpdH4en1/Q6xoS/ISgvY3XI=;
  b=MtnLo9ZlFKZu4HEFPj5w7V2b1hcd/OHm2v9pepIyQ2DMa3bgjmnYcTFl
   MrPMf30TxuUJAULQ6Rih5dW8tXvv5ZxcY4JPwHSunfSIzoyDE5iZkcA7J
   PTQe7gehYzGSMoMsfX0iXfL5mZ16kwFVKiSBs7Y+nBfgeBjhPG/6dMsa7
   fnStUX+v/YvcpwKN+deRa1zR2f3bXvyjtupLRvOmdmEgPE5DgMWkbRXAc
   mRWLo7Q5Zacgqlr+dl/8RQKtGXEoUyGr6fTGzl/KUynnipz0milme6GjK
   b8Avu4+MhBuqFqHAlG0dklcD7wIPIeovqqXDORU4MKuvfLV77nJhFtZd1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242742981"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242742981"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 19:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="515772983"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga007.jf.intel.com with ESMTP; 12 Jan 2022 19:59:27 -0800
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 19:59:26 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 11:59:24 +0800
Received: from shsmsx603.ccr.corp.intel.com ([10.109.6.143]) by
 SHSMSX603.ccr.corp.intel.com ([10.109.6.143]) with mapi id 15.01.2308.020;
 Thu, 13 Jan 2022 11:59:24 +0800
From:   "Tu, ShawnX" <shawnx.tu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>, lkp <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [sailus-media-tree:master 15/16]
 drivers/media/i2c/hi847.c:2700:49: error: passing argument 2 of
 'v4l2_subdev_get_try_format' from incompatible pointer type
Thread-Topic: [sailus-media-tree:master 15/16]
 drivers/media/i2c/hi847.c:2700:49: error: passing argument 2 of
 'v4l2_subdev_get_try_format' from incompatible pointer type
Thread-Index: AQHYB8fcvhi1L73XrkuAIXL0B9X2X6xfBjoAgAFLoMA=
Date:   Thu, 13 Jan 2022 03:59:24 +0000
Message-ID: <1e504b20307d4eaf90e5cd2e85faf7c1@intel.com>
References: <202201122346.jc4ZqZm5-lkp@intel.com>
 <Yd771idbGaGVU9OQ@paasikivi.fi.intel.com>
In-Reply-To: <Yd771idbGaGVU9OQ@paasikivi.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thanks for your information.
I'll update the driver later.

Thanks,
Shawn
-----Original Message-----
From: Sakari Ailus <sakari.ailus@linux.intel.com>=20
Sent: Thursday, January 13, 2022 12:04 AM
To: lkp <lkp@intel.com>
Cc: Tu, ShawnX <shawnx.tu@intel.com>; kbuild-all@lists.01.org; linux-kernel=
@vger.kernel.org
Subject: Re: [sailus-media-tree:master 15/16] drivers/media/i2c/hi847.c:270=
0:49: error: passing argument 2 of 'v4l2_subdev_get_try_format' from incomp=
atible pointer type

Hi Shawn,

On Wed, Jan 12, 2022 at 11:18:55PM +0800, kernel test robot wrote:
>    drivers/media/i2c/hi847.c: In function 'hi847_set_format':
> >> drivers/media/i2c/hi847.c:2700:49: error: passing argument 2 of=20
> >> 'v4l2_subdev_get_try_format' from incompatible pointer type=20
> >> [-Werror=3Dincompatible-pointer-types]
>     2700 |                 *v4l2_subdev_get_try_format(sd, cfg, fmt->pad)=
 =3D fmt->format;
>          |                                                 ^~~
>          |                                                 |
>          |                                                 struct v4l2_su=
bdev_pad_config *

There's been an API change in how the sub-device try state is stored and ac=
cessed. The patch changing the other drivers is:

<URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?id=3D0d346d2a6f5=
4f06f36b224fd27cd6eafe8c83be9>

Could you make similar changes to the hi847 driver? I'll then squash that p=
atch into the current patch adding the driver.

--
Kind regards,

Sakari Ailus
