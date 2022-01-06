Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18E1486630
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiAFOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:40:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51640 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiAFOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:40:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 575D461A44;
        Thu,  6 Jan 2022 14:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36682C36AED;
        Thu,  6 Jan 2022 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641480025;
        bh=IAelO/WpNJASTs4zT5UHRL6kX20OjY/4oCI8aj0DUIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDTgAT52Dn5yfvALOi0SU9S9WRgMfHpkzmC31tBSwChnB2sBR7HPvDb/G/KaBMrQ5
         Q0jZ/bFpe6qF9ZSEO9NEt2MsuRUftUJ84fOonBFYjy0e/w7Q+Jh4FS75VBpcJvG3bn
         KGYCBNDxGAyDk3Hzf+QLrzYfiF/JECokrypxCme4=
Date:   Thu, 6 Jan 2022 15:40:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 0/4] Documentation: update debugfs doc for Hisilicon
 Accelerator
Message-ID: <Ydb/V4HPALDPWgk3@kroah.com>
References: <20220104082919.45742-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104082919.45742-1-yekai13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 04:29:15PM +0800, Kai Ye wrote:
> Update documentation describing DebugFS for function's QoS limiting.
> Add the note that described how to use the function's QoS limiting.
> 
> changes v1->v2:
> 	fixup the documentation format.
> 
> Kai Ye (4):
>   Documentation: use the tabs on all acc documentation
>   Documentation: update debugfs doc for Hisilicon SEC
>   Documentation: update debugfs doc for Hisilicon ZIP
>   Documentation: update debugfs doc for Hisilicon HPRE
> 
>  Documentation/ABI/testing/debugfs-hisi-hpre | 178 +++++++++++---------
>  Documentation/ABI/testing/debugfs-hisi-sec  | 146 ++++++++--------
>  Documentation/ABI/testing/debugfs-hisi-zip  | 146 ++++++++--------
>  3 files changed, 250 insertions(+), 220 deletions(-)
> 
> -- 
> 2.33.0
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
