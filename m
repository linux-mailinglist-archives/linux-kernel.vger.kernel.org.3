Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED5474650
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhLNPV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:21:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:23843 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232651AbhLNPVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:21:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237735217"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="237735217"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:21:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="614311910"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:21:09 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 7F2A220462;
        Tue, 14 Dec 2021 17:21:07 +0200 (EET)
Date:   Tue, 14 Dec 2021 17:21:07 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH v1 0/2] media: i2c: hi846: minor PM fixes
Message-ID: <Ybi2Yylo718i8SLl@paasikivi.fi.intel.com>
References: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
 <f08075656c83ff43947942c6f754936ced63dc01.camel@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f08075656c83ff43947942c6f754936ced63dc01.camel@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 02:44:41PM +0100, Martin Kepplinger wrote:
> Am Dienstag, dem 09.11.2021 um 14:10 +0100 schrieb Martin Kepplinger:
> > hi Saraki and all,
> > 
> > Here are minor PM fixes for the hi846 sensor while testing system
> > suspend:
> > 
> > thank you very much for your time,
> > 
> >                              martin
> > 
> > 
> > Martin Kepplinger (2):
> >   media: i2c: hi846: check return value of regulator_bulk_disable()
> >   media: i2c: hi846: use pm_runtime_force_suspend/resume for system
> >     suspend
> > 
> >  drivers/media/i2c/hi846.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> 
> hi all. Any objection or other thoughts about this? This fixes system
> suspend.

Thanks for the ping, Martin.

The patches are in my tree now.

-- 
Sakari Ailus
