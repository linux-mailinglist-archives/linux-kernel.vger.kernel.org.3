Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA0853E0E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiFFFzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiFFFzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:55:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48031910
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3CC1B80FC0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08096C385A9;
        Mon,  6 Jun 2022 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494927;
        bh=NhiW/DZWdFttkvRo+PQSIkrmMlpMLgPm+d57yoJMkxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fE0zo+GvfbMWejpv/sgSEe70OfsKvdCZ8/a/HVluJOnDByePqeIsmuNWaa4Eztnxv
         APIaTsN7e/ovxF2MPUsoyVmguvUr6SZed1EYN1au2+R+3wWSFS8zNKlEUmU1vyCVI3
         2UOTeWy+6L7djk60/CMyFFUfyNk9ds5ZvFPElntk=
Date:   Mon, 6 Jun 2022 07:55:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] staging: r8188eu: Fix one kernel-doc comment
Message-ID: <Yp2WzN7q0Pe2WTKy@kroah.com>
References: <20220526125342.78264-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526125342.78264-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:53:42PM +0800, Yang Li wrote:
> Remove one warning found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> 
> drivers/staging/r8188eu/core/rtw_ieee80211.c:720: warning: expecting
> prototype for ieee802_11_parse_elems(). Prototype was for
> rtw_ieee802_11_parse_elems() instead

Again, all on one line please.

thanks,

greg k-h
