Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3C4BACDA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbiBQWoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:44:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiBQWo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:44:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2C169233;
        Thu, 17 Feb 2022 14:44:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D4DB82486;
        Thu, 17 Feb 2022 22:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62509C340E8;
        Thu, 17 Feb 2022 22:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137851;
        bh=hhqgD1Ns9JQAtTE82aJpvI4BqQ3WbOUg7da+cntYR1o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V0zUiCx3XPSYXyanhhuV15ugEAtMlqHVyvnhZdyELW8BsdldNrShZC2cnNQ9rrHKm
         V+0SGUKAe3MG9jXk3bMfPagXpNqGXapSjKWYFAVrQOIiMkXDmqc7rg4DgMgmm2TkXf
         +4eBsI1/XOvQOesSMLgHXeH5jJ3LdKBqSizQce2BtpTZvjyCUfVMfqAPnJOQLya/HR
         jGHXwl6EdLcRAkkLM73cqNz0Grlvo8SZzOeu8izXGGhQLY5It/Hw8DPKs0GDo3PW6X
         rrK1cb0NqbnBB3zW5CbFsnQFCpuiIboQGK/XsUGgj92gQO/trzmKJv8DT42t1L/tSb
         vq4BrjPr9i8Lg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220202183528.3911-1-tdas@codeaurora.org>
References: <20220202183528.3911-1-tdas@codeaurora.org>
Subject: Re: [PATCH v1 1/4] clk: qcom: sc7280: Update clk_init_data to const for GCC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Thu, 17 Feb 2022 14:44:09 -0800
User-Agent: alot/0.10
Message-Id: <20220217224411.62509C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-02 10:35:25)
> Update clk_init_data to const and also use index instead of fw_name for
> global clock controller.

Yes but why?

>=20
> Fixes: a3cc092196ef6 ("clk: qcom: Add Global Clock controller (GCC) drive=
r for SC7280")
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

I guess this supersedes the singleton patch? Can you please send a cover
letter for multi-patch series?
