Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172244F4231
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387708AbiDEOcr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Apr 2022 10:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiDEJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:33:02 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DD1DC5;
        Tue,  5 Apr 2022 02:20:29 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 6536D462BE9;
        Tue,  5 Apr 2022 11:20:27 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 539C1461980;
        Tue,  5 Apr 2022 11:20:27 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Tue,  5 Apr 2022 11:20:27 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Apr 2022
 11:20:26 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.022; Tue, 5 Apr 2022 11:20:26 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
Thread-Topic: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
Thread-Index: AQHYRNET6fGEHIFWCkie/s3TyF86+azZZi8AgAesmZo=
Date:   Tue, 5 Apr 2022 09:20:26 +0000
Message-ID: <c1726b6966e74c9fa9fb4a6ac56dedf9@hyperstone.com>
References: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
 <5eaae8e215d84dd3a4f7e09782478a29@hyperstone.com>,<YkW1qGY3uJPhrmf1@smile.fi.intel.com>
In-Reply-To: <YkW1qGY3uJPhrmf1@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.17]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1000-26814.006
X-TMASE-Result: 10--9.372200-10.000000
X-TMASE-MatchedRID: BFQSNthdAqLUL3YCMmnG4tKDcT1f9CjEQAKUX1R86jTMVqPzYKoX2fy+
        IfkvA3MsPzfUQuvyrgz0B9yN5j90xCbixKZRJvnJF+qQpCWTUjmCZaeJCjp8UkcTQWdpiE3Vo8W
        MkQWv6iUsOwD+dG3DyZ/Unpyav4ctavP8b9lJtWr6C0ePs7A07RQEL0GGu6SD0zjjSJ2xuUGIc3
        tHPZjuopV9NtlmaYdITb0eacHsFvw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 8ee7dfcf-8a27-4f92-b964-d58b1aaf410b-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Understood and sure, then I'll take 2/2 back.
@Ulf, would you like a v2 just containing 1/2 or is it fine like this?




From: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.com>
Sent: Thursday, March 31, 2022 4:07 PM
To: Christian Löhle
Cc: Ulf Hansson; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; adrian.hunter@intel.com; digetx@gmail.com; avri.altman@wdc.com
Subject: Re: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
    
On Thu, Mar 31, 2022 at 07:29:37AM +0000, Christian Löhle wrote:
> Any setup supporting more than 25MHz is able to utilize
> highspeed, so enable it even when not explicitly specified.

I'm not sure about this. I prefer to be on the safer side, i.e.
follow only what is supplied by firmware (ACPI / DT).

-- 
With Best Regards,
Andy Shevchenko


    =
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

