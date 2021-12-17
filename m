Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E74E4790D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhLQQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:00:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43300 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbhLQQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:00:36 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BHG07fH050996;
        Fri, 17 Dec 2021 10:00:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639756807;
        bh=o5FZZyggvdui1CUzq3pJk4FxP/aLklXa6J5Z54yqBDI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=cxGjYcsyyWWl8cRp4hi4RvvI9IPyl9TiOu2hgpw99b6K+y69rnesv6KglLhz3hKem
         vii1YKQzR0PPoAG0HtiwfvegB+pMYkfWNZ3T8CYJbB/8kvRX7gv/zbhtGNdyh7WT/2
         TezQp/ztI7ivfqKL+utM0uOSUI5pMVaWz543B2OY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BHG07BB034596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Dec 2021 10:00:07 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Dec 2021 10:00:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Dec 2021 10:00:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BHG07BW075506;
        Fri, 17 Dec 2021 10:00:07 -0600
Date:   Fri, 17 Dec 2021 10:00:07 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC:     <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] soc: Keystone driver update for v5.17
Message-ID: <20211217160007.etfr5urg76j2n5sf@reissue>
References: <20211217154921.cagzppcensxx6wm4@pension>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217154921.cagzppcensxx6wm4@pension>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:49-20211217, Nishanth Menon wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver-soc-fixes-for-v5.17


uggh.. Could have been tags/ti-driver-soc-for-v5.17 mostly fixes threw
my thought off a bit there.. - Do let me know if you folks prefer it
as ti-driver-soc-for-v5.17 instead of ti-driver-soc-fixes-for-v5.17
and I can retag and respin the PR..



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
