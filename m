Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0D4E5B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbiCWWTc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Mar 2022 18:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiCWWTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:19:31 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBB8FE5A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:17:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E3FC66081114;
        Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4-FDGu-sgWod; Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 949586081100;
        Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hVRzrM2FeVZm; Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 70D0E605DEA9;
        Wed, 23 Mar 2022 23:17:56 +0100 (CET)
Date:   Wed, 23 Mar 2022 23:17:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>
Message-ID: <1214200498.178206.1648073876352.JavaMail.zimbra@nod.at>
In-Reply-To: <20220324085653.4c4c5315@canb.auug.org.au>
References: <20220315205259.71b4238a@canb.auug.org.au> <20220324085653.4c4c5315@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the folio tree with the ubifs-fixes
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: manual merge of the folio tree with the ubifs-fixes tree
Thread-Index: +v3+gZWbrfis+eeRRMLR6nh7swB4Kw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> This is now a conflict between the ubifs-fixes tree and Linus' tree.

Thanks for letting me know, I'll note this in my PR to Linus.

Thanks,
//richard
