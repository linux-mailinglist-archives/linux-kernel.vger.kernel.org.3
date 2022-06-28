Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4655E6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbiF1O3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiF1O3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:29:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA423122E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:29:02 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6149022246;
        Tue, 28 Jun 2022 16:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656426540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpRKtZpFLktkgTbi7m0M2Z6Uxt/QW82l1sKys2neJSI=;
        b=tpeev2+k0VwkguJMzUXow/hE9mwgT6YIGphV0rguswqfC1KlbgkrV+R/nvNDq6k/j9benF
        uhP7vsQ6MP+MoW/2HUjS+56XWs1HG99Abmjc0jyqL0tR2fhMQ2JS8zT8vMEDfJlhuE1jCU
        /BmS4vN6wyRQbS/0J46mkeG1y9Cr98Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 16:29:00 +0200
From:   Michael Walle <michael@walle.cc>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, shawnguo@kernel.org
Subject: Re: [PATCH -next 2/2] soc: fsl: guts: check return value after
 calling of_iomap() in fsl_guts_get_soc_uid()
In-Reply-To: <20220628140249.1073809-2-yangyingliang@huawei.com>
References: <20220628140249.1073809-1-yangyingliang@huawei.com>
 <20220628140249.1073809-2-yangyingliang@huawei.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f7204602d78a5a077cfb7a0c91bde64a@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-06-28 16:02, schrieb Yang Yingliang:
> of_iomap() may return NULL, so we need check the return value.
> 
> Fixes: 786dde1e59d7 ("soc: fsl: guts: add serial_number support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Michael Walle <michael@walle.cc>
