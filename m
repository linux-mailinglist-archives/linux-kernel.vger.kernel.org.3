Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30288583E04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiG1Lsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiG1Lsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:48:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5351438;
        Thu, 28 Jul 2022 04:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C69C9B82323;
        Thu, 28 Jul 2022 11:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2CDC433D6;
        Thu, 28 Jul 2022 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659008927;
        bh=7yLMJnxn+yCfCmx9YAg2I3p2Jc9Uy24ZRDfydiXpLeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrC1bHjf2Rxd6xIjCNJWDmVzeiGjFEKHQQJJoWdDpoBEF5kL1CrhjVtH76D1FdbI+
         E5gK8SJpJ255J9p3LMrBqR2ZFNeNafaeN+BOctzLnyHCNihBN+JU/Wb+aHPfGoPyTE
         tfqCiHjeYP1t7Q2WhomElUb59XnMVGE1EMP5EIsU=
Date:   Thu, 28 Jul 2022 13:48:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "git@xilinx.com" <git@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] tty: xilinx_uartps: Check the clk_enable return value
Message-ID: <YuJ3nPM9mhCHFQN2@kroah.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <20220429081422.3630070-3-shubhrajyoti.datta@xilinx.com>
 <YnQ4e7afL/ghGnA2@kroah.com>
 <BY5PR12MB49028F76B4701BA309913A6181969@BY5PR12MB4902.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB49028F76B4701BA309913A6181969@BY5PR12MB4902.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:09:10AM +0000, Datta, Shubhrajyoti wrote:
> [AMD Official Use Only - General]
> 
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, May 6, 2022 2:20 AM
> > To: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > Cc: linux-serial@vger.kernel.org; michal.simek@xilinx.com;
> > jirislaby@kernel.org; git@xilinx.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 2/7] tty: xilinx_uartps: Check the clk_enable return value
> > 
> > On Fri, Apr 29, 2022 at 01:44:17PM +0530, Shubhrajyoti Datta wrote:
> > > Check the clk_enable return value.
> > 
> > That says what, but not why.
> > 
> Will fix v2.
> > >
> > > Addresses-Coverity: Event check_return.
> > 
> > Shouldn't this be a covertity id?
> 
> I could not find the warning in the Coverity that is run on the linux kernel. 
> Somehow was seeing int when I was running  locally.

Ok, then there's no need to reference coverity at all then :)

thanks,

greg k-h
