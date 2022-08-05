Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0852158AA3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiHELkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiHELkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:40:21 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931E511A2F;
        Fri,  5 Aug 2022 04:40:20 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 8A75941275;
        Fri,  5 Aug 2022 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-transfer-encoding:content-disposition
        :content-type:content-type:mime-version:references:message-id
        :subject:subject:from:from:date:date:received:received:received
        :received; s=mta-01; t=1659699617; x=1661514018; bh=GlgJJaXXbP0T
        ola3mcb0CZXyhSPLDsGJLM3k2v/rCtc=; b=Zjdv7Dl5l2ok+EMwzzYPxMZUxNgt
        7s+/TpYzoTZlkb60VjPP4btJyJ+mqgm5wJ2/IX6aG9bn2kXPadEbEXlySA78HREf
        pB0nLuEAM9+FjirzGSQlCB4huGfVOtmQtttfBLSXUYOhrlTcfBZ3vlJOldl1VQPX
        L06f9uoezAnjNds=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 082tpL9jtHD3; Fri,  5 Aug 2022 14:40:17 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3B575412D8;
        Fri,  5 Aug 2022 14:40:07 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 5 Aug 2022 14:40:07 +0300
Received: from yadro.com (10.178.118.226) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Fri, 5 Aug 2022
 14:40:06 +0300
Date:   Fri, 5 Aug 2022 14:40:05 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     <ojeda@kernel.org>, <linux-kernel@vger.kernel.org>,
        <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v8 28/31] samples: add Rust examples
Message-ID: <Yu0BlTVYG2/OKw0f@yadro.com>
References: <20220802015052.10452-29-ojeda@kernel.org>
 <YukvvPOOu8uZl7+n@yadro.com>
 <CANiq72m30zTwgSgV3+CDiMqdt2LH7TvkcnkMSw3B2do_gLn=Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m30zTwgSgV3+CDiMqdt2LH7TvkcnkMSw3B2do_gLn=Ng@mail.gmail.com>
X-Originating-IP: [10.178.118.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:31:41PM +0200, Miguel Ojeda wrote:
> «Внимание! Данное письмо от внешнего адресата!»
> 
> On Tue, Aug 2, 2022 at 4:08 PM Konstantin Shelekhin
> <k.shelekhin@yadro.com> wrote:
> >
> > A minor neat, but ain't it possible to use &str here in order to drop
> > this ugly binary string prefix?
> 
> Yeah, we would like to remove those at some point -- please see
> https://github.com/Rust-for-Linux/linux/issues/252.

Cool, thanks. I suggest it for the next patchset iteration, since it's
already has a GH issue.
