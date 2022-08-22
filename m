Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4038059B966
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiHVG0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 22 Aug 2022 02:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiHVG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:26:08 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B99627B28
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:26:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4C878615CC8A;
        Mon, 22 Aug 2022 08:26:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7T8jxlXV35al; Mon, 22 Aug 2022 08:25:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A4DF4615CCB6;
        Mon, 22 Aug 2022 08:25:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BcGappGnTvLl; Mon, 22 Aug 2022 08:25:59 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 79C83615CC8A;
        Mon, 22 Aug 2022 08:25:59 +0200 (CEST)
Date:   Mon, 22 Aug 2022 08:25:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     Yifei Liu <yifeliu@cs.stonybrook.edu>, ezk@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, David Woodhouse <dwmw2@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kyeong Yoo <kyeong.yoo@alliedtelesis.co.nz>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <513220739.132330.1661149559308.JavaMail.zimbra@nod.at>
In-Reply-To: <PH0PR10MB46153A784F27AE96DA69120DF46E9@PH0PR10MB4615.namprd10.prod.outlook.com>
References: <20220803155315.2073584-1-yifeliu@cs.stonybrook.edu> <PH0PR10MB46153A784F27AE96DA69120DF46E9@PH0PR10MB4615.namprd10.prod.outlook.com>
Subject: Re: [PATCH] jffs2: correct logic when creating a hole in
 jffs2_write_begin
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: correct logic when creating a hole in jffs2_write_begin
Thread-Index: AQHYp1GL3Ep6t2pZ9Uewp2J/7maioa25xpiVmVIRMXc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Joakim Tjernlund" <Joakim.Tjernlund@infinera.com>
> An: "Yifei Liu" <yifeliu@cs.stonybrook.edu>
> CC: ezk@cs.stonybrook.edu, madkar@cs.stonybrook.edu, "David Woodhouse" <dwmw2@infradead.org>, "richard"
> <richard@nod.at>, "Matthew Wilcox" <willy@infradead.org>, "Kyeong Yoo" <kyeong.yoo@alliedtelesis.co.nz>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Sonntag, 21. August 2022 20:21:04
> Betreff: Re: [PATCH] jffs2: correct logic when creating a hole in jffs2_write_begin

> What happened with this patch? Looks like a important fix but I don't see it
> applied ?

It will be part of the next fixes PR after I had a chance to review it.

Thanks,
//richard
