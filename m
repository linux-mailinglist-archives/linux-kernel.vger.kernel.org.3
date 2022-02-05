Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6104B4AA620
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 04:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379129AbiBEDD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 22:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiBEDD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 22:03:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3397C061346;
        Fri,  4 Feb 2022 19:03:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8242060C17;
        Sat,  5 Feb 2022 03:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF26FC004E1;
        Sat,  5 Feb 2022 03:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644030235;
        bh=B779VCbNhc940fOx/ZsWJA+XO5L+RfvVX2YwUFvKb/0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NU5XRUF2wnZPyDh8CjvW69c1iV1XyW1i0aVTY+koKIiQJN6rzXd/VDdh68XXSqhsg
         /kO+LHNQZueeOydiUnzAnm/LtZ6dSizWkEZDr9ZxWSZno7Iz+YY63xd3PemcoqQz4A
         uW6TKEY29XGJ4pRnga+/zDNOgCVXDUZym3kI16aNlTFFFyxT4g9M6Adh3CVHtlPA1S
         FWFf7zg43fUs6vY9qowJtoTOnaF0TOi9vHX3AxO/7MHSLA6rqvkcUSJjiWn6EjNSNH
         awx4ZHrAxMGDOBX+p8TQnoK+ZqlIlW7SJYkzx07yDIGsRrDBx+YSgTtbi6Z6LF7Y79
         BTy4M+9uZ3Vug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YfmtxA7fCmbBWK0Z@Ansuel-xps.localdomain>
References: <20220121210340.32362-1-ansuelsmth@gmail.com> <20220121210340.32362-11-ansuelsmth@gmail.com> <20220125204555.91DB4C340E0@smtp.kernel.org> <61f065b9.1c69fb81.ed14d.b9e2@mx.google.com> <20220125221825.D9B78C340E0@smtp.kernel.org> <YfmtxA7fCmbBWK0Z@Ansuel-xps.localdomain>
Subject: Re: [PATCH v3 10/15] drivers: clk: qcom: gcc-ipq806x: add additional freq for sdc table
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>
Date:   Fri, 04 Feb 2022 19:03:54 -0800
User-Agent: alot/0.10
Message-Id: <20220205030355.CF26FC004E1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-02-01 14:01:40)
> On Tue, Jan 25, 2022 at 02:18:24PM -0800, Stephen Boyd wrote:
> > Quoting Ansuel Smith (2022-01-25 13:03:52)
> > > On Tue, Jan 25, 2022 at 12:45:53PM -0800, Stephen Boyd wrote:
> > > > Quoting Ansuel Smith (2022-01-21 13:03:35)
> > > > > Add additional freq supported for the sdc table.
> > > > >=20
> > > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > > > ---
> > > > >  drivers/clk/qcom/gcc-ipq806x.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gc=
c-ipq806x.c
> > > > > index 77bc3d94f580..dbd61e4844b0 100644
> > > > > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > > > > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > > > > @@ -1292,6 +1292,7 @@ static const struct freq_tbl clk_tbl_sdc[] =
=3D {
> > > > >         {  20210000, P_PLL8,  1, 1,  19 },
> > > > >         {  24000000, P_PLL8,  4, 1,   4 },
> > > > >         {  48000000, P_PLL8,  4, 1,   2 },
> > > > > +       {  52000000, P_PLL8,  1, 2,  15 }, /* 51.2 Mhz */
> > > >=20
> > > > Why the comment and fake rate? Can it be 51200000 instead and drop =
the
> > > > comment?
> > >=20
> > > I will add the related reason in the commit.
> > >=20
> > > We cannot achieve exact 52Mhz(jitter free) clock using PLL8.
> > > As per the MND calculator the closest possible jitter free clock
> > > using PLL8 is 51.2Mhz. This patch adds the values, which will provide
> > > jitter free 51.2Mhz when the requested frequency is 52mhz.
> >=20
> > Sounds like this clk should use the round down clk_ops instead of the
> > round up ones. Then the actual frequency can be in the table.
>=20
> Some hint on how to do that? This use the rcg generic ops that doesn't
> use any round. Should I crate some special ops in the rcg driver to
> implement the round ops?
>=20

Use the clk_rcg2_floor_ops, or if this isn't an rcg2 clk, then make a
duplicate clk_rcg_floor_ops that does the same thing.
