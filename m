Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF205A8497
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiHaRlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHaRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:40:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE93558C8;
        Wed, 31 Aug 2022 10:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F8A1B821EC;
        Wed, 31 Aug 2022 17:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B42AC433D6;
        Wed, 31 Aug 2022 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967611;
        bh=9ztMf0QApoGYD/I3tZXdcEdrV29sJmOB0xtjK5z6bUE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vIbg1JuXXQdM5g4fPUj5MtIUk5eCExYuzxoTVeEUPaaS40HcbpBDftvH5NA9s6Cab
         ghiXFIARcN2yRssEiEyPuPzHOR+D+yO9z5Rz0fzbXWWLMiC9XVTKIzl5GbqZEbzFCv
         FEV+KR4u+ozd2+ezqgneLcDIbWRoxX4FHsokerW2N1jHpG3QPJRp99OcE9gb4B6Ni9
         MKwbtmFfRJIAcuLpROjkelCjxnwgpSpw/sUPCo8Ey9gtTEfp/OmkRJ4nDc5c/MtUpG
         kJO0kNqRgV5FWgYpFcVbNFWpoWPk5GjpIJ0+djMWeEyeLn/ugkx0tnT/xciijn0SNN
         qPWezkucFrijQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-5-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-5-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 04/10] spmi: pmic-arb: check apid against limits before calling irq handler
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        David Collins <collinsd@codeaurora.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:40:09 -0700
User-Agent: alot/0.10
Message-Id: <20220831174011.1B42AC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:40)
> From: David Collins <collinsd@codeaurora.org>
>=20
> Check that the apid for an SPMI interrupt falls between the
> min_apid and max_apid that can be handled by the APPS processor
> before invoking the per-apid interrupt handler:
> periph_interrupt().
>=20
> This avoids an access violation in rare cases where the status
> bit is set for an interrupt that is not owned by the APPS
> processor.
>=20
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
