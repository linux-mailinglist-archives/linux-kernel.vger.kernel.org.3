Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3804956FE50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiGKKKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiGKKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:09:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17538BFAD7;
        Mon, 11 Jul 2022 02:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657531961; x=1689067961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvlOIycD/hOZWbnnn2CZO1AZ4xb9HJG4UhYLza7VlNY=;
  b=Vwn/58Sr9+6ljoz1pgnrjVnSS/Psp/bEEtUuP0Q8qr2BReYNfYco//hU
   7ksFeBdlYpgfo/LPN6qLjt7kXiMb4E7CQoCPAmJIwiuHaoBWDqq81JLQP
   qRdFq0N4KSc94j6pjhrbCwHSuVoqAlRxH1H74MoCQADsfd6Ar+x+A0VLw
   GEW5LZCcCF6ImUCCG3OtEqGHRIQ2mIiNMUjAYTFaUxSGw0H/S4Zvi9HHE
   45+Uh1H20C14Ktd5+QHBnPUM2EeToyMaXncHQuBPBNFBFme+3TsqqeYLa
   UP9YPWgwY/8LmmKmYYlbdRisSpsWwba1gNvKs8IEgKVPzC8mMQ0vgMcY1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370926954"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="370926954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 02:32:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="771456457"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 02:32:29 -0700
Date:   Mon, 11 Jul 2022 10:32:22 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Vladis Dronov <vdronov@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [ammarfaizi2-block:herbert/cryptodev-2.6/master 45/53] htmldocs:
 Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected
 indentation.
Message-ID: <YsvuJsjxEjp/LHZa@silpixa00400314>
References: <202207090803.TEGI95qw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207090803.TEGI95qw-lkp@intel.com>
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

On Sat, Jul 09, 2022 at 08:23:35AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block herbert/cryptodev-2.6/master
> head:   79e6e2f3f3ff345947075341781e900e4f70db81
> commit: d4cfb144f60551d80732c93c892fe76fc8df860d [45/53] crypto: qat - expose device config through sysfs for 4xxx
> reproduce: make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.
> 
> vim +24 Documentation/ABI/testing/sysfs-driver-qat
> 
>   > 24	Date:		June 2022
I'm not able to spot what the issue is. Any suggestions?

Thanks,

-- 
Giovanni
