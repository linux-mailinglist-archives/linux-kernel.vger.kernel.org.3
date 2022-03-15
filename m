Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDBD4D9D37
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbiCOOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349088AbiCOOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:19:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17406E29
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ACB5B81676
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58595C340ED;
        Tue, 15 Mar 2022 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647353868;
        bh=3H3AfSuzjw8pYm8fCGgzUqWeRwhM4iueTYBYoa7skz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z6aUgf5LLpP8KyJQw9dN13bziiiNz8XhKd4RnKNr/naJZREyQIrZnJBbV1fniRVTp
         NfjIoQaJkBafyqk3D9l5Y2drlX8GShXhAnH5bH2JwyTOGtG6ikU0eDQ40JgbStnNW8
         +q0uPaLns6c0wgKiLQMOFlyCHCeMWYcugmBBuVO8=
Date:   Tue, 15 Mar 2022 15:17:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vt6656: Removed unused variable
 vt3342_vnt_threshold
Message-ID: <YjCgCEH4etP/6Ele@kroah.com>
References: <cover.1647284830.git.philipp.g.hortmann@gmail.com>
 <6e1ef287e66039f9013435f8fa1266de7387df2e.1647284830.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1ef287e66039f9013435f8fa1266de7387df2e.1647284830.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 08:31:11PM +0100, Philipp Hortmann wrote:
> Missing part of staging: vt6656: Remove unused rf_type in baseband.c
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Nit, the Reported-by: goes next to the signed-off-by: line.

I've fixed this up in my tree.

thanks,

greg k-h
