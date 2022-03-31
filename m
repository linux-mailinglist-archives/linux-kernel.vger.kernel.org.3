Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20DA4EDAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiCaN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCaN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:58:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C2216FAB;
        Thu, 31 Mar 2022 06:56:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62F82B81FB7;
        Thu, 31 Mar 2022 13:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BB6C340F3;
        Thu, 31 Mar 2022 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648735013;
        bh=nGAWwdrBLbof0MlXW0yomhyhqY4p0AJh0Mm0ExRZmOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXX6Eup6BXRhvEIt5nDMtEY53v6+v/5OG4UUBdrPltDwzyAsAW2hhF1O5/lKX6x8h
         kTejUZ7JHYK0xbNk93JrQpYTXQRwX5DxFOhPhmLbi022p/9Ag3bLcbe4KgCtXhEpED
         dgKBnCWeoaH2OqFhCsBsb6jfSYLN5Eydo5nWUGrI=
Date:   Thu, 31 Mar 2022 15:56:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     niravkumar.l.rabara@intel.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Altera hardware mutex driver
Message-ID: <YkWzIJ2G/NZ8JCzK@kroah.com>
References: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331214911.27194-1-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 05:49:11AM +0800, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Altera hardware mutex soft IP provides hardware assistance for
> synchronization and mutual exclusion between processors in
> asymmetric/symmetric multiprocessing (AMP/SMP) system or
> multi processes/threads in uniprocessor system.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Sorry, but you have not followed the Intel-required rules for submitting
changes to the kernel.  Please contact the Intel Linux kernel team for
details about this to help prevent some of the problems that this
submission contains.

thanks!

greg k-h
