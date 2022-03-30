Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244394EBF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbiC3LHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiC3LHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:07:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6809E08B;
        Wed, 30 Mar 2022 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648638349; x=1680174349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYCryOcIAiX8RK8QwL575BHmStD3LWKxFVsGNh49MH4=;
  b=WS/r60a7PcZTSJ+PkTPqkf4D6IoyZsbahk25nJ4VaiaApd7GLGJqNkhe
   aqv3w9YhphpLPpLek58Eb15nNMTPLlKmjFNIABbIsuQnKLy6vhCDcGdz3
   BtWKVKbOxSz+e56LvWnR0ry/iWhvaJ9FtbDBONAxrhjd816cgL52tCNut
   fcI5Qzt0Z87kYiZ5Ia9C4llDQ/CalhrvJay3/pklv3JYBIQHjwFjBgcIb
   w7+fGHmNH33TvnyvpW/7NXT0+0FTBh2y0a7x4PBPzqZND7pGCtmGwMwBP
   ljZEwjgQosjw+mOLZkY6izP2X2dEfKal9AVhihbRv0T5IIxNFhgo7VKvJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345952115"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="345952115"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:05:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="719933391"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:05:47 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 97C3F20365;
        Wed, 30 Mar 2022 14:05:45 +0300 (EEST)
Date:   Wed, 30 Mar 2022 14:05:45 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hangyu Hua <hbh25y@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mc: delete redundant code in
 __media_device_unregister_entity
Message-ID: <YkQ5ic2b/gaF8cF+@paasikivi.fi.intel.com>
References: <20220324102752.47077-1-hbh25y@gmail.com>
 <Yjx2Xm7JmS+E8d7M@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjx2Xm7JmS+E8d7M@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 03:47:10PM +0200, Laurent Pinchart wrote:
> Hi Hangyu,
> 
> Thank you for the patch.
> 
> On Thu, Mar 24, 2022 at 06:27:52PM +0800, Hangyu Hua wrote:
> > media_gobj_destroy has already set graph_obj.mdev to NULL. There is no need to
> > set it again.
> > 
> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> >  drivers/media/mc/mc-device.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
> > index cf5e459b1d96..7727c619043e 100644
> > --- a/drivers/media/mc/mc-device.c
> > +++ b/drivers/media/mc/mc-device.c
> > @@ -605,7 +605,6 @@ static void __media_device_unregister_entity(struct media_entity *entity)
> >  
> >  	/* invoke entity_notify callbacks to handle entity removal?? */
> >  
> > -	entity->graph_obj.mdev = NULL;

Removed the extra newline above, too. Applied.

Please run scripts/checkpatch.pl on the patches, too.

> >  }
> >  
> >  /**
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Sakari Ailus
