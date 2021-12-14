Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088924743C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhLNNos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:44:48 -0500
Received: from comms.puri.sm ([159.203.221.185]:58314 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234525AbhLNNor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:44:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 618C6E039C;
        Tue, 14 Dec 2021 05:44:47 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qy2plum6yCBm; Tue, 14 Dec 2021 05:44:46 -0800 (PST)
Message-ID: <f08075656c83ff43947942c6f754936ced63dc01.camel@puri.sm>
Subject: Re: [PATCH v1 0/2] media: i2c: hi846: minor PM fixes
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     sakari.ailus@linux.intel.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm
Date:   Tue, 14 Dec 2021 14:44:41 +0100
In-Reply-To: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
References: <20211109131013.2684058-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 09.11.2021 um 14:10 +0100 schrieb Martin Kepplinger:
> hi Saraki and all,
> 
> Here are minor PM fixes for the hi846 sensor while testing system
> suspend:
> 
> thank you very much for your time,
> 
>                              martin
> 
> 
> Martin Kepplinger (2):
>   media: i2c: hi846: check return value of regulator_bulk_disable()
>   media: i2c: hi846: use pm_runtime_force_suspend/resume for system
>     suspend
> 
>  drivers/media/i2c/hi846.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

hi all. Any objection or other thoughts about this? This fixes system
suspend.

thank you!

                          martin

