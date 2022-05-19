Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8652C8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 02:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiESAoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 20:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiESAnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C419320E;
        Wed, 18 May 2022 17:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8448617AD;
        Thu, 19 May 2022 00:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C882C385AA;
        Thu, 19 May 2022 00:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652921029;
        bh=r+yZah9FzgvFzwWr+6axQypA2eebbBbzY/xbwtsywMI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=repoD+EMeddl3q21RJI8JTj5L6NBhqRi9u5wfUc3roRe5gKa/SGuX2NAlyNSvZE6v
         YX078+2xbZEQ/+Es+568i0I7ZO/BKg572l0K6eIyeddEYLVGU06btO05eSXH7QKcq6
         /Rnvu2J2oPRYAscYP1M+QglzxLmSu69vSjUKVPyteU8xQng5b/oXBi7D0UbU9W/6IZ
         fQ0O88flzGQcY7Zv9/jNn/j8KSHAZEQuLSCJsmAG6e5vcxENW5AValOmW6tGiSsZOn
         MJvgEXeePqd25sUaBq1xTP7sTmqVBqpMbdhVVbn4SjAsaGT/7vSDM6b079SxYwvJ6Q
         l1cHxR2dxFsmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220505025457.1693716-2-bjorn.andersson@linaro.org>
References: <20220505025457.1693716-1-bjorn.andersson@linaro.org> <20220505025457.1693716-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 May 2022 17:43:47 -0700
User-Agent: alot/0.10
Message-Id: <20220519004349.3C882C385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-05-04 19:54:56)
> Add binding for the Qualcomm SC8280XP Global Clock controller.
>=20
> The clock-names property is purposefully omitted, to clearly communicate
> to the writer (and reader) of the DeviceTree source based on this
> binding that the order of "clocks" is significant, in contrast to
> previous GCC bindings.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
