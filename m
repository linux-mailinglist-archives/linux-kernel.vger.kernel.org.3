Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD645045CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 02:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiDQAIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 20:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiDQAIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 20:08:22 -0400
Received: from abedmanico.biharhotel.com (abedmanico.biharhotel.com [194.31.98.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B002BC02
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 17:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=biharhotel.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=mar.veg@biharhotel.com;
 bh=dnkE0QHVOCf1aNji21hnkG44FB8=;
 b=CxrpP4QMHpAivwYXkqYg495+9tGI0sVS9d3h+mKOoDnd49BwFltZ1Mq6EV2vYarsSV5Ve2uRoxAE
   JAcvD23W65tMvtG7OecDtP/1vnxboaMhOCObU+MemAf3XE6E85mzLqXx/VQ/phw94OV+3qvnc4EI
   vCXAV95Jd02QMyUkEYU4VUAfNHpwRCatqUMlWY7n9WLBSJRG8kcl96/NzwCcsOmst/4olr+NfVxd
   jyiTosee4JjKuvyIe2vPFSeCEVC1Q6ZnylgAUEWybE3e21bZBNLqqy13TwmNw+z9TIFHdM6Hq2ub
   mxFd7J9TW/BpF3n+y8TG/O+g2lYcEgXlRvnyeQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=biharhotel.com;
 b=di+tu/RAVTiKSDcKTzGsd8UcqYMjAmw9l3rzi8anJx0rplCLCAjgABqDePDk+MM/PXlbK0HSbvdM
   BMUMGGmpdEWEm7yslSoZ7XgECidmUXaKVxlpVw2O96RoIc9e/OJ5nD5Et0+nNLuGMdKf8hjUnZ7+
   Au6feI/8mMcYjQqXR9XdSIpnsQ5wTTsOsfXJSz+n5hhVaeF/EjHLLAU/xrNWCgr9Wka/nmrbdUJa
   6WNGe+5NrUFQDRfoLajx6B0Jt9GZdUoB2kyEZH4hv0hIL/jFkl/JaftK9gyKnscnyAFfftc244Ie
   Nec611StQh/w6A3bCHuoW26/Cy8PQb3HGct5oA==;
Reply-To: bradleywrubel@scotfoundation.org
From:   "MACKENZIE SCOTT (Scott Foundation)" <mar.veg@biharhotel.com>
To:     linux-kernel@vger.kernel.org
Subject: CONGRATULATIONS...
Date:   17 Apr 2022 02:03:05 +0200
Message-ID: <20220417020305.ADB59FCC7B30314C@biharhotel.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        NIXSPAM_IXHASH,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_US_DOLLARS_3 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?194.31.98.11>]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 T_US_DOLLARS_3 BODY: Mentions millions of $ ($NN,NNN,NNN.NN)
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 RCVD_IN_MSPIKE_L4 RBL: Bad reputation (-4)
        *      [194.31.98.11 listed in bl.mailspike.net]
        *  3.0 NIXSPAM_IXHASH http://www.nixspam.org/
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blacklisted
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm Mackenzie Scott, Ex-wife to Jeff Bezos (Amazon Founder and=20
CEO). I'm donating $4 billion to charities, churches, individuals,=20
colleges and businesses across the Globe from Scott's Foundation to=20
provide immediate support to people and businesses suffering=20
economically from the impact of COVID-19 pandemic and the ongoing=20
war in Ukraine. Your email emerged as one of the lucky winners=20
after an electronically conducted ballot process.

I have a donation grant worth $8,500,000.00 Dollars for you. You=20
are to contact Mr. BRADLEY WRUBEL for more information if you're=20
interested.

Mr. BRADLEY WRUBEL
bradleywrubel@scotfoundation.org

Congratulations.

Yours Sincerely
Mackenzie Scott
The Scott Foundation
P.O. Box 1513
Los Gatos, CA 95031-1513
USA.
