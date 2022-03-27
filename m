Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F084B4E8A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiC0WEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiC0WEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:04:32 -0400
X-Greylist: delayed 1373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Mar 2022 15:02:52 PDT
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3671B794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:02:52 -0700 (PDT)
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 9B8CA7BA3D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 16:39:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YacAnZMTNRnrrYacAnnY0i; Sun, 27 Mar 2022 16:39:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zl66yGQLXnlbIrYYhPtA53tmGSepbA0ejTWrEOlsGgY=; b=wPHQSZCQcjgGbqyFBtR6FE+up2
        fN0m0R6zL5vNTD+8ndEtmMxTEI3BV00YU+wC6FXAHVCNf3c4IhEIjTjiZx3/JWG2AekRsxY3j4VXH
        uirILTXSyu7d4k5RBlUxr7o9ubBF0cM4as17mrEN9sGXg5PgNNDOuE+rd+Gd0eHaWKGng78XU5HxP
        2pGRLyt2ak6JQusLpYVCWK8Qv8O+GvXFxfhQs5TgpxNHyUqsr4/hCdevEUU7T0Y6i6zYFwKIBP/Ml
        4tzFZZT22r6O0HQ6TND0rOB7My+DHYhVr2fhhLLb6M/eaSgh4hq2F1ZGwYv+tTxBpOBvOIaxxhcgx
        eHFniVeg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:37142 helo=[192.168.15.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1nYacA-001q1P-Bs; Sun, 27 Mar 2022 16:39:58 -0500
Message-ID: <6a18d5fe-06ce-50db-81ca-a4f0669bd8ec@embeddedor.com>
Date:   Sun, 27 Mar 2022 16:48:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: Signed-off-by missing for commit in the kspp-gustavo
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220328082746.6a9470f9@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20220328082746.6a9470f9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1nYacA-001q1P-Bs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.9]) [187.162.31.110]:37142
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 3/27/22 16:27, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    e432da2a9c19 ("afs: Prefer struct_size over open coded arithmetic")
> 
> is missing a Signed-off-by from its committer.

I'll fix it up right away.

Thanks for the report!
--
Gustavo
