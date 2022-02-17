Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07504BAD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiBQXHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:07:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBQXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:07:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD1AEF38;
        Thu, 17 Feb 2022 15:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99B15B8236F;
        Thu, 17 Feb 2022 23:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383F6C340E8;
        Thu, 17 Feb 2022 23:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645139220;
        bh=5yB+KImF9YCE+5F+LGd6a0+llDKf0TdeVqxMDqDDiyY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZceRAGx3nbedxrMs5+Afktc3NmF9iFGamK6WfiG+RvL8NmTLtJOVaB1ZZao0pQkOo
         3F8TknNo/+nqXt73Zghtc7Ybj3keBHxiPG953MYTMjlkrWaQIDOVcJW8lznTBM/EN5
         cxjMJgSREPepj0HMBumiqrFtGEnT1kVnubXeppXkOejxIPhqNGBpfb3ctZs/2T9jvz
         pVaNeOspY4JH27pHC0rvuADyEzDOGWJgqGUj4ryM8O7IeeOATGS9K/2z9222b3aX/I
         ZUSPZDVErjvDBZ+22/y5iJBnam//qTEKPcCuhkDrmP++iW+CADq8vnKZI/rj0t6grO
         kodJz0P6mz10Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220202172540.2458-2-tdas@codeaurora.org>
References: <20220202172540.2458-1-tdas@codeaurora.org> <20220202172540.2458-2-tdas@codeaurora.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: clk-rcg2: Update the frac table for pixel clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 17 Feb 2022 15:06:58 -0800
User-Agent: alot/0.10
Message-Id: <20220217230700.383F6C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-02 09:25:40)
> Support the new numerator and denominator for pixel clock.
>=20
> Fixes: 99cbd064b059f ("clk: qcom: Support display RCG clocks")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>

I guess the previous patch is to make this patch work? Please mention
that in the first patches commit text.

> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
