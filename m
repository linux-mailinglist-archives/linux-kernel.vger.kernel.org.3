Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329865A84A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiHaRmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiHaRlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:41:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171364C6;
        Wed, 31 Aug 2022 10:41:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E0ECB821E7;
        Wed, 31 Aug 2022 17:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BEFC433D6;
        Wed, 31 Aug 2022 17:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967663;
        bh=A16txUzILfnWQj8iUE09NDSP11cfJ+OkKuofMLKBb/Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lxgza1mHTzhAOOtQXc8LBCZhvPBfmEEJyYhZFthdoluKZSDA5SkaMpyaS8W3EKCBT
         667oqietKXfPBo+pGuVupfbMm4pChsWYgzLjOvEAKfyQ6MdHBr5n0P0LOZCGmNgyVa
         OoIsjbGfrNiRXlW1+6DDRAvYjEyyR7KPDa+jPlnK5riNj2TShjImwTyoiGol1FCqla
         uGVXtTP4w+xHCrQ+tZaXCrlu3rTN8pFz4WG6gybZevU2+cQccgPa1mcLGCHsCyrlzN
         mBDN0aWnTa+7xgDALnFMXNx0oEZ7CKkNnoNnZA6ZC0NiQ4AqFKMoo81ma3R5IgVXKO
         wE1gCbHhpy6Dg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1655004286-11493-11-git-send-email-quic_fenglinw@quicinc.com>
References: <1655004286-11493-1-git-send-email-quic_fenglinw@quicinc.com> <1655004286-11493-11-git-send-email-quic_fenglinw@quicinc.com>
Subject: Re: [RESEND PATCH v6 10/10] spmi: pmic-arb: increase SPMI transaction timeout delay
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_fenglinw@quicinc.com, tglx@linutronix.de, maz@kernel.org,
        David Collins <collinsd@codeaurora.org>
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:41:01 -0700
User-Agent: alot/0.10
Message-Id: <20220831174103.34BEFC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fenglin Wu (2022-06-11 20:24:46)
> From: David Collins <collinsd@codeaurora.org>
>=20
> Increase the SPMI transaction timeout delay from 100 us to
> 1000 us in order to account for the slower execution time
> found on some simulator targets.
>=20
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---

Applied to spmi-next
