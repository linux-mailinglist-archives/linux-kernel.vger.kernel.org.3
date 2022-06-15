Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91D454CF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbiFORRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiFORQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:16:58 -0400
Received: from challenge-bot.com (challenge-bot.com [IPv6:2602:fffa:fff:108a:0:16:3e15:92b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A935DCD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=challenge-bot.com; s=20180430; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=55zlIXYUbXtl7SzLvjogB+Y/GM8hMsZIeb8tJz2Oe34=; b=hXAMuF2mpiGaDpCI4b8UN/cMF
        o043XI0B1Kmt7pX/TbIu6T4bD0fi8IcZC1jepmJgb7j/5AgGKcniMkcuUf2oDnfHXmaCua51ojOJt
        w+7r+gc21aSH9je0r3tfij1Rx/vOi3EtXEPDnJbPAaoLTImJMCM1+uqjcJ1v3w7/bESnQ=;
Received: from ozzloy by challenge-bot.com with local (Exim 4.92)
        (envelope-from <ozzloy@challenge-bot.com>)
        id 1o1WdQ-0005eO-Qg; Wed, 15 Jun 2022 10:16:52 -0700
Date:   Wed, 15 Jun 2022 10:16:52 -0700
From:   daniel watson <ozzloy@challenge-bot.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] call rtw_IOL_append_*_cmd directly
Message-ID: <YqoUBIPfaW1lf4UK@challenge-bot.com>
References: <cover.1655249804.git.ozzloy@challenge-bot.com>
 <20220615083715.GM2146@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615083715.GM2146@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:37:15AM +0300, Dan Carpenter wrote:
> On Tue, Jun 14, 2022 at 05:49:24PM -0700, daniel watson wrote:
> > From: Daniel Watson <ozzloy@challenge-bot.com>
> > 
> > This patchset calls the rtw_IOL_append_*_cmd group of functions
> > directly and removes the #define wrappers.
> > 
> 
> Looks good, thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
>

Thanks!  I noticed a typo in the first commit message.
I'll send a v3 to fix it.
