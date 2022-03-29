Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6764EB471
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiC2UKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiC2UKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:10:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6E62D2;
        Tue, 29 Mar 2022 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648584543; x=1680120543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJBFAHQdu8LK3MnfBlyd4ynLCpZPwxsuj3ERMXvrSf4=;
  b=hEAEFeepfv2P9VPz1L21QzHrsUdbaFWR4jcJNruqBw1KBHjXqljSK0/l
   XEmtVYSVJ+B1VzyOzQCbhbgQMCQjg6GWJJ0SPWXJL57py+dfgexlmUxx/
   TGxGDVqROpqtIOLMGL3p7N0yC8eTY/QfP6ffokeVJUuDtU8KdNhlA8tmJ
   +yTrV9wKjiCkktecKCVvNMLnkCIUZ3hvkjcgXLx5N5XcSoI8kq8iImUHL
   6WcnQYDuZmvZUv3IvBi111kGs0zYrvM4WAPklgj+rRGuBy2YK9vnZ6aF1
   2YeBeoxk509+ShJs6dn7kXRHiVZzqO6rUj/SMdtybiQi4lI9NW9MJapTr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345798713"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="345798713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 13:08:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="694848177"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 13:08:15 -0700
Date:   Tue, 29 Mar 2022 13:10:21 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media:av7110:av7110_av.c remove blank line
Message-ID: <20220329201021.GA1171096@alison-desk>
References: <20220329190133.6243-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329190133.6243-1-eng.alaamohamedsoliman.am@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:01:33PM +0200, Alaa Mohamed wrote:
> according to checkpatch.pl results
> "CHECK: Please don't use multiple blank lines"
> after lines 73 and 78 ,I removed the blank lines
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>  drivers/staging/media/av7110/av7110_av.c | 2 --

Hi Alaa,

We are not taking cleanup patches in drivers/staging/media.
It's documented in here https://kernelnewbies.org/Outreachyfirstpatch
and I will repost the restriction on this list as the discussion
occurred a few days before the contribution period began.

If you look at the git history on this file, you'll see it is
on it's way out of the kernel, not on it's way in!

Please look at my feedback to Rebecca and Sevinj recent checkpatch
cleanups as guidance for your next (non-media) cleanup patch.

Thanks!
Alison





>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
> index 91f4866c7e59..1544f120e8b1 100644
> --- a/drivers/staging/media/av7110/av7110_av.c
> +++ b/drivers/staging/media/av7110/av7110_av.c
> @@ -70,12 +70,10 @@
>  #define PIECE_RATE	 0x40
>  #define SEAM_SPLICE	 0x20
>  
> -
>  static void p_to_t(u8 const *buf, long int length, u16 pid,
>  		   u8 *counter, struct dvb_demux_feed *feed);
>  static int write_ts_to_decoder(struct av7110 *av7110, int type, const u8 *buf, size_t len);
>  
> -
>  int av7110_record_cb(struct dvb_filter_pes2ts *p2t, u8 *buf, size_t len)
>  {
>  	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *) p2t->priv;
> -- 
> 2.35.1
> 
> 
