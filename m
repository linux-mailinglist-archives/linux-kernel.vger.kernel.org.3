Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594935A849A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiHaRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHaRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:40:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F67D7BE;
        Wed, 31 Aug 2022 10:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48240B82208;
        Wed, 31 Aug 2022 17:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF78CC433D7;
        Wed, 31 Aug 2022 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967621;
        bh=dTs5bMak26qMelsBKoMp9vwQizKxUYHbWJGtjAF9xVA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dQt4oQ8EuLwEz3CBd6VPUbqI00bS0VJLMffSMt0lYeXsHYUF4WJ1rvAjkAHmy41e/
         o06siC/QpgKpP7cQvENb6c3EAf3DjFr8pYiY58f6VKteZSHH2+uVRprT6JDpCdMGYq
         qG+Cew0GhftxQxWnlWsE4yakxN9Wyzs7RjOoYI4q1OmW0Y2+pss6iDM6bU4TNV0/wX
         +GKqaGYmJHfGuy7lK/j46E2lYKlnZsxsXtubBgRh8VoINFQ0atVHSMNUJ+I4JU96D7
         L1TWYAfb1L8iBXZjnuIT9bTeSg4Ldun4EcRDxrZdY6dRq7B0R8tmdF5m6ksFNb8IXq
         o6wuLo5xiHSpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-6-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-6-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 05/10] spmi: pmic-arb: add support to dispatch interrupt based on IRQ status
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        Ashay Jaiswal <ashayj@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:40:19 -0700
User-Agent: alot/0.10
Message-Id: <20220831174021.CF78CC433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:41)
> From: Ashay Jaiswal <ashayj@codeaurora.org>
>=20
> Current implementation of SPMI arbiter dispatches interrupt based on the
> Arbiter's accumulator status, in some cases the accumulator status may
> remain zero and the interrupt remains un-handled. Add logic to dispatch
> interrupts based Arbiter's IRQ status if the accumulator status is zero.
>=20
> Signed-off-by: Ashay Jaiswal <ashayj@codeaurora.org>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
