Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55C5793EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiGSHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiGSHN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D932BA9;
        Tue, 19 Jul 2022 00:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 205A1616B2;
        Tue, 19 Jul 2022 07:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55706C341C6;
        Tue, 19 Jul 2022 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658214804;
        bh=f0b/6Gq8XSz4gZwascnvxuyywScLfxOZ0x33lLTnggc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=q20HdPmGPOV4UZTZejW1hg87agGw1bWtvOtlP+EY4HfrCFVrKowcoLes3nelloR2F
         2JN8YlBcba8BuX8ad5ugcfi3cAqHQWWDX9+Kiv4kCiS11OATWWGVWHzpi+1i1C0lRp
         8mCcGukFxCCnJdLfx0+BL6orx4ITfoDJolwDEexGSicTqd1q7tUM5zACv00CtBnWYu
         5xaM1Vzy4eTSWHsXfuAmIBq4yNdERZ6Dz5C6livVw4nlEuuapkjv8B4xnSznRDyC++
         HjgFGMX1xGRMS4RKUjvi40VnWF/NapC7ujVfkmtQSqIzGXDTyAXggny0hppNdznsE7
         cLn3AK6pKf+bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220716192714.454031-2-konrad.dybcio@somainline.org>
References: <20220716192714.454031-1-konrad.dybcio@somainline.org> <20220716192714.454031-2-konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom: rpmcc: Add BIMC_FREQ_LOG
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Date:   Tue, 19 Jul 2022 00:13:22 -0700
User-Agent: alot/0.10
Message-Id: <20220719071324.55706C341C6@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2022-07-16 12:27:13)
> Add the missing definition for the aforementioned clock.
>=20

What does the bimc freq log do?
