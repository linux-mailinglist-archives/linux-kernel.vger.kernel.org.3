Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC652517E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356061AbiELPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356055AbiELPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:44:38 -0400
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B226B0AD;
        Thu, 12 May 2022 08:44:37 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A08DC3C04C1;
        Thu, 12 May 2022 17:44:36 +0200 (CEST)
Received: from lxhi-065 (10.72.94.11) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 12 May
 2022 17:44:36 +0200
Date:   Thu, 12 May 2022 17:44:31 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Naveen kumar Sunkari <naveenkumar.sunkari@in.bosch.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: Re: [PATCH] usb: hub: Simplify error and success path in
 port_over_current_notify
Message-ID: <20220512154431.GA4536@lxhi-065>
References: <1652354127-3499-1-git-send-email-erosca@de.adit-jv.com>
 <YnzxvJ7/LGpu92bK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YnzxvJ7/LGpu92bK@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.11]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

On Do, Mai 12, 2022 at 01:38:36 +0200, Greg Kroah-Hartman wrote:
> On Thu, May 12, 2022 at 01:15:27PM +0200, Eugeniu Rosca wrote:
> > From: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>

[..]

> >  	if (!envp[1])
> > -		goto exit;
> > +		goto exit_path;
> 
> No need to rename this, right?
> 
> >  
> > -	envp[2] = NULL;
> >  	kobject_uevent_env(&hub_dev->kobj, KOBJ_CHANGE, envp);
> >  
> > +exit_path:
> >  	kfree(envp[1]);
> > -exit:
> 
> Move this up one line?

Thank you for your comments. Much appreciated.

Please, find the updated version at:
https://lore.kernel.org/linux-usb/1652369834-4480-1-git-send-email-erosca@de.adit-jv.com

Best regards,
Eugeniu
