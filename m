Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079853535E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347376AbiEZSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345184AbiEZSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B17764BCB;
        Thu, 26 May 2022 11:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FEA617DA;
        Thu, 26 May 2022 18:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD5BC385A9;
        Thu, 26 May 2022 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653589992;
        bh=YhhHIgcOKVT8ssjKTlxdBesw5tuPoPTkFl/PGzHIC7w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aza/knjdjYV+OgAtCe7UK2GPM86hH9zAY7u8nzNRl3Lm8sreIyDA9AOjAvKTsYPzL
         q/iPrkLZEra/Tlf1NfjneSICIhdP+xunUpekq9CVjeGXfiCmT4w4P+0gPEiKESKhqA
         F77W/8wS0oNoyztFviEAGkM65Nrw5Hdu6Tv46+UJoCnWj9b2jfDlz53/vX4HjzS+TC
         MXhjjMDegSBcNFO6gnH2FYdUexkeOQX3SLXzgxaeaCSyoiPPUFO71uoypg84c2CfgK
         eEjKHKQCNJ0O+q5nNEDVVIxJ0Yhd3prNGslguFT9yn0vVn6oHelhGKDrgSzKnctQ0c
         //s9YPBYoqbhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YotUwhIrwlSXH6Ak@hovoldconsulting.com>
References: <20220520100948.19622-1-johan+linaro@kernel.org> <20220521035111.A94B7C385A9@smtp.kernel.org> <YotUwhIrwlSXH6Ak@hovoldconsulting.com>
Subject: Re: [PATCH 0/3] clk: qcom: gdsc: add support for collapse-vote registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tdas@quicinc.com,
        quic_rnayak@quicinc.com
To:     Johan Hovold <johan@kernel.org>
Date:   Thu, 26 May 2022 11:33:10 -0700
User-Agent: alot/0.10
Message-Id: <20220526183311.EDD5BC385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2022-05-23 02:32:50)
> On Fri, May 20, 2022 at 08:51:09PM -0700, Stephen Boyd wrote:
> > Please add Qualcomm on code for their hardware :)
> >=20
> > I did a translation from codeaurora but I don't know if Rajendra's will
> > work.
>=20
> These addresses need to be added to .mailmap.

Patches welcome :)

>=20
> > Quoting Johan Hovold (2022-05-20 03:09:45)
> > > Recent Qualcomm platforms have APCS collapse-vote registers that allow
> > > for sharing GDSCs with other masters (e.g. LPASS).
> >=20
> > How is it different from the voting logic that already exists in the
> > gdsc file? Now every subsystem has to vote for off in addition to voting
> > for on?
>=20
> No, the voting logic is unchanged (i.e. enabling by clearing a collapse
> bit).
>=20
> The difference is just that a separate register register is used for the
> voting.
>=20

Ok. Got it.
