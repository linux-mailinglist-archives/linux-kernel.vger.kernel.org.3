Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E27508C41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380299AbiDTPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380357AbiDTPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:37:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA91DA5F;
        Wed, 20 Apr 2022 08:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7492B81F95;
        Wed, 20 Apr 2022 15:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02272C385A0;
        Wed, 20 Apr 2022 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650468908;
        bh=0TvdShlIkCt6RpyVO2I0TcefFwjvh8bV2p1H8fkiRCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfCCWMrlvQ7r8C8oCO+V3OEkoZT+yCc1nyQ/di1itJ78t/ql3ehtDekGvZnIC0f0s
         mV/030tbzJqg8eEmHPd/KpRzen1MTbg1uyRkd+cL6e1wy8uH2SYMBFGn1nzEQ7xjOp
         VdzA+wfCOZ2exyOVSfQKaFYjz8Ke5y9C1NoSVn+Y=
Date:   Wed, 20 Apr 2022 17:35:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/18] xen/usbfront: use xenbus_setup_ring() and
 xenbus_teardown_ring()
Message-ID: <YmAoKaw2Xe39oWm+@kroah.com>
References: <20220420150942.31235-1-jgross@suse.com>
 <20220420150942.31235-17-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420150942.31235-17-jgross@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 05:09:40PM +0200, Juergen Gross wrote:
> Simplify xen-hcd's ring creation and removal via xenbus_setup_ring()
> and xenbus_teardown_ring().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/usb/host/xen-hcd.c | 55 +++++++++-----------------------------
>  1 file changed, 13 insertions(+), 42 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
