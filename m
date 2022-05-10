Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6E521EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345803AbiEJPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345692AbiEJPdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:33:21 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32334662;
        Tue, 10 May 2022 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1652196397;
  x=1683732397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yUD3uwtewYu9aG509jJFvj6tNpbiQKxIslmOylkUtdk=;
  b=k+juFkF1CHzm5dkkd8MSQMyMKFQWyGZoeW6s9zbpzw8A1R80zWQ9GGDU
   eY0AlEv8itrWT3KNMTlfAKBnwO5a87BlRRZVRYMG9x2xuJsVosn2GB9EP
   1b122qrfO4QZjx3WDAJkC8ej5a8nDx7Hqio6aZ3ljCdktUUidFaNF2rKF
   TfADQlpUmf2KLLYuman+MlY3cRtONDOzDRWpF73AoPeVBNCdfYDXDoxeS
   OmR4Hq0ESgfi6fOu21IPuoUH+efJhGIRRxXesDm5D37TRB1L++nHqrr3J
   N5vMJrqQgSN1U9JT80urq2hPpGNQcwK5ZumudZonNOBHyXancaOHsl90H
   A==;
Date:   Tue, 10 May 2022 17:26:35 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     kernel test robot <lkp@intel.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "joern@lazybastard.org" <joern@lazybastard.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        kernel <kernel@axis.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtd: phram: Allow cached mappings
Message-ID: <20220510152635.GA17605@axis.com>
References: <20220412135302.1682890-5-vincent.whitchurch@axis.com>
 <202204131446.omJ5mC54-lkp@intel.com>
 <20220414090402.GA11067@axis.com>
 <20220425102816.54619c66@xps13>
 <20220425103015.1cc05f77@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425103015.1cc05f77@xps13>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:30:15AM +0200, Miquel Raynal wrote:
> miquel.raynal@bootlin.com wrote on Mon, 25 Apr 2022 10:28:16 +0200:
> > Looks good to me but I don't want to be the one "carrying" new compile
> > errors so I'll drop the series for now, until you get this patch
> > applied. Please then just resend the series with this thread mentioned
> > and I'll take it back.
> 
> BTW, I'm only talking about this improvement, patches 1-3 will remain.

Thank you.  I've now refactored this patch and send it out separately as
a v4, primarily to avoid the SH build problems (which look like they're
going to take a while[0] to get fixed) but also to remove some code
duplication.

[0] https://lore.kernel.org/lkml/CAMuHMdW-8HaQip+DT5W2Owq8M8kbYwHsf8_Zd-5rRfSjSjK0=g@mail.gmail.com/
