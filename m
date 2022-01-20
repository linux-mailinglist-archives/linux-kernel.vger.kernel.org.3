Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F92494BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376353AbiATKld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:41:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:42914 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234719AbiATKlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642675292; x=1674211292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OBMOL0VzCLgMEf9ZI8yngKUNQE5hRXEG8BIhuh1vD8M=;
  b=gX0S+1aQt3cMkG2cI+y4hMsBIpSQIq8q/Elr/CRdrv3BWYrcuFq3NaQ8
   eZ5Gty28ZsWD5kFE4kZn3nSsYlfsVabo980+PSS1/ile2gD0EKvLfD1UJ
   R67PDqZIuJ02rhLEvn9rdfPY3nV577RExexdO5DuOvbQBGnJ4SBgYXE6v
   UNOvXT2X/i6zEenheajct6FYotBHT5cbXNgTtmg4Ns4J0pr9CjMrb5Hkr
   Vo+TYPNEzv0MfBpDweP9yCku1VDFXJpjCI4y7QT/XOSgFgAudsHrr9k5S
   Ri07N8Lc9D0D2RzHJgAwEW3uN+hSHhT6VKV/XjfQJLCLKV0LpdXAVuA4j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="306054222"
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="306054222"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 02:41:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,302,1635231600"; 
   d="scan'208";a="477747886"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 02:41:28 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 2082E206B3;
        Thu, 20 Jan 2022 12:41:26 +0200 (EET)
Date:   Thu, 20 Jan 2022 12:41:26 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
Message-ID: <Yek8Vk7hyK0FvcXC@paasikivi.fi.intel.com>
References: <20220120012553.23295-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220120104029.wenol7qdfjl2f53n@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120104029.wenol7qdfjl2f53n@uno.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:40:29AM +0100, Jacopo Mondi wrote:
> Hello Prabhakar
> 
> On Thu, Jan 20, 2022 at 01:25:53AM +0000, Lad Prabhakar wrote:
> > CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> > handled by rcar-csi2.c driver. This patch updates the data-lanes property
> > to describe the same.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi All,
> >
> > Instead of adding uniqueItems:true into SoC binding doc's I think we could
> > add this in video-interfaces.yaml for data-lanes property. Any thoughts on this?
> >
> 
> As repeating items are not allowed I think it's a good idea.

Could this be put into the schema instead? The same holds true for all
devices.

-- 
Sakari Ailus
