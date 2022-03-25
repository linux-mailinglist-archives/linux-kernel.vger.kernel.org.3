Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49B74E6C83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbiCYC0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbiCYC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:26:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D83B715C;
        Thu, 24 Mar 2022 19:24:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E786BB81D87;
        Fri, 25 Mar 2022 02:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D24AC340EC;
        Fri, 25 Mar 2022 02:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648175087;
        bh=W0F2Z3p5WAM8fTBOKDMDZFzxM3rAnJKqt6oovefK64k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gBARd777s6T2nNiwInnDZ80Vh4r6FjUzoGC7yk++50o/cO70nzX6bIf0NRqqQ5GQI
         hj6NJffEd0K45pOEiibjPGCNPM0O11VxCw79ZN/AQTw3vU3wqfakyZtA6ZAvc/ulhR
         zXMXwI3d50W4ADQ2GGYc7HM2QRpJzfP83FbJEGZ821MaSSfX8Cc9k8uxtigI1DOkDp
         ZrT/uRRCDRS1Y9p9MnMeFFsA37JlHCIVk1D5MiXq7Frd2Kx22URXzrUv8URL6nEPFT
         1TxHpc8sBCkUTEgjWj/IalfDag5ZE6N/gK1faPBu0x+6mGWI+OTpgarcu6Ga1xIpjG
         OVa9Uo+m7z/NQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220301190400.1644150-1-robh@kernel.org>
References: <20220301190400.1644150-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: renesas: Make example 'clocks' parsable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
Date:   Thu, 24 Mar 2022 19:24:45 -0700
User-Agent: alot/0.10
Message-Id: <20220325022447.9D24AC340EC@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2022-03-01 11:03:59)
> 'clocks' in the example is not parsable with the 0 phandle value
> because the number of #clock-cells is unknown in the previous entry.
> Solve this by adding the clock provider node. Only 'cpg_clocks' is
> needed as the examples are built with fixups which can be used to
> identify phandles.
>=20
> This is in preparation to support schema validation on .dtb files.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
