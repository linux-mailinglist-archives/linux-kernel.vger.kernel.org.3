Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912555A213
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiFXTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:42:17 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCCF82684;
        Fri, 24 Jun 2022 12:42:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 87CD02A0;
        Fri, 24 Jun 2022 19:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 87CD02A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656099736; bh=JUzKm/L5+zBJhnDBfJre5xrFZKsQlVuNcD548RrRD30=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=C05qtDTf7xaJChqZyrJnaHvSj1ZDdMwHIkVgrnV5ZxcSj6YiHgZ2tQFgVJ6aVIB/2
         thsLPAgFf5fcuNfUrThUany9kToUE8krE7J8kTB1sjqHJxyjDDRwkA+IyH/qXyUDeC
         /kwd3gXU3dPHH8QPicZX5YQvKiEgPV7V15GsIxq/aNBbk47CVHF6BnlqN5eTGBmP40
         4f/QZJEVuuxBTuP9R5oaCbp0AHwHX75tzCc4Ih7jhm+MX7bpBocncZWsuRVdSFrxn/
         BdbmK1hbhisROqQ+6ioJltKHAHotSmGTAmtZl0E+QggBfT+4LJiTxBddDkPDfLbuMF
         OYI+8/4BMRc8w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wu XiangCheng <bobwxc@email.cn>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Cc:     Li Feng <felixlee868@icloud.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/kernel-hacking/hacking.rst to
 5.19-rc1
In-Reply-To: <Yp41+eTjoPRa4hrl@bobwxc.mipc>
References: <Yp41+eTjoPRa4hrl@bobwxc.mipc>
Date:   Fri, 24 Jun 2022 13:42:15 -0600
Message-ID: <87tu893l2g.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu XiangCheng <bobwxc@email.cn> writes:

> * update to commit f35cf1a59e9a ("Documentation: kernel-hacking: minor
>   edits for style")
>
> * fix a homophone typo reported by Li Feng
>
> Reported-by: Li Feng <felixlee868@icloud.com>
> Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> ---
>  .../zh_CN/kernel-hacking/hacking.rst          | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Series applied, thanks.

jon
