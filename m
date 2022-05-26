Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F453535B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiEZSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347870AbiEZSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B665D5D9;
        Thu, 26 May 2022 11:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 715C361253;
        Thu, 26 May 2022 18:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F047C385A9;
        Thu, 26 May 2022 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653589939;
        bh=LavzREuF1tBDqZDmhtBOmA5kmgbGDHnLoBNXRB/bOWg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UPWHODL6WD+wVDG/+wJJUbQbbHn+mju0PBArKtmCuLzc7lHss/MTPDqV8oW3mAJIi
         oLWN99ts+wDm+XzUzmB2JqjSi0YB9999/o/idea9ody/aZ8FFFGFi3C70x/reAcihu
         einOpXoQJc0b9C9K5/KpYWKcw9rP93s4soh4chExJCGN1hEINRnEWlGDBK21dR0gZE
         VEt4dfYtMdm1Dpa6Hi7cYzlD67W7NriMEOlrtG0M7U4gXE7RpQ1iJMxt9JWD4UOAfX
         2Vh6tg/7OL1JpWVbIYXWHrMBTpWaqa4aGVYviqYWyW9bDp5EtlNz43NRjL/3TfhFJA
         8vD829Qv7i9bQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yot4XHaf6uHcJxTL@hovoldconsulting.com>
References: <20220520100948.19622-1-johan+linaro@kernel.org> <20220520100948.19622-3-johan+linaro@kernel.org> <20220521035228.1FD9AC385A9@smtp.kernel.org> <Yot4XHaf6uHcJxTL@hovoldconsulting.com>
Subject: Re: [PATCH 2/3] clk: qcom: gdsc: add support for collapse-vote registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Johan Hovold <johan@kernel.org>
Date:   Thu, 26 May 2022 11:32:17 -0700
User-Agent: alot/0.10
Message-Id: <20220526183219.9F047C385A9@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Johan Hovold (2022-05-23 05:04:44)
> On Fri, May 20, 2022 at 08:52:26PM -0700, Stephen Boyd wrote:
> > Quoting Johan Hovold (2022-05-20 03:09:47)
> > > Recent Qualcomm platforms have APCS collapse-vote registers that allow
> > > for sharing GDSCs with other masters (e.g. LPASS).
> >=20
> > Maybe just say 'with other subsystems' because LPASS is an entire
> > subsystem.
>=20
> The term "subsystem" is too broad and also has a different meaning in
> Linux.
>=20
> The vendor kernel uses "masters" here which is clear enough and
> presumably matches their documentation.
>=20

How about "voter"? Then it isn't confused with linux subsystems.
