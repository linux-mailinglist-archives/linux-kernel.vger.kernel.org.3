Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF4D595A97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiHPLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHPLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:49:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357125DD;
        Tue, 16 Aug 2022 04:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4878FB81665;
        Tue, 16 Aug 2022 11:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6526BC433D6;
        Tue, 16 Aug 2022 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660649023;
        bh=/20kKX71ZpfVF9rw5LOSwmFXtujowJ7PjoE2wdNJC20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MNXbG/Z2FgZSh8Rj+XTRdK48LAJCQ8xFwRAfYmHWIg2UQRdOGjemwXuapTGjDrdLL
         hPX3Li+cnvtAvIgm7osgUqAxvaZyBEZKIlIaEgZHVT3yxfAX+LL+gz6Nf+A6t8XrJZ
         oxHQ/TlFh22R5sUeRX9KHCM61uPIGb5M95bZxiP8=
Date:   Tue, 16 Aug 2022 13:23:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v4] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <Yvt+O8P9dDHcFH3T@kroah.com>
References: <20220816105502.9059-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816105502.9059-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 06:55:02PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> The patch add tb_nvm_validate() contain an array that has functions
> pointers to asmedia_nvm_validate().
> And asmedia_nvm_validate() that recognize supported vendor works in one
> of the following cases:
> Case NVM_UPGRADE: enable nvm's attribute by setting no_nvm_upgrade
> flag to create nvm_authenticate file node.
> Case NVM_ADD: add active/non-active NVM devices.
> Case NVM_WRITE: update firmware to non-ative NVM device.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---Add enum nvm_validate_ops and modify ASMedia NVM Version format.
> ---Repair file(switch.c) has existed warning, but have 7 warn not fixed.
> 
> Note: The three previous submissions accidentally used the same subject
> prefix. This changelog is relative to the most recent submission at
> https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220815-121330

This needs to be below a line that _only_ has "---" on it.

See the documentation for examples, or one of the many commits on this
mailing list.

Please fix up and resend a v5.

Also be sure to fix up all the issues the kernel test robot found in
your previous submissions.

thanks,

greg k-h
