Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA54518D18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbiECTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiECTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70EE3FBE9;
        Tue,  3 May 2022 12:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8292461948;
        Tue,  3 May 2022 19:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBE0C385A9;
        Tue,  3 May 2022 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651605543;
        bh=S8r5AHZucns0I0daOUq3N1CwlE3hsFkxc7yh810nreU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bw7HNipUWvVQAmvSfBp+4cNCpONzg66Mq1gQNQ1prwJNza4BP4VwA3t/aa5GPcgRB
         sVRPbpX79XPIyPz+bStoZlAd7Sw7PfahlxgrobOEv1p9Jns47R9sq5agA+sl+6JFmr
         47vTxkOikFB8RorCnPnwDErJhafnBK5RgzY0wozNRFPsZRTetA43tp2aTq8RPDBmh+
         mZUfFXlxuIvtp5aPGTP114yS1MuAlj+l4XRYURX6Q6iqxF9W2UbYE6g/hQ1//O/mv/
         fY6o211mifvZ3feH/y5R9c+alyEuJlclmSheeomx16sskw7+5vs+z5VL8VVJgecemo
         le9lipnnV6bkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YmrnMQwIR9wOeoKE@ripper>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org> <20220423014824.912ACC385A0@smtp.kernel.org> <YmNsYSxLtwLpw98t@ripper> <20220423031350.01299C385A0@smtp.kernel.org> <YmN11qt/PqogYruQ@ripper> <20220425223426.BE973C385A4@smtp.kernel.org> <3fb043e6-2748-24f8-0115-b5372c747a12@linaro.org> <Ymq6UOjrYgFlzl/W@ripper> <CAA8EJpqBMzTNjTSWN1UMXM61-DmW22RKQJyWoMw3Rds=xEVQaQ@mail.gmail.com> <YmrnMQwIR9wOeoKE@ripper>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 03 May 2022 12:19:01 -0700
User-Agent: alot/0.10
Message-Id: <20220503191903.CEBE0C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-28 12:12:49)
> On Thu 28 Apr 09:24 PDT 2022, Dmitry Baryshkov wrote:
>=20
> > > >
> > > > And actually might I suggest an alternative approach to manually us=
ing
> > > > indices everywhere? What about spending the time once during the bo=
ot to
> > > > convert .fw_name and clock_names to parent indices during clock reg=
istration
> > > > and then using them for all the further operations?
> > > >
> > >
> > > I'm pretty sure that's what clk_core_fill_parent_index() already does.
> >=20
> > In this case I think we should go for clock-name in the DT and
> > auto-flled indices inside. Stephen, WDYT? Would that fix your concern
> > for comparing strings each and every time?
> >=20
>=20
> You mean, just continue doing what we've been doing lately with fw_name
> etc?
>=20
> That lookup is the one that Stephen wants to avoid.
>=20

Right. Translating .fw_name to indices isn't a solution because I want to=20

 1. Reduce the number of string comparisons

 2. Shrink the kernel's data section by removing strings

and having there still be strings works against both points.
