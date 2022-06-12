Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B888547A14
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiFLMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiFLMYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:24:01 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2BB4D267
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:23:59 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A3306C01D; Sun, 12 Jun 2022 14:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655036638; bh=h2RHYSByEU5eRTPDXbysP2Dge1dTMEpexMMRrlnjQtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBMbff3imYxiandiIfSWCWx/mqkIvMSlzbeAOgFOKlZkolTI1EF8WXZCMJBW8rbRd
         ydOUY8dEizMhu7EI1GNmiX2q9AcRj0hVZwQ5kGc7vs9RQ1pBc6owUcQF34kbJZcOUZ
         dmRoK/s34Nzw01ILzF5KhlStpiLr2glSb3wplBRpvbBnwUU9biRQDgD3yFI0tfpLc+
         XvuOxsU2AFtgVqILaByd5xCqfik2M+JKWoqThwi8klRezIMr6bBCu96AYUWAd/UDC1
         AIjzLD2qhxpeU8CYHg25uYskszdQp2p8N3SsWZmhcRzJdSxMz4pyoLqWbWf1LWwWts
         JH4o412dyjIFg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C388FC009;
        Sun, 12 Jun 2022 14:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655036638; bh=h2RHYSByEU5eRTPDXbysP2Dge1dTMEpexMMRrlnjQtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBMbff3imYxiandiIfSWCWx/mqkIvMSlzbeAOgFOKlZkolTI1EF8WXZCMJBW8rbRd
         ydOUY8dEizMhu7EI1GNmiX2q9AcRj0hVZwQ5kGc7vs9RQ1pBc6owUcQF34kbJZcOUZ
         dmRoK/s34Nzw01ILzF5KhlStpiLr2glSb3wplBRpvbBnwUU9biRQDgD3yFI0tfpLc+
         XvuOxsU2AFtgVqILaByd5xCqfik2M+JKWoqThwi8klRezIMr6bBCu96AYUWAd/UDC1
         AIjzLD2qhxpeU8CYHg25uYskszdQp2p8N3SsWZmhcRzJdSxMz4pyoLqWbWf1LWwWts
         JH4o412dyjIFg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1e40d947;
        Sun, 12 Jun 2022 12:23:52 +0000 (UTC)
Date:   Sun, 12 Jun 2022 21:23:37 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [martinetd:9p-next 11/13] ERROR: modpost: "p9_fid_put"
 [fs/9p/9p.ko] undefined!
Message-ID: <YqXayRpfhqMwUjXe@codewreck.org>
References: <202206122057.RBESqurT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202206122057.RBESqurT-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot wrote on Sun, Jun 12, 2022 at 08:18:10PM +0800:
> >> ERROR: modpost: "p9_fid_put" [fs/9p/9p.ko] undefined!
> >> ERROR: modpost: "p9_fid_get" [fs/9p/9p.ko] undefined!

Thanks, I had this fixed in my tree and in the patches I submitted to
the list but forgot to update the branch.

(looks like this was caught before the linux-next merge at least, that
was helpful)

-- 
Dominique
