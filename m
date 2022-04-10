Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DED4FAF2B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiDJRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiDJRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:10:13 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB911C14
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 10:08:02 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id D73DD22FA7;
        Sun, 10 Apr 2022 17:08:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 27B8520019;
        Sun, 10 Apr 2022 17:07:59 +0000 (UTC)
Message-ID: <783d850ce7778e9d8f203155034e432910553b1b.camel@perches.com>
Subject: Re: [PATCH 1/6] staging: r8188eu: drop unnecessary wrapper
 rtw_free_cmd_priv
From:   Joe Perches <joe@perches.com>
To:     Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Date:   Sun, 10 Apr 2022 10:07:58 -0700
In-Reply-To: <20220410163117.3964-2-makvihas@gmail.com>
References: <20220410163117.3964-1-makvihas@gmail.com>
         <20220410163117.3964-2-makvihas@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 27B8520019
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: izm1rq8p4turfu5zpncoxejchtfie6ou
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/lClx2oPpr4EGHJAsyxoihyxirHS6hFEk=
X-HE-Tag: 1649610479-746718
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-10 at 22:01 +0530, Vihas Makwana wrote:
> Remove the unnecessary wrapper. The logic of rtw_free_cmd_priv can
> be moved to _rtw_free_cmd_priv.

If you are going to drop wrappers, my preference would be
to drop the underscore prefixed ones.


