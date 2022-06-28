Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8095F55E930
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346745AbiF1O1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbiF1O13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:27:29 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E04F2F03D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:27:28 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4498222246;
        Tue, 28 Jun 2022 16:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1656426446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHFbXd+WNtNIJszeKeAq0pw48IrQ1dnM0j78sJ1LNLI=;
        b=CT1XHrctn/p9QrSCpS0yYSjSmCtZ/F8BJDs5EhDC57YFKCtnE0lH9vNzjaDEpHUM7sXzrI
        HiLecE56ocS4JE0BIx06jXp+yzJatOIsntln1TlfUqUzqizz1rMVzIlLn/if3Uq13lWVj6
        N6iWnX086nc/79yXg2u4WAFqgky5EoA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jun 2022 16:27:23 +0200
From:   Michael Walle <michael@walle.cc>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, arnd@arndb.de, shawnguo@kernel.org
Subject: Re: [PATCH -next 1/2] soc: fsl: guts: fix return value check in
 fsl_guts_init()
In-Reply-To: <20220628140249.1073809-1-yangyingliang@huawei.com>
References: <20220628140249.1073809-1-yangyingliang@huawei.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <42601e860097651547fb9baecd660b5c@walle.cc>
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
> In case of error, of_iomap() returns NULL pointer not ERR_PTR().
> The IS_ERR() test in the return value check should be replaced
> with NULL test and return -ENOMEM as error value.
> 
> Fixes: ab4988d6a393 ("soc: fsl: guts: embed fsl_guts_get_svr() in 
> probe()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks!

Reviewed-by: Michael Walle <michael@walle.cc>
