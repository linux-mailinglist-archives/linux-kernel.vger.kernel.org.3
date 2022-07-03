Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F16C56468B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGCJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiGCJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:57:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA1959A;
        Sun,  3 Jul 2022 02:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B88561239;
        Sun,  3 Jul 2022 09:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C0AC341C6;
        Sun,  3 Jul 2022 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656842260;
        bh=sr4KPKwXln9dVhXaJKSMNkYjpQn83ttknVa4Y3jo6As=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jcg++DqrYeV/JqOaBEI6N7zwG7+KcHD1+g4g+eGG+h+43qxnOzOAdFiHL2sCpXVSm
         zM0jOX1B1wZdzZfi/1KWZ7sx0tc68XbpJr030DrsQkgqYoNylO1FNMiHoIb07HpicI
         3MRwouPL/KM8wzkALGO4MlitCSUTJkKZcAx777zE1lFBpA4HccZhzgfYE2ZWu7CSQL
         AAfJvGz9Is8uRkKGccVaMid8I1O87M56DDHuyxrq89OSzJpMSXyozQdghqAlD35JzK
         Vysj9G7HlPwhB2PTEvGM/j5x5+FpEIwipnuQ2UdnvmlL6VOO+bfQCeSeR280j3lg1l
         raTHgIdgi9i5g==
Date:   Sun, 3 Jul 2022 10:57:34 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: htmldocs: Documentation/ABI/testing/sysfs-bus-iio-sx9324:2:
 WARNING: Unexpected indentation.
Message-ID: <20220703105734.05076795@sal.lan>
In-Reply-To: <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
References: <202207021703.lEW6FLT1-lkp@intel.com>
        <85c5fe48-90fd-6ad6-72d8-a3e7929f23e4@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 3 Jul 2022 10:29:44 +0700
Bagas Sanjaya <bagasdotme@gmail.com> escreveu:

> On 7/2/22 16:23, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   089866061428ec9bf67221247c936792078c41a4
> > commit: 4c18a890dff8d95ca234d184773910383a978d45 iio:proximity:sx9324: Add SX9324 support
> > date:   5 months ago
> > reproduce: make htmldocs
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> >   
> >>> Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.  
> > 
> > vim +2 Documentation/ABI/testing/sysfs-bus-iio-sx9324
> >   
> >    > 2	Date:		November 2021  
> >   
> 
> I'm not sure how to fix above, since the Date: field looks OK to me.

This one is trivial: just add a blank line. I already provided
Jonathan a feedback about that:

	https://lore.kernel.org/all/20220626234411.227c1a87@sal.lan/

Regards,
Mauro
