Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49045A84A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiHaRmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiHaRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:41:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E81EAE4;
        Wed, 31 Aug 2022 10:40:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A734561B4E;
        Wed, 31 Aug 2022 17:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079EEC433C1;
        Wed, 31 Aug 2022 17:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967649;
        bh=jzTCmjZs6oRV5vAtJdRT/DcBLCSdXLMxCOdEalCI1qI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aGsnA5+QkIomOr8vlRBARUc1AF8099TTw/GMr5zXmULF9QAeKNmPrcQ5AjUMeCjgM
         2W/tj9UehXBp6b3lnHgB8VS1bq8THaMSNwyO5ZgxowPW847AR7uZEKHvr+1iPBVP6n
         hpVoK+VYmSc9CuaI1Uepp0iHoF9tzOeJBIO4EzTzFvTVQcviizrYyKl2nBb4LsjbfR
         J84KDbXe+CBvcgXt4cB/XvO+MLgZqCNRIaKPW9dsnvWHW4ggNyBHA1rIqQh+54p9c5
         SGZ9GhhpnktNgOKWUNqIdr3QlQApH6U+ICyA3XgxZOPBgQsAhWhCGTbKo9T6bsCSaA
         XBLu4o4+jQiHQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-8-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-8-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 07/10] spmi: pmic-arb: block access for invalid PMIC arbiter v5 SPMI writes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        David Collins <collinsd@codeaurora.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:40:47 -0700
User-Agent: alot/0.10
Message-Id: <20220831174049.079EEC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:43)
> From: David Collins <collinsd@codeaurora.org>
>=20
> The system crashes due to an access permission violation when
> writing to a PMIC peripheral which is not owned by the current
> ee.  Add a check for PMIC arbiter version 5 for such invalid
> write requests and return an error instead of crashing the
> system.
>=20
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
