Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F064E6BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357181AbiCYBMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348172AbiCYBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:12:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996AABD2CC;
        Thu, 24 Mar 2022 18:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44D94B82708;
        Fri, 25 Mar 2022 01:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF2BC340F5;
        Fri, 25 Mar 2022 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648170669;
        bh=XXJwdKbRIPQqpbw+XXIDq31nnyqfGTKaTl41lSDbjsY=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=Wyki5ppwb91WYLWpHcQUdRos8EnsH/g/oBZMAnokevHMODXRrcMyeIJ23qcFW+eEE
         PcIwc9Yfr/nEB3PdFk01BEF8xYYuGDF5qBX42G9PQTot7kOTOmYuJtxASLm43CcuCK
         bEOvaaMPJ6owAgJ714UuFt1omSFLeasB651FM1xnCLhTTY/35hetiiFW0AhpuB2G9g
         G2bYu938g3QlXTt9PBnYgQOT8UslD59ClSbAgYLh8rQqESsTqM8cPNHjIfw496eY4K
         NRHq4cGPFS5GcG5lDr8dJTfpnSSoEe1MWfPp+TaA/w0IowVNc1JePuPyfDcUZfORHL
         j82Ok7lu4QW3g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220321231548.14276-3-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com> <20220321231548.14276-3-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 02/18] clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
From:   Stephen Boyd <sboyd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 18:11:07 -0700
User-Agent: alot/0.10
Message-Id: <20220325011108.EFF2BC340F5@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-03-21 16:15:32)
> Skip pxo/cxo clock registration if they are already defined in DTS as fix=
ed
> clock.

Why?

>=20
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
