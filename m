Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6F54AD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiFNJTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiFNJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:19:39 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC4641FBA;
        Tue, 14 Jun 2022 02:19:37 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 9BC8CC1A36;
        Tue, 14 Jun 2022 12:19:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1655198375;
        bh=1o9DeVG8YeM34HzPAkbwky9SDW6qSepU54xAMe2uuYw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=IFpLRJb0Cioyj7p1ymgbLIxwGm7gpsmrb2OLEy4adcOYiHj1LwN1ye4fJ5yN20EZ9
         bJYX2eEMEgUdZ5Wmjui1Y4HLRdKYh6aBsHoLT63f2KDBXgsX8Wr6A3NaTXkPdsV+w+
         2ks2Q89gi63l6oVsHUhZbPJya8PZT+hpHTZi8qDkWAZyHyQJ9fJbzbBsLNToAwPO5Y
         fn6SlFdaZy1FV7Hffwf0a9SPuMRdsJETV9O+pK/fq+JvM51Sxl142lvd3f2a2uLU1+
         sLCZYs9oYjBxrr4c78cMTjutw/uszm0VJFd2S3BLjOiMkO7W7zTFoENm8CIu9Qnc3V
         vwe7qpPpoEdqg==
Received: from veeam.com (172.24.14.5) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 14 Jun
 2022 11:19:33 +0200
Date:   Tue, 14 Jun 2022 12:19:25 +0300
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/20] block, blk_filter: enable block device filters
Message-ID: <20220614091925.GA2429@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-2-git-send-email-sergei.shtepa@veeam.com>
 <44efdfc2-526f-0ea7-e332-ec29c00ef762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <44efdfc2-526f-0ea7-e332-ec29c00ef762@infradead.org>
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7662
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy.

Thanks for the review.
I agree with all the comments and will pay more attention to the documentation.

-- 
Sergei Shtepa
Veeam Software developer.
