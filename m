Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A368595D35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiHPNY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiHPNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:24:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E0C86B6A;
        Tue, 16 Aug 2022 06:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B1B1B81A0C;
        Tue, 16 Aug 2022 13:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77D1C433D6;
        Tue, 16 Aug 2022 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660656293;
        bh=HnM4pxjUtPvA70Cr3g+ceoTLOVrmwq33Kb8C1Uf60yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/O+UdqMxG9H1YcwcqpB7mBuCSekiVH+WxSptSakOuDh4LLm3Yg4kwZxS7NGO1Ib5
         mq+nDPAOhPrTqY/fOujjuaa6qqokG3Ksyedgq6ue3P1IPu2qz7K7r4ak0QEMBd0l0J
         T5QBclds4ZRmb3koC6lEvWzzHUsuOHz2re7taFbk=
Date:   Tue, 16 Aug 2022 15:24:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: Add Rosewill USB-N150 Nano to
 device tables
Message-ID: <Yvuaor2ppSiG9Sao@kroah.com>
References: <20220814175027.2689-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814175027.2689-1-Larry.Finger@lwfinger.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 12:50:27PM -0500, Larry Finger wrote:
> This device is reported as using the RTL8188EUS chip.
> 
> It has the improbable USB ID of 0bda:ffef, which normally would belong
> to Realtek, but this ID works for the reporter.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/staging/r8188eu/os_dep/usb_intf.c | 1 +
>  1 file changed, 1 insertion(+)

Where is patch 2/2?

thanks,

greg k-h
