Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9954BF27C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiBVHMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiBVHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:12:53 -0500
Received: from smtpbg587.qq.com (smtpbg587.qq.com [113.96.223.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865CEBAFF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:12:24 -0800 (PST)
X-QQ-mid: bizesmtp85t1645513927t16oxsxy
Received: from localhost.localdomain (unknown [223.80.100.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 22 Feb 2022 15:12:06 +0800 (CST)
X-QQ-SSF: 0120000000000040B000B00A0000000
X-QQ-FEAT: NTS5Yb/oJHvoVHZCmsX9G9T5Gt7huud0SMOYOSnKw76UQdIjkDZYrYEz2bzlj
        wLbiyD72pPy5MZyMs4nNm6X/Qg6xIl6zaPKnTb6tLscug+5E8P64QoyqhIvovZdHNiuP1+K
        Up2PtffxapGW947GyIwun+vXI4gPiPdMHINDNWujRTGx4wJF754mplnUfMq4qw44HvRIV+Q
        qxsFcAe8dDMbNEX2h03kHNI2amLqTJElw0aoO0Upq1UjumcLk8GxrwLwL97hKS0MuNys7FO
        PnnFHKXejoHBNgqmz49smMjAW5C7yvqotUqr9+h/j1v5rB
X-QQ-GoodBg: 0
From:   Jialu Xu <xujialu@vimux.org>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, corbet@lwn.net, rkovhaev@gmail.com
Subject: Re: Re: [PATCH] scripts/tags.sh: parse *.dts.tmp for compiled sources
Date:   Tue, 22 Feb 2022 15:11:26 +0800
Message-Id: <20220222071127.1956675-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAK7LNAS=zPm6XxoUK=CQAiX6_0DbGtWY=kLG5nDQCPtfV36rQg@mail.gmail.com>
References: <CAK7LNAS=zPm6XxoUK=CQAiX6_0DbGtWY=kLG5nDQCPtfV36rQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybgspam:qybgspam3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > There are files listed in *.dts.tmp, parse them as *.cmd for compiled sources.
> >
> > Signed-off-by: Jialu Xu <xujialu@vimux.org>
> > ---
> 
> Why?

Seems that i had a misunderstanding of this, the purpose of this
function is to generate tags but not a file list, and files that
this patch can get additionally are some device tree sources, so
this patch is probabily not necessary. Sorry.


