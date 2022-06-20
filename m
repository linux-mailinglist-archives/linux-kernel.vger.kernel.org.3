Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D266355101C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiFTGMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTGMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:12:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D1BF48;
        Sun, 19 Jun 2022 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655705536; x=1687241536;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=XtxJpqDbFVcRPpaU+TI9RnGpqfSj+zLbBO02iyij09E=;
  b=cl3/J1/XrmKoN/Bbmkow1FHZMQUJ+mdjD/jL5sOaEsGLhX01CJEM3y0X
   Ssvc0p7Dlm28O0PA40pPDUckXEHmWDzBbhVrVqIHmTN2JQ9ih9efuURmg
   DxXEHpMedSPqkh26KnTWQZqYWplA6x0FnyqnWXcX9vH07xFLFfeu+b9tE
   RwHM3X5GoT02FiZSlFrF8YDJPHva1KP85F1S8EE80wza9Ynjdw6VGMoXg
   79hnnfwTCUs+15S5jL29hITvcf7pZ1+kBubEKl+lhufwTBeOHJxhvE922
   4r+M0d1yy5R47cza9vO6rxoVY1uRNzRat1vCC8mxbnkkhzBcApcUcKuh7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278585159"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278585159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:12:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642958459"
Received: from lspinell-mobl1.ger.corp.intel.com ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:12:12 -0700
Date:   Mon, 20 Jun 2022 09:12:06 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
cc:     Joe Perches <joe@perches.com>, kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild-all@lists.01.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [kbuild-all] Re: [PATCH] MAINTAINERS: Update DW 8250 UART
 maintainership
In-Reply-To: <7c01c4f8-1826-8769-c3d3-309a9d23f113@intel.com>
Message-ID: <e87a53b4-6fd1-f4a5-76c-37d8e61bf087@linux.intel.com>
References: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com> <202206180451.ZfYLcA43-lkp@intel.com> <7690845ccf9597e8cdc560a674a1b8e79a10f680.camel@perches.com> <7c01c4f8-1826-8769-c3d3-309a9d23f113@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1334455863-1655703831=:2433"
Content-ID: <f54532f8-7340-26d9-5cbd-c152b6c7aab0@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1334455863-1655703831=:2433
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <634e449a-1471-c9d5-fd5-9b2a9087c286@linux.intel.com>

On Mon, 20 Jun 2022, Chen, Rong A wrote:
> On 6/18/2022 4:17 AM, Joe Perches wrote:
> > On Sat, 2022-06-18 at 04:09 +0800, kernel test robot wrote:
> > > Hi "Ilpo,
> > > 
> > > Thank you for the patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on linus/master]
> > > [also build test ERROR on v5.19-rc2 next-20220617]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch]
> > > 
> > > url:
> > > https://github.com/intel-lab-lkp/linux/commits/Ilpo-J-rvinen/MAINTAINERS-Update-DW-8250-UART-maintainership/20220617-174145
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > 47700948a4abb4a5ae13ef943ff682a7f327547a
> > > reproduce: make htmldocs
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > 'utf-8' codec can't decode byte 0xe4 in position 1396: invalid
> > > > > continuation byte
> > 
> > ?
> > 
> > false positive?

This is correctly identified problem, however, the problem is lkp's end.
It seemingly fails to handle non-UTF8 encoded emails correctly and just 
goes to assume the input is UTF8 encoded (w/o checking the Content-Type 
header).

> I tried to apply the patch, and I can reproduce the error by 'make htmldocs':
> 
> $ wget -q -O -
> https://lore.kernel.org/lkml/be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com/raw
> | git apply -v
> $ git --no-pager diff
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f52543aedd61e..3d64756814f09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19247,8 +19247,9 @@ F:
> Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
>  F:     drivers/gpio/gpio-creg-snps.c
> 
>  SYNOPSYS DESIGNWARE 8250 UART DRIVER
> +M:     Ilpo Jrvinen <ilpo.jarvinen@linux.intel.com>
>  R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> -S:     Maintained
> +S:     Supported
>  F:     drivers/tty/serial/8250/8250_dw.c
>  F:     drivers/tty/serial/8250/8250_dwlib.*
>  F:     drivers/tty/serial/8250/8250_lpss.c
> 
> It seems the special character 'ä' in name 'Ilpo Järvinen' was parsed wrongly.

The original file was UTF-8 (0xc3 0xa4). The email is correctly encoded 
ISO 8859-15 as can be see e.g. by downloading this (with a single 0xe4 
char):
  https://marc.info/?l=linux-kernel&m=165545870203513&q=raw

When saving patch/exporting email, MUA/exporter should do ISO 8859-15 -> 
UTF-8 conversion. If I export email I sent, I get it back to UTF-8 just 
fine (as per the locale I've in use).

Just in case, I've attached the original patch file.

I thought git's toolchain these days handles these things fine but 
it seems not.


-- 
 i.
--8323329-1334455863-1655703831=:2433
Content-Type: text/x-diff; NAME=maint.patch
Content-Transfer-Encoding: BASE64
Content-ID: <f57e3f35-a418-9262-d9e4-18a18ec84dc@linux.intel.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=maint.patch

RnJvbTogSWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50
ZWwuY29tPg0KU3ViamVjdDogW1BBVENIXSBNQUlOVEFJTkVSUzogVXBkYXRl
IERXIDgyNTAgVUFSVCBtYWludGFpbmVyc2hpcA0KDQpBZGQgbXlzZWxmIGFz
IG1haW50YWluZXIgZm9yIERXIDgyNTAgVUFSVCBhbmQgdXAgaXQgdG8gU3Vw
cG9ydGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWxw
by5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQoNCi0tLQ0KIE1BSU5UQUlO
RVJTIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBi
L01BSU5UQUlORVJTDQppbmRleCBhNmQzYmQ5ZDJhOGQuLjZjOTA0ODRmMzk1
YiAxMDA2NDQNCi0tLSBhL01BSU5UQUlORVJTDQorKysgYi9NQUlOVEFJTkVS
Uw0KQEAgLTE5MjMwLDggKzE5MjMwLDkgQEAgRjoJRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwaW8vc25wcyxjcmVnLWdwaW8udHh0DQog
RjoJZHJpdmVycy9ncGlvL2dwaW8tY3JlZy1zbnBzLmMNCiANCiBTWU5PUFNZ
UyBERVNJR05XQVJFIDgyNTAgVUFSVCBEUklWRVINCitNOglJbHBvIErDpHJ2
aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQogUjoJQW5k
eSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b20+DQotUzoJTWFpbnRhaW5lZA0KK1M6CVN1cHBvcnRlZA0KIEY6CWRyaXZl
cnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZHcuYw0KIEY6CWRyaXZlcnMvdHR5
L3NlcmlhbC84MjUwLzgyNTBfZHdsaWIuKg0KIEY6CWRyaXZlcnMvdHR5L3Nl
cmlhbC84MjUwLzgyNTBfbHBzcy5jDQoNCi0tIA0KdGc6ICg2NTUzNDczNmQ5
YTUuLikgZHcvbWFpbnRhaW5lciAoZGVwZW5kcyBvbjogdHR5LW5leHQpDQo=

--8323329-1334455863-1655703831=:2433--
