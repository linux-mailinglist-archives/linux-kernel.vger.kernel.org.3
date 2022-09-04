Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F32A5AC4F5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiIDPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIDPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:23:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB731DD8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 08:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 837E3B80D90
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 15:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C03C433D6;
        Sun,  4 Sep 2022 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662305036;
        bh=IUGYHmtAUfAccRR1FbzpWQzSqcWDUTuXiOiqyYMbwm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmI6XA26LGv7twEb1KC8RRUcQw/fkcoY+bq2QO/eg75ajxcW7D3f7ywPUlL0/xuxs
         Mth5VfJmaE4tuWeXGSGR5odChRumnuzs/AbJSu7nGzMtF9gW3TT6Dy1wzhIaFa+k6E
         bu/QYOm7qvtjuczNmt0zJehOPw8I0DUdTN4h6+BpNIGiQ+4WWEMsCZsuoK0QK/FweU
         1AIV+GzPn+9uXgzcjb1IP7lorrSN5fsJdVGJ6b3I+/f9g07C+Y1B8A0XK1+Ptd1rC8
         twFPNRteXX8rWj0nnR+OJ/JDV+7XNE7l5gbV3yosG5hVAgULPsvtbu9aP0BLnt72c1
         aFp+94aDauaeQ==
Date:   Sun, 4 Sep 2022 20:53:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Samuel Holland <samuel@sholland.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] phy: rockchip-inno-usb2: Return zero after otg sync
Message-ID: <YxTDBpkllQjf0nIW@matsya>
References: <20220902184543.1234835-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902184543.1234835-1-pgwipeout@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-09-22, 14:45, Peter Geis wrote:
> The otg sync state patch reuses the ret variable, but fails to set it to
> zero after use. This leads to a situation when the otg port is in
> peripheral mode where the otg phy aborts halfway through setup.  It also
> fails to account for a failure to register the extcon notifier. Fix this
> by using our own variable and skipping otg sync in case of failure.

Applied, thanks

-- 
~Vinod
