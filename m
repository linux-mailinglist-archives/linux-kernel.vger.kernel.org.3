Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C35A4B07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiH2MGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiH2MGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:06:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85D2D1C8;
        Mon, 29 Aug 2022 04:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 981BEB80DD5;
        Mon, 29 Aug 2022 11:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5213C433D7;
        Mon, 29 Aug 2022 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661773328;
        bh=Xsfgl7e6NlVwn8xIM0IF5nw3L7EgSwgAuiqnYe1tzkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=16Fq0dL8+o2ZaYkCq1aycTaOqpfU9fTuCjQKmqpC4HezWP1yTlAlkocvOvsSNtw9/
         XrOuuclq6tGohTM4ktbEUeV8azFJFc6TRiOtraTUvFPv5UofX/+Q2scgNspLRjTHw2
         ep2DZTx7wJBuZ//mNqOHPnk18dBebfoXwfFjw7Uo=
Date:   Mon, 29 Aug 2022 13:42:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v7 1/3] thunderbolt: Add vendor's specific operations of
 NVM
Message-ID: <YwymDTBiG3oFWhni@kroah.com>
References: <20220829111059.665305-1-chensiying21@gmail.com>
 <20220829111059.665305-2-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829111059.665305-2-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 07:10:57PM +0800, Szuying Chen wrote:
> ---
> Fix $subject and add part of kernel-doc.

Please read the documentation in the kernel for how to show this
properly.  Please read the section entitled "The canonical patch format"
in the kernel file, Documentation/SubmittingPatches for what needs to be
done here to properly describe this.

thanks,

greg k-h
