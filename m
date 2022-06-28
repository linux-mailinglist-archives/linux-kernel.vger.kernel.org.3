Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8389055D1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbiF1G2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244839AbiF1G2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:28:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE1A12AAD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 023C1B81CC9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE6C3411D;
        Tue, 28 Jun 2022 06:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656397697;
        bh=VYfL6apSVCp3F/QqS9sXxLvCyNuy4vKnXaZkAuaoZc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vyq/1kQ4NPKadRjLYHlg9n/VmSbi5m2dewUkXg+PGJc/SKi3wV/U+3Oei539o+KkO
         V0snDsZqOP9zigX4tTIQtR0s8aCwJfd+Y687QGNXDwTg4XFcZx2aPixnA1zi/OWy13
         VTbMomAohaL9vSjtGwvlMA+L9uUDc3K/TRdmPGOk=
Date:   Tue, 28 Jun 2022 08:28:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] habanalabs/gaudi2: add asic registers header files
Message-ID: <Yrqffh0IxXiEZHiF@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-2-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202620.961350-2-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:26:09PM +0300, Oded Gabbay wrote:
> +#ifndef __GAUDI2_ARC_COMMON_PACKETS_H__
> +#define __GAUDI2_ARC_COMMON_PACKETS_H__
> +
> +/**
> + * \file    gaudi2_arc_common_packets.h
> + * \brief   IDs for QMAN ARC CPUs
> + *          This defines IDs that needs to be programmed into CPU ID
> + *          register xx_ARC_AUX_ARC_NUM

What is this "\" formatting for and from?  What uses it?  I don't think
it's kernel-doc, right?

And if it is kernel-doc, are these files all hooked into the kernel
documentation build process to generate the output of them?

thanks,

greg k-h
