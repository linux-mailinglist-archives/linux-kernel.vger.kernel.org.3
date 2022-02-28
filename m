Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1254C704F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiB1PJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiB1PJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:09:50 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0555532D4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:09:09 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21SF8rYG064262;
        Mon, 28 Feb 2022 09:08:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646060933;
        bh=kj1qA05v2AGqLoUp6CmooBJw+K7QqgiXXWeiU0iop18=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=P9vZEhgZQ0olwUCwg2K1aU7ORzLxaprkpGrV9JZCVKEnHMdeRzc87mJOGUIPag7Z8
         wFYW0c96Yt4DN9hkcuOLYmyMEEURC2J8VCTSvVY7ZbXvwJcwlZwWKvYooQ0vobX0+/
         5pte/wzDG/mV87PHN4iHcUhYGAb64XLYpmknhqOM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21SF8rP3027020
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 09:08:53 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 09:08:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 09:08:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21SF8rEV105074;
        Mon, 28 Feb 2022 09:08:53 -0600
Date:   Mon, 28 Feb 2022 09:08:53 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [GIT PULL 2/3] TI K3 defconfig updates for v5.18
Message-ID: <20220228150853.fuymvwutymtkmswu@gondola>
References: <20220228120704.346bn5c56e53qylb@finless>
 <CAK8P3a1PW8afbjvsUNe2UHXBcQHxGXXPodYiK9AgfW-3tTQR0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a1PW8afbjvsUNe2UHXBcQHxGXXPodYiK9AgfW-3tTQR0w@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:41-20220228, Arnd Bergmann wrote:
> On Mon, Feb 28, 2022 at 1:07 PM Nishanth Menon <nm@ti.com> wrote:
> >
> > Hi ARM SoC maintainers,
> >
> > The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> >
> >   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-config-for-v5.18
> >
> > for you to fetch changes up to 3bc04fba357a269f4b7ff824b146d82ad1ebf9de:
> >
> >   arm64: defconfig: Enable USB controller drivers for TI K3 SoC (2022-01-24 13:40:42 -0600)
> >
> > ----------------------------------------------------------------
> > TI K3 defconfig updates for v5.18
> >
> > * Enable USB modules
> 
> It looks like I had this one applied already from the 5.17 submissions. My plan
> was to drop it all, but it looks like I made a minor mistake here. As
> the contents
> are identical, I'll just keep the old version.

Thanks Arnd.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
