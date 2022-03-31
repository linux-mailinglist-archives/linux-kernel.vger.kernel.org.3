Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9964ED888
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiCaLeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiCaLeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BE182DAE;
        Thu, 31 Mar 2022 04:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875ED615DB;
        Thu, 31 Mar 2022 11:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D67C340F3;
        Thu, 31 Mar 2022 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648726331;
        bh=t0lC1RQIMJQ9wmY9jq+yTfW7RjoXXGVpdb/3uZ0FJ0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNHj4AGDpAZrOi7HiVrnjfUu7pjzWkaPko+JNLbcKZCq1IcQNPbnZI3QbEQF8yvRD
         Rvk9BPTAwt7es2EjGzdbFqgtTVi8dudTKL5PzhagULHwH7Fd7NF7hUGYl/TkAaJfQP
         HfvLROs/ZB3GYsvWt/+ImhAkzMugwhVX4fBop67k=
Date:   Thu, 31 Mar 2022 13:32:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nas Chung <nas.chung@chipsnmedia.com>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dafna3@gmail.com" <dafna3@gmail.com>,
        "bob.beckett@collabora.com" <bob.beckett@collabora.com>,
        "kiril.bicevski@collabora.com" <kiril.bicevski@collabora.com>,
        "lafley.kim" <lafley.kim@chipsnmedia.com>,
        Scott Woo <scott.woo@chipsnmedia.com>,
        "olivier.crete@collabora.com" <olivier.crete@collabora.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "daniel@0x0f.com" <daniel@0x0f.com>
Subject: Re: [PATCH v6 4/6] staging: media: wave5: Add TODO file
Message-ID: <YkWRN4ac0ivRn4aB@kroah.com>
References: <SL2P216MB12463DE2E1E100E2498A5C33FBE19@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
 <SL2P216MB1246D7900A0B9620F1E1A038FBE19@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB1246D7900A0B9620F1E1A038FBE19@SL2P216MB1246.KORP216.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:55:10AM +0000, Nas Chung wrote:
> From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> 
> Add a TODO file listing all that is need for destaging.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  drivers/staging/media/wave5/TODO | 64 ++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 drivers/staging/media/wave5/TODO
> 
> diff --git a/drivers/staging/media/wave5/TODO b/drivers/staging/media/wave5/TODO
> new file mode 100644
> index 000000000000..425ed42a234c
> --- /dev/null
> +++ b/drivers/staging/media/wave5/TODO
> @@ -0,0 +1,64 @@
> +* Test on real silicon once available
> +
> +  This driver has so far been tested on pre-silicon FPGA and on the beta BeagleV
> +  board which uses the StarFive JH7100 beta SoC.
> +
> +  Testing on FPGA shows it working fine, though the FPGA uses polled interrupts
> +  and copied buffers between the host and it's on board RAM.
> +
> +  Testing on BeagleV shows buffer corruption that is currently attributed to a
> +  known silicon issue in the SoC that makes the cache coherent interconnect not
> +  so coherent.
> +  This can likely be solved when the riscv non-coherent dma support lands and
> +  provide optional v4l2 non-contiguous allocator, though it remains to be seen
> +  whether support non-coherent use cases will be useful in real world hw.
> +
> +  Until we can test and resolve any issues on final silicon (due 2H 2021)
> +  this driver should remain in staging.

Then why not just wait?  Why merge this now?  What is the benifit of us
taking this code at this point in time for hardware that is no one has
as it is not even created?

thanks,

greg k-h
