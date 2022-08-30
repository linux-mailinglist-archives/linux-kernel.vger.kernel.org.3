Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A35A71F0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiH3Xit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiH3Xig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:38:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A71B117;
        Tue, 30 Aug 2022 16:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D862B81E2A;
        Tue, 30 Aug 2022 23:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E82C433D6;
        Tue, 30 Aug 2022 23:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661902712;
        bh=74pUL4kJX+AtHciLgWbE8X0HyPiBGgkY6vXdgWzpbs8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r8uQ97wxFv39UPZFANKiXA984ToDpwqrnaIaGbOwiQ37LhKkqRDUWUFAeCS2RBFWo
         sPIo7Uqxk07Tz2ivrbaQueY3qW2QASTNsLZeXx73qVEUCJCzmGfUaZLdBYAATRuZNW
         3fBx6NswjbPV1aZnhPGR16v1fFZHe+kaqmXkOXak1/RYNVb/iCvIxqa+jmC6HZuzqH
         rhh/rG54XbP67KA2wVs+Pf4ryBPsVEAh6MUZ1KIrBpKnA3/JmvRnekdCPOV2Vdsec5
         kLqmopGB28498TMWjFGAqq33Hj0rlYVLrJlM3h6+4FM1cGozlRVLHArXI17dJGQOiq
         8NgEy7v9nLYUA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-10-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-10-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 09/10] spmi: pmic-arb: make interrupt support optional
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        David Collins <collinsd@codeaurora.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 Aug 2022 16:38:30 -0700
User-Agent: alot/0.10
Message-Id: <20220830233832.D2E82C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:45)
> From: David Collins <collinsd@codeaurora.org>
>=20
> Make the support of PMIC peripheral interrupts optional for
> spmi-pmic-arb devices.  This is useful in situations where
> SPMI address mapping is required without the need for IRQ
> support.
>=20
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>

This needs a binding update so that interrupt-controller is forbidden
when the device doesn't support it.
