Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5A4BDCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379722AbiBUP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:56:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbiBUP4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:56:46 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA5F27FF5;
        Mon, 21 Feb 2022 07:56:22 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1B0B792009C; Mon, 21 Feb 2022 16:56:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 17B9B92009B;
        Mon, 21 Feb 2022 15:56:21 +0000 (GMT)
Date:   Mon, 21 Feb 2022 15:56:21 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild@lists.01.org, Jiri Slaby <jirislaby@kernel.org>,
        lkp@intel.com, kbuild-all@lists.01.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mike Korreng <mkorreng@endruntechnologies.com>,
        info@endruntechnologies.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] serial: 8250: Add proper clock handling for OxSemi
 PCIe devices
In-Reply-To: <20220217132352.GC2467@kadam>
Message-ID: <alpine.DEB.2.21.2202211415350.56785@angie.orcam.me.uk>
References: <202202130027.ZKBCgtm5-lkp@intel.com> <alpine.DEB.2.21.2202171009440.34636@angie.orcam.me.uk> <20220217132352.GC2467@kadam>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022, Dan Carpenter wrote:

> >  These variables do get assigned to in the first iteration of the loop, 
> > because the deviation calculated (`srem') is normalised to the range of 
> > [0,spre/2] and that divided by the original divisor (`spre') always works 
> > out at within [0,0.5], so `squot' will be within [0,32768].  I guess the 
> > static analyser is too dumb to figure it out, so I'll see how to paper it 
> > over unless someone has a better proposal.
> 
> These emails are a one time email so it's okay to ignore them if you
> want.

 I'm inclined to leave it as it is then.  Thank you for your explanation.

  Maciej
