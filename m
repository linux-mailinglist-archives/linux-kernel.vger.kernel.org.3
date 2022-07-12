Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407F65718AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiGLLhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGLLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:36:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F276AC075;
        Tue, 12 Jul 2022 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657625818; x=1689161818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lxMJ1vvRgybvdBg5/M8m36eEI4N5PCc2jpWN3LR5nWg=;
  b=VCD2YCnFjtBQXOaaPYli7aoJSQi2pSa+VH1Ld9kTgFcOsYBl/hChhZjL
   VFxBM8n1qqPt87fG/Cqa/d01de5vuscD0+1Bs6AO4akJy65Ryve9kYER4
   i5mexfTWjHChilpJijR8RCcERhP1u6+sqaTIXvo2thB3R2dZIAZLWoZND
   VnMVosx/zDgzr9XQtnQQ9Hgw7K5KjXIEwZZCfvj8U1I78pWzXJGAMsW2C
   D32lBuK5F3R4NdigQI5xjWOGJ9DL6ATQEgPtD76m9uN8nglsxEr0las+W
   MQEW+KaPmPZ2pqxlAmLMuMel3lsfyxSP6oeHjcDhQCVSjxieDXYf3fmQQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283663480"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="283663480"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:36:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="841352271"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 04:36:11 -0700
Date:   Tue, 12 Jul 2022 12:36:08 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     lkp@intel.com, Vlad Dronov <vdronov@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH RESEND] crypto: qat - fix indentation in ABI documentation
Message-ID: <Ys1cqLYbk+SS2Cep@silpixa00400314>
References: <202207090803.TEGI95qw-lkp@intel.com>
 <YsvuJsjxEjp/LHZa@silpixa00400314>
 <CAMusb+QfUZwq+JRkUrOLGO7mQLZbg_ueFVo2_PTSiSRiq7BoEA@mail.gmail.com>
 <YsxJnq32lAJIRSET@silpixa00400314>
 <YsxP5n0rjUaX0mL8@silpixa00400314>
 <YsxlfOG17XQ+zLLZ@silpixa00400314>
 <0ec6f86a-a78b-4b5e-fb43-72f74ee71ceb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec6f86a-a78b-4b5e-fb43-72f74ee71ceb@gmail.com>
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

Hi Bagas,

On Tue, Jul 12, 2022 at 05:33:45PM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> I think the culprit is just missing code block marker, which is added
> above. Thanks.
Thanks for your fixes!

This patch should be ignore.

Regards,

-- 
Giovanni
