Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860D5A0C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbiHYJ1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiHYJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:27:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E488A6E2EB;
        Thu, 25 Aug 2022 02:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02777B827CF;
        Thu, 25 Aug 2022 09:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3D8C433D7;
        Thu, 25 Aug 2022 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661419603;
        bh=6LFyQ6YlD5on8u6gveMR+kD0JxrBIJfsAknJq3NW5IU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=l9fek1rf931eJmOQYz/shO6Sb/3dxt0C+PY5gd4hS4f0JHL6z0aI2lLpNgakP+QFd
         VBBZjj/VGoT/NfzMJJcS+oVU8IzS1KGbTPCIusQpJfqqIlhaQtTlAVOW73P8ZYV5AJ
         m2oGkcIsen06ASbZIkH74t91iaUbi66XQiQedZO2uNcyQ+XvK4lNCll8ard9D/wiV+
         +AvKrPMvmaFcvFmW44qh1hXQ9ZVrQ7jvkdURSGv3asOAA8Wm2cB8o9IFDYIBmB4w8r
         14y4WvI1/pVmohtXt8epdITYeZZZczuyc89/fdp7INUSxqQ0PpI8GjS0qZkDEPswT1
         AR+f/DJ448eNg==
Date:   Thu, 25 Aug 2022 11:26:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: cp2112: Remove some dead code
In-Reply-To: <6ee2132c415db2fc90e7fa2106db427a914cc566.1655563907.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2208251126010.19850@cbobk.fhfr.pm>
References: <6ee2132c415db2fc90e7fa2106db427a914cc566.1655563907.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2022, Christophe JAILLET wrote:

> Commit 13de9cca514e ("HID: cp2112: add IRQ chip handling") has introduced
> cp2112_allocate_irq() that seems to be unused since 2016.
> 
> Remove it, remove the associated resources and part of the remove()
> function that frees the resources allocated in cp2112_allocate_irq().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> Maybe the issue is completely elsewhere and the probe() should call
> cp2112_allocate_irq() in some cases.

Benjamin, could you please take a look? Apparently you were aware of the 
code being dead due to the __maybe_unused annotation ... :) What was the 
point?

Thanks,

-- 
Jiri Kosina
SUSE Labs

