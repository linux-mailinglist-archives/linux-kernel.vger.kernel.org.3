Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9758C55DFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbiF1GT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245099AbiF1GTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD71144A;
        Mon, 27 Jun 2022 23:19:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCCA1618AC;
        Tue, 28 Jun 2022 06:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC19BC3411D;
        Tue, 28 Jun 2022 06:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656397159;
        bh=z314VE6+rvvIxHO8FAyYU+8gEAGtAgh2/8aHXbcFb9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lzq2N1vBnDQaNTfyk/ZmpjHfynu+2WSfItvBcLidMR/dFIGoZICmcPh7z21M92pVt
         MN3uWIStwy/UH1n0w6E46oCQAB1fHvc7U7ke9ZyjwZdhr8D6D0coj15SSwjj/xczmI
         4tZ65LaGtwwS3quOD4o/zKDUXq7M0Vw5o9vH9NYM=
Date:   Tue, 28 Jun 2022 08:19:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v12 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <YrqdZE7IfKYZHkCu@kroah.com>
References: <20220628044843.2257885-1-xji@analogixsemi.com>
 <20220628044843.2257885-3-xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628044843.2257885-3-xji@analogixsemi.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:48:42PM +0800, Xin Ji wrote:
> Add driver for analogix ANX7411 USB Type-C DRP port controller.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
> V11 -> V12 : Fix Greg Kroah-Hartman's comment

Which comment?  This is very vague, it's almost like "made changes".

We need specifics here, otherwise it's impossible to review.  Would you
want to see this as a changelog statement for something you spent time
in reviewing?

Also, your changelog itself needs more text, as to what type of device
this is and more information about it if possible.

thanks,

greg k-h
