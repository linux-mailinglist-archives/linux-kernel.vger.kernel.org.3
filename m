Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861A5547E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbiFVJQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiFVJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:16:37 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3232738
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aEnj6RSsJ68f2qx5PM9IqL6QL82fSufUdWRfkS5+iAA=;
  b=P/wR+uyuuu6pIDsy9EOwy5IaYvuvHHCH05sCASsfRHcSpN9pr80dXjvj
   se2+CYt/6GsY2c5NeRNf898tZ3U1jwh7nmKJ6RIYZckV3VgzOqwbqsc+C
   F0Pz2+4SySCfBoUOm8Z+XS4PKvVHOPNofni0+mii9t/QJAdPEfi69NEKU
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.92,212,1650924000"; 
   d="scan'208";a="17472762"
Received: from 71-51-165-43.chvl.centurylink.net (HELO hadrien.PK5001Z) ([71.51.165.43])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:16:32 +0200
Date:   Wed, 22 Jun 2022 05:16:21 -0400 (EDT)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        "vgupta@kernel.org" <vgupta@kernel.org>,
        "Julia.Lawall@inria.fr" <Julia.Lawall@inria.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC:mm:Fix syntax errors in comments
In-Reply-To: <4cef89c9-3b27-11e8-2971-66b93b847ede@synopsys.com>
Message-ID: <alpine.DEB.2.22.394.2206220513590.2646@hadrien>
References: <20220622080423.41570-1-yuanjilin@cdjrlc.com> <YrLTCXLrr3HB39lv@debian.me> <4cef89c9-3b27-11e8-2971-66b93b847ede@synopsys.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2022, Shahab Vahedi wrote:

> On 6/22/22 10:30, Bagas Sanjaya wrote:
>
> > I think that this kind of cleanup patches (typofixes) are best done
> > as part of **actual** work on the code in question (for example
> > refactoring or fixing build errors).
>
> Amen!

So code that is fine will have typos forever?  Fixing typos in comments
doesn't break git blame for the following code.  And typos in comments
give a bad impression about the state of the code in general.

But that is a general statement.  Perhaps this code does particularly need
work.

julia
