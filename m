Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C716054D23D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbiFOUCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiFOUCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E7E0F8;
        Wed, 15 Jun 2022 13:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21A1361477;
        Wed, 15 Jun 2022 20:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C47C34115;
        Wed, 15 Jun 2022 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655323350;
        bh=N+ZxzuAjYb3UjX3opuYl3NmMcBi+WXp8I5IE22RDtvc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WMo83Yd+PudKCWpq2JtXborGZ16IJXhxW539k6fOGwFSB/H4yqipXZh4MA5fGVdzV
         CNZc2Ljyjli3Y+YEkg8HpzHb6hHbGG14PDXa4NPS9AE3w2rHJ8sNeAb6rZR6ab463b
         SVptpd4KGFJPk/YduIX7JWP+Zdi7VLbIUQrnmjqQH2GJkuQNwRF9YVAu5zYln5i1LC
         5LwQ5izAHYab4k7qKNyqYHsKxWrBJk+kzxZMaEeP1GioSfRXXDfgv2KzrLyKLmD71w
         gdZviit0AP9wS8eZzYXUBrhhUNpX0yq24NbZDlqk0pp8AEfBvEBUhH3GwbRQm9kVSw
         SUfDuAVe79uYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <62aa1dd0.1c69fb81.b9887.676e@mx.google.com>
References: <20220615163408.30154-1-ansuelsmth@gmail.com> <a92fe431-a995-4c7f-b90b-8e80298bc71a@linaro.org> <62aa1b41.1c69fb81.95632.5b71@mx.google.com> <717ad899-31ad-5e70-b299-ffb8ca287071@linaro.org> <62aa1dd0.1c69fb81.b9887.676e@mx.google.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Wed, 15 Jun 2022 13:02:28 -0700
User-Agent: alot/0.10
Message-Id: <20220615200230.72C47C34115@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2022-06-15 10:04:40)
>=20
> Ansuel is second name. Smith is not real... (sorry)
> So with extendend name I mean full name + second name that is
> Christian Ansuel Marangi.
>=20
> Honestly it's a very stupid mistake by me not using the full name from
> the start.

Please send a patch to the .mailmap file to fix up the name.
