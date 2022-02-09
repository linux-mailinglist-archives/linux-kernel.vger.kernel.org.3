Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8653C4AF4B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbiBIPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiBIPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:05:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B43CC06157B;
        Wed,  9 Feb 2022 07:05:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3E9EB81FFB;
        Wed,  9 Feb 2022 15:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3ABC340F0;
        Wed,  9 Feb 2022 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644419100;
        bh=UpmdKE+FAEUDCpd84WVrU8vXwvXmnS9fqkRQF7MlYCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fm1rscbSWAvPYky3Oqj0WI/wHkLlCW0gIRIW1OwQm0FHClPf7qKSFCZSVfWRflvdw
         Oyy5QlUX9fOMfv7BGGc9n6mAM1z55Z3nQrrmQH9+/Tyr/sFZ4hDce/QxucHDXt5n8M
         quPyW+qPgJ34SG2ogvhZsHSBpCfWK/adVn57CiBE4YGZt0W8Kez4CMPjkv2ZTZm+B9
         5ILSlNZ738PtuID6zbFs2YA0A61NHcGi8c4Q7JfMcCTqEUZS4S56o837ppmbfEe5Lf
         TPdf77Xjbv0fymxDYJk/ikFmtLbIdQMVB6NLl16mUpwTRXe15jb001/kzPTEs3Y9su
         6JP6nr2W8XC9A==
Received: by mail-ej1-f52.google.com with SMTP id y3so8275392ejf.2;
        Wed, 09 Feb 2022 07:05:00 -0800 (PST)
X-Gm-Message-State: AOAM531DJMg26kyQUJPwRC9UM79vdZZVIA/Xq1riDG2msvzMJJHMQM+/
        oU1YeqH90faO/v3EHmIfrjeTAhzSAhdFYs9x+g==
X-Google-Smtp-Source: ABdhPJzns7zVz28y4D67gQ8s0rvNVw71WOHhT2Jxl44ZXol/CnXKBDMw2ppS/LCgWhMeXpYI/2QuBDrlplZg3FK+frQ=
X-Received: by 2002:a17:907:6284:: with SMTP id nd4mr2329421ejc.423.1644419099004;
 Wed, 09 Feb 2022 07:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20220118135918.2126010-1-abel.vesa@nxp.com> <20220209065029.GA4909@dragon>
In-Reply-To: <20220209065029.GA4909@dragon>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Feb 2022 09:04:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7aa+3+xEWAzOpbwLu=Df7bqohdHVcWKWR-vafw3vpyg@mail.gmail.com>
Message-ID: <CAL_JsqL7aa+3+xEWAzOpbwLu=Df7bqohdHVcWKWR-vafw3vpyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP
 backwards compatibility
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 12:50 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Jan 18, 2022 at 03:59:17PM +0200, Abel Vesa wrote:
> > Drop the i.MX8QXP backwards compatibility with i.MX7ULP since they
> > differ from clocks handling point of view.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>
> I tried to pick up the patch, but it failed to apply to my imx/bindings
> branch.  Could you rebase?

Shouldn't Greg be picking this up?

Rob
