Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDE5A849C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiHaRlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiHaRlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:41:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A96E2F6;
        Wed, 31 Aug 2022 10:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40C47B8221C;
        Wed, 31 Aug 2022 17:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AA1C433C1;
        Wed, 31 Aug 2022 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967636;
        bh=CSi9zdOEieKO9KvzPJVKxibckZ1pRIiwIsaU8dUChCk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BJG6N2/fl9OQc01eZUq+PTFfm4NvorGPhfDQkJjl/iwBXzBytZ0jeReDVtzd7+DI3
         dqaM9UX113v3DxXaRvIOedA17YFwdwcuQ5jZLUtLBJYgwChR1sCAy+fb5EwCnPXEeI
         uObBiXGut83IXESJUHs7asVQ1Ld9trGBTvI2KVbPQd9kbAWa1VyQ0EJjayYA5zwP2Y
         xnPYLCbjCch58myuTts4evyix5+/oLOr+s7F9mox1IE35FjazzMSjLKMxJmngorwBg
         CUiLkJgNyNzBwEHaUj8/tpBZFlVddWpvfULxzLrkhpxvBR+iJ59ig0jEBwlGDnLxNF
         9kSIQ2/uesARA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-7-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-7-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 06/10] spmi: pmic-arb: correct duplicate APID to PPID mapping logic
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org
To:     David Collins <collinsd@codeaurora.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:40:34 -0700
User-Agent: alot/0.10
Message-Id: <20220831174036.00AA1C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:42)
> From: David Collins <collinsd@codeaurora.org>
>=20
> Correct the way that duplicate PPID mappings are handled for PMIC
> arbiter v5.  The final APID mapped to a given PPID should be the
> one which has write owner =3D APPS EE, if it exists, or if not
> that, then the first APID mapped to the PPID, if it exists.
>=20
> Fixes: 40f318f0ed67 ("spmi: pmic-arb: add support for HW version 5")
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
